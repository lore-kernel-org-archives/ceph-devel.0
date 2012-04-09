From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: defaults paths #2
Date: Mon, 9 Apr 2012 11:03:44 -0700
Message-ID: <CAORUGqD06LYcg3-y5BNNt724cvxUm1pkarDx_LoWoPSzx1=f1g@mail.gmail.com>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
 <9B9005B1-9397-4171-8726-A52903B8B8F1@openminds.be> <CAORUGqD_Oe2F-yTS87h5P8oB=OrUTcuZo7BsWo3bqy66VJ1YfA@mail.gmail.com>
 <720D7ADB-C3E4-4C5E-B308-216D941FDC83@openminds.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64391 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677Ab2DISEG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Apr 2012 14:04:06 -0400
Received: by vbbff1 with SMTP id ff1so2449380vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Apr 2012 11:04:05 -0700 (PDT)
In-Reply-To: <720D7ADB-C3E4-4C5E-B308-216D941FDC83@openminds.be>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bernard Grymonpon <bernard@openminds.be>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 6, 2012 at 12:45, Bernard Grymonpon <bernard@openminds.be> wrote:
> Lets go wild, and say, if you have hunderds of machines, summing up to thousands of of disks, all already migrated/moved to other machines/... , and it reports that OSD 536 is offline, how will you find what disk is failing/corrupt/... in which machine? Will you keep track which OSD ran on which node last?

That's a good question and I don't have a good enough answer for you
yet. Rest assured that's a valid concern.

It seems we're still approaching this from different angles. You want
to have an inventory of disks, known by uuid, and want to track where
they are, and plan their moves.

I want to know I have N servers with K hdd slots each, and I want each
one to be fully populated with healthy disks. I don't care what disk
is where, and I don't think it's realistic for me to maintain a manual
inventory. A failed disk means unplug that disk. An empty slot means
plug in a disk from the dedicated pile of spares. A chassis needing
maintenance is to be shut down, disks unplugged & plugged in
elsewhere. I don't care where. A lost disk needs to have its osd
deleted at some point (or just let them pile up; not a realistic
problem for a decade or so). Any inventory of disks is only realistic
from the discovery angle; just report what's plugged in right now.

I consider individual disks just about as uninteresting as power
supplies. Does that make sense?

Details pending..
