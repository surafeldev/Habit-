module 0x0416f59263fa4f4c52cfa45b89fcb47fa2eebef78cfda644bb3b8a19f0a4f3c6::test_UserManagement {
    use aptos_std::signer;
    use HabitTerritories::UserManagement;

    // Test function to check user management initialization
    public fun test_initialize_user(account: &signer) {
        UserManagement::initialize_user(account);
        assert!(UserManagement::is_registered(signer::address_of(account)), 0x3); // Should pass if registered
    }

    // Test function to check user unregistration
    public fun test_unregister_user(account: &signer) {
        UserManagement::initialize_user(account);
        UserManagement::unregister_user(account);
        assert!(!UserManagement::is_registered(signer::address_of(account)), 0x4); // Should pass if unregistered
    }
}
