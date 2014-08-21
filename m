From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: active+remapped after remove osd via ceph osd out
Date: Thu, 21 Aug 2014 15:59:57 +0200
Message-ID: <CAMNMNTzD_V7d3XUyfa0vVgbA=aaLaOH_0saHO+ZtEZ90JSpyyA@mail.gmail.com>
References: <CAMNMNTwzjZHmf5Yw-kf3ty1Z5TJYjTvA+abwtwRNLcvWRWsyjw@mail.gmail.com>
	<CAMNMNTxUQpQ8-CP-gjrcJU7Hfr1r5=-e4yKoxoDcaQ17L2VDUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMNMNTxUQpQ8-CP-gjrcJU7Hfr1r5=-e4yKoxoDcaQ17L2VDUA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,
I have 2 PG in active+remapped state.

ceph health detail
HEALTH_WARN 2 pgs stuck unclean; recovery 24/348041229 degraded (0.000%)
pg 3.1a07 is stuck unclean for 29239.046024, current state
active+remapped, last acting [167,80,145]
pg 3.154a is stuck unclean for 29239.039777, current state
active+remapped, last acting [377,224,292]
recovery 24/348041229 degraded (0.000%)

This happend when i call "ceph osd reweight-by-utilization 102"

What can be wrong ?

ceph -v -> ceph version 0.67.10 (9d446bd416c52cd785ccf048ca67737ceafcdd7f)

Tunables:
ceph osd crush dump | tail -n 4
  "tunables": { "choose_local_tries": 0,
      "choose_local_fallback_tries": 0,
      "choose_total_tries": 60,
      "chooseleaf_descend_once": 1}}

Cluster:
6 racks X 3 hosts X 22 OSDs. (396 osds: 396 up, 396 in)

> crushtool -i ../crush2  --min-x 0 --num-rep 3  --max-x 10624 --test --show-bad-mappings
is clean.

When 'ceph osd reweight' for all osd is 1.0 is ok, but i have nearfull OSD's.

There is no missing OSD's in crushmap
> grep device /tmp/crush.txt | grep -v osd
# devices

ceph osd dump | grep -i pool
pool 0 'data' rep size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 64 pgp_num 64 last_change 28459 owner 0
crash_replay_interval 45
pool 1 'metadata' rep size 3 min_size 1 crush_ruleset 1 object_hash
rjenkins pg_num 64 pgp_num 64 last_change 28460 owner 0
pool 2 'rbd' rep size 3 min_size 1 crush_ruleset 2 object_hash
rjenkins pg_num 64 pgp_num 64 last_change 28461 owner 0
pool 3 '.rgw.buckets' rep size 3 min_size 1 crush_ruleset 0
object_hash rjenkins pg_num 8192 pgp_num 8192 last_change 73711 owner
0
pool 4 '.log' rep size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 2048 pgp_num 2048 last_change 90517 owner 0
pool 5 '.rgw' rep size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 128 pgp_num 128 last_change 72467 owner 0
pool 6 '.users.uid' rep size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 last_change 28465 owner 0
pool 7 '.users' rep size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 last_change 28466 owner 0
pool 8 '.usage' rep size 2 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 last_change 28467 owner
18446744073709551615
pool 9 '.intent-log' rep size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 last_change 28468 owner
18446744073709551615
pool 10 '.rgw.control' rep size 3 min_size 1 crush_ruleset 0
object_hash rjenkins pg_num 8 pgp_num 8 last_change 33485 owner
18446744073709551615
pool 11 '.rgw.gc' rep size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 last_change 33487 owner
18446744073709551615
pool 12 '.rgw.root' rep size 2 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 last_change 44540 owner 0
pool 13 '' rep size 2 min_size 1 crush_ruleset 0 object_hash rjenkins
pg_num 8 pgp_num 8 last_change 46912 owner 0

> ceph pg 3.1a07 query
{ "state": "active+remapped",
  "epoch": 181721,
  "up": [
        167,
        80],
  "acting": [
        167,
        80,
        145],
  "info": { "pgid": "3.1a07",
      "last_update": "181719'94809",
      "last_complete": "181719'94809",
      "log_tail": "159997'91808",
      "last_backfill": "MAX",
      "purged_snaps": "[]",
      "history": { "epoch_created": 4,
          "last_epoch_started": 179611,
          "last_epoch_clean": 179611,
          "last_epoch_split": 11522,
          "same_up_since": 179610,
          "same_interval_since": 179610,
          "same_primary_since": 179610,
          "last_scrub": "160655'94695",
          "last_scrub_stamp": "2014-08-19 04:16:20.308318",
          "last_deep_scrub": "158290'91157",
          "last_deep_scrub_stamp": "2014-08-12 05:15:25.557591",
          "last_clean_scrub_stamp": "2014-08-19 04:16:20.308318"},
      "stats": { "version": "181719'94809",
          "reported_seq": "995830",
          "reported_epoch": "181721",
          "state": "active+remapped",
          "last_fresh": "2014-08-21 14:53:14.050284",
          "last_change": "2014-08-21 09:42:07.473356",
          "last_active": "2014-08-21 14:53:14.050284",
          "last_clean": "2014-08-21 07:38:51.366084",
          "last_became_active": "2013-10-25 13:59:36.125019",
          "last_unstale": "2014-08-21 14:53:14.050284",
          "mapping_epoch": 179606,
          "log_start": "159997'91808",
          "ondisk_log_start": "159997'91808",
          "created": 4,
          "last_epoch_clean": 179611,
          "parent": "0.0",
          "parent_split_bits": 0,
          "last_scrub": "160655'94695",
          "last_scrub_stamp": "2014-08-19 04:16:20.308318",
          "last_deep_scrub": "158290'91157",
          "last_deep_scrub_stamp": "2014-08-12 05:15:25.557591",
          "last_clean_scrub_stamp": "2014-08-19 04:16:20.308318",
          "log_size": 3001,
          "ondisk_log_size": 3001,
          "stats_invalid": "0",
          "stat_sum": { "num_bytes": 2880784014,
              "num_objects": 12108,
              "num_object_clones": 0,
              "num_object_copies": 0,
              "num_objects_missing_on_primary": 0,
              "num_objects_degraded": 0,
              "num_objects_unfound": 0,
              "num_read": 645471,
              "num_read_kb": 16973620,
              "num_write": 111416,
              "num_write_kb": 2459459,
              "num_scrub_errors": 0,
              "num_shallow_scrub_errors": 0,
              "num_deep_scrub_errors": 0,
              "num_objects_recovered": 48440,
              "num_bytes_recovered": 10006953676,
              "num_keys_recovered": 0},
          "stat_cat_sum": {},
          "up": [
                167,
                80],
          "acting": [
                167,
                80,
                145]},
      "empty": 0,
      "dne": 0,
      "incomplete": 0,
      "last_epoch_started": 179611},
  "recovery_state": [
        { "name": "Started\/Primary\/Active",
          "enter_time": "2014-08-21 09:42:07.473030",
          "might_have_unfound": [],
          "recovery_progress": { "backfill_target": -1,
              "waiting_on_backfill": 0,
              "backfill_pos": "0\/\/0\/\/-1",
              "backfill_info": { "begin": "0\/\/0\/\/-1",
                  "end": "0\/\/0\/\/-1",
                  "objects": []},
              "peer_backfill_info": { "begin": "0\/\/0\/\/-1",
                  "end": "0\/\/0\/\/-1",
                  "objects": []},
              "backfills_in_flight": [],
              "pull_from_peer": [],
              "pushing": []},
          "scrub": { "scrubber.epoch_start": "0",
              "scrubber.active": 0,
              "scrubber.block_writes": 0,
              "scrubber.finalizing": 0,
              "scrubber.waiting_on": 0,
              "scrubber.waiting_on_whom": []}},
        { "name": "Started",
          "enter_time": "2014-08-21 09:42:06.410951"}]}

--
Regards
Dominik

2014-08-18 23:27 GMT+02:00 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> After replace broken disk and ceph osd in it, cluster:
> ceph health detail
> HEALTH_WARN 2 pgs stuck unclean; recovery 60/346857819 degraded (0.000%)
> pg 3.884 is stuck unclean for 570722.873270, current state
> active+remapped, last acting [143,261,314]
> pg 3.154a is stuck unclean for 577659.917066, current state
> active+remapped, last acting [85,224,64]
> recovery 60/346857819 degraded (0.000%)
>
> What can be wrong?
> It is possible this is caused by 'ceph osd reweight-by-utilization' ?
>
> More info:
> ceph -v
> ceph version 0.67.9 (ba340a97c3dafc9155023da8d515eecc675c619a)
>
> Enabled tunnables:
> # begin crush map
> tunable choose_local_tries 0
> tunable choose_local_fallback_tries 0
> tunable choose_total_tries 50
> tunable chooseleaf_descend_once 1
>
> df osd:
> 143 - 78%
> 261 - 78%
> 314 - 80%
>
> 85 - 76%
> 224  76%
> 64 - 75%
>
> ceph osd dump | grep -i pool
> pool 0 'data' rep size 3 min_size 1 crush_ruleset 0 object_hash
> rjenkins pg_num 64 pgp_num 64 last_change 28459 owner 0
> crash_replay_interval 45
> pool 1 'metadata' rep size 3 min_size 1 crush_ruleset 1 object_hash
> rjenkins pg_num 64 pgp_num 64 last_change 28460 owner 0
> pool 2 'rbd' rep size 3 min_size 1 crush_ruleset 2 object_hash
> rjenkins pg_num 64 pgp_num 64 last_change 28461 owner 0
> pool 3 '.rgw.buckets' rep size 3 min_size 1 crush_ruleset 0
> object_hash rjenkins pg_num 8192 pgp_num 8192 last_change 73711 owner
> 0
> pool 4 '.log' rep size 3 min_size 1 crush_ruleset 0 object_hash
> rjenkins pg_num 2048 pgp_num 2048 last_change 90517 owner 0
> pool 5 '.rgw' rep size 3 min_size 1 crush_ruleset 0 object_hash
> rjenkins pg_num 128 pgp_num 128 last_change 72467 owner 0
> pool 6 '.users.uid' rep size 3 min_size 1 crush_ruleset 0 object_hash
> rjenkins pg_num 8 pgp_num 8 last_change 28465 owner 0
> pool 7 '.users' rep size 3 min_size 1 crush_ruleset 0 object_hash
> rjenkins pg_num 8 pgp_num 8 last_change 28466 owner 0
> pool 8 '.usage' rep size 2 min_size 1 crush_ruleset 0 object_hash
> rjenkins pg_num 8 pgp_num 8 last_change 28467 owner
> 18446744073709551615
> pool 9 '.intent-log' rep size 3 min_size 1 crush_ruleset 0 object_hash
> rjenkins pg_num 8 pgp_num 8 last_change 28468 owner
> 18446744073709551615
> pool 10 '.rgw.control' rep size 3 min_size 1 crush_ruleset 0
> object_hash rjenkins pg_num 8 pgp_num 8 last_change 33485 owner
> 18446744073709551615
> pool 11 '.rgw.gc' rep size 3 min_size 1 crush_ruleset 0 object_hash
> rjenkins pg_num 8 pgp_num 8 last_change 33487 owner
> 18446744073709551615
> pool 12 '.rgw.root' rep size 2 min_size 1 crush_ruleset 0 object_hash
> rjenkins pg_num 8 pgp_num 8 last_change 44540 owner 0
> pool 13 '' rep size 2 min_size 1 crush_ruleset 0 object_hash rjenkins
> pg_num 8 pgp_num 8 last_change 46912 owner 0
>
> ceph pg 3.884 query
> { "state": "active+remapped",
>   "epoch": 160655,
>   "up": [
>         143],
>   "acting": [
>         143,
>         261,
>         314],
>   "info": { "pgid": "3.884",
>       "last_update": "160655'111533",
>       "last_complete": "160655'111533",
>       "log_tail": "159997'108532",
>       "last_backfill": "MAX",
>       "purged_snaps": "[]",
>       "history": { "epoch_created": 4,
>           "last_epoch_started": 160261,
>           "last_epoch_clean": 160261,
>           "last_epoch_split": 11488,
>           "same_up_since": 160252,
>           "same_interval_since": 160260,
>           "same_primary_since": 160252,
>           "last_scrub": "155516'107396",
>           "last_scrub_stamp": "2014-08-06 03:15:18.193611",
>           "last_deep_scrub": "155516'107293",
>           "last_deep_scrub_stamp": "2014-08-03 06:45:59.215397",
>           "last_clean_scrub_stamp": "2014-08-06 03:15:18.193611"},
>       "stats": { "version": "160655'111533",
>           "reported_seq": "856860",
>           "reported_epoch": "160655",
>           "state": "active+remapped",
>           "last_fresh": "2014-08-18 23:06:47.068588",
>           "last_change": "2014-08-17 21:12:29.452628",
>           "last_active": "2014-08-18 23:06:47.068588",
>           "last_clean": "2014-08-12 08:44:00.293916",
>           "last_became_active": "2013-10-25 14:54:55.902442",
>           "last_unstale": "2014-08-18 23:06:47.068588",
>           "mapping_epoch": 160258,
>           "log_start": "159997'108532",
>           "ondisk_log_start": "159997'108532",
>           "created": 4,
>           "last_epoch_clean": 160261,
>           "parent": "0.0",
>           "parent_split_bits": 0,
>           "last_scrub": "155516'107396",
>           "last_scrub_stamp": "2014-08-06 03:15:18.193611",
>           "last_deep_scrub": "155516'107293",
>           "last_deep_scrub_stamp": "2014-08-03 06:45:59.215397",
>           "last_clean_scrub_stamp": "2014-08-06 03:15:18.193611",
>           "log_size": 3001,
>           "ondisk_log_size": 3001,
>           "stats_invalid": "0",
>           "stat_sum": { "num_bytes": 2750235192,
>               "num_objects": 12015,
>               "num_object_clones": 0,
>               "num_object_copies": 0,
>               "num_objects_missing_on_primary": 0,
>               "num_objects_degraded": 0,
>               "num_objects_unfound": 0,
>               "num_read": 708045,
>               "num_read_kb": 39418032,
>               "num_write": 120983,
>               "num_write_kb": 2383937,
>               "num_scrub_errors": 0,
>               "num_shallow_scrub_errors": 0,
>               "num_deep_scrub_errors": 0,
>               "num_objects_recovered": 44904,
>               "num_bytes_recovered": 7915543525,
>               "num_keys_recovered": 0},
>           "stat_cat_sum": {},
>           "up": [
>                 143],
>           "acting": [
>                 143,
>                 261,
>                 314]},
>       "empty": 0,
>       "dne": 0,
>       "incomplete": 0,
>       "last_epoch_started": 160261},
>   "recovery_state": [
>         { "name": "Started\/Primary\/Active",
>           "enter_time": "2014-08-17 21:12:29.452429",
>           "might_have_unfound": [],
>           "recovery_progress": { "backfill_target": -1,
>               "waiting_on_backfill": 0,
>               "backfill_pos": "0\/\/0\/\/-1",
>               "backfill_info": { "begin": "0\/\/0\/\/-1",
>                   "end": "0\/\/0\/\/-1",
>                   "objects": []},
>               "peer_backfill_info": { "begin": "0\/\/0\/\/-1",
>                   "end": "0\/\/0\/\/-1",
>                   "objects": []},
>               "backfills_in_flight": [],
>               "pull_from_peer": [],
>               "pushing": []},
>           "scrub": { "scrubber.epoch_start": "0",
>               "scrubber.active": 0,
>               "scrubber.block_writes": 0,
>               "scrubber.finalizing": 0,
>               "scrubber.waiting_on": 0,
>               "scrubber.waiting_on_whom": []}},
>         { "name": "Started",
>           "enter_time": "2014-08-17 21:12:28.436021"}]}
>
> ---
> Regards
> Dominik
>
> 2014-08-17 21:57 GMT+02:00 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Hi,
>> After ceph osd out ( 1 osd ) cluster stopped rebalancing on
>> 10621 active+clean, 2 active+remapped, 1 active+degraded+remapped;
>>
>> My crushmap is clean, there is not 'empty' device's.
>> grep device /tmp/crush1.txt  | grep -v osd | grep -v '^#' | wc -l
>> 0
>>
>> Can You help me with this?
>>
>>   "up": [
>>         73],
>>   "acting": [
>>         73,
>>         102],
>> I have only one copy of this PG ?
>>
>> More info:
>> --
>> ceph health detail
>> HEALTH_WARN 1 pgs degraded; 3 pgs stuck unclean; recovery
>> 12008/346501095 degraded (0.003%)
>> pg 3.884 is stuck unclean for 478441.392837, current state
>> active+remapped, last acting [143,261,314]
>> pg 3.154a is stuck unclean for 485378.436630, current state
>> active+remapped, last acting [85,224,64]
>> pg 3.cc7 is stuck unclean for 116231.803324, current state
>> active+degraded+remapped, last acting [73,102]
>> pg 3.cc7 is active+degraded+remapped, acting [73,102]
>> recovery 12008/346501095 degraded (0.003%)
>> --
>> ceph pg dump | grep 3.cc7
>> dumped all in format plain
>> 3.cc7   12014   0       12012   0       2845541648      3870    3870
>>  active+degraded+remapped        2014-08-17 21:08:04.155348
>> 160273'273322   160273:1044675  [73]    [73,102]159997'270388
>> 2014-08-13 05:23:48.386184      159997'270388   2014-08-13
>> 05:23:48.386184
>> --
>> grep '3.cc7' /var/log/ceph/ceph-osd.73.log
>> 2014-08-17 21:06:47.494511 7f788a625700 20 osd.73 160241  kicking pg 3.cc7
>> 2014-08-17 21:06:47.494513 7f788a625700 30 osd.73 pg_epoch: 160241
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160026 n=12016 ec=4 les/c 160026/160026
>> 160024/160025/153162) [73]/[73,102] r=0 lpr=160025 mlcod 160241'273319
>> active+degraded+remapped] lock
>> 2014-08-17 21:06:47.494522 7f788a625700 10 osd.73 pg_epoch: 160241
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160026 n=12016 ec=4 les/c 160026/160026
>> 160024/160025/153162) [73]/[73,102] r=0 lpr=160025 mlcod 160241'273319
>> active+degraded+remapped] on_shutdown
>> 2014-08-17 21:06:47.494530 7f788a625700 10 osd.73 pg_epoch: 160241
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160026 n=12016 ec=4 les/c 160026/160026
>> 160024/160025/153162) [73]/[73,102] r=0 lpr=160025 mlcod 160241'273319
>> active+degraded+remapped] clear_primary_state
>> 2014-08-17 21:06:47.494541 7f788a625700 10 osd.73 pg_epoch: 160241
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160026 n=12016 ec=4 les/c 160026/160026
>> 160024/160025/153162) [73]/[73,102] r=0 lpr=160025 luod=0'0 mlcod 0'0
>> active+degraded+remapped] cancel_recovery
>> 2014-08-17 21:06:47.494548 7f788a625700 10 osd.73 pg_epoch: 160241
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160026 n=12016 ec=4 les/c 160026/160026
>> 160024/160025/153162) [73]/[73,102] r=0 lpr=160025 luod=0'0 mlcod 0'0
>> active+degraded+remapped] clear_recovery_state
>> 2014-08-17 21:07:00.758061 7f9819814700  1 osd.73 pg_epoch: 160244
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160026 n=12016 ec=4 les/c 160026/160026
>> 160244/160244/160244) [73]/[73,102] r=0 lpr=160244 pi=160025-160243/2
>> lcod 0'0 mlcod 0'0 remapped] state<Start>: transitioning to Primary
>> 2014-08-17 21:07:51.121028 7f9819814700  1 osd.73 pg_epoch: 160246
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160245 n=12016 ec=4 les/c 160245/160245
>> 160244/160246/160244) [73] r=0 lpr=160246 pi=160244-160245/1 lcod 0'0
>> mlcod 0'0 inactive] state<Start>: transitioning to Primary
>> 2014-08-17 21:08:02.995105 7f9818011700  1 osd.73 pg_epoch: 160248
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160247 n=12016 ec=4 les/c 160247/160247
>> 160244/160248/160244) [73]/[73,102] r=0 lpr=160248 pi=160246-160247/1
>> lcod 0'0 mlcod 0'0 remapped] state<Start>: transitioning to Primary
>> --
>> grep '3.cc7' /var/log/ceph/ceph-osd.102.log
>> 2014-08-17 21:06:47.554359 7f630df7a700  1 osd.102 pg_epoch: 160242
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160026 n=12016 ec=4 les/c 160026/160026
>> 160242/160242/160242) []/[102] r=0 lpr=160242 pi=158292-160241/12 lcod
>> 160241'273319 mlcod 0'0 remapped] state<Start>: transitioning to
>> Primary
>> 2014-08-17 21:07:00.772420 7f630b775700  1 osd.102 pg_epoch: 160244
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160243 n=12016 ec=4 les/c 160243/160243
>> 160244/160244/160244) [73]/[73,102] r=1 lpr=160244 pi=160242-160243/1
>> lcod 160241'273319 remapped NOTIFY] state<Start>: transitioning to
>> Stray
>> 2014-08-17 21:07:50.832077 7f62f878a700 20 osd.102 160245  kicking pg 3.cc7
>> 2014-08-17 21:07:50.832079 7f62f878a700 30 osd.102 pg_epoch: 160245
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160245 n=12016 ec=4 les/c 160245/160245
>> 160244/160244/160244) [73]/[73,102] r=1 lpr=160244 pi=160242-160243/1
>> luod=0'0 lcod 160241'273319 active+remapped] lock
>> 2014-08-17 21:07:50.832089 7f62f878a700 10 osd.102 pg_epoch: 160245
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160245 n=12016 ec=4 les/c 160245/160245
>> 160244/160244/160244) [73]/[73,102] r=1 lpr=160244 pi=160242-160243/1
>> luod=0'0 lcod 160241'273319 active+remapped] on_shutdown
>> 2014-08-17 21:07:50.832099 7f62f878a700 10 osd.102 pg_epoch: 160245
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160245 n=12016 ec=4 les/c 160245/160245
>> 160244/160244/160244) [73]/[73,102] r=1 lpr=160244 pi=160242-160243/1
>> luod=0'0 lcod 160241'273319 active+remapped] clear_primary_state
>> 2014-08-17 21:07:50.832109 7f62f878a700 10 osd.102 pg_epoch: 160245
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160245 n=12016 ec=4 les/c 160245/160245
>> 160244/160244/160244) [73]/[73,102] r=1 lpr=160244 pi=160242-160243/1
>> luod=0'0 lcod 160241'273319 active+remapped] cancel_recovery
>> 2014-08-17 21:07:50.832117 7f62f878a700 10 osd.102 pg_epoch: 160245
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160245 n=12016 ec=4 les/c 160245/160245
>> 160244/160244/160244) [73]/[73,102] r=1 lpr=160244 pi=160242-160243/1
>> luod=0'0 lcod 160241'273319 active+remapped] clear_recovery_state
>> 2014-08-17 21:08:02.979471 7f3d54953700  1 osd.102 pg_epoch: 160248
>> pg[3.cc7( v 160241'273320 (155516'269452,160241'273320]
>> local-les=160245 n=12016 ec=4 les/c 160245/160245
>> 160244/160248/160244) [73]/[73,102] r=1 lpr=160248 pi=160242-160247/3
>> lcod 0'0 remapped NOTIFY] state<Start>: transitioning to Stray
>> --
>> ceph pg 3.cc7 query:
>> { "state": "active+degraded+remapped",
>>   "epoch": 160273,
>>   "up": [
>>         73],
>>   "acting": [
>>         73,
>>         102],
>>   "info": { "pgid": "3.cc7",
>>       "last_update": "160273'273322",
>>       "last_complete": "160273'273322",
>>       "log_tail": "155516'269452",
>>       "last_backfill": "MAX",
>>       "purged_snaps": "[]",
>>       "history": { "epoch_created": 4,
>>           "last_epoch_started": 160249,
>>           "last_epoch_clean": 160249,
>>           "last_epoch_split": 11503,
>>           "same_up_since": 160244,
>>           "same_interval_since": 160248,
>>           "same_primary_since": 160244,
>>           "last_scrub": "159997'270388",
>>           "last_scrub_stamp": "2014-08-13 05:23:48.386184",
>>           "last_deep_scrub": "159997'270388",
>>           "last_deep_scrub_stamp": "2014-08-13 05:23:48.386184",
>>           "last_clean_scrub_stamp": "2014-08-13 05:23:48.386184"},
>>       "stats": { "version": "160273'273322",
>>           "reported_seq": "1044675",
>>           "reported_epoch": "160273",
>>           "state": "active+degraded+remapped",
>>           "last_fresh": "2014-08-17 21:25:34.935269",
>>           "last_change": "2014-08-17 21:08:04.155348",
>>           "last_active": "2014-08-17 21:25:34.935269",
>>           "last_clean": "2014-08-16 13:20:49.883438",
>>           "last_became_active": "2013-10-25 13:05:26.849618",
>>           "last_unstale": "2014-08-17 21:25:34.935269",
>>           "mapping_epoch": 160246,
>>           "log_start": "155516'269452",
>>           "ondisk_log_start": "155516'269452",
>>           "created": 4,
>>           "last_epoch_clean": 160249,
>>           "parent": "0.0",
>>           "parent_split_bits": 0,
>>           "last_scrub": "159997'270388",
>>           "last_scrub_stamp": "2014-08-13 05:23:48.386184",
>>           "last_deep_scrub": "159997'270388",
>>           "last_deep_scrub_stamp": "2014-08-13 05:23:48.386184",
>>           "last_clean_scrub_stamp": "2014-08-13 05:23:48.386184",
>>           "log_size": 3870,
>>           "ondisk_log_size": 3870,
>>           "stats_invalid": "0",
>>           "stat_sum": { "num_bytes": 2845541648,
>>               "num_objects": 12014,
>>               "num_object_clones": 0,
>>               "num_object_copies": 0,
>>               "num_objects_missing_on_primary": 0,
>>               "num_objects_degraded": 0,
>>               "num_objects_unfound": 0,
>>               "num_read": 723032,
>>               "num_read_kb": 24658206,
>>               "num_write": 118401,
>>               "num_write_kb": 2360009,
>>               "num_scrub_errors": 0,
>>               "num_shallow_scrub_errors": 0,
>>               "num_deep_scrub_errors": 0,
>>               "num_objects_recovered": 55614,
>>               "num_bytes_recovered": 10782825899,
>>               "num_keys_recovered": 0},
>>           "stat_cat_sum": {},
>>           "up": [
>>                 73],
>>           "acting": [
>>                 73,
>>                 102]},
>>       "empty": 0,
>>       "dne": 0,
>>       "incomplete": 0,
>>       "last_epoch_started": 160249},
>>   "recovery_state": [
>>         { "name": "Started\/Primary\/Active",
>>           "enter_time": "2014-08-17 21:08:04.154871",
>>           "might_have_unfound": [],
>>           "recovery_progress": { "backfill_target": -1,
>>               "waiting_on_backfill": 0,
>>               "backfill_pos": "0\/\/0\/\/-1",
>>               "backfill_info": { "begin": "0\/\/0\/\/-1",
>>                   "end": "0\/\/0\/\/-1",
>>                   "objects": []},
>>               "peer_backfill_info": { "begin": "0\/\/0\/\/-1",
>>                   "end": "0\/\/0\/\/-1",
>>                   "objects": []},
>>               "backfills_in_flight": [],
>>               "pull_from_peer": [],
>>               "pushing": []},
>>           "scrub": { "scrubber.epoch_start": "0",
>>               "scrubber.active": 0,
>>               "scrubber.block_writes": 0,
>>               "scrubber.finalizing": 0,
>>               "scrubber.waiting_on": 0,
>>               "scrubber.waiting_on_whom": []}},
>>         { "name": "Started",
>>           "enter_time": "2014-08-17 21:08:02.995104"}]}
>>
>>
>> --
>> Regards
>> Dominik
>
>
>
> --
> Pozdrawiam
> Dominik



-- 
Pozdrawiam
Dominik
