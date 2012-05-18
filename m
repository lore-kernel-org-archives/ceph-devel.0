From: Christian Brunner <christian@brunner-muc.de>
Subject: Re: is rados block cluster production ready ?
Date: Fri, 18 May 2012 12:43:01 +0200
Message-ID: <CAJafhzQL4tpyZeRot2=+7HDyMR8xPTcgQS93rXNn+M+f2j8W0Q@mail.gmail.com>
References: <CAJafhzR2PLsH1B3Wwz5c=WAmVNsA1+GeTVKR4o7uLJVoeC_Ubw@mail.gmail.com>
	<b8e35866-361b-4fb2-9273-4c29017158d0@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49117 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966034Ab2ERKnD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 06:43:03 -0400
Received: by yhmm54 with SMTP id m54so2717098yhm.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 03:43:02 -0700 (PDT)
In-Reply-To: <b8e35866-361b-4fb2-9273-4c29017158d0@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

2012/5/18 Alexandre DERUMIER <aderumier@odiso.com>:
> Hi Christian,
> thanks for your response.
>
>>>We are using 0.45 in production. Recent ceph versions are quite stable
>>>(although we hat some troubles with excessive logging and a full log
>>>partition lately which caused our cluster to halt).
>
> excessive logging because of a configuration error ?

0.45 had some debug messages enabled by default, which we didn't
realize when doing the update. It can be easily disabled in the
config. (Haven't checked if this is still the case in 0.46).

>>>For the moment I would definitely recommend using XFS as the
>>>underlying filesystem. At least until there is a fix for the
>>>orphan_commit_root problem. XFS comes with a slight performance
>>>impact, but it seems to be the only filesystem that is able to handle
>>>heavy ceph workload for the moment.
>
> What's the benefit of using btrfs ? snapshots ? (I would like to be able to do snapshots, maybe clones)

RBD snapshots are handled independent of the underlying filesystem. So
you wouldn't loose that feature. (AFAIK clones are still on the
roadmap - RBD layering).

When enabled ceph is using btrfs snapshots internally for consistent
writes. This gives you some performances advantages. With other
filesystems you can only use "write ahead journaling".

see http://ceph.com/docs/master/dev/filestore-filesystem-compat/

>>>We are running a small ceph cluster (4 Servers with 4 OSDs each) on a
>>>10GE network. Servers are spread across two datacenters with a 5km (3
>>>mile) long 10GE fibre-link for data replication. Our servers are
>>>equipped with 80GB Fusion-IO drives (for the journal) and traditional
>>>3,5'' SAS drives in a RAID5 configuration (but I would not reccommend
>>>this setup).
>
>>>From a guest we can get a throughput ~ 500MB/s.
>
> Great ! (And from multiple guests ? do you have more throughput ?)

Yes. We were able to increase that even from a single guest with a
RAID0 over multiple rbd volumes.

> Also about latencies, do you have good latencies with you fusion-io journal?

Latencies are ok, but I don't like the proprietary driver. Not that
the driver is causing any problems, but it is always a bit tricky when
doing kernel updates.

> I currently use zfs storage, and writes are going to fast journal nvram then flushed to disk 15K.
> It is the same behaviour with ceph ?

That is quite similar to the ceph journal.

>>>This is probably the best hardware for a ceph cluster money can buy.
>>>Are you planning a single SAS drive per OSD?
>
> Yes, on osd by drive.
> So if something goes wrong with brtfs or xfs, I'll have only 1 failed disk and not the whole raid.
> Is it the right way for osd ?

You can do it this way. We decided to put the ceph storage on a local
RAID5 because we didn't want to re-replicate over the network when a
single disk has to be swapped. There has been a discussion on the
list, about the best way to setup the OSDs, but I think there was no
final consensus.

Regards,
Christian
