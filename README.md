# Todo App with Sharing Capabilities

A full-featured task management application with user collaboration features, built with Ruby on Rails.

## Features

✅ **User Authentication**  
- Secure sign up/login with Devise

📝 **Task Management**  
- Create todo lists with multiple tasks
- Mark tasks as complete/incomplete
- Add detailed descriptions to tasks

👥 **Collaboration**  
- Share lists with other users
- Control permissions (read-only or read-write)
- See who has access to your lists

## Technology Stack

- **Backend**: Ruby on Rails 8
- **Frontend**: Bootstrap 5, Hotwire
- **Database**: PostgreSQL
- **Authentication**: Devise

## System Requirements

- **Ruby**: 3.4.2
- **Rails**: 8.0.2
- **PostgreSQL**: 14+

## Setup Instructions

### 1. Install Dependencies

Ensure you have these installed on your Windows system:
- [Ruby 3.4.2](https://rubyinstaller.org/)
- [PostgreSQL 15](https://www.postgresql.org/download/windows/)
- [Node.js 18+](https://nodejs.org/)

### Installation
1. Clone the repo:
   ```bash
   git clone https://github.com/cosminEmil/demo_app.git
   cd demo_app
# Create PostgreSQL user (if needed)
sudo -u postgres createuser -s demo_app

# Setup databases
rails db:create
rails db:migrate

# Install dependencies
bundle install
yarn install

# Start the server
rails server
# Visit http://localhost:3000 in your browser.
