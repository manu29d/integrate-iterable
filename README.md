# Iterable Integration

## Overview

### Author: Manu Dwivedi <manu29.d@gmail.com>

This is a Rails project developed with Rails version 7.1.3 and Ruby version 3.2.2. It utilizes various gems and libraries for different functionalities.

**Note:** Docker setup has not been implemented, and there's no guarantee it works as intended.

## Development Insights

- **Documentation**: Thoughts during development and choices for certain implementations have been documented within the codebase.
- **External API Mocking**: The project utilizes WebMock for mocking external API calls.
- **User Authentication**: Devise gem is used for user authentication. The default setup is employed without significant modifications.
- **Testing**: RSpec is the testing framework used for this project.
- **Iterable Integration**: The project requires an API key for Iterable integration. As the key is not present, the project is non-functional in this aspect. However, tests have been written and pass successfully.

## Setup Instructions

1. **Clone the Repository**:
Please host it as per your choice of platform. Then,
```bash
git clone <repository_url>
```
2. **Install Dependencies**:
```bash
bundle install
```
3. **Database Setup**:
```bash
rails db:create
rails db:migrate
```
4. **Run Tests**:
```bash
bundle exec rspec
```
Ensure that all tests pass successfully.

## Usage

As mentioned earlier, due to missing API key for Iterable, the project is not fully functional. However, for testing purposes:

1. Start the Rails server:
```bash
rails server
```
2. Access the application through the browser or API endpoints for any implemented functionality.
