-- Database setup script for Insightify Actionable AI
-- Run this in your Supabase SQL editor to create the required tables

-- Create reviews table
CREATE TABLE IF NOT EXISTS public.reviews (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    content TEXT NOT NULL,
    sentiment TEXT NOT NULL CHECK (sentiment IN ('positive', 'negative', 'neutral')),
    confidence DECIMAL(3,2) NOT NULL CHECK (confidence >= 0 AND confidence <= 1),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    session_id UUID NOT NULL
);

-- Create analysis_sessions table
CREATE TABLE IF NOT EXISTS public.analysis_sessions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id TEXT NOT NULL,
    total_reviews INTEGER NOT NULL DEFAULT 0,
    positive_count INTEGER NOT NULL DEFAULT 0,
    negative_count INTEGER NOT NULL DEFAULT 0,
    neutral_count INTEGER NOT NULL DEFAULT 0,
    issues_count INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Add foreign key constraint
ALTER TABLE public.reviews
ADD CONSTRAINT reviews_session_id_fkey
FOREIGN KEY (session_id) REFERENCES public.analysis_sessions(id) ON DELETE CASCADE;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_reviews_session_id ON public.reviews(session_id);
CREATE INDEX IF NOT EXISTS idx_reviews_sentiment ON public.reviews(sentiment);
CREATE INDEX IF NOT EXISTS idx_reviews_created_at ON public.reviews(created_at);
CREATE INDEX IF NOT EXISTS idx_analysis_sessions_user_id ON public.analysis_sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_analysis_sessions_created_at ON public.analysis_sessions(created_at);

-- Enable Row Level Security (RLS)
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.analysis_sessions ENABLE ROW LEVEL SECURITY;

-- Create policies for reviews table
CREATE POLICY "Users can view their own reviews" ON public.reviews
    FOR SELECT USING (
        session_id IN (
            SELECT id FROM public.analysis_sessions
            WHERE user_id = auth.jwt() ->> 'email'
        )
    );

CREATE POLICY "Users can insert their own reviews" ON public.reviews
    FOR INSERT WITH CHECK (
        session_id IN (
            SELECT id FROM public.analysis_sessions
            WHERE user_id = auth.jwt() ->> 'email'
        )
    );

CREATE POLICY "Users can update their own reviews" ON public.reviews
    FOR UPDATE USING (
        session_id IN (
            SELECT id FROM public.analysis_sessions
            WHERE user_id = auth.jwt() ->> 'email'
        )
    );

CREATE POLICY "Users can delete their own reviews" ON public.reviews
    FOR DELETE USING (
        session_id IN (
            SELECT id FROM public.analysis_sessions
            WHERE user_id = auth.jwt() ->> 'email'
        )
    );

-- Create policies for analysis_sessions table
CREATE POLICY "Users can view their own analysis sessions" ON public.analysis_sessions
    FOR SELECT USING (user_id = auth.jwt() ->> 'email');

CREATE POLICY "Users can insert their own analysis sessions" ON public.analysis_sessions
    FOR INSERT WITH CHECK (user_id = auth.jwt() ->> 'email');

CREATE POLICY "Users can update their own analysis sessions" ON public.analysis_sessions
    FOR UPDATE USING (user_id = auth.jwt() ->> 'email');

CREATE POLICY "Users can delete their own analysis sessions" ON public.analysis_sessions
    FOR DELETE USING (user_id = auth.jwt() ->> 'email');

-- Grant necessary permissions
GRANT ALL ON public.reviews TO authenticated;
GRANT ALL ON public.analysis_sessions TO authenticated;

-- Insert some sample data for testing (optional)
-- You can remove this section if you don't want sample data
/*
INSERT INTO public.analysis_sessions (user_id, total_reviews, positive_count, negative_count, neutral_count, issues_count) VALUES
('test@example.com', 10, 6, 2, 2, 3),
('test@example.com', 15, 8, 3, 4, 5);

INSERT INTO public.reviews (content, sentiment, confidence, session_id) VALUES
('Great product, fast delivery!', 'positive', 0.85, (SELECT id FROM public.analysis_sessions LIMIT 1)),
('Poor customer service, disappointed.', 'negative', 0.92, (SELECT id FROM public.analysis_sessions LIMIT 1)),
('Amazing quality, highly recommend.', 'positive', 0.88, (SELECT id FROM public.analysis_sessions LIMIT 1));
*/
