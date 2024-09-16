module HabitTerritories::UserManagement {
    use aptos_framework::signer; // Import the Signer module from AptosFramework

    // Define a struct to store user data
    struct User has key, drop { // Added 'drop' ability to enable resource removal
        address: address, // The address of the user
        registered: bool, // Indicates whether the user is registered
    }

    /// Initializes a new user by creating a `User` resource under the signer's account.
    ///
    /// # Parameters
    /// - `account`: The signer's account which will hold the `User` resource.
    public fun initialize_user(account: &signer) {
        let user_address = signer::address_of(account); // Use signer module correctly
        // Check if the user already exists; if not, create a new user
        if (!exists<User>(user_address)) {
            // Move the new `User` resource to the account of the signer
            move_to(account, User {
                address: user_address,
                registered: true,
            });
        } else {
            // Abort with an error code if the user already exists
            abort 0x1 // Removed unnecessary semicolon
        }
    }

    /// Checks if a user is registered by looking for a `User` resource at the given address.
    ///
    /// # Parameters
    /// - `user_address`: The address to check for registration.
    ///
    /// # Returns
    /// - `bool`: Returns `true` if the user is registered, otherwise `false`.
    public fun is_registered(user_address: address): bool {
        exists<User>(user_address)
    }

    /// Removes the `User` resource from the account to unregister the user.
    ///
    /// # Parameters
    /// - `account`: The signer's account from which the `User` resource will be removed.
    public fun unregister_user(account: &signer) acquires User {  // Correct placement of acquires annotation
        let user_address = signer::address_of(account); // Use signer module correctly
        // Ensure the user is registered before attempting to unregister
        assert!(exists<User>(user_address), 0x2); // Error code if user does not exist
        // Remove the user resource from the global storage
        move_from<User>(user_address);
    }
}
