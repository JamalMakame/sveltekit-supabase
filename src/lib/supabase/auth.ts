import { writable } from 'svelte/store';
import type { Session, User } from '@supabase/supabase-js';
import { supabase } from './client';

export const session = writable<Session | null>(null);
export const user = writable<User | null>(null);

// Subscribe to auth changes
supabase.auth.onAuthStateChange((_, newSession) => {
  session.set(newSession);
  user.set(newSession?.user || null);
});

// Initialize auth state
export const initAuth = async () => {
  const { data } = await supabase.auth.getSession();
  session.set(data.session);
  user.set(data.session?.user || null);
};

// Helper functions for authentication
export const signIn = async (email: string, password: string) => {
  return supabase.auth.signInWithPassword({ email, password });
};

export const signUp = async (email: string, password: string) => {
  return supabase.auth.signUp({ email, password });
};

export const signOut = async () => {
  return supabase.auth.signOut();
};
