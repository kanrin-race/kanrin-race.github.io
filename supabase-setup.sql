-- 漢輪レース：全国ランキング用のテーブル
create table public.ta_scores (
  id bigint generated always as identity primary key,
  day date not null,
  ver int not null,
  name text not null check (char_length(name) between 1 and 12),
  rear text not null check (char_length(rear) between 1 and 2),
  front text not null check (char_length(front) between 1 and 2),
  frame text not null check (frame in ('std','racer','off','boat','snow','heavy')),
  size text not null check (size in ('s','m','l')),
  created_at timestamptz not null default now(),
  unique (day, ver, name, rear, front, frame, size)
);
alter table public.ta_scores enable row level security;
create policy "誰でも見られる" on public.ta_scores for select to anon using (true);
create policy "今日の分だけ送れる" on public.ta_scores for insert to anon
  with check (day between current_date - 1 and current_date + 1);
