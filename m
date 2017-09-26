From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: another inconsistent pg issue
Date: Tue, 26 Sep 2017 16:09:32 -0400
Message-ID: <CAGbviv+uH_5JV73UF76EkR0B2waES7q+3prnj8J2Z3uP+J+uFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:45579 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966382AbdIZUJf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Sep 2017 16:09:35 -0400
Received: by mail-lf0-f43.google.com with SMTP id d17so5683588lfe.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 Sep 2017 13:09:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I  have a new inconsistent pg that says "scrub stat mismatch".  There
is no indication of which object is missing, though. Not sure how to
clean this up.  pg repair and deep-scrub are not fixing it.

/var/log/ceph/ceph-osd.81.log:780:2017-09-26 11:37:35.898029
7fc9072af700 -1 log_channel(cluster) log [ERR] : 1.608 scrub stat
mismatch, got 8207/8209 objects, 2178/2179 clones, 8207/8209 dirty,
0/0 omap, 0/0 pinned, 0/0 hit_set_archive, 0/0 whiteouts,
13237771959/13239309537 bytes, 0/0 hit_set_archive bytes.
/var/log/ceph/ceph-osd.81.log:782:2017-09-26 11:37:35.898162
7fc9072af700 -1 log_channel(cluster) log [ERR] : 1.608 scrub 1 errors


Rados doesnt show any inconsistent objects in the PG, though.

$ rados list-inconsistent-obj 1.608
{"epoch":264424,"inconsistents":[]}


$ ceph pg 1.608 query
{
    "state": "active+clean+inconsistent",
    "snap_trimq": "[]",
    "epoch": 269494,
    "up": [
        81,
        75,
        36
    ],
    "acting": [
        81,
        75,
        36
    ],
    "actingbackfill": [
        "36",
        "75",
        "81"
    ],
    "info": {
        "pgid": "1.608",
        "last_update": "269249'234346",
        "last_complete": "269249'234346",
        "log_tail": "244856'231298",
        "last_user_version": 234346,
        "last_backfill": "MAX",
        "last_backfill_bitwise": 1,
        "purged_snaps": "[2~4,e0~2,1c7~1,a2f~2,12c0~1,12cc~3,12d0~7]",
        "history": {
            "epoch_created": 23117,
            "last_epoch_started": 264425,
            "last_epoch_clean": 264425,
            "last_epoch_split": 0,
            "last_epoch_marked_full": 0,
            "same_up_since": 264423,
            "same_interval_since": 264424,
            "same_primary_since": 260548,
            "last_scrub": "269249'234346",
            "last_scrub_stamp": "2017-09-26 11:37:35.898185",
            "last_deep_scrub": "113820'222872",
            "last_deep_scrub_stamp": "2017-09-08 03:14:01.429978",
            "last_clean_scrub_stamp": "2017-09-08 03:14:01.429978"
        },
        "stats": {
            "version": "269249'234346",
            "reported_seq": "237227",
            "reported_epoch": "269494",
            "state": "active+clean+inconsistent",
            "last_fresh": "2017-09-26 16:07:04.599995",
            "last_change": "2017-09-26 11:37:35.898366",
            "last_active": "2017-09-26 16:07:04.599995",
            "last_peered": "2017-09-26 16:07:04.599995",
            "last_clean": "2017-09-26 16:07:04.599995",
            "last_became_active": "2017-09-22 16:23:28.866514",
            "last_became_peered": "2017-09-22 16:23:28.866514",
            "last_unstale": "2017-09-26 16:07:04.599995",
            "last_undegraded": "2017-09-26 16:07:04.599995",
            "last_fullsized": "2017-09-26 16:07:04.599995",
            "mapping_epoch": 264423,
            "log_start": "244856'231298",
            "ondisk_log_start": "244856'231298",
            "created": 23117,
            "last_epoch_clean": 264425,
            "parent": "0.0",
            "parent_split_bits": 11,
            "last_scrub": "269249'234346",
            "last_scrub_stamp": "2017-09-26 11:37:35.898185",
            "last_deep_scrub": "113820'222872",
            "last_deep_scrub_stamp": "2017-09-08 03:14:01.429978",
            "last_clean_scrub_stamp": "2017-09-08 03:14:01.429978",
            "log_size": 3048,
            "ondisk_log_size": 3048,
            "stats_invalid": false,
            "dirty_stats_invalid": false,
            "omap_stats_invalid": false,
            "hitset_stats_invalid": false,
            "hitset_bytes_stats_invalid": false,
            "pin_stats_invalid": true,
            "stat_sum": {
                "num_bytes": 13239309537,
                "num_objects": 8209,
                "num_object_clones": 2179,
                "num_object_copies": 24627,
                "num_objects_missing_on_primary": 0,
                "num_objects_missing": 0,
                "num_objects_degraded": 0,
                "num_objects_misplaced": 0,
                "num_objects_unfound": 0,
                "num_objects_dirty": 8209,
                "num_whiteouts": 0,
                "num_read": 62339,
                "num_read_kb": 73941261,
                "num_write": 19592,
                "num_write_kb": 12102896,
                "num_scrub_errors": 1,
                "num_shallow_scrub_errors": 1,
                "num_deep_scrub_errors": 0,
                "num_objects_recovered": 93354,
                "num_bytes_recovered": 142746697426,
                "num_keys_recovered": 0,
                "num_objects_omap": 0,
                "num_objects_hit_set_archive": 0,
                "num_bytes_hit_set_archive": 0,
                "num_flush": 0,
                "num_flush_kb": 0,
                "num_evict": 0,
                "num_evict_kb": 0,
                "num_promote": 0,
                "num_flush_mode_high": 0,
                "num_flush_mode_low": 0,
                "num_evict_mode_some": 0,
                "num_evict_mode_full": 0,
                "num_objects_pinned": 0
            },
            "up": [
                81,
                75,
                36
            ],
            "acting": [
                81,
                75,
                36
            ],
            "blocked_by": [],
            "up_primary": 81,
            "acting_primary": 81
        },
        "empty": 0,
        "dne": 0,
        "incomplete": 0,
        "last_epoch_started": 264425,
        "hit_set_history": {
            "current_last_update": "0'0",
            "history": []
        }
    },
    "peer_info": [
        {
            "peer": "36",
            "pgid": "1.608",
            "last_update": "269249'234346",
            "last_complete": "269249'234346",
            "log_tail": "244780'230891",
            "last_user_version": 0,
            "last_backfill": "MAX",
            "last_backfill_bitwise": 1,
            "purged_snaps": "[2~4,e0~2,1c7~1,a2f~2,12c0~1,12cc~3,12d0~7]",
            "history": {
                "epoch_created": 23117,
                "last_epoch_started": 264425,
                "last_epoch_clean": 264425,
                "last_epoch_split": 0,
                "last_epoch_marked_full": 0,
                "same_up_since": 264423,
                "same_interval_since": 264424,
                "same_primary_since": 260548,
                "last_scrub": "269249'234346",
                "last_scrub_stamp": "2017-09-26 11:37:35.898185",
                "last_deep_scrub": "113820'222872",
                "last_deep_scrub_stamp": "2017-09-08 03:14:01.429978",
                "last_clean_scrub_stamp": "2017-09-08 03:14:01.429978"
            },
            "stats": {
                "version": "245006'233891",
                "reported_seq": "235477",
                "reported_epoch": "251873",
                "state": "active+undersized+degraded+remapped+backfilling",
                "last_fresh": "2017-09-21 00:52:16.967954",
                "last_change": "2017-09-20 22:41:38.726616",
                "last_active": "2017-09-21 00:52:16.967954",
                "last_peered": "2017-09-21 00:52:16.967954",
                "last_clean": "2017-09-20 21:34:23.603267",
                "last_became_active": "2017-09-20 21:51:35.892368",
                "last_became_peered": "2017-09-20 21:51:35.892368",
                "last_unstale": "2017-09-21 00:52:16.967954",
                "last_undegraded": "2017-09-20 21:50:41.575351",
                "last_fullsized": "2017-09-20 21:50:41.575351",
                "mapping_epoch": 264423,
                "log_start": "177919'223463",
                "ondisk_log_start": "177919'223463",
                "created": 23117,
                "last_epoch_clean": 244780,
                "parent": "0.0",
                "parent_split_bits": 11,
                "last_scrub": "113820'222872",
                "last_scrub_stamp": "2017-09-08 03:14:01.429978",
                "last_deep_scrub": "113820'222872",
                "last_deep_scrub_stamp": "2017-09-08 03:14:01.429978",
                "last_clean_scrub_stamp": "2017-09-08 03:14:01.429978",
                "log_size": 10428,
                "ondisk_log_size": 10428,
                "stats_invalid": false,
                "dirty_stats_invalid": false,
                "omap_stats_invalid": false,
                "hitset_stats_invalid": false,
                "hitset_bytes_stats_invalid": false,
                "pin_stats_invalid": true,
                "stat_sum": {
                    "num_bytes": 13239309537,
                    "num_objects": 8209,
                    "num_object_clones": 2028,
                    "num_object_copies": 24627,
                    "num_objects_missing_on_primary": 0,
                    "num_objects_missing": 0,
                    "num_objects_degraded": 0,
                    "num_objects_misplaced": 0,
                    "num_objects_unfound": 0,
                    "num_objects_dirty": 8209,
                    "num_whiteouts": 0,
                    "num_read": 61917,
                    "num_read_kb": 73302073,
                    "num_write": 19437,
                    "num_write_kb": 12102896,
                    "num_scrub_errors": 0,
                    "num_shallow_scrub_errors": 0,
                    "num_deep_scrub_errors": 0,
                    "num_objects_recovered": 93354,
                    "num_bytes_recovered": 142746697426,
                    "num_keys_recovered": 0,
                    "num_objects_omap": 0,
                    "num_objects_hit_set_archive": 0,
                    "num_bytes_hit_set_archive": 0,
                    "num_flush": 0,
                    "num_flush_kb": 0,
                    "num_evict": 0,
                    "num_evict_kb": 0,
                    "num_promote": 0,
                    "num_flush_mode_high": 0,
                    "num_flush_mode_low": 0,
                    "num_evict_mode_some": 0,
                    "num_evict_mode_full": 0,
                    "num_objects_pinned": 0
                },
                "up": [
                    81,
                    75,
                    36
                ],
                "acting": [
                    81,
                    75,
                    36
                ],
                "blocked_by": [],
                "up_primary": 81,
                "acting_primary": 81
            },
            "empty": 0,
            "dne": 0,
            "incomplete": 0,
            "last_epoch_started": 264425,
            "hit_set_history": {
                "current_last_update": "0'0",
                "history": []
            }
        },
        {
            "peer": "75",
            "pgid": "1.608",
            "last_update": "269249'234346",
            "last_complete": "269249'234346",
            "log_tail": "177919'223463",
            "last_user_version": 226465,
            "last_backfill": "MAX",
            "last_backfill_bitwise": 1,
            "purged_snaps": "[2~4,e0~2,1c7~1,a2f~2,12c0~1,12cc~3,12d0~7]",
            "history": {
                "epoch_created": 23117,
                "last_epoch_started": 264425,
                "last_epoch_clean": 264425,
                "last_epoch_split": 0,
                "last_epoch_marked_full": 0,
                "same_up_since": 264423,
                "same_interval_since": 264424,
                "same_primary_since": 260548,
                "last_scrub": "269249'234346",
                "last_scrub_stamp": "2017-09-26 11:37:35.898185",
                "last_deep_scrub": "113820'222872",
                "last_deep_scrub_stamp": "2017-09-08 03:14:01.429978",
                "last_clean_scrub_stamp": "2017-09-08 03:14:01.429978"
            },
            "stats": {
                "version": "245006'233891",
                "reported_seq": "235774",
                "reported_epoch": "264424",
                "state": "peering",
                "last_fresh": "2017-09-22 08:01:16.981982",
                "last_change": "2017-09-22 08:01:16.935337",
                "last_active": "2017-09-21 15:21:00.706884",
                "last_peered": "2017-09-21 15:21:00.706884",
                "last_clean": "2017-09-20 21:34:23.603267",
                "last_became_active": "2017-09-21 15:21:00.706769",
                "last_became_peered": "2017-09-21 15:21:00.706769",
                "last_unstale": "2017-09-22 08:01:16.981982",
                "last_undegraded": "2017-09-22 08:01:16.981982",
                "last_fullsized": "2017-09-22 08:01:16.981982",
                "mapping_epoch": 264423,
                "log_start": "177919'223463",
                "ondisk_log_start": "177919'223463",
                "created": 23117,
                "last_epoch_clean": 256588,
                "parent": "0.0",
                "parent_split_bits": 11,
                "last_scrub": "113820'222872",
                "last_scrub_stamp": "2017-09-08 03:14:01.429978",
                "last_deep_scrub": "113820'222872",
                "last_deep_scrub_stamp": "2017-09-08 03:14:01.429978",
                "last_clean_scrub_stamp": "2017-09-08 03:14:01.429978",
                "log_size": 10428,
                "ondisk_log_size": 10428,
                "stats_invalid": false,
                "dirty_stats_invalid": false,
                "omap_stats_invalid": false,
                "hitset_stats_invalid": false,
                "hitset_bytes_stats_invalid": false,
                "pin_stats_invalid": true,
                "stat_sum": {
                    "num_bytes": 13239309537,
                    "num_objects": 8209,
                    "num_object_clones": 2028,
                    "num_object_copies": 24627,
                    "num_objects_missing_on_primary": 0,
                    "num_objects_missing": 0,
                    "num_objects_degraded": 0,
                    "num_objects_misplaced": 0,
                    "num_objects_unfound": 0,
                    "num_objects_dirty": 8209,
                    "num_whiteouts": 0,
                    "num_read": 61917,
                    "num_read_kb": 73302073,
                    "num_write": 19437,
                    "num_write_kb": 12102896,
                    "num_scrub_errors": 0,
                    "num_shallow_scrub_errors": 0,
                    "num_deep_scrub_errors": 0,
                    "num_objects_recovered": 93354,
                    "num_bytes_recovered": 142746697426,
                    "num_keys_recovered": 0,
                    "num_objects_omap": 0,
                    "num_objects_hit_set_archive": 0,
                    "num_bytes_hit_set_archive": 0,
                    "num_flush": 0,
                    "num_flush_kb": 0,
                    "num_evict": 0,
                    "num_evict_kb": 0,
                    "num_promote": 0,
                    "num_flush_mode_high": 0,
                    "num_flush_mode_low": 0,
                    "num_evict_mode_some": 0,
                    "num_evict_mode_full": 0,
                    "num_objects_pinned": 0
                },
                "up": [
                    81,
                    75,
                    36
                ],
                "acting": [
                    81,
                    75,
                    36
                ],
                "blocked_by": [],
                "up_primary": 81,
                "acting_primary": 81
            },
            "empty": 0,
            "dne": 0,
            "incomplete": 0,
            "last_epoch_started": 264425,
            "hit_set_history": {
                "current_last_update": "0'0",
                "history": []
            }
        }
    ],
    "recovery_state": [
        {
            "name": "Started\/Primary\/Active",
            "enter_time": "2017-09-22 16:23:28.817966",
            "might_have_unfound": [],
            "recovery_progress": {
                "backfill_targets": [],
                "waiting_on_backfill": [],
                "last_backfill_started": "MIN",
                "backfill_info": {
                    "begin": "MIN",
                    "end": "MIN",
                    "objects": []
                },
                "peer_backfill_info": [],
                "backfills_in_flight": [],
                "recovering": [],
                "pg_backend": {
                    "pull_from_peer": [],
                    "pushing": []
                }
            },
            "scrub": {
                "scrubber.epoch_start": "264424",
                "scrubber.active": 0,
                "scrubber.state": "INACTIVE",
                "scrubber.start": "MIN",
                "scrubber.end": "MIN",
                "scrubber.subset_last_update": "0'0",
                "scrubber.deep": false,
                "scrubber.seed": 0,
                "scrubber.waiting_on": 0,
                "scrubber.waiting_on_whom": []
            }
        },
        {
            "name": "Started",
            "enter_time": "2017-09-22 16:23:27.770833"
        }
    ],
    "agent_state": {}
}
