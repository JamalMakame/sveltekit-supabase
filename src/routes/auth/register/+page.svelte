<script lang="ts">
	import RegisterForm from '$lib/components/auth/RegisterForm.svelte';
	import { user } from '$lib/supabase';
	import { goto } from '$app/navigation';
	import { onMount } from 'svelte';
	
	// Redirect to dashboard if already logged in
	onMount(() => {
		if ($user) {
			goto('/dashboard');
		}
	});
</script>

<div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
	<RegisterForm />
</div>
