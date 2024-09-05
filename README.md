# **Posts Application** (Ruby on Rails + JavaScript)

This project is a **Post Management Application** built with **Ruby on Rails** for the backend and integrated **JavaScript** to handle dynamic behavior on the frontend. The application allows users to create, update, and delete posts, and includes pagination, user authentication, and basic authorization.

## **Features**
- **CRUD operations** for posts: Create, Read, Update, Delete.
- **User Authentication**: Only authenticated users can create, update, or delete posts.
- **Authorization**: Users can only modify or delete their own posts.
- **Pagination**: Dynamic loading and navigation of posts, displaying 10 posts per page.
- **See More/See Less** functionality: Automatically truncates long posts on display with the option to expand or collapse the content.
- **I18n Support**: Bilingual support (English and Spanish) for all user-facing texts, including success and error messages.
- **CSRF Protection**: Cross-site request forgery protection enabled for all actions.
- **Error Handling**: Graceful error handling for missing records and unauthorized access.


## **Technologies Used**
- **Ruby on Rails**: Backend framework.
- **PostgreSQL**: Database for storing posts and users.
- **JavaScript**: Frontend scripting to handle dynamic features such as pagination and See More/See Less functionality.
- **RSpec**: For unit testing the Rails controllers and models.
- **Devise**: For user authentication.
- **Kaminari**: For pagination.
- **i18n-js**: For JavaScript localization.

## **Getting Started**

### **1. Prerequisites**
Make sure you have the following installed:
- Ruby (>= 3.0.0)
- Rails (>= 7.0.0)
- PostgreSQL (>= 13)

### **2. Setup**

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/posts-app.git
   cd posts-app
   ```

2. Install dependencies:
   ```bash
   bundle install
   yarn install
   ```

3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

### **3. Running the Application**

1. Start the Rails server:
   ```bash
   rails server
   ```

2. Visit the application in your browser at:
   ```
   http://localhost:3000
   ```

## **API Endpoints Explanation**

The application exposes several API endpoints for managing posts.

### **1. List Posts (Paginated)**
- **URL**: `/api/posts?page=1`
- **Method**: GET
- **Description**: Retrieves a list of paginated posts (10 per page).

### **2. Show Post**
- **URL**: `/api/posts/:id`
- **Method**: GET
- **Description**: Retrieves a single post by its ID.

### **3. Create Post**
- **URL**: `/api/posts`
- **Method**: POST
- **Authorization**: User must be authenticated.
- **Body Parameters**:
  - `title`: string
  - `body`: string
- **Description**: Creates a new post associated with the current user.

### **4. Update Post**
- **URL**: `/api/posts/:id`
- **Method**: PATCH
- **Authorization**: User must be authenticated and the post must belong to the user.
- **Body Parameters**:
  - `title`: string
  - `body`: string
- **Description**: Updates an existing post.

### **5. Delete Post**
- **URL**: `/api/posts/:id`
- **Method**: DELETE
- **Authorization**: User must be authenticated and the post must belong to the user.
- **Description**: Deletes a post.


## **Running Tests**

This project uses **RSpec** for unit tests. To run the test suite:

```bash
rspec
```

Ensure you have correctly set up your test database before running the tests.

## **Most Important about Project Structure**

- **app/controllers/api/posts_controller.rb**: Main controller for handling post-related API actions.
- **app/views/posts/_post.html.erb**: Partial for rendering each post in the list.
- **app/views/shared/_pagination.html.erb**: Partial for rendering pagination controls.
- **app/javascript/posts.js.erb**: JavaScript logic for dynamic "See More/See Less" functionality and pagination.
- **config/locales/en.yml**: English translations.
- **config/locales/es.yml**: Spanish translations.

## **Areas for Potential Improvement**
1. **Optimization**: Implement caching for the most common queries (e.g., list of posts).
2. **Cohesion & Decoupling**: Separate pagination logic into its own module to allow reuse.
3. **Security**: Add role-based access control (RBAC) for future features.
4. **Testing**: Increase test coverage to include edge cases and integration tests.

## **License**

This project is licensed under the MIT License.


## **Contact**

If you have any questions or suggestions, feel free to open an issue or contact me at `dantealonsoh@gmail.com`.
