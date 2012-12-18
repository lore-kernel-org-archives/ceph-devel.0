From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Striped images and cluster misbehavior
Date: Tue, 18 Dec 2012 11:26:05 +0300
Message-ID: <CABYiri_5ww+RBdXM0CVEU9+WcHveXdQEJ6ymcp_-K9hgO_o=QQ@mail.gmail.com>
References: <CABYiri-uqJ3sJt-pnV24EG60T6PGL7K+QvhSwE-=OnEG1R6W_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56584 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab2LRIwd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Dec 2012 03:52:33 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so335844obb.33
        for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 00:52:32 -0800 (PST)
In-Reply-To: <CABYiri-uqJ3sJt-pnV24EG60T6PGL7K+QvhSwE-=OnEG1R6W_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Dec 17, 2012 at 2:36 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
> Hi,
>
> After recent switch do default  ``--stripe-count 1'' on image upload I
> have observed some strange thing - single import or deletion of the
> striped image may temporarily turn off entire cluster, literally(see
> log below).
> Of course next issued osd map fix the situation, but all in-flight
> operations experiencing a short freeze. This issue appears randomly in
> some import or delete operation, have not seen any other types causing
> this. Even if a nature of this bug laying completely in the client-osd
> interaction, may be ceph should develop a some foolproof actions even
> if complaining client have admin privileges? Almost for sure this
> should be reproduced within teuthology with rwx rights both on osds
> and mons at the client. And as I can see there is no problem on both
> physical and protocol layer for dedicated cluster interface on client
> machine.
>
> 2012-12-17 02:17:03.691079 mon.0 [INF] pgmap v2403268: 15552 pgs:
> 15552 active+clean; 931 GB data, 2927 GB used, 26720 GB / 29647 GB
> avail
> 2012-12-17 02:17:04.693344 mon.0 [INF] pgmap v2403269: 15552 pgs:
> 15552 active+clean; 931 GB data, 2927 GB used, 26720 GB / 29647 GB
> avail
> 2012-12-17 02:17:05.695742 mon.0 [INF] pgmap v2403270: 15552 pgs:
> 15552 active+clean; 931 GB data, 2927 GB used, 26720 GB / 29647 GB
> avail
> 2012-12-17 02:17:05.991900 mon.0 [INF] osd.0 10.5.0.10:6800/4907
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.991859 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992017 mon.0 [INF] osd.1 10.5.0.11:6800/5011
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.991995 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992139 mon.0 [INF] osd.2 10.5.0.12:6803/5226
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.992110 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992240 mon.0 [INF] osd.3 10.5.0.13:6803/6054
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.992224 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992330 mon.0 [INF] osd.4 10.5.0.14:6803/5792
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.992317 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992420 mon.0 [INF] osd.5 10.5.0.15:6803/5564
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.992405 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992515 mon.0 [INF] osd.7 10.5.0.17:6803/5902
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.992501 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992607 mon.0 [INF] osd.8 10.5.0.10:6803/5338
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.992591 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992702 mon.0 [INF] osd.10 10.5.0.12:6800/5040
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.992686 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992793 mon.0 [INF] osd.11 10.5.0.13:6800/5748
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.992778 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992891 mon.0 [INF] osd.12 10.5.0.14:6800/5459
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.992875 >=
> grace 20.000000)
> 2012-12-17 02:17:05.992980 mon.0 [INF] osd.13 10.5.0.15:6800/5235
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.992966 >=
> grace 20.000000)
> 2012-12-17 02:17:05.993081 mon.0 [INF] osd.16 10.5.0.30:6800/5585
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.993065 >=
> grace 20.000000)
> 2012-12-17 02:17:05.993184 mon.0 [INF] osd.17 10.5.0.31:6800/5578
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.993169 >=
> grace 20.000000)
> 2012-12-17 02:17:05.993274 mon.0 [INF] osd.18 10.5.0.32:6800/5097
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.993260 >=
> grace 20.000000)
> 2012-12-17 02:17:05.993367 mon.0 [INF] osd.19 10.5.0.33:6800/5109
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.993352 >=
> grace 20.000000)
> 2012-12-17 02:17:05.993464 mon.0 [INF] osd.20 10.5.0.34:6800/5125
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.993448 >=
> grace 20.000000)
> 2012-12-17 02:17:05.993554 mon.0 [INF] osd.21 10.5.0.35:6800/5183
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.993538 >=
> grace 20.000000)
> 2012-12-17 02:17:05.993644 mon.0 [INF] osd.22 10.5.0.36:6800/5202
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.993628 >=
> grace 20.000000)
> 2012-12-17 02:17:05.993740 mon.0 [INF] osd.23 10.5.0.37:6800/5252
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.993725 >=
> grace 20.000000)
> 2012-12-17 02:17:05.993831 mon.0 [INF] osd.24 10.5.0.30:6803/5758
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.993816 >=
> grace 20.000000)
> 2012-12-17 02:17:05.993924 mon.0 [INF] osd.25 10.5.0.31:6803/5748
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.993908 >=
> grace 20.000000)
> 2012-12-17 02:17:05.994018 mon.0 [INF] osd.26 10.5.0.32:6803/5275
> failed (3 reports from 1 peers after 2012-12-17 02:17:29.994002 >=
> grace 20.000000)
> 2012-12-17 02:17:06.105315 mon.0 [INF] osdmap e24204: 32 osds: 4 up, 32 in
> 2012-12-17 02:17:06.051291 osd.6 [WRN] 1 slow requests, 1 included
> below; oldest blocked for > 30.947080 secs
> 2012-12-17 02:17:06.051299 osd.6 [WRN] slow request 30.947080 seconds
> old, received at 2012-12-17 02:16:35.042711:
> osd_op(client.2804602.0:20660 rbd_data.2a8fb612200854.00000000000000ec
> [write 1572864~278528] 6.b45f4c88) v4 currently waiting for sub ops


Dropping client privileges works for me somehow - I`m not able to mark
as down more than a couple of osds on same host using rados
copy/clone/remove commands. I`ll check if
http://tracker.newdream.net/issues/3567 resolved this issue by testing
in this week.
