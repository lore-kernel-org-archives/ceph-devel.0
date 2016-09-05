From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Inconclusive answer when running tests for cephtool-test-mon.sh
Date: Mon, 5 Sep 2016 13:42:53 +0200
Message-ID: <91990552-a865-e81d-0946-11236d27bd86@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:57681 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932643AbcIELnN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Sep 2016 07:43:13 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id BC33128E82
        for <ceph-devel@vger.kernel.org>; Mon,  5 Sep 2016 13:43:06 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

I would innterested to know why I get 2 different answers:

(this is asking the OSDs directly?)
ceph osd dump
  but osd.0 is in, up, up_from 179 up_thru 185 down_at 176
  osd.1/2 are in, up, up_from 8/13 up_thru 224 down_at 0

ceph -s reports 1 OSD down

So all osds in the dump are in and up, but ...
I guess that osd.0 is telling me when it came back and that it has not
all the data that osd.1/2 have because they go up to 224

Which is why ceph -s tells me that one osd is down?
Or did the leading MON nog get fully informed.

What daemon is missing what part of the communication?
And what for type of warning/error should I look for in the log files?

Thanx,
--WjW


4: /home/wjw/wip/qa/workunits/cephtool/test.sh:12: check_no_osd_down:
ceph osd dump
4: epoch 230
4: fsid d00499b7-6b4c-4e71-a862-420b0d921097
4: created 2016-09-05 13:10:08.247894
4: modified 2016-09-05 13:13:17.952969
4: flags sortbitwise,require_jewel_osds,require_kraken_osds
4: pool 0 'rbd' replicated size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 last_change 1 flags hashpspool stripe_width 0
4: max_osd 3
4: osd.0 up   in  weight 1 up_from 179 up_thru 185 down_at 176
last_clean_interval [4,178) 127.0.0.1:6800/27490 127.0.0.1:6812/1027490
127.0.0.1:6813/1027490 127.0.0.1:6814/1027490 exists,up
cb894225-670c-4e80-8e15-123c161cd00e
4: osd.1 up   in  weight 1 up_from 8 up_thru 224 down_at 0
last_clean_interval [0,0) 127.0.0.1:6804/27505 127.0.0.1:6805/27505
127.0.0.1:6806/27505 127.0.0.1:6807/27505 exists,up
8cf8bf1f-27ce-49bb-88cf-c1d54511c434
4: osd.2 up   in  weight 1 up_from 13 up_thru 224 down_at 0
last_clean_interval [0,0) 127.0.0.1:6808/27520 127.0.0.1:6809/27520
127.0.0.1:6810/27520 127.0.0.1:6811/27520 exists,up
568223b6-06d6-41d0-92c3-286227819bb5
4: pg_temp 0.2 [1,2]
4: pg_temp 0.6 [1,2]
4: pg_temp 0.7 [1,2]
4: /home/wjw/wip/qa/workunits/cephtool/test.sh:13: check_no_osd_down:
ceph -s
4:     cluster d00499b7-6b4c-4e71-a862-420b0d921097
4:      health HEALTH_WARN
4:             5 pgs peering
4:             3 pgs stale
4:             1/3 in osds are down
4:      monmap e1: 3 mons at
{a=127.0.0.1:7202/0,b=127.0.0.1:7203/0,c=127.0.0.1:7204/0}
4:             election epoch 6, quorum 0,1,2 a,b,c
4:      osdmap e232: 3 osds: 2 up, 3 in; 5 remapped pgs
4:             flags sortbitwise,require_jewel_osds,require_kraken_osds
4:       pgmap v326: 8 pgs, 1 pools, 0 bytes data, 0 objects
4:             200 GB used, 248 GB / 448 GB avail
4:                    3 stale+active+clean
4:                    3 remapped+peering
4:                    2 peering
