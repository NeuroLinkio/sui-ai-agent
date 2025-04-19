move
#[test_only]
module ai_agent::agent_test {
    use sui::test_scenario;
    use ai_agent::agent;

    #[test]
    fun test_basic_flow() {
        // Инициализация сценария тестирования
        let scenario = test_scenario::begin(@0x123);
        let admin = test_scenario::next_address(&mut scenario);

        // Создаем агента
        test_scenario::next_tx(&mut scenario, admin);
        let create_result = agent::create_agent(admin, 1000000, b"gpt-4", test_scenario::ctx(&mut scenario));
        assert!(create_result.is_ok(), b"Ошибка при создании агента");

        // Получаем ID созданного агента
        let agent_id = test_scenario::take_object_id(&mut scenario);

        // Тестируем обработку запроса
        test_scenario::next_tx(&mut scenario, admin);
        let request_result = agent::process_request(
            test_scenario::get_mut_object<agent::AIAgent>(&mut scenario, agent_id),
            test_scenario::create_coin<SUI>(&mut scenario, 1000000),
            b"Hello AI",
            test_scenario::ctx(&mut scenario)
        );
        assert!(request_result.is_ok(), b"Ошибка при обработке запроса");

        // Завершение сценария тестирования
        test_scenario::end(scenario);
    }
}
