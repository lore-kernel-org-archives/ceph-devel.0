From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph stays degraded after crushmap rearrangement
Date: Sat, 05 Jan 2013 18:11:13 +0100
Message-ID: <50E85EB1.8060803@profihost.ag>
References: <50E85799.4060607@profihost.ag> <50E85CC9.9080503@profihost.ag> <alpine.DEB.2.00.1301050905170.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:47820 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819Ab3AERLI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 12:11:08 -0500
In-Reply-To: <alpine.DEB.2.00.1301050905170.15430@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

i just stopped EVERYTHING and have now started ALL osds again. It seems 
to recover now. But here is the output.

Am 05.01.2013 18:06, schrieb Sage Weil:
> It looks like some of the ceph-osds stopped.

Yes they just run with 100% CPU but do nothing.

> Are all daemons running the testing branch code?
Yes.

> What does 'ceph -s' say?
    health HEALTH_WARN 1247 pgs degraded; 4105 pgs peering; 4414 pgs 
stale; 3876 pgs stuck inactive; 4394 pgs stuck stale; 7632 pgs stuck 
unclean; recovery 6503/79122 degraded (8.219%)
    monmap e1: 3 mons at 
{a=10.255.0.100:6789/0,b=10.255.0.101:6789/0,c=10.255.0.102:6789/0}, 
election epoch 1990, quorum 0,1,2 a,b,c
    osdmap e8292: 24 osds: 24 up, 24 in
     pgmap v2212272: 7632 pgs: 1 stale, 119 peering, 467 
active+remapped, 6 active+degraded, 24 stale+peering, 1 stale+remapped, 
1748 stale+active+remapped, 63 active+replay+remapped, 1 
stale+active+degraded, 2563 remapped+peering, 1399 
stale+remapped+peering, 1154 stale+active+degraded+remapped, 86 
stale+active+replay+degraded+remapped; 152 GB data, 313 GB used, 5022 GB 
/ 5336 GB avail; 6503/79122 degraded (8.219%)
    mdsmap e1: 0/0/1 up

> Or 'ceph pg <pgid> query' on a random active+remapped pgid?
# ceph pg 3.b53 query

{ "state": "active+remapped",
   "up": [
         53],
   "acting": [
         53,
         32],
   "info": { "pgid": "3.b53",
       "last_update": "7137'9942",
       "last_complete": "7137'9942",
       "log_tail": "6452'8941",
       "last_backfill": "MAX",
       "purged_snaps": "[1~69,6b~724]",
       "history": { "epoch_created": 10,
           "last_epoch_started": 8291,
           "last_epoch_clean": 8291,
           "last_epoch_split": 0,
           "same_up_since": 8284,
           "same_interval_since": 8284,
           "same_primary_since": 8284,
           "last_scrub": "7137'9942",
           "last_scrub_stamp": "2013-01-05 15:28:03.766723",
           "last_deep_scrub": "6644'9328",
           "last_deep_scrub_stamp": "2012-12-30 15:27:19.596947"},
       "stats": { "version": "7137'9942",
           "reported": "8284'13320",
           "state": "active+remapped",
           "last_fresh": "2013-01-05 18:10:06.987730",
           "last_change": "2013-01-05 18:09:03.891013",
           "last_active": "2013-01-05 18:10:06.987730",
           "last_clean": "2013-01-05 17:00:45.793351",
           "last_unstale": "2013-01-05 18:10:06.987730",
           "mapping_epoch": 8283,
           "log_start": "6452'8941",
           "ondisk_log_start": "6452'8941",
           "created": 10,
           "last_epoch_clean": 10,
           "parent": "0.0",
           "parent_split_bits": 0,
           "last_scrub": "7137'9942",
           "last_scrub_stamp": "2013-01-05 15:28:03.766723",
           "last_deep_scrub": "6644'9328",
           "last_deep_scrub_stamp": "2012-12-30 15:27:19.596947",
           "log_size": 155155,
           "ondisk_log_size": 155155,
           "stats_invalid": "0",
           "stat_sum": { "num_bytes": 54525952,
               "num_objects": 13,
               "num_object_clones": 0,
               "num_object_copies": 0,
               "num_objects_missing_on_primary": 0,
               "num_objects_degraded": 0,
               "num_objects_unfound": 0,
               "num_read": 0,
               "num_read_kb": 0,
               "num_write": 9933,
               "num_write_kb": 1130756},
           "stat_cat_sum": {},
           "up": [
                 53],
           "acting": [
                 53,
                 32]},
       "empty": 0,
       "dne": 0,
       "incomplete": 0,
       "last_epoch_started": 8291},
   "recovery_state": [
         { "name": "Started\/Primary\/Active",
           "enter_time": "2013-01-05 18:09:03.890171",
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
           "enter_time": "2013-01-05 18:08:41.848771"}]}

Stefan
