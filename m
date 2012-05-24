From: Florian Haas <florian@hastexo.com>
Subject: Re: ceph rbd crashes/stalls while random write 4k blocks
Date: Thu, 24 May 2012 14:12:00 +0200
Message-ID: <CAPUexz8MxynjO9m=TFpAiVtE9OCGWQfL615XU9yYFksHhNKTeA@mail.gmail.com>
References: <4FBE167A.9060505@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:51334 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab2EXMMD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 08:12:03 -0400
Received: by qadb17 with SMTP id b17so3967783qad.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 05:12:00 -0700 (PDT)
In-Reply-To: <4FBE167A.9060505@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Stefan,

On 05/24/12 13:07, Stefan Priebe - Profihost AG wrote:
> Hi list,
>
> i'm still testing ceph rbd with kvm. Right now i'm testing a rbd block
> device within a network booted kvm.
>
> Sequential write/reads and random reads are fine. No problems so far.
>
> But when i trigger lots of 4k random writes all of them stall after
> short time and i get 0 iops and 0 transfer.
>
> used command:
> fio --filename=/dev/vda --direct=1 --rw=randwrite --bs=4k --size=20G
> --numjobs=50 --runtime=30 --group_reporting --name=file1
>
> Then some time later i see this call trace:
>
> INFO: task ceph-osd:3065 blocked for more than 120 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> ceph-osd        D ffff8803b0e61d88     0  3065      1 0x00000004
>  ffff88032f3ab7f8 0000000000000086 ffff8803bffdac08 ffff880300000000
>  ffff8803b0e61820 0000000000010800 ffff88032f3abfd8 ffff88032f3aa010
>  ffff88032f3abfd8 0000000000010800 ffffffff81a0b020 ffff8803b0e61820
> Call Trace:
>  [<ffffffff815e0e1a>] schedule+0x3a/0x60
>  [<ffffffff815e127d>] schedule_timeout+0x1fd/0x2e0
>  [<ffffffff812696c4>] ? xfs_iext_bno_to_ext+0x84/0x160
>  [<ffffffff81074db1>] ? down_trylock+0x31/0x50
>  [<ffffffff812696c4>] ? xfs_iext_bno_to_ext+0x84/0x160
>  [<ffffffff815e20b9>] __down+0x69/0xb0
>  [<ffffffff8128c4a6>] ? _xfs_buf_find+0xf6/0x280
>  [<ffffffff81074e6b>] down+0x3b/0x50

sorry I'm coming a bit late to the various threads you've posted
recently, but on this particular issue: what kernel are your OSDs
running on, and do these hung tasks occur if you're using a local
filesystem other than XFS?

As of late XFS has occasionally been producing seemingly random kernel
hangs. Your call trace doesn't have the signature entries from xfssyncd
that identify a particular problem that I've been struggling with
lately, but you just might be affected by some other effect of the same
root issue.

Take a look at these to see if anything looks familiar:

http://oss.sgi.com/bugzilla/show_bug.cgi?id=922
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/979498
http://oss.sgi.com/archives/xfs/2011-11/msg00400.html

Not sure if this helps at all; just thought I might pitch that in.

Cheers,
Florian
