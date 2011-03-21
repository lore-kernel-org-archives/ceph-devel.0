From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Disk allocation
Date: Mon, 21 Mar 2011 08:17:31 -0700
Message-ID: <AANLkTimo+LohYdZdF4SSEar3HHfuHf8tqn5FCvee620B@mail.gmail.com>
References: <1449881494.12831.1300600065210.JavaMail.root@mail.linserv.se>
	<51655650.12833.1300603409038.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39966 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab1CUPRf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 11:17:35 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id BD8C4C068
	for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 08:17:33 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6E05CC066
	for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 08:17:33 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1539791eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 08:17:32 -0700 (PDT)
In-Reply-To: <51655650.12833.1300603409038.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel@vger.kernel.org

On Sat, Mar 19, 2011 at 11:43 PM, Martin Wilderoth
<martin.wilderoth@linserv.se> wrote:
> I have a small ceph cluster with 4 osd ( 2 disks on 2 hosts).
>
> I have been adding and removing files from the file system, mounted as ceph on an other host.
>
> Now I have removed most of the data on the file system, so I only have 300 MB left plus two snapshots.
>
> The problem is that looking at the disks the are allocating 88G of data
> on the ceph filesystem.
There are a few possibilities:
1) You've hosted your OSDs on a partition that's shared with the rest
of the computer. In that case the reported used space will include
whatever else is on the partition, not just the Ceph files. (This can
include Ceph debug logs, so even if nothing used to be there but you
were logging on that partition that can build up pretty quickly.)
2) You deleted the files quickly and just haven't given enough time
for the file deletion to propagate to the OSDs. Because the POSIX
filesystem is layered over an object store, this can take some time.
3) Your snapshots contain a lot of files, so nothing (or very little)
actually got deleted. Snapshots are pretty cool but they aren't
miraculous disk space!
Given the uneven distribution of disk space I suspect option #2, but I
could be mistaken. :) Let us know!
-Greg
