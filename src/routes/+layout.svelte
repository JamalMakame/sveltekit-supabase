<script lang="ts">
	import '../app.css';
	import { initAuth, user } from '$lib/supabase';
	import { onMount } from 'svelte';

	let { children } = $props();

	onMount(() => {
		// Initialize authentication on client-side
		initAuth();
	});
</script>

<div class="min-h-screen bg-gray-50">
	{#if $user}
		<!-- Header for authenticated users -->
		<header class="bg-white shadow">
			<div class="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8 flex justify-between items-center">
				<h1 class="text-2xl font-bold text-primary-700">SvelteKit Supabase</h1>
				<nav>
					<ul class="flex space-x-4">
						<li><a href="/dashboard" class="text-gray-600 hover:text-primary-700">Dashboard</a></li>
						<li><a href="/profile" class="text-gray-600 hover:text-primary-700">Profile</a></li>
						<li>
							<button 
								class="text-gray-600 hover:text-primary-700"
								onclick={() => import('$lib/supabase').then(m => m.signOut())}
							>
								Logout
							</button>
						</li>
					</ul>
				</nav>
			</div>
		</header>
	{:else}
		<!-- Header for non-authenticated users -->
		<header class="bg-white shadow">
			<div class="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8 flex justify-between items-center">
				<h1 class="text-2xl font-bold text-primary-700">SvelteKit Supabase</h1>
				<nav>
					<ul class="flex space-x-4">
						<li><a href="/" class="text-gray-600 hover:text-primary-700">Home</a></li>
						<li><a href="/auth/login" class="text-gray-600 hover:text-primary-700">Login</a></li>
						<li><a href="/auth/register" class="text-gray-600 hover:text-primary-700">Register</a></li>
					</ul>
				</nav>
			</div>
		</header>
	{/if}

	<main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
		{@render children()}
	</main>

	<footer class="bg-white shadow mt-auto py-4">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center text-gray-500">
			<p>© {new Date().getFullYear()} SvelteKit Supabase Starter Template</p>
		</div>
	</footer>
</div>
