from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class Post(db.Model):
    __tablename__ = "post"
    id = db.Column(db.Integer, primary_key=True)
    likes = db.Column(db.Integer, nullable=False)
    text = db.Column(db.String, nullable=False)
    nickname = db.Column(db.String, nullable=False)
    workout = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        self.likes = kwargs.get("likes", 0)
        self.text = kwargs.get("text", "")
        self.nickname = kwargs.get("nickname")
        self.workout = kwargs.get("workout")

    def serialize(self):
        return {
            "id": self.id,
            "likes": self.likes,
            "text": self.text,
            "nickname": self.nickname,
            "workout": self.workout,
        }
