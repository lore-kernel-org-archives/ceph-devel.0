From: Christian Brunner <christian@brunner-muc.de>
Subject: Re: Designing a cluster guide
Date: Mon, 21 May 2012 16:59:47 +0200
Message-ID: <CAJafhzQp1SeGZUdUL5XszaRw-0bU0f38r3ghLgmTvZrF0oB_=w@mail.gmail.com>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
	<4FB8A3A5.5090809@profihost.ag>
	<CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>
	<4FB8B1CE.1080803@icukhosting.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53275 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757173Ab2EUO7s convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 10:59:48 -0400
Received: by yenm10 with SMTP id m10so4382934yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 07:59:47 -0700 (PDT)
In-Reply-To: <4FB8B1CE.1080803@icukhosting.co.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim O'Donovan <tim@icukhosting.co.uk>
Cc: ceph-devel@vger.kernel.org

2012/5/20 Tim O'Donovan <tim@icukhosting.co.uk>:
>> - High performance Block Storage (RBD)
>>
>> =A0 Many large SATA SSDs for the storage (prbably in a RAID5 config)
>> =A0 stec zeusram ssd drive for the journal
>
> How do you think standard SATA disks would perform in comparison to
> this, and is a separate journaling device really necessary?

A journaling device is improving write latency a lot and the write
latency is directly related to the throughput you get in your virtual
machine. If you have a raid controller with a battery backed write
cache you could try to put the journal on a separate, small partition
of your SATA disk. I haven't tried this, but I think this could work.

Apart from that you should calculate the sum of the IOPS your guests
genereate. In the end everything has to be written on your backend
storage and is has to be able to deliver the IOPS.

With the journal you might be able to compensate short write peaks and
there might be a gain by merging write requests on the OSDs, but for a
solid sizing I would neglect this. Read requests can be delivered for
the OSDs cache (RAM), but again this will probably give you only a
small gain.

=46or a single SATA disk you can calculate with 100-150 IOPS (depending
on the speed of the disk). SSDs can deliver much higher IOPS values.

> Perhaps three servers, each with 12 x 1TB SATA disks configured in
> RAID10, an osd on each server and three separate mon servers.

With a replication level of two this would be 1350 IOPS:

150 IOPS per disk * 12 disks * 3 servers / 2 for the RAID10 / 2 for
ceph replication

Comments on this formula would be welcome...

> Would this be suitable for the storage backend for a small OpenStack
> cloud, performance wise, for instance?

That depends on what you are doing in your guests.

Regards,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
