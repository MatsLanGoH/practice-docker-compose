# Start from an official image
FROM python:3.7

ENV PYTHONUNBUFFERED 1

# Create app directory in container
RUN mkdir -p /var/www/djangoapp/src
WORKDIR /var/www/djangoapp/src

# Install dependencies
# Use `--system` flag because we don't need an extra virtualenv
COPY Pipfile Pipfile.lock /var/www/djangoapp/src/
RUN pip install pipenv && pipenv install --system

# Copy project code
COPY . /var/www/djangoapp/src
RUN cd hello && python manage.py collectstatic --no-input

# Expose port 8000
EXPOSE 8000

# Define default command to run when starting the container
#CMD ["gunicorn", "-c", "config/gunicorn/conf.py", "--chdir", "hello", "--bind", ":8000", "hello.wsgi:application"]
