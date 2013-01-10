From: Gregory Farnum <greg@inktank.com>
Subject: Re: Crushmap Design Question
Date: Thu, 10 Jan 2013 13:34:20 -0800
Message-ID: <CAPYLRziRWbtuZy=dQaZyJ9UckLzZWFUq1YQmmYN0td=t3JxCtA@mail.gmail.com>
References: <AEBA0243790A484AA72D5CDF477159BC1CEB087D@SN2PRD0106MB178.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:61000 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab3AJVeW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 16:34:22 -0500
Received: by mail-qa0-f48.google.com with SMTP id l8so982484qaq.7
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 13:34:21 -0800 (PST)
In-Reply-To: <AEBA0243790A484AA72D5CDF477159BC1CEB087D@SN2PRD0106MB178.prod.exchangelabs.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Moore, Shawn M" <smmoore@catawba.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 8, 2013 at 12:20 PM, Moore, Shawn M <smmoore@catawba.edu> wrote:
> I have been testing ceph for a little over a month now.  Our design goal is to have 3 datacenters in different buildings all tied together over 10GbE.  Currently there are 10 servers each serving 1 osd in 2 of the datacenters.  In the third is one large server with 16 SAS disks serving 8 osds.  Eventually we will add one more identical large server into the third datacenter.  I have told ceph to keep 3 copies and tried to do the crushmap in such a way that as long as a majority of mon's can stay up, we could run off of one datacenter's worth of osds.   So in my testing, it doesn't work out quite this way...
>
> Everything is currently ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
>
> I will put hopefully relevant files at the end of this email.
>
> When all 28 osds are up, I get:
> 2013-01-08 13:56:07.435914 mon.0 [INF] pgmap v2712076: 7104 pgs: 7104 active+clean; 60264 MB data, 137 GB used, 13570 GB / 14146 GB avail
>
> When I fail a datacenter (including 1 of 3 mon's) I eventually get:
> 2013-01-08 13:58:54.020477 mon.0 [INF] pgmap v2712139: 7104 pgs: 7104 active+degraded; 60264 MB data, 137 GB used, 13570 GB / 14146 GB avail; 16362/49086 degraded (33.333%)
>
> At this point everything is still ok.  But when I fail the 2nd datacenter (still leaving 2 out of 3 mons running) I get:
> 2013-01-08 14:01:25.600056 mon.0 [INF] pgmap v2712189: 7104 pgs: 7104 incomplete; 60264 MB data, 137 GB used, 13570 GB / 14146 GB avail
>
> Most VM's quit working and "rbd ls" works, but not a single line from "rados -p rbd ls" works and the command hangs.  Now after a while (you can see from timestamps) I end up at and stays this way:
> 2013-01-08 14:40:54.030370 mon.0 [INF] pgmap v2713794: 7104 pgs: 213 active, 117 active+remapped, 3660 incomplete, 3108 active+degraded+remapped, 6 remapped+incomplete; 60264 MB data, 65701 MB used, 4604 GB / 4768 GB avail; 7696/49086 degraded (15.679%)

This took me a bit to work out as well, but you've run afoul of a new
post-argonaut feature intended to prevent people from writing with
insufficient durability. Pools now have a "min size" and PGs in that
pool won't go active if they don't have that many OSDs to write on.
The clue here is the "incomplete" state. You can change it with "ceph
osd pool foo set min_size 1", where "foo" is the name of the pool
whose min_size you wish to change (and this command sets the min size
to 1, obviously). The default for new pools is controlled by the "osd
pool default min size" config value (which you should put in the
global section). By default it'll be half of your default pool size.

So in your case your pools have a default size of 3, and the min size
is (3/2 = 1.5 rounded up), and the OSDs are refusing to go active
because of the dramatically reduced redundancy. You can set the min
size down though and they will go active.
-Greg
