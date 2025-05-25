<script lang="ts">
	import { user } from '$lib/supabase';
	import { goto } from '$app/navigation';
	import { onMount } from 'svelte';
	
	// Redirect to login if not authenticated
	onMount(() => {
		if (!$user) {
			goto('/auth/login');
		}
	});
	
	// Example user stats
	const stats = [
		{ name: 'Total Projects', value: '12' },
		{ name: 'Completed Tasks', value: '87%' },
		{ name: 'Recent Activities', value: '24' },
		{ name: 'Team Members', value: '5' }
	];
</script>

<div class="py-6">
	<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
		<h1 class="text-2xl font-semibold text-gray-900">Dashboard</h1>
		
		{#if $user}
			<div class="mt-4 bg-white shadow overflow-hidden rounded-lg p-6">
				<h2 class="text-lg font-medium text-gray-900">Welcome, {$user.email || 'User'}</h2>
				<p class="mt-1 text-sm text-gray-500">Here's an overview of your account and activities</p>
				
				<div class="mt-6 grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
					{#each stats as stat}
						<div class="bg-gray-50 overflow-hidden shadow rounded-lg">
							<div class="px-4 py-5 sm:p-6">
								<dt class="text-sm font-medium text-gray-500 truncate">
									{stat.name}
								</dt>
								<dd class="mt-1 text-3xl font-semibold text-primary-600">
									{stat.value}
								</dd>
							</div>
						</div>
					{/each}
				</div>
			</div>
			
			<div class="mt-6 bg-white shadow overflow-hidden sm:rounded-lg">
				<div class="px-4 py-5 sm:px-6">
					<h3 class="text-lg leading-6 font-medium text-gray-900">Recent Activity</h3>
					<p class="mt-1 max-w-2xl text-sm text-gray-500">Your recent actions and updates</p>
				</div>
				<div class="border-t border-gray-200 px-4 py-5 sm:p-6">
					<ul class="divide-y divide-gray-200">
						<li class="py-4 flex">
							<div class="ml-3">
								<p class="text-sm font-medium text-gray-900">Project created</p>
								<p class="text-sm text-gray-500">New project "Landing Page" was created</p>
								<p class="text-xs text-gray-400">Today at 2:30 PM</p>
							</div>
						</li>
						<li class="py-4 flex">
							<div class="ml-3">
								<p class="text-sm font-medium text-gray-900">Database updated</p>
								<p class="text-sm text-gray-500">Schema changes applied to "users" table</p>
								<p class="text-xs text-gray-400">Yesterday at 11:15 AM</p>
							</div>
						</li>
						<li class="py-4 flex">
							<div class="ml-3">
								<p class="text-sm font-medium text-gray-900">Storage bucket created</p>
								<p class="text-sm text-gray-500">New storage bucket "avatars" initialized</p>
								<p class="text-xs text-gray-400">2 days ago</p>
							</div>
						</li>
					</ul>
				</div>
			</div>
		{:else}
			<div class="mt-4 bg-white shadow overflow-hidden rounded-lg p-6">
				<p class="text-gray-500">Loading dashboard...</p>
			</div>
		{/if}
	</div>
</div>
