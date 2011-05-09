From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: replication write speed
Date: Mon, 9 May 2011 09:02:38 -0700
Message-ID: <BANLkTinZLKcRhdui7Ct94_qWDBmYHGEHsQ@mail.gmail.com>
References: <BANLkTimPZ0rNe2-edtahK4RHRMQZH52qBw@mail.gmail.com>
	<BANLkTi=gkJcs9yxXVAMo9nrvz2J1yGhQ4w@mail.gmail.com>
	<BANLkTinznnde+t8sLSMT3rMmN6tyQ5Z-Bw@mail.gmail.com>
	<BANLkTinaWG5W+HzvF9G=0U7Q48jk9fCkCw@mail.gmail.com>
	<BANLkTi=5JynhL3V_AJ9iCP=Fjz8b2eVKuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50867 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab1EIQCm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2011 12:02:42 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id BA042C067
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 09:02:41 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id A83C7C065
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 09:02:40 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1584136eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 May 2011 09:02:39 -0700 (PDT)
In-Reply-To: <BANLkTi=5JynhL3V_AJ9iCP=Fjz8b2eVKuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, May 9, 2011 at 12:01 AM, Simon Tian <aixt2006@gmail.com> wrote:
> 2011/5/9 Gregory Farnum <gregf@hq.newdream.net>:
>> On Sun, May 8, 2011 at 8:04 PM, Simon Tian <aixt2006@gmail.com> wrot=
e:
>>> For primary copy, I think when the replication size is 3, 4, or eve=
n
>>> more, the writing speed should also near with 2 replication. Becaus=
e
>>> the 2nd, 3rd, 4th, ... replication are written parallelly. =A0The s=
peed
>>> I got for 3, 4 replication is not near with the speed of 2, in fact=
,
>>> like linear reduce.
>> You're hitting your network limits there. With primary copy then the
>> primary needs to send out the data to each of the replicas, which ca=
ps
>> the write speed at (network bandwidth) / (num replicas). Presumably
>> you're using a gigabit network (or at least your nodes have gigabit
>> connections):
>> 1 replica: ~125MB/s (really a bit less due to protocol overhead)
>> 2 replicas:~62MB/s
>> 3 replicas: ~40MB/s
>> 4 replicas: ~31MB/s
>> etc.
>> Of course, you can also be limited by the speed of your disks (don't
>> forget to take journaling into account); and your situation is furth=
er
>> complicated by having multiple daemons per physical node. But I
>> suspect you get the idea. :)
>
>
> =A0Yes, you are very right! =A0 The client throughput with different =
replication
> size will be limited by the network bandwidth of the primary copy.
>
>
> I have some other questions:
> 1. =A0If I have to write or read a sparse file randomly, will the
> performance reduce much?
That depends on how large your random IOs are, how much of the file is
cached in-memory on the OSDs, etc. In general, random IO does not look
a lot different than sequential IO to the OSDs -- since the OSDs store
files in 4MB blocks then any large file read will involve retrieving
random 4MB blocks from the OSD anyway. On the client you might see a
bigger difference, though -- there is a limited amount of prefetching
going on client-side and it will work much better with sequential than
random reads.

But behavior under different workloads is an area that still needs
more study and refinement.

> 2. Is a rbd image sparse file?
Yes! As with files in the POSIX-compatible Ceph layer, RBD images are
stored in blocks (4MB by default) on the OSDs. Only those chunks with
data actually exist, and depending on your options and the backing
filesystem, only the piece of the chunk with data is actually stored.

> 3. As the attachment showed, =A0the read throughput will increase whe=
n
> I/O size increasing.
> =A0 What is this I/O size mean? Is there any relationship between I/O
> size and object size?
> =A0 In the latest ceph, what will the read throughput of different fi=
le
> system like with different I/O size?
Is that one of the illustrations from Sage's thesis?
In general larger IOs will have higher throughput for many of the same
reasons that larger IOs have higher throughput on hard drives: the OSD
still needs to retrieve the data from off-disk, and a larger IO size
will minimize the impact of the seek latency there. With very large
IOs, the client can dispatch multiple read requests at once, allowing
the seek latency on the OSDs to happen simultaneously rather than
sequentially.
You can obviously do IOs of any size without regard fro the size of
the object; the client layers handle all the necessary translation.
In all versions of Ceph, you can expect higher throughput with larger
IO sizes. I'm not sure if that's what you mean?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
