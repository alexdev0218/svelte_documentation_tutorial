export async function getRandomPokemon() {
	// Fetch a random number between 0 and 100
	// (with a delay, so that we can see it)
	let pokemonId = Math.floor(Math.random() * 898) + 1;
	const res = await fetch(`https://pokeapi.co/api/v2/pokemon/${pokemonId}`);

	if (res.ok) {
		return await res.json();
	} else {
		// Sometimes the API will fail!
		throw new Error('Request failed');
	}
}
