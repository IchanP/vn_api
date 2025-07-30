-- This script will create the necessary tables and import all data into an
-- existing PostgreSQL database.
--
-- Usage:
--   Run a 'CREATE DATABASE $database' somewhere.
--   psql -U $user $database -f import.sql
--
-- The imported database does not include any indices, other than primary keys.
-- You may want to create some indices by hand to speed up complex queries.
--
-- This script automatically detects whether you have the 'vndbid' type loaded
-- into the database and will use that when it is available. To use it, load
-- sql/vndbid.sql from the VNDB source repository into your database before
-- running this import script. If the type is not detected, vndbid's will be
-- imported into a generic text column instead. This works fine for most use
-- cases, but is slightly less efficient, lacks some convenience functions and
-- identifiers will compare and sort differently.
--
-- Uncomment to import the schema and data into a separate namespace:
--CREATE SCHEMA vndb;
--SET search_path TO vndb;


CREATE DOMAIN animation AS smallint CHECK(value IS NULL OR value IN(0,1) OR ((value & (4+8+16+32)) > 0 AND (value & (256+512)) <> (256+512)));
CREATE TYPE anime_type        AS ENUM ('tv', 'ova', 'mov', 'oth', 'web', 'spe', 'mv');
CREATE TYPE blood_type        AS ENUM ('unknown', 'a', 'b', 'ab', 'o');
CREATE TYPE char_gender       AS ENUM ('', 'm', 'f', 'o', 'a');
CREATE TYPE char_role         AS ENUM ('main', 'primary', 'side', 'appears');
CREATE TYPE char_sex          AS ENUM ('', 'm', 'f', 'b', 'n');
CREATE TYPE credit_type       AS ENUM ('scenario', 'chardesign', 'art', 'music', 'songs', 'director', 'translator', 'editor', 'qa', 'staff');
CREATE TYPE cup_size          AS ENUM ('', 'AAA', 'AA', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
CREATE TYPE extlink_site AS ENUM (
    'afdian',
    'anidb',
    'animateg',
    'anison',
    'appstore',
    'bgmtv',
    'bilibili',
    'boosty',
    'booth',
    'booth_pub',
    'bsky',
    'cien',
    'denpa',
    'deviantar',
    'digiket',
    'discogs',
    'dlsite',
    'dlsiteen',
    'dmm',
    'egs',
    'egs_creator',
    'erotrail',
    'facebook',
    'fakku',
    'fanbox',
    'freegame',
    'freem',
    'gamefaqs_comp',
    'gamejolt',
    'getchu',
    'getchudl',
    'gog',
    'googplay',
    'gyutto',
    'imdb',
    'instagram',
    'itch',
    'itch_dev',
    'jastusa',
    'jlist',
    'kofi',
    'mbrainz',
    'melon',
    'melonjp',
    'mg',
    'mobygames',
    'mobygames_comp',
    'nintendo',
    'nintendo_hk',
    'nintendo_jp',
    'novelgam',
    'nutaku',
    'patreon',
    'patreonp',
    'pixiv',
    'playstation_eu',
    'playstation_hk',
    'playstation_jp',
    'playstation_na',
    'scloud',
    'steam',
    'steam_curator',
    'substar',
    'toranoana',
    'tumblr',
    'twitter',
    'vgmdb',
    'vgmdb_org',
    'vk',
    'vndb',
    'website',
    'weibo',
    'wikidata',
    'wp',
    'youtube'
);
CREATE TYPE language          AS ENUM ('ar', 'be', 'bg', 'ca', 'cs', 'ck', 'da', 'de', 'el', 'en', 'eo', 'es', 'eu', 'fa', 'fi', 'fr', 'ga', 'gl', 'gd', 'he', 'hi', 'hr', 'hu', 'id', 'it', 'iu', 'ja', 'kk', 'ko', 'mk', 'ms', 'ne', 'la', 'lt', 'lv', 'nl', 'no', 'pl', 'pt-pt', 'pt-br', 'ro', 'ru', 'sk', 'sl', 'sr', 'sv', 'ta', 'th', 'tr', 'uk', 'ur', 'vi', 'zh', 'zh-Hans', 'zh-Hant');
CREATE TYPE medium            AS ENUM ('cd', 'dvd', 'gdr', 'blr', 'flp', 'cas', 'mrt', 'mem', 'umd', 'nod', 'in', 'dc', 'otc');
CREATE TYPE platform          AS ENUM ('win', 'dos', 'lin', 'mac', 'ios', 'and', 'dvd', 'bdp', 'fm7', 'fm8', 'fmt', 'gba', 'gbc', 'msx', 'nds', 'nes', 'p88', 'p98', 'pce', 'pcf', 'psp', 'ps1', 'ps2', 'ps3', 'ps4', 'ps5', 'psv', 'drc', 'smd', 'scd', 'sat', 'sfc', 'swi', 'sw2', 'wii', 'wiu', 'n3d', 'vnd', 'x1s', 'x68', 'xb1', 'xb3', 'xbo', 'xxs', 'web', 'tdo', 'mob', 'oth');
CREATE TYPE producer_relation AS ENUM ('old', 'new', 'sub', 'par', 'imp', 'ipa', 'spa', 'ori');
CREATE TYPE producer_type     AS ENUM ('co', 'in', 'ng');
CREATE TYPE release_image_type AS ENUM ('pkgfront', 'pkgback', 'pkgcontent', 'pkgside', 'pkgmed', 'dig');
CREATE TYPE release_type      AS ENUM ('complete', 'partial', 'trial');
CREATE TYPE staff_gender      AS ENUM ('', 'm', 'f');
CREATE TYPE tag_category      AS ENUM('cont', 'ero', 'tech');
CREATE TYPE vn_relation       AS ENUM ('seq', 'preq', 'set', 'alt', 'char', 'side', 'par', 'ser', 'fan', 'orig');


SELECT EXISTS(SELECT 1 FROM pg_type WHERE typname = 'vndbtag') as has_vndbtag\gset
\if :has_vndbtag
\i /docker-entrypoint-initdb.d/import/schema_vndbid.sql
\else
  \i schema_plain.sql
\endif


-- You can comment out tables you don't need, to speed up the import and save some disk space.
\copy anime from 'db/anime'
\copy chars from 'db/chars'
\copy chars_traits from 'db/chars_traits'
\copy chars_vns from 'db/chars_vns'
-- \copy docs from 'db/docs'
-- \copy entry_meta from 'db/entry_meta'
\copy extlinks from 'db/extlinks'
-- \copy image_votes from 'db/image_votes'
\copy images from 'db/images'
\copy producers from 'db/producers'
\copy producers_extlinks from 'db/producers_extlinks'
\copy producers_relations from 'db/producers_relations'
\copy quotes from 'db/quotes'
\copy releases from 'db/releases'
\copy releases_extlinks from 'db/releases_extlinks'
\copy releases_images from 'db/releases_images'
\copy releases_media from 'db/releases_media'
\copy releases_platforms from 'db/releases_platforms'
\copy releases_producers from 'db/releases_producers'
\copy releases_supersedes from 'db/releases_supersedes'
\copy releases_titles from 'db/releases_titles'
\copy releases_vn from 'db/releases_vn'
-- \copy rlists from 'db/rlists'
\copy staff from 'db/staff'
\copy staff_alias from 'db/staff_alias'
\copy staff_extlinks from 'db/staff_extlinks'
\copy tags from 'db/tags'
\copy tags_parents from 'db/tags_parents'
\copy tags_vn from 'db/tags_vn'
\copy traits from 'db/traits'
\copy traits_parents from 'db/traits_parents'
--\copy ulist_labels from 'db/ulist_labels'
--\copy ulist_vns from 'db/ulist_vns'
--\copy users from 'db/users'
\copy vn from 'db/vn'
\copy vn_anime from 'db/vn_anime'
\copy vn_editions from 'db/vn_editions'
--\copy vn_image_votes from 'db/vn_image_votes'
\copy vn_length_votes from 'db/vn_length_votes'
\copy vn_relations from 'db/vn_relations'
\copy vn_screenshots from 'db/vn_screenshots'
\copy vn_seiyuu from 'db/vn_seiyuu'
\copy vn_staff from 'db/vn_staff'
\copy vn_titles from 'db/vn_titles'
\copy wikidata from 'db/wikidata'


-- These are included to verify the internal consistency of the dump, you can safely comment out this part.
-- Keep these - all referenced tables exist:
ALTER TABLE chars                    ADD CONSTRAINT chars_main_fkey                    FOREIGN KEY (main)      REFERENCES chars         (id);
ALTER TABLE chars                    ADD CONSTRAINT chars_image_fkey                   FOREIGN KEY (image)     REFERENCES images        (id);
ALTER TABLE chars_traits             ADD CONSTRAINT chars_traits_id_fkey               FOREIGN KEY (id)        REFERENCES chars         (id);
ALTER TABLE chars_traits             ADD CONSTRAINT chars_traits_tid_fkey              FOREIGN KEY (tid)       REFERENCES traits        (id);
ALTER TABLE chars_vns                ADD CONSTRAINT chars_vns_id_fkey                  FOREIGN KEY (id)        REFERENCES chars         (id);
ALTER TABLE chars_vns                ADD CONSTRAINT chars_vns_vid_fkey                 FOREIGN KEY (vid)       REFERENCES vn            (id);
ALTER TABLE chars_vns                ADD CONSTRAINT chars_vns_rid_fkey                 FOREIGN KEY (rid)       REFERENCES releases      (id);
ALTER TABLE producers_extlinks       ADD CONSTRAINT producers_extlinks_id_fkey         FOREIGN KEY (id)        REFERENCES producers     (id);
ALTER TABLE producers_extlinks       ADD CONSTRAINT producers_extlinks_link_fkey       FOREIGN KEY (link)      REFERENCES extlinks      (id);
ALTER TABLE producers_relations      ADD CONSTRAINT producers_relations_pid_fkey       FOREIGN KEY (pid)       REFERENCES producers     (id);
ALTER TABLE quotes                   ADD CONSTRAINT quotes_vid_fkey                    FOREIGN KEY (vid)       REFERENCES vn            (id);
ALTER TABLE quotes                   ADD CONSTRAINT quotes_cid_fkey                    FOREIGN KEY (cid)       REFERENCES chars         (id);
ALTER TABLE releases                 ADD CONSTRAINT releases_olang_fkey                FOREIGN KEY (id,olang)  REFERENCES releases_titles(id,lang) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE releases_extlinks        ADD CONSTRAINT releases_extlinks_id_fkey          FOREIGN KEY (id)        REFERENCES releases      (id);
ALTER TABLE releases_extlinks        ADD CONSTRAINT releases_extlinks_link_fkey        FOREIGN KEY (link)      REFERENCES extlinks      (id);
ALTER TABLE releases_images          ADD CONSTRAINT releases_images_id_fkey            FOREIGN KEY (id)        REFERENCES releases      (id);
ALTER TABLE releases_images          ADD CONSTRAINT releases_images_img_fkey           FOREIGN KEY (img)       REFERENCES images        (id);
ALTER TABLE releases_images          ADD CONSTRAINT releases_images_vid_fkey           FOREIGN KEY (id,vid)    REFERENCES releases_vn   (id,vid) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE releases_titles          ADD CONSTRAINT releases_titles_id_fkey            FOREIGN KEY (id)        REFERENCES releases      (id);
ALTER TABLE releases_media           ADD CONSTRAINT releases_media_id_fkey             FOREIGN KEY (id)        REFERENCES releases      (id);
ALTER TABLE releases_platforms       ADD CONSTRAINT releases_platforms_id_fkey         FOREIGN KEY (id)        REFERENCES releases      (id);
ALTER TABLE releases_producers       ADD CONSTRAINT releases_producers_id_fkey         FOREIGN KEY (id)        REFERENCES releases      (id);
ALTER TABLE releases_producers       ADD CONSTRAINT releases_producers_pid_fkey        FOREIGN KEY (pid)       REFERENCES producers     (id);
ALTER TABLE releases_supersedes      ADD CONSTRAINT releases_supersedes_id_fkey        FOREIGN KEY (id)        REFERENCES releases      (id);
ALTER TABLE releases_supersedes      ADD CONSTRAINT releases_supersedes_rid_fkey       FOREIGN KEY (rid)       REFERENCES releases      (id);
ALTER TABLE releases_vn              ADD CONSTRAINT releases_vn_id_fkey                FOREIGN KEY (id)        REFERENCES releases      (id);
ALTER TABLE releases_vn              ADD CONSTRAINT releases_vn_vid_fkey               FOREIGN KEY (vid)       REFERENCES vn            (id);
ALTER TABLE staff                    ADD CONSTRAINT staff_main_fkey                    FOREIGN KEY (main)      REFERENCES staff_alias   (aid) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE staff                    ADD CONSTRAINT staff_prod_fkey                    FOREIGN KEY (prod)      REFERENCES producers     (id);
ALTER TABLE staff_alias              ADD CONSTRAINT staff_alias_id_fkey                FOREIGN KEY (id)        REFERENCES staff         (id);
ALTER TABLE staff_extlinks           ADD CONSTRAINT staff_extlinks_id_fkey             FOREIGN KEY (id)        REFERENCES staff         (id);
ALTER TABLE staff_extlinks           ADD CONSTRAINT staff_extlinks_link_fkey           FOREIGN KEY (link)      REFERENCES extlinks      (id);
ALTER TABLE tags_parents             ADD CONSTRAINT tags_parents_id_fkey               FOREIGN KEY (id)        REFERENCES tags          (id);
ALTER TABLE tags_parents             ADD CONSTRAINT tags_parents_parent_fkey           FOREIGN KEY (parent)    REFERENCES tags          (id);
ALTER TABLE tags_vn                  ADD CONSTRAINT tags_vn_tag_fkey                   FOREIGN KEY (tag)       REFERENCES tags          (id);
ALTER TABLE tags_vn                  ADD CONSTRAINT tags_vn_vid_fkey                   FOREIGN KEY (vid)       REFERENCES vn            (id);
ALTER TABLE traits                   ADD CONSTRAINT traits_gid_fkey                    FOREIGN KEY (gid)       REFERENCES traits        (id);
ALTER TABLE traits_parents           ADD CONSTRAINT traits_parents_id_fkey             FOREIGN KEY (id)        REFERENCES traits        (id);
ALTER TABLE traits_parents           ADD CONSTRAINT traits_parents_parent_fkey         FOREIGN KEY (parent)    REFERENCES traits        (id);
ALTER TABLE vn                       ADD CONSTRAINT vn_image_fkey                      FOREIGN KEY (image)     REFERENCES images        (id);
ALTER TABLE vn                       ADD CONSTRAINT vn_l_wikidata_fkey                 FOREIGN KEY (l_wikidata)REFERENCES wikidata      (id);
ALTER TABLE vn                       ADD CONSTRAINT vn_olang_fkey                      FOREIGN KEY (id,olang)  REFERENCES vn_titles     (id,lang)   DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vn_anime                 ADD CONSTRAINT vn_anime_id_fkey                   FOREIGN KEY (id)        REFERENCES vn            (id);
ALTER TABLE vn_anime                 ADD CONSTRAINT vn_anime_aid_fkey                  FOREIGN KEY (aid)       REFERENCES anime         (id);
ALTER TABLE vn_relations             ADD CONSTRAINT vn_relations_id_fkey               FOREIGN KEY (id)        REFERENCES vn            (id);
ALTER TABLE vn_relations             ADD CONSTRAINT vn_relations_vid_fkey              FOREIGN KEY (vid)       REFERENCES vn            (id);
ALTER TABLE vn_screenshots           ADD CONSTRAINT vn_screenshots_id_fkey             FOREIGN KEY (id)        REFERENCES vn            (id);
ALTER TABLE vn_screenshots           ADD CONSTRAINT vn_screenshots_scr_fkey            FOREIGN KEY (scr)       REFERENCES images        (id);
ALTER TABLE vn_screenshots           ADD CONSTRAINT vn_screenshots_rid_fkey            FOREIGN KEY (rid)       REFERENCES releases      (id);
ALTER TABLE vn_seiyuu                ADD CONSTRAINT vn_seiyuu_id_fkey                  FOREIGN KEY (id)        REFERENCES vn            (id);
ALTER TABLE vn_seiyuu                ADD CONSTRAINT vn_seiyuu_aid_fkey                 FOREIGN KEY (aid)       REFERENCES staff_alias   (aid) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vn_seiyuu                ADD CONSTRAINT vn_seiyuu_cid_fkey                 FOREIGN KEY (cid)       REFERENCES chars         (id);
ALTER TABLE vn_staff                 ADD CONSTRAINT vn_staff_id_eid_fkey               FOREIGN KEY (id,eid)    REFERENCES vn_editions   (id,eid) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vn_staff                 ADD CONSTRAINT vn_staff_aid_fkey                  FOREIGN KEY (aid)       REFERENCES staff_alias   (aid) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vn_titles                ADD CONSTRAINT vn_titles_id_fkey                  FOREIGN KEY (id)        REFERENCES vn            (id);
-- ALTER TABLE image_votes              ADD CONSTRAINT image_votes_id_fkey                FOREIGN KEY (id)        REFERENCES images        (id) ON DELETE CASCADE;
-- ALTER TABLE image_votes              ADD CONSTRAINT image_votes_uid_fkey               FOREIGN KEY (uid)       REFERENCES users         (id) ON DELETE SET DEFAULT;
-- ALTER TABLE rlists                   ADD CONSTRAINT rlists_uid_fkey                    FOREIGN KEY (uid)       REFERENCES users         (id) ON DELETE CASCADE;
-- ALTER TABLE rlists                   ADD CONSTRAINT rlists_rid_fkey                    FOREIGN KEY (rid)       REFERENCES releases      (id);
-- ALTER TABLE tags_vn                  ADD CONSTRAINT tags_vn_uid_fkey                   FOREIGN KEY (uid)       REFERENCES users         (id) ON DELETE SET DEFAULT;
-- ALTER TABLE ulist_labels             ADD CONSTRAINT ulist_labels_uid_fkey              FOREIGN KEY (uid)       REFERENCES users         (id) ON DELETE CASCADE;
-- ALTER TABLE ulist_vns                ADD CONSTRAINT ulist_vns_uid_fkey                 FOREIGN KEY (uid)       REFERENCES users         (id) ON DELETE CASCADE;
-- ALTER TABLE ulist_vns                ADD CONSTRAINT ulist_vns_vid_fkey                 FOREIGN KEY (vid)       REFERENCES vn            (id);
ALTER TABLE vn_length_votes          ADD CONSTRAINT vn_length_votes_vid_fkey           FOREIGN KEY (vid)       REFERENCES vn            (id);
-- ALTER TABLE vn_length_votes          ADD CONSTRAINT vn_length_votes_uid_fkey           FOREIGN KEY (uid)       REFERENCES users         (id) ON DELETE SET DEFAULT;
-- ALTER TABLE vn_image_votes           ADD CONSTRAINT vn_image_votes_vid_fkey            FOREIGN KEY (vid)       REFERENCES vn            (id);
-- ALTER TABLE vn_image_votes           ADD CONSTRAINT vn_image_votes_uid_fkey            FOREIGN KEY (uid)       REFERENCES users         (id) ON DELETE CASCADE;
-- ALTER TABLE vn_image_votes           ADD CONSTRAINT vn_image_votes_img_fkey            FOREIGN KEY (img)       REFERENCES images        (id) ON DELETE CASCADE;


-- Sparse documentation, but it's something!
COMMENT ON TABLE anime IS 'Anime information fetched from AniDB, only used for linking with visual novels.';
COMMENT ON COLUMN anime.id IS 'AniDB identifier';
COMMENT ON COLUMN anime.ann_id IS 'Anime News Network identifier';
COMMENT ON COLUMN anime.nfo_id IS 'AnimeNFO identifier (unused, site is long dead)';
COMMENT ON COLUMN chars.bloodt IS 'Blood type';
COMMENT ON COLUMN chars.spoil_sex IS 'Character''s actual sex, in case it''s a spoiler';
COMMENT ON COLUMN chars.main IS 'When this character is an instance of another character';
COMMENT ON COLUMN chars.s_bust IS 'cm';
COMMENT ON COLUMN chars.s_waist IS 'cm';
COMMENT ON COLUMN chars.s_hip IS 'cm';
COMMENT ON COLUMN chars.birthday IS 'Birthday, 0 or mmdd';
COMMENT ON COLUMN chars.height IS 'cm';
COMMENT ON COLUMN chars.weight IS 'kg';
COMMENT ON COLUMN chars.age IS 'years';
-- COMMENT ON COLUMN docs.content IS 'In MultiMarkdown format';
-- COMMENT ON COLUMN entry_meta.lastmod IS 'Last modification date';
-- COMMENT ON COLUMN entry_meta.revision IS 'Latest revision number';
-- COMMENT ON COLUMN entry_meta.num_edits IS 'Number of non-bot edits';
-- COMMENT ON COLUMN entry_meta.num_users IS 'Number of users who have edited this entry';
-- COMMENT ON COLUMN image_votes.sexual IS '0 = safe, 1 = suggestive, 2 = explicit';
-- COMMENT ON COLUMN image_votes.violence IS '0 = tame, 1 = violent, 2 = brutal';
-- COMMENT ON COLUMN image_votes.ignore IS 'Set when overruled by a moderator';
COMMENT ON COLUMN images.width IS 'px';
COMMENT ON COLUMN images.height IS 'px';
COMMENT ON COLUMN images.c_sexual_avg IS '0 - 200, so average vote * 100';
COMMENT ON COLUMN images.c_violence_avg IS '0 - 200';
COMMENT ON COLUMN images.c_weight IS 'Random selection weight for the image flagging UI';
COMMENT ON COLUMN releases.gtin IS 'JAN/UPC/EAN/ISBN';
COMMENT ON COLUMN releases.olang IS 'Refers to the main title to use for display purposes, not necessarily the original language.';
COMMENT ON COLUMN releases.reso_x IS 'When reso_x is 0, reso_y is either 0 for ''unknown'' or 1 for ''non-standard''.';
COMMENT ON COLUMN releases.minage IS 'Age rating, 0 - 18';
COMMENT ON COLUMN releases.ani_story IS '(old, superseded by the newer ani_* columns)';
COMMENT ON COLUMN releases.ani_ero IS '(^ but the newer columns haven''t been filled out much)';
COMMENT ON COLUMN releases.ani_story_sp IS 'Story sprite animation';
COMMENT ON COLUMN releases.ani_story_cg IS 'Story CG animation';
COMMENT ON COLUMN releases.ani_cutscene IS 'Cutscene animation';
COMMENT ON COLUMN releases.ani_ero_sp IS 'Ero scene sprite animation';
COMMENT ON COLUMN releases.ani_ero_cg IS 'Ero scene CG animation';
COMMENT ON COLUMN releases.ani_bg IS 'Background effects';
COMMENT ON COLUMN releases.ani_face IS 'Eye blink / lip sync';
-- COMMENT ON TABLE rlists IS 'User''s releases list';
-- COMMENT ON COLUMN rlists.status IS '0 = Unknown, 1 = Pending, 2 = Obtained, 3 = On loan, 4 = Deleted';
COMMENT ON COLUMN staff.main IS 'Primary name for the staff entry';
COMMENT ON COLUMN staff_alias.aid IS 'Globally unique ID of this alias';
COMMENT ON COLUMN tags_vn.vote IS 'negative for downvote, 1-3 otherwise';
COMMENT ON COLUMN tags_vn.lie IS 'implies spoiler=0';
COMMENT ON COLUMN traits.gid IS 'Trait group (technically a cached column, main parent''s root trait)';
COMMENT ON COLUMN traits.gorder IS 'Group order, only used when gid IS NULL';
-- COMMENT ON TABLE ulist_labels IS 'User labels assigned to visual novels';
-- COMMENT ON COLUMN ulist_labels.id IS '0 < builtin < 10 <= custom, ids are reused';
-- COMMENT ON TABLE ulist_vns IS 'User''s VN lists';
-- COMMENT ON COLUMN ulist_vns.lastmod IS 'updated when any column in this row has changed';
-- COMMENT ON COLUMN ulist_vns.vote_date IS 'Not updated when the vote is changed';
-- COMMENT ON COLUMN ulist_vns.vote IS '0 - 100';
-- COMMENT ON COLUMN users.ign_votes IS 'Set when user''s votes are ignored';
-- COMMENT ON COLUMN users.perm_imgvote IS 'User''s image votes don''t count when false';
-- COMMENT ON COLUMN users.perm_tag IS 'User''s tag votes don''t count when false';
-- COMMENT ON COLUMN users.perm_lengthvote IS 'User''s length votes don''t count when false';
COMMENT ON COLUMN vn.image IS 'deprecated, replaced with c_image';
COMMENT ON COLUMN vn.olang IS 'Original language';
COMMENT ON COLUMN vn.c_rating IS 'decimal vote*100, i.e. 100 - 1000';
COMMENT ON COLUMN vn.c_average IS 'decimal vote*100, i.e. 100 - 1000';
COMMENT ON COLUMN vn.length IS 'Old length field, 0 = unknown, 1 = very short [..] 5 = very long';
COMMENT ON COLUMN vn.devstatus IS '0 = finished, 1 = ongoing, 2 = cancelled';
COMMENT ON COLUMN vn.l_renai IS 'Renai.us identifier';
COMMENT ON COLUMN vn_editions.eid IS 'Edition identifier, local to the VN, not stable across revisions';
COMMENT ON COLUMN vn_length_votes.length IS 'minutes';
COMMENT ON COLUMN vn_length_votes.speed IS 'NULL=uncounted/ignored, 0=slow, 1=normal, 2=fast';
COMMENT ON COLUMN vn_length_votes.lang IS 'NULL for votes before 2025-06-05, inferred from the release language(s) in that case';
COMMENT ON TABLE wikidata IS 'Information fetched from Wikidata';
COMMENT ON COLUMN wikidata.id IS 'Q-number';
COMMENT ON COLUMN wikidata.website IS 'P856';
COMMENT ON COLUMN wikidata.vndb IS 'P3180';
COMMENT ON COLUMN wikidata.mobygames IS 'P1933';
COMMENT ON COLUMN wikidata.mobygames_company IS 'P4773';
COMMENT ON COLUMN wikidata.gamefaqs_game IS 'P4769';
COMMENT ON COLUMN wikidata.gamefaqs_company IS 'P6182';
COMMENT ON COLUMN wikidata.anidb_anime IS 'P5646';
COMMENT ON COLUMN wikidata.anidb_person IS 'P5649';
COMMENT ON COLUMN wikidata.ann_anime IS 'P1985';
COMMENT ON COLUMN wikidata.ann_manga IS 'P1984';
COMMENT ON COLUMN wikidata.musicbrainz_artist IS 'P434';
COMMENT ON COLUMN wikidata.twitter IS 'P2002';
COMMENT ON COLUMN wikidata.vgmdb_product IS 'P5659';
COMMENT ON COLUMN wikidata.vgmdb_artist IS 'P3435';
COMMENT ON COLUMN wikidata.discogs_artist IS 'P1953';
COMMENT ON COLUMN wikidata.acdb_char IS 'P7013';
COMMENT ON COLUMN wikidata.acdb_source IS 'P7017';
COMMENT ON COLUMN wikidata.indiedb_game IS 'P6717';
COMMENT ON COLUMN wikidata.howlongtobeat IS 'P2816';
COMMENT ON COLUMN wikidata.crunchyroll IS 'P4110';
COMMENT ON COLUMN wikidata.igdb_game IS 'P5794';
COMMENT ON COLUMN wikidata.giantbomb IS 'P5247';
COMMENT ON COLUMN wikidata.pcgamingwiki IS 'P6337';
COMMENT ON COLUMN wikidata.steam IS 'P1733';
COMMENT ON COLUMN wikidata.gog IS 'P2725';
COMMENT ON COLUMN wikidata.pixiv_user IS 'P5435';
COMMENT ON COLUMN wikidata.doujinshi_author IS 'P7511';
COMMENT ON COLUMN wikidata.soundcloud IS 'P3040';
COMMENT ON COLUMN wikidata.humblestore IS 'P4477';
COMMENT ON COLUMN wikidata.itchio IS 'P7294';
COMMENT ON COLUMN wikidata.playstation_jp IS 'P5999';
COMMENT ON COLUMN wikidata.playstation_na IS 'P5944';
COMMENT ON COLUMN wikidata.playstation_eu IS 'P5971';
COMMENT ON COLUMN wikidata.lutris IS 'P7597';
COMMENT ON COLUMN wikidata.wine IS 'P600';
