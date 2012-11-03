From: Gregory Farnum <greg@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Sat, 3 Nov 2012 18:55:34 +0100
Message-ID: <CAPYLRzhjfpj6GqzVaxvn3VCLOj7SLFw0pucjk=zHYjDTDYDx0g@mail.gmail.com>
References: <alpine.DEB.2.00.1210040823250.23556@cobra.newdream.net>
	<201210041554.q94FsdHG021382@ayesha.phys.virginia.edu>
	<CAPYLRzh=xCNWeHyLVpcJH3Vzy1PeBCkaibXNSQO2L7_=g64Ufw@mail.gmail.com>
	<201210291508.q9TF8P18020879@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39853 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab2KCRzg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 13:55:36 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3282893lbo.19
        for <ceph-devel@vger.kernel.org>; Sat, 03 Nov 2012 10:55:35 -0700 (PDT)
In-Reply-To: <201210291508.q9TF8P18020879@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>, Samuel Just <sam.just@inktank.com>
Cc: bryan@virginia.edu, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Oct 29, 2012 at 4:08 PM, Bryan K. Wright
<bkw1a@ayesha.phys.virginia.edu> wrote:
>
> greg@inktank.com said:
>> Eeek, I was going through my email backlog and came across this thre=
ad again.
>> Everything here does look good; the data distribution etc is pretty
>> reasonable. If you're still testing, we can at least get a rough ide=
a of the
>> sorts of IO the OSD is doing by looking at the perfcounters out of t=
he admin
>> socket: ceph --admin-daemon /path/to/socket perf dump (I believe the=
 default
>> path is /var/run/ceph/ceph-osd.*.asok)
>
> Hi Greg,
>
>         Thanks for your help.  I've been experimenting with other thi=
ngs,
> so the cluster has a different arrangement now, but the performance
> seems to be about the same.  I've now broken down the RAID arrays int=
o
> JBOD disks, and I'm running one OSD per disk, recklessly ignoring
> the warning about syncfs being missing.  (Performance doesn't seem
> any better or worse than it was before when rsyncing a large director=
y
> of small files.)  I've also added another osd node into the mix, with
> a different disk controller.
>
>         For what it's worth, here are "perf dump" outputs for a
> couple of OSDs running on the old and new hardware, respectively:
>
> http://ayesha.phys.virginia.edu/~bryan/perf.osd.200.txt
> http://ayesha.phys.virginia.edu/~bryan/perf.osd.100.txt
>
> If you could take a look at them and let me know if you see
> anything enlightening, I'd really appreciate it.

Sam, can you check these out? I notice in particular that the average
"apply_latency" is 1.44 seconds =97 but I don't know if I have the unit=
s
right on that or have parsed something else wrong.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
