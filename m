From: Gregory Farnum <greg@inktank.com>
Subject: Re: Is Ceph recovery able to handle massive crash
Date: Sat, 5 Jan 2013 07:24:38 -0800
Message-ID: <E4F7F67B3C984E789484B54769B434BB@inktank.com>
References: <50E81A3D.5070100@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:55035 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab3AEPdA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 10:33:00 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so9835886pad.31
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jan 2013 07:32:59 -0800 (PST)
In-Reply-To: <50E81A3D.5070100@ledeuns.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Saturday, January 5, 2013 at 4:19 AM, Denis Fondras wrote:
> Hello all,
> 
> I'm using Ceph 0.55.1 on a Debian Wheezy (1 mon, 1 mds et 3 osd over 
> btrfs) and every once in a while, an OSD process crashes (almost never 
> the same osd crashes).
> This time I had 2 osd crash in a row and so I only had one replicate. I 
> could bring the 2 crashed osd up and it started to recover. 
> Unfortunately, the "source" osd crashed while recovering and now I have 
> a some lost PGs.
> 
> If I happen to bring the primary OSD up again, can I imagine the lost PG 
> will be recovered too ?


Yes, it will recover just fine. Ceph is strictly consistent and so you won't lose any data unless you lose the disks.
-Greg

