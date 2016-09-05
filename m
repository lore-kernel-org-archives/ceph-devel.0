From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Inconclusive answer when running tests for cephtool-test-mon.sh
Date: Mon, 5 Sep 2016 17:18:57 +0200
Message-ID: <de1a271c-7860-38ed-1d2d-a6b241c99a61@digiware.nl>
References: <91990552-a865-e81d-0946-11236d27bd86@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:57645 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932448AbcIEP1b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Sep 2016 11:27:31 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id E295729764
        for <ceph-devel@vger.kernel.org>; Mon,  5 Sep 2016 17:19:10 +0200 (CEST)
In-Reply-To: <91990552-a865-e81d-0946-11236d27bd86@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 5-9-2016 13:42, Willem Jan Withagen wrote:
> Hi
> 
> I would innterested to know why I get 2 different answers:
> 
> (this is asking the OSDs directly?)
> ceph osd dump
>   but osd.0 is in, up, up_from 179 up_thru 185 down_at 176
>   osd.1/2 are in, up, up_from 8/13 up_thru 224 down_at 0
> 
> ceph -s reports 1 OSD down
> 
> So all osds in the dump are in and up, but ...
> I guess that osd.0 is telling me when it came back and that it has not
> all the data that osd.1/2 have because they go up to 224
> 
> Which is why ceph -s tells me that one osd is down?
> Or did the leading MON nog get fully informed.
> 
> What daemon is missing what part of the communication?
> And what for type of warning/error should I look for in the log files?

A bit of extra info:

The trouble starts with:
ceph osd down 0
4: marked down osd.0.

ceph osd dump
4: epoch 174
4: fsid eee1774b-3560-46ec-83b4-bac0e8763e93
4: created 2016-09-05 16:47:43.301220
4: modified 2016-09-05 16:51:16.529826
4: flags noup,sortbitwise,require_jewel_osds,require_kraken_osds
4: pool 0 'rbd' replicated size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 last_change 1 flags hashpspool stripe_width 0
4: max_osd 3
4: osd.0 down in  weight 1 up_from 4 up_thru 167 down_at 173
last_clean_interval [0,0) 127.0.0.1:6800/45257 127.0.0.1:6801/45257
127.0.0.1:6802/45257 127.0.0.1:6803/45257 exists
7688bac7-75ec-4a3c-8edc-ce7245071a90
4: osd.1 up   in  weight 1 up_from 8 up_thru 173 down_at 0
last_clean_interval [0,0) 127.0.0.1:6804/45271 127.0.0.1:6805/45271
127.0.0.1:6806/45271 127.0.0.1:6807/45271 exists,up
7639c41c-be59-42e4-9eb4-fcb6372e7042
4: osd.2 up   in  weight 1 up_from 14 up_thru 173 down_at 0
last_clean_interval [0,0) 127.0.0.1:6808/45285 127.0.0.1:6809/45285
127.0.0.1:6810/45285 127.0.0.1:6811/45285 exists,up
39e812a4-2f50-4088-bebd-6392dc05c76c
4: pg_temp 0.0 [0,2,1]
4: pg_temp 0.1 [2,0,1]
4: pg_temp 0.2 [0,1,2]
4: pg_temp 0.3 [2,0,1]
4: pg_temp 0.4 [0,2,1]
4: pg_temp 0.5 [0,2,1]
4: pg_temp 0.6 [0,1,2]
4: pg_temp 0.7 [1,0,2]

ceph daemon osd.0 status
4: {
4:     "cluster_fsid": "eee1774b-3560-46ec-83b4-bac0e8763e93",
4:     "osd_fsid": "7688bac7-75ec-4a3c-8edc-ce7245071a90",
4:     "whoami": 0,
4:     "state": "active",
4:     "oldest_map": 1,
4:     "newest_map": 172,
4:     "num_pgs": 8
4: }
4: /home/wjw/wip/qa/workunits/cephtool/test.sh:15: osd_state:  ceph -s
4:     cluster eee1774b-3560-46ec-83b4-bac0e8763e93
4:      health HEALTH_WARN
4:             3 pgs degraded
4:             3 pgs stale
4:             3 pgs undersized
4:             1/3 in osds are down
4:             noup,sortbitwise,require_jewel_osds,require_kraken_osds
flag(s) set
4:      monmap e1: 3 mons at
{a=127.0.0.1:7202/0,b=127.0.0.1:7203/0,c=127.0.0.1:7204/0}
4:             election epoch 6, quorum 0,1,2 a,b,c
4:      osdmap e174: 3 osds: 2 up, 3 in; 8 remapped pgs
4:             flags noup,sortbitwise,require_jewel_osds,require_kraken_osds
4:       pgmap v294: 8 pgs, 1 pools, 0 bytes data, 0 objects
4:             300 GB used, 349 GB / 650 GB avail
4:                    3 stale+active+clean
4:                    3 active+undersized+degraded
4:                    2 active+clean

And then:
ceph osd unset noup
4: noup is unset

And we wait/loop until çeph osd dump' reports osd.0 up.

ceph osd dump
4: epoch 177
4: fsid eee1774b-3560-46ec-83b4-bac0e8763e93
4: created 2016-09-05 16:47:43.301220
4: modified 2016-09-05 16:51:20.098412
4: flags sortbitwise,require_jewel_osds,require_kraken_osds
4: pool 0 'rbd' replicated size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 last_change 1 flags hashpspool stripe_width 0
4: max_osd 3
4: osd.0 up   in  weight 1 up_from 176 up_thru 176 down_at 173
last_clean_interval [4,175) 127.0.0.1:6800/45257 127.0.0.1:6812/1045257
127.0.0.1:6813/1045257 127.0.0.1:6814/1045257 exists,up
7688bac7-75ec-4a3c-8edc-ce7245071a90
4: osd.1 up   in  weight 1 up_from 8 up_thru 176 down_at 0
last_clean_interval [0,0) 127.0.0.1:6804/45271 127.0.0.1:6805/45271
127.0.0.1:6806/45271 127.0.0.1:6807/45271 exists,up
7639c41c-be59-42e4-9eb4-fcb6372e7042
4: osd.2 up   in  weight 1 up_from 14 up_thru 176 down_at 0
last_clean_interval [0,0) 127.0.0.1:6808/45285 127.0.0.1:6809/45285
127.0.0.1:6810/45285 127.0.0.1:6811/45285 exists,up
39e812a4-2f50-4088-bebd-6392dc05c76c
4: pg_temp 0.2 [1,2]
4: pg_temp 0.6 [1,2]
4: pg_temp 0.7 [1,2]

ceph daemon osd.0 status
4: {
4:     "cluster_fsid": "eee1774b-3560-46ec-83b4-bac0e8763e93",
4:     "osd_fsid": "7688bac7-75ec-4a3c-8edc-ce7245071a90",
4:     "whoami": 0,
4:     "state": "booting",
4:     "oldest_map": 1,
4:     "newest_map": 177,
4:     "num_pgs": 8
4: }

ceph -s
4:     cluster eee1774b-3560-46ec-83b4-bac0e8763e93
4:      health HEALTH_WARN
4:             3 pgs degraded
4:             3 pgs peering
4:             3 pgs undersized
4:      monmap e1: 3 mons at
{a=127.0.0.1:7202/0,b=127.0.0.1:7203/0,c=127.0.0.1:7204/0}
4:             election epoch 6, quorum 0,1,2 a,b,c
4:      osdmap e177: 3 osds: 3 up, 3 in; 3 remapped pgs
4:             flags sortbitwise,require_jewel_osds,require_kraken_osds
4:       pgmap v298: 8 pgs, 1 pools, 0 bytes data, 0 objects
4:             300 GB used, 349 GB / 650 GB avail
4:                    3 peering
4:                    3 active+undersized+degraded
4:                    2 active+clean

And even though the cluster is reported UP, the osd itself is booting,
and never gets out of that state.

I have reworked the code that actually rebinds the accepters, which
seems to be working. But obviously it doesn't have enough work done to
really go to the active state.
Wido suggested to look for: wrongly marked me down, because that should
start triggering the reconnect state.
Which led me to SimpleMessenger

Does anybody have suggestions as to where to start looking this time??

Thanx,
--WjW

