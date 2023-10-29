if ! uci -q get 'system.@system[-1].zonename'; then
	uci set 'system.@system[-1].zonename=Europe/Warsaw'
fi

if ! uci -q get 'system.@system[-1]._country'; then
	uci set 'system.@system[-1]._country=PL'
fi

if [ -n "$(uci changes 'system.@system[-1]')" ]; then
	uci commit 'system.@system[-1]'
fi
