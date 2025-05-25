import { createClient } from '@supabase/supabase-js';
import { redirect } from '@sveltejs/kit';
import { env } from '$env/dynamic/public';
import type { Cookies } from '@sveltejs/kit';

interface ServerLoadProps {
  cookies: Cookies;
  url: URL;
}

export const load = (async ({ cookies, url }: ServerLoadProps) => {
  // Create a Supabase client for server-side operations
  const supabase = createClient(
    env.PUBLIC_SUPABASE_URL || '',
    env.PUBLIC_SUPABASE_ANON_KEY || ''
  );

  // Get session from Supabase (simplified for this template)
  const authToken = cookies.get('supabase-auth-token');
  let session = null;
  
  if (authToken) {
    try {
      // This is simplified - in a real app, you'd validate the token properly
      const { data, error } = await supabase.auth.getUser(authToken);
      if (data?.user && !error) {
        session = { user: data.user };
      }
    } catch (error) {
      console.error('Error validating session:', error);
    }
  }

  // Protected routes - redirect to login if not authenticated
  const protectedRoutes = ['/dashboard', '/profile'];
  if (protectedRoutes.some(route => url.pathname.startsWith(route)) && !session) {
    throw redirect(303, '/auth/login');
  }

  // Auth routes - redirect to dashboard if already authenticated
  const authRoutes = ['/auth/login', '/auth/register'];
  if (authRoutes.some(route => url.pathname === route) && session) {
    throw redirect(303, '/dashboard');
  }

  return {
    supabase,
    session
  };
});
