from application import app
from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy


if __name__ == '__main__':
    app.run(port=5001, host='0.0.0.0')
