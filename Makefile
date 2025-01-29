makefile
setup:
    @echo "Installing dependencies..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    cargo install --git https://github.com/MystenLabs/sui.git --branch devnet sui
    cd frontend && npm install

deploy:
    sui client publish --path contracts/ai_agent --gas-budget 100000000

test:
    sui move test --path contracts/ai_agent
    cd frontend && npm test
