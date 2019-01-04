import json
from db import db, Post
from flask import Flask, request

db_filename = "board.db"
app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


@app.route("/api/posts/", methods=["GET"])
def get_posts():
    posts = Post.query.all()
    return (
        json.dumps({"success": True, "data": [post.serialize() for post in posts]}),
        200,
    )


@app.route("/api/posts/", methods=["POST"])
def create_post():
    post_body = json.loads(request.data)
    post = Post(
        likes=0,
        text=post_body["text"],
        nickname=post_body["nickname"],
        workout=post_body["workout"],
    )
    db.session.add(post)
    db.session.commit()
    return json.dumps({"success": True, "data": post.serialize()}), 200


@app.route("/api/post/<int:post_id>/like/", methods=["POST"])
def vote_post(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is not None:
        post.likes += 1
        db.session.commit()
        return json.dumps({"success": True, "data": post.serialize()}), 200
    return json.dumps({"success": False, "error": "Post not found"}), 404

@app.route("/api/posts/clear/", methods=["DELETE"])
def clear_posts():
    posts = Post.query.all()
    for post in posts:
        db.session.delete(post)
        db.session.commit()
    return json.dumps({"success": True, "data": [post.serialize() for post in posts]})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

