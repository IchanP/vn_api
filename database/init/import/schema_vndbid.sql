
CREATE TABLE anime (
  id integer NOT NULL,
  ann_id integer,
  type anime_type,
  year smallint,
  nfo_id text,
  title_romaji text,
  title_kanji text,
  PRIMARY KEY(id)
);

CREATE TABLE chars (
  id vndbid(c) NOT NULL,
  image vndbid(ch),
  bloodt blood_type NOT NULL,
  cup_size cup_size NOT NULL,
  sex char_sex NOT NULL,
  spoil_sex char_sex,
  gender char_gender,
  spoil_gender char_gender,
  main vndbid(c),
  main_spoil smallint NOT NULL,
  s_bust smallint NOT NULL,
  s_waist smallint NOT NULL,
  s_hip smallint NOT NULL,
  birthday smallint NOT NULL,
  height smallint NOT NULL,
  weight smallint,
  age smallint,
  name text NOT NULL,
  latin text,
  alias text NOT NULL,
  description text NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE chars_traits (
  id vndbid(c) NOT NULL,
  tid vndbid(i) NOT NULL,
  spoil smallint NOT NULL,
  lie boolean NOT NULL,
  PRIMARY KEY(id, tid)
);

CREATE TABLE chars_vns (
  id vndbid(c) NOT NULL,
  vid vndbid(v) NOT NULL,
  rid vndbid(r) NULL,
  role char_role NOT NULL,
  spoil smallint NOT NULL
);

-- CREATE TABLE docs (
--   id vndbid(d) NOT NULL,
--   title text NOT NULL,
--   content text NOT NULL,
--   PRIMARY KEY(id)
-- );

-- CREATE TABLE entry_meta (
--   id vndbid,
--   created date NOT NULL,
--   lastmod date NOT NULL,
--   revision smallint NOT NULL,
--   num_edits smallint NOT NULL,
--   num_users smallint NOT NULL,
--   PRIMARY KEY(id)
-- );

CREATE TABLE extlinks (
  id integer,
  site extlink_site NOT NULL,
  value text NOT NULL,
  PRIMARY KEY(id)
);

-- CREATE TABLE image_votes (
--   id vndbid NOT NULL,
--   uid vndbid(u),
--   date date NOT NULL,
--   sexual smallint NOT NULL CHECK(sexual >= 0 AND sexual <= 2),
--   violence smallint NOT NULL CHECK(violence >= 0 AND violence <= 2),
--   ignore boolean NOT NULL
-- );

CREATE TABLE images (
  id vndbid NOT NULL,
  width smallint NOT NULL,
  height smallint NOT NULL,
  c_votecount smallint NOT NULL,
  c_sexual_avg smallint NOT NULL,
  c_sexual_stddev smallint NOT NULL,
  c_violence_avg smallint NOT NULL,
  c_violence_stddev smallint NOT NULL,
  c_weight smallint NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE producers (
  id vndbid(p) NOT NULL,
  type producer_type NOT NULL,
  lang language NOT NULL,
  name text NOT NULL,
  latin text,
  alias text NOT NULL,
  description text NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE producers_extlinks (
  id vndbid(p) NOT NULL,
  link integer NOT NULL,
  PRIMARY KEY(id, link)
);

CREATE TABLE producers_relations (
  id vndbid(p) NOT NULL,
  pid vndbid(p) NOT NULL,
  relation producer_relation NOT NULL,
  PRIMARY KEY(id, pid)
);

CREATE TABLE quotes (
  id vndbid(q) NOT NULL,
  vid vndbid(v) NOT NULL,
  cid vndbid(c),
  score smallint NOT NULL,
  quote text NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE releases (
  id vndbid(r) NOT NULL,
  gtin bigint NOT NULL,
  olang language NOT NULL,
  released integer NOT NULL,
  voiced smallint NOT NULL,
  reso_x smallint NOT NULL,
  reso_y smallint NOT NULL,
  minage smallint,
  ani_story smallint NOT NULL,
  ani_ero smallint NOT NULL,
  ani_story_sp animation,
  ani_story_cg animation,
  ani_cutscene animation,
  ani_ero_sp animation,
  ani_ero_cg animation,
  ani_bg boolean,
  ani_face boolean,
  has_ero boolean NOT NULL,
  patch boolean NOT NULL,
  freeware boolean NOT NULL,
  uncensored boolean,
  official boolean NOT NULL,
  catalog text NOT NULL,
  engine text NOT NULL,
  notes text NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE releases_extlinks (
  id vndbid(r) NOT NULL,
  link integer NOT NULL,
  PRIMARY KEY(id, link)
);

CREATE TABLE releases_images (
  id vndbid(r) NOT NULL,
  img vndbid(cv) NOT NULL,
  vid vndbid(v),
  itype release_image_type NOT NULL,
  lang language[],
  PRIMARY KEY(id, img)
);

CREATE TABLE releases_media (
  id vndbid(r) NOT NULL,
  medium medium NOT NULL,
  qty smallint NOT NULL,
  PRIMARY KEY(id, medium, qty)
);

CREATE TABLE releases_platforms (
  id vndbid(r) NOT NULL,
  platform platform NOT NULL,
  PRIMARY KEY(id, platform)
);

CREATE TABLE releases_producers (
  id vndbid(r) NOT NULL,
  pid vndbid(p) NOT NULL,
  developer boolean NOT NULL,
  publisher boolean NOT NULL,
  PRIMARY KEY(id, pid)
);

CREATE TABLE releases_supersedes (
  id vndbid(r) NOT NULL,
  rid vndbid(r) NOT NULL,
  PRIMARY KEY(id, rid)
);

CREATE TABLE releases_titles (
  id vndbid(r) NOT NULL,
  lang language NOT NULL,
  mtl boolean NOT NULL,
  title text,
  latin text,
  PRIMARY KEY(id, lang)
);

CREATE TABLE releases_vn (
  id vndbid(r) NOT NULL,
  vid vndbid(v) NOT NULL,
  rtype release_type NOT NULL,
  PRIMARY KEY(id, vid)
);

-- CREATE TABLE rlists (
--   uid vndbid(u) NOT NULL,
--   rid vndbid(r) NOT NULL,
--   added date NOT NULL,
--   status smallint NOT NULL,
--   PRIMARY KEY(uid, rid)
-- );

CREATE TABLE staff (
  id vndbid(s) NOT NULL,
  gender staff_gender NOT NULL,
  lang language NOT NULL,
  main integer NOT NULL,
  description text NOT NULL,
  prod vndbid(p),
  PRIMARY KEY(id)
);

CREATE TABLE staff_alias (
  id vndbid(s) NOT NULL,
  aid integer,
  name text NOT NULL,
  latin text,
  PRIMARY KEY(aid)
);

CREATE TABLE staff_extlinks (
  id vndbid(s) NOT NULL,
  link integer NOT NULL,
  PRIMARY KEY(id, link)
);

CREATE TABLE tags (
  id vndbid(g) NOT NULL,
  cat tag_category NOT NULL,
  defaultspoil smallint NOT NULL,
  searchable boolean NOT NULL,
  applicable boolean NOT NULL,
  name text NOT NULL,
  alias text NOT NULL,
  description text NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE tags_parents (
  id vndbid(g) NOT NULL,
  parent vndbid(g) NOT NULL,
  main boolean NOT NULL,
  PRIMARY KEY(id, parent)
);

CREATE TABLE tags_vn (
  date date NOT NULL,
  tag vndbid(g) NOT NULL,
  vid vndbid(v) NOT NULL,
  uid vndbid(u),
  vote smallint NOT NULL,
  spoiler smallint CHECK(spoiler >= 0 AND spoiler <= 2),
  ignore boolean NOT NULL,
  lie boolean,
  notes text NOT NULL
);

CREATE TABLE traits (
  id vndbid(i) NOT NULL,
  gid vndbid(i),
  gorder smallint NOT NULL,
  defaultspoil smallint NOT NULL,
  sexual boolean NOT NULL,
  searchable boolean NOT NULL,
  applicable boolean NOT NULL,
  name text NOT NULL,
  alias text NOT NULL,
  description text NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE traits_parents (
  id vndbid(i) NOT NULL,
  parent vndbid(i) NOT NULL,
  main boolean NOT NULL,
  PRIMARY KEY(id, parent)
);

-- CREATE TABLE ulist_labels (
--   uid vndbid(u) NOT NULL,
--   id smallint NOT NULL,
--   label text NOT NULL,
--   PRIMARY KEY(uid, id)
-- );

-- CREATE TABLE ulist_vns (
--   uid vndbid(u) NOT NULL,
--   vid vndbid(v) NOT NULL,
--   added date NOT NULL,
--   lastmod date NOT NULL,
--   vote_date date,
--   started date,
--   finished date,
--   vote smallint CHECK(vote IS NULL OR vote BETWEEN 10 AND 100),
--   notes text NOT NULL,
--   labels smallint[] NOT NULL,
--   PRIMARY KEY(uid, vid)
-- );

-- CREATE TABLE users (
--   id vndbid(u) NOT NULL,
--   ign_votes boolean NOT NULL,
--   perm_imgvote boolean NOT NULL,
--   perm_tag boolean NOT NULL,
--   perm_lengthvote boolean NOT NULL,
--   username text,
--   PRIMARY KEY(id)
-- );

CREATE TABLE vn (
  id vndbid(v) NOT NULL,
  image vndbid(cv),
  c_image vndbid(cv),
  olang language NOT NULL,
  l_wikidata integer,
  c_votecount integer NOT NULL,
  c_rating smallint,
  c_average smallint,
  length smallint NOT NULL,
  devstatus smallint NOT NULL,
  alias text NOT NULL,
  l_renai text NOT NULL,
  description text NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE vn_anime (
  id vndbid(v) NOT NULL,
  aid integer NOT NULL,
  PRIMARY KEY(id, aid)
);

CREATE TABLE vn_editions (
  id vndbid(v) NOT NULL,
  lang language,
  eid smallint NOT NULL,
  official boolean NOT NULL,
  name text NOT NULL,
  PRIMARY KEY(id, eid)
);

-- CREATE TABLE vn_image_votes (
  -- vid vndbid(v) NOT NULL,
  -- uid vndbid(u) NOT NULL,
  -- img vndbid(cv) NOT NULL,
  -- PRIMARY KEY(vid, uid, img)
-- );

-- CREATE TABLE vn_length_votes (
--   vid vndbid(v) NOT NULL,
--   uid vndbid(u),
--   date date NOT NULL,
--   length smallint NOT NULL,
--   speed smallint,
--   rid vndbid[] NOT NULL,
--   notes text NOT NULL,
--   lang language[]
-- );

CREATE TABLE vn_relations (
  id vndbid(v) NOT NULL,
  vid vndbid(v) NOT NULL,
  relation vn_relation NOT NULL,
  official boolean NOT NULL,
  PRIMARY KEY(id, vid)
);

CREATE TABLE vn_screenshots (
  id vndbid(v) NOT NULL,
  scr vndbid(sf) NOT NULL,
  rid vndbid(r),
  PRIMARY KEY(id, scr)
);

CREATE TABLE vn_seiyuu (
  id vndbid(v) NOT NULL,
  cid vndbid(c) NOT NULL,
  aid integer NOT NULL,
  note text NOT NULL,
  PRIMARY KEY(id, aid, cid)
);

CREATE TABLE vn_staff (
  id vndbid(v) NOT NULL,
  aid integer NOT NULL,
  role credit_type NOT NULL,
  eid smallint,
  note text NOT NULL
);

CREATE TABLE vn_titles (
  id vndbid(v) NOT NULL,
  lang language NOT NULL,
  official boolean NOT NULL,
  title text NOT NULL,
  latin text,
  PRIMARY KEY(id, lang)
);

CREATE TABLE wikidata (
  id integer NOT NULL,
  enwiki text,
  jawiki text,
  website text[],
  vndb text[],
  mobygames text[],
  mobygames_company text[],
  gamefaqs_game integer[],
  gamefaqs_company integer[],
  anidb_anime integer[],
  anidb_person integer[],
  ann_anime integer[],
  ann_manga integer[],
  musicbrainz_artist uuid[],
  twitter text[],
  vgmdb_product integer[],
  vgmdb_artist integer[],
  discogs_artist integer[],
  acdb_char integer[],
  acdb_source integer[],
  indiedb_game text[],
  howlongtobeat integer[],
  crunchyroll text[],
  igdb_game text[],
  giantbomb text[],
  pcgamingwiki text[],
  steam integer[],
  gog text[],
  pixiv_user integer[],
  doujinshi_author integer[],
  soundcloud text[],
  humblestore text[],
  itchio text[],
  playstation_jp text[],
  playstation_na text[],
  playstation_eu text[],
  lutris text[],
  wine integer[],
  PRIMARY KEY(id)
);
