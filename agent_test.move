move
#[test_only]
module ai_agent::agent_test {
    use sui::test_scenario;
    use ai_agent::agent;

    #[test]
    fun test_basic_flow() {
        let scenario = test_scenario::begin(@0x123);
        let admin = test_scenario::next_address(&mut scenario);
        
        // Создаем агента
        test_scenario::next_tx(&mut scenario, admin);
        agent::create_agent(admin, 1000000, b"gpt-4", test_scenario::ctx(&mut scenario));
        
        // Тестируем запрос
        let agent_id = test_scenario::take_object_id(&mut scenario);
        test_scenario::next_tx(&mut scenario, admin);
        agent::process_request(
            test_scenario::get_mut_object<agent::AIAgent>(&mut scenario, agent_id),
            test_scenario::create_coin<SUI>(&mut scenario, 1000000),
            b"Hello AI",
            test_scenario::ctx(&mut scenario)
        );
        
        test_scenario::end(scenario);
    }
}
