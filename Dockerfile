# Start from an official image
FROM python:3.7

# Create app directory in container
RUN mkdir -p /var/www/djangoapp/src
WORKDIR /var/www/djangoapp/src

# Install dependencies
# Use `--system` flag because we don't need an extra virtualenv
COPY Pipfile Pipfile.lock /var/www/djangoapp/src/
RUN pip install pipenv && pipenv install --system

# Copy project code
COPY . /var/www/djangoapp/src

# Expose port 8000
EXPOSE 8000

# Define default command to run when starting the container
CMD ["gunicorn", "--chdir", "hello", "--bind", ":8000", "hello.wsgi:application"]
