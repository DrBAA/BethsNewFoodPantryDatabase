USE beths_new_food_pantry;

CREATE TABLE session_storage (
  session_id VARCHAR(128) PRIMARY KEY,
  user_id INT NOT NULL,
  csrf_token VARCHAR(128),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  expires_at DATETIME,
  last_accessed_at DATETIME,
  CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES app_users(id),
  
  -- 📊 Index to optimize user-based lookups
  INDEX idx_session_storage_user_id (user_id),

  -- 🔍 Index to speed up session validation checks
  INDEX idx_session_storage_valid (session_id, expires_at)
);


