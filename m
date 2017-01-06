From: Samuel Just <sjust@redhat.com>
Subject: Re: PG stuck unclean after rebalance-by-weight
Date: Fri, 6 Jan 2017 07:54:14 -0800
Message-ID: <CAN=+7FX2c=SGkX2dyD78BLWYsezCTdfLX_mwiSCUtqKjtVpZdw@mail.gmail.com>
References: <F6CE90086791D84F8329539EF4C81484E0241E59@GRPCPHMBX11.ramboll-group.global.network>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35974 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936616AbdAFPyQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 10:54:16 -0500
Received: by mail-qk0-f172.google.com with SMTP id n21so468399651qka.3
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2017 07:54:15 -0800 (PST)
In-Reply-To: <F6CE90086791D84F8329539EF4C81484E0241E59@GRPCPHMBX11.ramboll-group.global.network>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Dueholm Christensen <JEDC@ramboll.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

You should not have min_size set to 1, set it to 2 (not related to
your problem, but important).

http://docs.ceph.com/docs/master/rados/operations/crush-map/ has a
summary of the crush map tunables.

You might try kicking tunable choose_total_tries 50 to 75.  You should
use osdmaptool on an osdmap grabbed from your cluster to experiment
with new crushmap settings without actually injecting the new
crushmap.
-Sam


On Thu, Jan 5, 2017 at 2:08 PM, Jens Dueholm Christensen
<JEDC@ramboll.com> wrote:
> Hi list
>
> I was told to post here after asking for advice in #ceph-devel on IRC..
>
> As subject says, I've got a PG (ID 2.143) stuck after doing a routing rebalance-by-weight to level out usage of my cluster.
>
>
> I have tried reparing the PG with a "ceph pg repair 2.143" and I've tried restarting all acting OSDs (osd.1, osd.11 and osd.13) for that PG - all to no avail.
>
> Logs from MON and OSDs around the time the PG becase stuck are all uninteresting - only the MON sees that the PG is stuck.
>
> Please advice on how to proceed - this is a production level cluster that has been running without incident for more than a year, and I cannot afford to loose the PG or the data it holds just by discarding it.
>
>
> Below are details such as:
>
> * Ceph version
> * Basic status (ceph -s)
> * Dump of stuck PGs (ceph pg dump_stuck unclean)
> * list_missing for the affected PG (ceph pg 2.143 list_missing)
> * query for the affected PG (ceph pg 2.143 query)
> * Decompiled CRUSHmap from epoch 14750
> * OSDmap in plain text from epoch 14750
>
> If further information is needed I will be happy to provide it.
>
>
> Only information listed above below this line.
>
> ------
>
> jedc@web11:/home/jedc>$ ceph -v
> ceph version 0.94.9 (fe6d859066244b97b24f09d46552afc2071e6f90)
>
> ------
>
> jedc@web11:/home/jedc>$ sudo ceph -s
>     cluster 0e754a32-1085-4e79-8088-88f429061280
>      health HEALTH_WARN
>             1 pgs stuck unclean
>             recovery 1291/3981807 objects misplaced (0.032%)
>      monmap e3: 3 mons at {ceph1=192.168.82.1:6789/0,ceph2=192.168.82.3:6789/0,ceph3=192.168.82.5:6789/0}
>             election epoch 442, quorum 0,1,2 ceph1,ceph2,ceph3
>      osdmap e14750: 18 osds: 18 up, 18 in; 1 remapped pgs
>       pgmap v23244561: 1024 pgs, 1 pools, 4904 GB data, 1296 kobjects
>             14650 GB used, 74739 GB / 89389 GB avail
>             1291/3981807 objects misplaced (0.032%)
>                 1023 active+clean
>                    1 active+remapped
>   client io 380 kB/s rd, 54679 kB/s wr, 330 op/s
>
> ------
>
> jedc@web11:/home/jedc>$ sudo ceph pg dump_stuck unclean
> ok
> pg_stat state   up      up_primary      acting  acting_primary
> 2.143   active+remapped [11,13] 11      [11,13,1]       11
>
> ------
>
> jedc@web11:/home/jedc>$ sudo ceph pg 2.143 list_missing
> {
>     "offset": {
>         "oid": "",
>         "key": "",
>         "snapid": 0,
>         "hash": 0,
>         "max": 0,
>         "pool": -1,
>         "namespace": ""
>     },
>     "num_missing": 0,
>     "num_unfound": 0,
>     "objects": [],
>     "more": 0
> }
>
> ------
>
> jedc@web11:/home/jedc>$ sudo ceph pg 2.143 query
> {
>     "state": "active+remapped",
>     "snap_trimq": "[]",
>     "epoch": 14750,
>     "up": [
>         11,
>         13
>     ],
>     "acting": [
>         11,
>         13,
>         1
>     ],
>     "actingbackfill": [
>         "1",
>         "11",
>         "13"
>     ],
>     "info": {
>         "pgid": "2.143",
>         "last_update": "14750'888611",
>         "last_complete": "14750'888611",
>         "log_tail": "14746'885604",
>         "last_user_version": 888611,
>         "last_backfill": "MAX",
>         "purged_snaps": "[]",
>         "history": {
>             "epoch_created": 87,
>             "last_epoch_started": 14750,
>             "last_epoch_clean": 14750,
>             "last_epoch_split": 0,
>             "same_up_since": 14749,
>             "same_interval_since": 14749,
>             "same_primary_since": 14741,
>             "last_scrub": "14365'883104",
>             "last_scrub_stamp": "2017-01-05 01:42:49.031661",
>             "last_deep_scrub": "14365'883104",
>             "last_deep_scrub_stamp": "2017-01-05 01:42:49.031661",
>             "last_clean_scrub_stamp": "2017-01-05 01:42:49.031661"
>         },
>         "stats": {
>             "version": "14750'888611",
>             "reported_seq": "1087017",
>             "reported_epoch": "14750",
>             "state": "active+remapped",
>             "last_fresh": "2017-01-05 21:19:23.365312",
>             "last_change": "2017-01-05 21:14:17.749771",
>             "last_active": "2017-01-05 21:19:23.365312",
>             "last_peered": "2017-01-05 21:19:23.365312",
>             "last_clean": "2017-01-05 14:50:29.665704",
>             "last_became_active": "0.000000",
>             "last_became_peered": "0.000000",
>             "last_unstale": "2017-01-05 21:19:23.365312",
>             "last_undegraded": "2017-01-05 21:19:23.365312",
>             "last_fullsized": "2017-01-05 21:19:23.365312",
>             "mapping_epoch": 14747,
>             "log_start": "14746'885604",
>             "ondisk_log_start": "14746'885604",
>             "created": 87,
>             "last_epoch_clean": 14750,
>             "parent": "0.0",
>             "parent_split_bits": 0,
>             "last_scrub": "14365'883104",
>             "last_scrub_stamp": "2017-01-05 01:42:49.031661",
>             "last_deep_scrub": "14365'883104",
>             "last_deep_scrub_stamp": "2017-01-05 01:42:49.031661",
>             "last_clean_scrub_stamp": "2017-01-05 01:42:49.031661",
>             "log_size": 3007,
>             "ondisk_log_size": 3007,
>             "stats_invalid": "0",
>             "stat_sum": {
>                 "num_bytes": 5145563136,
>                 "num_objects": 1291,
>                 "num_object_clones": 0,
>                 "num_object_copies": 3873,
>                 "num_objects_missing_on_primary": 0,
>                 "num_objects_degraded": 0,
>                 "num_objects_misplaced": 1291,
>                 "num_objects_unfound": 0,
>                 "num_objects_dirty": 1291,
>                 "num_whiteouts": 0,
>                 "num_read": 936667,
>                 "num_read_kb": 24755508,
>                 "num_write": 1714757,
>                 "num_write_kb": 90534516,
>                 "num_scrub_errors": 0,
>                 "num_shallow_scrub_errors": 0,
>                 "num_deep_scrub_errors": 0,
>                 "num_objects_recovered": 7341,
>                 "num_bytes_recovered": 29177446400,
>                 "num_keys_recovered": 0,
>                 "num_objects_omap": 0,
>                 "num_objects_hit_set_archive": 0,
>                 "num_bytes_hit_set_archive": 0
>             },
>             "up": [
>                 11,
>                 13
>             ],
>             "acting": [
>                 11,
>                 13,
>                 1
>             ],
>             "blocked_by": [],
>             "up_primary": 11,
>             "acting_primary": 11
>         },
>         "empty": 0,
>         "dne": 0,
>         "incomplete": 0,
>         "last_epoch_started": 14750,
>         "hit_set_history": {
>             "current_last_update": "0'0",
>             "current_last_stamp": "0.000000",
>             "current_info": {
>                 "begin": "0.000000",
>                 "end": "0.000000",
>                 "version": "0'0",
>                 "using_gmt": "0"
>             },
>             "history": []
>         }
>     },
>     "peer_info": [
>         {
>             "peer": "1",
>             "pgid": "2.143",
>             "last_update": "14750'888611",
>             "last_complete": "14750'888611",
>             "log_tail": "14746'885304",
>             "last_user_version": 888309,
>             "last_backfill": "MAX",
>             "purged_snaps": "[]",
>             "history": {
>                 "epoch_created": 87,
>                 "last_epoch_started": 14750,
>                 "last_epoch_clean": 14750,
>                 "last_epoch_split": 0,
>                 "same_up_since": 14749,
>                 "same_interval_since": 14749,
>                 "same_primary_since": 14741,
>                 "last_scrub": "14365'883104",
>                 "last_scrub_stamp": "2017-01-05 01:42:49.031661",
>                 "last_deep_scrub": "14365'883104",
>                 "last_deep_scrub_stamp": "2017-01-05 01:42:49.031661",
>                 "last_clean_scrub_stamp": "2017-01-05 01:42:49.031661"
>             },
>             "stats": {
>                 "version": "14746'888308",
>                 "reported_seq": "1086704",
>                 "reported_epoch": "14746",
>                 "state": "active+remapped",
>                 "last_fresh": "2017-01-05 21:12:53.274561",
>                 "last_change": "2017-01-05 19:20:33.517579",
>                 "last_active": "2017-01-05 21:12:53.274561",
>                 "last_peered": "2017-01-05 21:12:53.274561",
>                 "last_clean": "2017-01-05 14:50:29.665704",
>                 "last_became_active": "0.000000",
>                 "last_became_peered": "0.000000",
>                 "last_unstale": "2017-01-05 21:12:53.274561",
>                 "last_undegraded": "2017-01-05 21:12:53.274561",
>                 "last_fullsized": "2017-01-05 21:12:53.274561",
>                 "mapping_epoch": 14747,
>                 "log_start": "14746'885304",
>                 "ondisk_log_start": "14746'885304",
>                 "created": 87,
>                 "last_epoch_clean": 14746,
>                 "parent": "0.0",
>                 "parent_split_bits": 0,
>                 "last_scrub": "14365'883104",
>                 "last_scrub_stamp": "2017-01-05 01:42:49.031661",
>                 "last_deep_scrub": "14365'883104",
>                 "last_deep_scrub_stamp": "2017-01-05 01:42:49.031661",
>                 "last_clean_scrub_stamp": "2017-01-05 01:42:49.031661",
>                 "log_size": 3004,
>                 "ondisk_log_size": 3004,
>                 "stats_invalid": "0",
>                 "stat_sum": {
>                     "num_bytes": 5145563136,
>                     "num_objects": 1291,
>                     "num_object_clones": 0,
>                     "num_object_copies": 3873,
>                     "num_objects_missing_on_primary": 0,
>                     "num_objects_degraded": 4,
>                     "num_objects_misplaced": 1291,
>                     "num_objects_unfound": 0,
>                     "num_objects_dirty": 1291,
>                     "num_whiteouts": 0,
>                     "num_read": 936647,
>                     "num_read_kb": 24755404,
>                     "num_write": 1714153,
>                     "num_write_kb": 90528472,
>                     "num_scrub_errors": 0,
>                     "num_shallow_scrub_errors": 0,
>                     "num_deep_scrub_errors": 0,
>                     "num_objects_recovered": 7341,
>                     "num_bytes_recovered": 29177446400,
>                     "num_keys_recovered": 0,
>                     "num_objects_omap": 0,
>                     "num_objects_hit_set_archive": 0,
>                     "num_bytes_hit_set_archive": 0
>                 },
>                 "up": [
>                     11,
>                     13
>                 ],
>                 "acting": [
>                     11,
>                     13,
>                     1
>                 ],
>                 "blocked_by": [],
>                 "up_primary": 11,
>                 "acting_primary": 11
>             },
>             "empty": 0,
>             "dne": 0,
>             "incomplete": 0,
>             "last_epoch_started": 14750,
>             "hit_set_history": {
>                 "current_last_update": "0'0",
>                 "current_last_stamp": "0.000000",
>                 "current_info": {
>                     "begin": "0.000000",
>                     "end": "0.000000",
>                     "version": "0'0",
>                     "using_gmt": "0"
>                 },
>                 "history": []
>             }
>         },
>         {
>             "peer": "13",
>             "pgid": "2.143",
>             "last_update": "14750'888611",
>             "last_complete": "14750'888611",
>             "log_tail": "14746'885304",
>             "last_user_version": 888309,
>             "last_backfill": "MAX",
>             "purged_snaps": "[]",
>             "history": {
>                 "epoch_created": 87,
>                 "last_epoch_started": 14750,
>                 "last_epoch_clean": 14750,
>                 "last_epoch_split": 0,
>                 "same_up_since": 14749,
>                 "same_interval_since": 14749,
>                 "same_primary_since": 14741,
>                 "last_scrub": "14365'883104",
>                 "last_scrub_stamp": "2017-01-05 01:42:49.031661",
>                 "last_deep_scrub": "14365'883104",
>                 "last_deep_scrub_stamp": "2017-01-05 01:42:49.031661",
>                 "last_clean_scrub_stamp": "2017-01-05 01:42:49.031661"
>             },
>             "stats": {
>                 "version": "14746'888308",
>                 "reported_seq": "1086704",
>                 "reported_epoch": "14746",
>                 "state": "active+remapped",
>                 "last_fresh": "2017-01-05 21:12:53.274561",
>                 "last_change": "2017-01-05 19:20:33.517579",
>                 "last_active": "2017-01-05 21:12:53.274561",
>                 "last_peered": "2017-01-05 21:12:53.274561",
>                 "last_clean": "2017-01-05 14:50:29.665704",
>                 "last_became_active": "0.000000",
>                 "last_became_peered": "0.000000",
>                 "last_unstale": "2017-01-05 21:12:53.274561",
>                 "last_undegraded": "2017-01-05 21:12:53.274561",
>                 "last_fullsized": "2017-01-05 21:12:53.274561",
>                 "mapping_epoch": 14747,
>                 "log_start": "14746'885304",
>                 "ondisk_log_start": "14746'885304",
>                 "created": 87,
>                 "last_epoch_clean": 14746,
>                 "parent": "0.0",
>                 "parent_split_bits": 0,
>                 "last_scrub": "14365'883104",
>                 "last_scrub_stamp": "2017-01-05 01:42:49.031661",
>                 "last_deep_scrub": "14365'883104",
>                 "last_deep_scrub_stamp": "2017-01-05 01:42:49.031661",
>                 "last_clean_scrub_stamp": "2017-01-05 01:42:49.031661",
>                 "log_size": 3004,
>                 "ondisk_log_size": 3004,
>                 "stats_invalid": "0",
>                 "stat_sum": {
>                     "num_bytes": 5145563136,
>                     "num_objects": 1291,
>                     "num_object_clones": 0,
>                     "num_object_copies": 3873,
>                     "num_objects_missing_on_primary": 0,
>                     "num_objects_degraded": 4,
>                     "num_objects_misplaced": 1291,
>                     "num_objects_unfound": 0,
>                     "num_objects_dirty": 1291,
>                     "num_whiteouts": 0,
>                     "num_read": 936647,
>                     "num_read_kb": 24755404,
>                     "num_write": 1714153,
>                     "num_write_kb": 90528472,
>                     "num_scrub_errors": 0,
>                     "num_shallow_scrub_errors": 0,
>                     "num_deep_scrub_errors": 0,
>                     "num_objects_recovered": 7341,
>                     "num_bytes_recovered": 29177446400,
>                     "num_keys_recovered": 0,
>                     "num_objects_omap": 0,
>                     "num_objects_hit_set_archive": 0,
>                     "num_bytes_hit_set_archive": 0
>                 },
>                 "up": [
>                     11,
>                     13
>                 ],
>                 "acting": [
>                     11,
>                     13,
>                     1
>                 ],
>                 "blocked_by": [],
>                 "up_primary": 11,
>                 "acting_primary": 11
>             },
>             "empty": 0,
>             "dne": 0,
>             "incomplete": 0,
>             "last_epoch_started": 14750,
>             "hit_set_history": {
>                 "current_last_update": "0'0",
>                 "current_last_stamp": "0.000000",
>                 "current_info": {
>                     "begin": "0.000000",
>                     "end": "0.000000",
>                     "version": "0'0",
>                     "using_gmt": "0"
>                 },
>                 "history": []
>             }
>         }
>     ],
>     "recovery_state": [
>         {
>             "name": "Started\/Primary\/Active",
>             "enter_time": "2017-01-05 21:14:17.723754",
>             "might_have_unfound": [],
>             "recovery_progress": {
>                 "backfill_targets": [],
>                 "waiting_on_backfill": [],
>                 "last_backfill_started": "-1\/0\/\/0",
>                 "backfill_info": {
>                     "begin": "-1\/0\/\/0",
>                     "end": "-1\/0\/\/0",
>                     "objects": []
>                 },
>                 "peer_backfill_info": [],
>                 "backfills_in_flight": [],
>                 "recovering": [],
>                 "pg_backend": {
>                     "pull_from_peer": [],
>                     "pushing": []
>                 }
>             },
>             "scrub": {
>                 "scrubber.epoch_start": "0",
>                 "scrubber.active": 0,
>                 "scrubber.waiting_on": 0,
>                 "scrubber.waiting_on_whom": []
>             }
>         },
>         {
>             "name": "Started",
>             "enter_time": "2017-01-05 21:14:16.737119"
>         }
>     ],
>     "agent_state": {}
> }
>
> ------
>
> jedc@web11:/home/jedc>$ cat crushmap-20170105.txt
> # begin crush map
> tunable choose_local_tries 0
> tunable choose_local_fallback_tries 0
> tunable choose_total_tries 50
> tunable chooseleaf_descend_once 1
> tunable chooseleaf_vary_r 1
> tunable straw_calc_version 1
> tunable allowed_bucket_algs 54
>
> # devices
> device 0 osd.0
> device 1 osd.1
> device 2 osd.2
> device 3 osd.3
> device 4 osd.4
> device 5 osd.5
> device 6 osd.6
> device 7 osd.7
> device 8 osd.8
> device 9 osd.9
> device 10 osd.10
> device 11 osd.11
> device 12 osd.12
> device 13 osd.13
> device 14 osd.14
> device 15 osd.15
> device 16 osd.16
> device 17 osd.17
>
> # types
> type 0 osd
> type 1 host
> type 2 chassis
> type 3 rack
> type 4 row
> type 5 pdu
> type 6 pod
> type 7 room
> type 8 datacenter
> type 9 region
> type 10 root
>
> # buckets
> host ceph1 {
>         id -2           # do not change unnecessarily
>         # weight 8.000
>         alg straw
>         hash 0  # rjenkins1
>         item osd.0 weight 4.000
>         item osd.1 weight 4.000
> }
> host ceph2 {
>         id -4           # do not change unnecessarily
>         # weight 8.000
>         alg straw
>         hash 0  # rjenkins1
>         item osd.2 weight 4.000
>         item osd.3 weight 4.000
> }
> host ceph3 {
>         id -5           # do not change unnecessarily
>         # weight 8.000
>         alg straw
>         hash 0  # rjenkins1
>         item osd.4 weight 4.000
>         item osd.5 weight 4.000
> }
> host ceph4 {
>         id -7           # do not change unnecessarily
>         # weight 36.000
>         alg straw2
>         hash 0  # rjenkins1
>         item osd.6 weight 6.000
>         item osd.7 weight 6.000
>         item osd.8 weight 6.000
>         item osd.9 weight 6.000
>         item osd.10 weight 6.000
>         item osd.11 weight 6.000
> }
> host ceph5 {
>         id -8           # do not change unnecessarily
>         # weight 36.000
>         alg straw2
>         hash 0  # rjenkins1
>         item osd.12 weight 6.000
>         item osd.13 weight 6.000
>         item osd.14 weight 6.000
>         item osd.15 weight 6.000
>         item osd.16 weight 6.000
>         item osd.17 weight 6.000
> }
> rack sr2-b-02 {
>         id -3           # do not change unnecessarily
>         # weight 96.000
>         alg straw
>         hash 0  # rjenkins1
>         item ceph1 weight 8.000
>         item ceph2 weight 8.000
>         item ceph3 weight 8.000
>         item ceph4 weight 36.000
>         item ceph5 weight 36.000
> }
> room sr2 {
>         id -6           # do not change unnecessarily
>         # weight 96.000
>         alg straw
>         hash 0  # rjenkins1
>         item sr2-b-02 weight 96.000
> }
> root default {
>         id -1           # do not change unnecessarily
>         # weight 96.000
>         alg straw
>         hash 0  # rjenkins1
>         item sr2 weight 96.000
> }
>
> # rules
> rule replicated_ruleset {
>         ruleset 0
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step chooseleaf firstn 0 type host
>         step emit
> }
>
> # end crush map
>
> ------
>
> jedc@web11:/home/jedc>$ osdmaptool --print osdmap-20170105.bin
> osdmaptool: osdmap file 'osdmap-20170105.bin'
> epoch 14750
> fsid 0e754a32-1085-4e79-8088-88f429061280
> created 2015-11-09 10:45:18.081805
> modified 2017-01-05 21:14:11.182857
> flags
>
> pool 2 'rbd' replicated size 3 min_size 1 crush_ruleset 0 object_hash rjenkins pg_num 1024 pgp_num 1024 last_change 87 flags hashpspool stripe_width 0
>
> max_osd 18
> osd.0 up   in  weight 0.800018 up_from 122 up_thru 14749 down_at 120 last_clean_interval [44,119) 192.168.82.1:6800/18216 192.168.16.1:6800/18216 192.168.16.1:6801/18216 192.168.82.1:6801/18216 exists,up 699e4633-2eb2-4052-92f6-e3ad71dd9fdf
> osd.1 up   in  weight 0.700027 up_from 14745 up_thru 14749 down_at 14743 last_clean_interval [126,14742) 192.168.82.1:6802/20031 192.168.16.1:6802/20031 192.168.16.1:6803/20031 192.168.82.1:6803/20031 exists,up b78970ba-6cd4-4b57-80d3-6b3907897fc9
> osd.2 up   in  weight 0.700012 up_from 130 up_thru 14749 down_at 128 last_clean_interval [99,127) 192.168.82.3:6800/31579 192.168.16.3:6800/31579 192.168.16.3:6801/31579 192.168.82.3:6801/31579 exists,up 0a26c1c0-ac51-40c8-9dc3-c824c9c7e9a3
> osd.3 up   in  weight 0.700012 up_from 134 up_thru 14749 down_at 132 last_clean_interval [101,131) 192.168.82.3:6803/32241 192.168.16.3:6802/32241 192.168.16.3:6803/32241 192.168.82.3:6804/32241 exists,up 274e9648-9196-42d6-9408-b8f30e83f7b0
> osd.4 up   in  weight 0.700012 up_from 138 up_thru 14749 down_at 136 last_clean_interval [69,135) 192.168.82.5:6800/11915 192.168.16.5:6800/11915 192.168.16.5:6801/11915 192.168.82.5:6801/11915 exists,up d9479f20-4c3a-4ac1-ab10-62f464d8fd50
> osd.5 up   in  weight 0.700027 up_from 142 up_thru 14749 down_at 140 last_clean_interval [73,139) 192.168.82.5:6802/12554 192.168.16.5:6802/12554 192.168.16.5:6803/12554 192.168.82.5:6803/12554 exists,up addea482-7e00-4cce-bdcd-e2aad9db5d7e
> osd.6 up   in  weight 1 up_from 151 up_thru 14749 down_at 0 last_clean_interval [0,0) 192.168.82.7:6800/5012 192.168.16.7:6800/5012 192.168.16.7:6801/5012 192.168.82.7:6801/5012 exists,up 7acbfcfc-8229-47a6-b3a5-dd6e7d4150db
> osd.7 up   in  weight 1 up_from 367 up_thru 14749 down_at 0 last_clean_interval [0,0) 192.168.82.7:6802/115215 192.168.16.7:6802/115215 192.168.16.7:6803/115215 192.168.82.7:6803/115215 exists,up e493af6f-dca9-4781-a932-2dbae7816ab3
> osd.8 up   in  weight 1 up_from 489 up_thru 14749 down_at 0 last_clean_interval [0,0) 192.168.82.7:6804/126604 192.168.16.7:6804/126604 192.168.16.7:6805/126604 192.168.82.7:6805/126604 exists,up d2492161-aed5-4507-b8d4-b6e34a620ca8
> osd.9 up   in  weight 1 up_from 554 up_thru 14749 down_at 0 last_clean_interval [0,0) 192.168.82.7:6806/135200 192.168.16.7:6806/135200 192.168.16.7:6807/135200 192.168.82.7:6807/135200 exists,up 9531c9aa-bf81-4da0-a804-245ed0c16f96
> osd.10 up   in  weight 1 up_from 560 up_thru 14749 down_at 0 last_clean_interval [0,0) 192.168.82.7:6808/137160 192.168.16.7:6808/137160 192.168.16.7:6809/137160 192.168.82.7:6809/137160 exists,up 9531c9aa-bf81-4da0-a804-245ed0c16f96
> osd.11 up   in  weight 1 up_from 14741 up_thru 14749 down_at 14739 last_clean_interval [581,14738) 192.168.82.7:6810/335170 192.168.16.7:6810/335170 192.168.16.7:6811/335170 192.168.82.7:6811/335170 exists,up 70f6db7d-2feb-41fd-a8b1-b843357a43b5
> osd.12 up   in  weight 1 up_from 644 up_thru 14745 down_at 0 last_clean_interval [0,0) 192.168.82.9:6800/80052 192.168.16.9:6800/80052 192.168.16.9:6801/80052 192.168.82.9:6801/80052 exists,up 6366c7a6-46be-4cc4-b803-307282d36091
> osd.13 up   in  weight 1 up_from 14749 up_thru 14749 down_at 14747 last_clean_interval [645,14746) 192.168.82.9:6802/122542 192.168.16.9:6802/122542 192.168.16.9:6803/122542 192.168.82.9:6803/122542 exists,up 2501f0d6-23a5-4b11-bac6-c336b05b8ec7
> osd.14 up   in  weight 1 up_from 646 up_thru 14745 down_at 0 last_clean_interval [0,0) 192.168.82.9:6804/80838 192.168.16.9:6804/80838 192.168.16.9:6805/80838 192.168.82.9:6805/80838 exists,up da22bb6d-6da4-448c-8794-0c84f2cd1790
> osd.15 up   in  weight 1 up_from 647 up_thru 14745 down_at 0 last_clean_interval [0,0) 192.168.82.9:6806/81215 192.168.16.9:6806/81215 192.168.16.9:6807/81215 192.168.82.9:6807/81215 exists,up 3a86cb1c-c403-49ff-a113-6b9c63798a92
> osd.16 up   in  weight 1 up_from 648 up_thru 14745 down_at 0 last_clean_interval [0,0) 192.168.82.9:6808/81575 192.168.16.9:6808/81575 192.168.16.9:6809/81575 192.168.82.9:6809/81575 exists,up c00874cf-a62c-46a7-9e16-bd9efb636c46
> osd.17 up   in  weight 1 up_from 649 up_thru 14745 down_at 0 last_clean_interval [0,0) 192.168.82.9:6810/81959 192.168.16.9:6810/81959 192.168.16.9:6811/81959 192.168.82.9:6811/81959 exists,up 04f327b7-f523-463a-b12c-51873c285ff0
>
> pg_temp 2.143 [11,13,1]
>
> ------
>
>
> Regards,
> Jens Dueholm Christensen
> Rambøll Survey IT
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
