module 0x04fdf105567e4010dc62622231b16cda0efc3b68e020d2ceed3ec08f9c5db64b::test_user_management {
    use aptos_framework::test_helpers::{create_signer_account}; // Adjust based on actual module structure
    use aptos_framework::signer;
    use 0x04fdf105567e4010dc62622231b16cda0efc3b68e020d2ceed3ec08f9c5db64b::UserManagement;

    // Test function to check user management initialization
    public fun test_initialize_user() {
        let account = create_signer_account(); // Use correct helper function to create a signer account
        UserManagement::initialize_user(&account);
        assert!(UserManagement::is_registered(signer::address_of(&account)), 0x3); // Should pass if registered
    }

    // Test function to check user unregistration
    public fun test_unregister_user() {
        let account = create_signer_account();
        UserManagement::initialize_user(&account);
        UserManagement::unregister_user(&account);
        assert!(!UserManagement::is_registered(signer::address_of(&account)), 0x4); // Should pass if unregistered
    }
}
