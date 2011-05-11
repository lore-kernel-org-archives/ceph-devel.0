From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: OSD Crash
Date: Wed, 11 May 2011 14:39:26 -0700
Message-ID: <BANLkTi=YHhuXAj5MyuWQiF5qCMu7o=5s-g@mail.gmail.com>
References: <B828A4C02BE12543ACDFCF7EB0C693C67886112B1F@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42991 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756805Ab1EKVj2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 17:39:28 -0400
Received: by fxm17 with SMTP id 17so680791fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 14:39:26 -0700 (PDT)
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C67886112B1F@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, May 11, 2011 at 1:47 PM, Mark Nigh <mnigh@netelligent.com> wrot=
e:
> Some additional testing shows that the underlying filesystem btrfs do=
es fail thus the daemon appropriately fails.
>
> The way I am simulating a failed HDD is by removing the HDD. The fail=
ure is working,
> but the problem is when I reinsert the HDD. I think I see the BTRFS f=
ilesystem
> recovery (btrfs filesystem show) and I can start the correct osd daem=
on that corresponds
> to the mount point but I do not see the osd come up and in (ceph -s).

I am assuming that you are using serial ATA (SATA), because that is
what comes standard on most PCs these days. The last time I used SATA
hotplug, which was in 2009, the driver support was still pretty flaky
at the chipset level. Things may have improved since then, but I
suspect that SATA hotplug is still an uncommon and poorly tested
operation.

If you really want to get hotplug working, start with the basics--
just see whether it works at the driver and block device level. Then
get btrfs involved, and finally if all that works, try Ceph.

However, it might be simpler just to simulate failures by randomly
killing cosd processes.
When cosd hangs on a sync for too long, it will deliver a SIGABRT to
itself anyway. So the only part of the proecss you would be bypassing
is the hang. You're putting your SATA driver and btrfs's error
handling paths through a workout, but not really testing Ceph per se.

Colin


>
> =A0ceph version 0.27.commit: 793034c62c8e9ffab4af675ca97135fd1b193c9c=
=2E process: cosd. pid: 2702
> 2011-05-11 15:13:58.650515 7fc6a349d760 filestore(/mnt/osd2) mount FI=
EMAP ioctl is NOT supported
> 2011-05-11 15:13:58.650754 7fc6a349d760 filestore(/mnt/osd2) mount de=
tected btrfs
> 2011-05-11 15:13:58.650768 7fc6a349d760 filestore(/mnt/osd2) mount bt=
rfs CLONE_RANGE ioctl is supported
>
> If I try to restart the osd daemon, it is unable to kill the process =
and repeats trying to kill it.
>
> Is the underlying file system not recovery like I think? I guess remo=
ving and inserting the HDD isn't the correct way to simulate a dead HDD=
=2E? Show I following the process of removing the osd, initializing the=
 osd data dir and then restart the osd daemon?
>
> Thanks.
>
> Mark Nigh
> Systems Architect
> Netelligent Corporation
> mnigh@netelligent.com
>
>
>
> -----Original Message-----
> From: Mark Nigh
> Sent: Wednesday, May 11, 2011 8:12 AM
> To: 'ceph-devel@vger.kernel.org'
> Subject: OSD Crash
>
> I was performing a few failure test with the osd by removing a HDD fr=
om one of the osd host. All was well, the cluster noticed the failure a=
nd re-balanced data but when I replace the HDD into the host, the cosd =
crashed.
>
> Here is my setup. 6 osd host with 4 HDDs each (4 cosd daemons running=
 for each host). 1 mon and 2 mds (separate host).
>
> Here is the log from the osd0
>
> 2011-05-10 16:25:02.776151 7f9e16d36700 -- 10.6.1.92:6800/15566 >> 10=
=2E6.1.63:0/2322371038 pipe(0x4315a00 sd=3D14 pgs=3D0 cs=3D0 l=3D0).acc=
ept peer addr is really 10.6.1.63:0/2322371038 (socket is 10.6.1.63:422=
99/0)
> os/FileStore.cc: In function 'unsigned int FileStore::_do_transaction=
(ObjectStore::Transaction&)', in thread '0x7f9e22577700'
> os/FileStore.cc: 2120: FAILED assert(0 =3D=3D "EIO handling not imple=
mented")
> =A0ceph version 0.27 (commit:793034c62c8e9ffab4af675ca97135fd1b193c9c=
)
> =A01: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x194) [=
0x5a0c84]
> =A02: (FileStore::do_transactions(std::list<ObjectStore::Transaction*=
, std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x156) [=
0x5a3536]
> =A03: (FileStore::_do_op(FileStore::OpSequencer*)+0x13e) [0x598ebe]
> =A04: (ThreadPool::worker()+0x2a2) [0x626fa2]
> =A05: (ThreadPool::WorkThread::entry()+0xd) [0x529f1d]
> =A06: (()+0x6d8c) [0x7f9e29434d8c]
> =A07: (clone()+0x6d) [0x7f9e2808204d]
> =A0ceph version 0.27 (commit:793034c62c8e9ffab4af675ca97135fd1b193c9c=
)
> =A01: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x194) [=
0x5a0c84]
> =A02: (FileStore::do_transactions(std::list<ObjectStore::Transaction*=
, std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x156) [=
0x5a3536]
> =A03: (FileStore::_do_op(FileStore::OpSequencer*)+0x13e) [0x598ebe]
> =A04: (ThreadPool::worker()+0x2a2) [0x626fa2]
> =A05: (ThreadPool::WorkThread::entry()+0xd) [0x529f1d]
> =A06: (()+0x6d8c) [0x7f9e29434d8c]
> =A07: (clone()+0x6d) [0x7f9e2808204d]
> os/FileStore.cc: In function 'unsigned int FileStore::_do_transaction=
(ObjectStore::Transaction&)', in thread '0x7f9e21d76700'
> os/FileStore.cc: 2120: FAILED assert(0 =3D=3D "EIO handling not imple=
mented")
> =A0ceph version 0.27 (commit:793034c62c8e9ffab4af675ca97135fd1b193c9c=
)
> =A01: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x194) [=
0x5a0c84]
> =A02: (FileStore::do_transactions(std::list<ObjectStore::Transaction*=
, std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x156) [=
0x5a3536]
> =A03: (FileStore::_do_op(FileStore::OpSequencer*)+0x13e) [0x598ebe]
> =A04: (ThreadPool::worker()+0x2a2) [0x626fa2]
> =A05: (ThreadPool::WorkThread::entry()+0xd) [0x529f1d]
> =A06: (()+0x6d8c) [0x7f9e29434d8c]
> =A07: (clone()+0x6d) [0x7f9e2808204d]
> =A0ceph version 0.27 (commit:793034c62c8e9ffab4af675ca97135fd1b193c9c=
)
> =A01: (FileStore::_do_transaction(ObjectStore::Transaction&)+0x194) [=
0x5a0c84]
> =A02: (FileStore::do_transactions(std::list<ObjectStore::Transaction*=
, std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x156) [=
0x5a3536]
> =A03: (FileStore::_do_op(FileStore::OpSequencer*)+0x13e) [0x598ebe]
> =A04: (ThreadPool::worker()+0x2a2) [0x626fa2]
> =A05: (ThreadPool::WorkThread::entry()+0xd) [0x529f1d]
> =A06: (()+0x6d8c) [0x7f9e29434d8c]
> =A07: (clone()+0x6d) [0x7f9e2808204d]
> *** Caught signal (Aborted) **
> =A0in thread 0x7f9e22577700
> ceph version 0.27.commit: 793034c62c8e9ffab4af675ca97135fd1b193c9c. p=
rocess: cosd. pid: 1414
> 2011-05-10 22:01:13.762083 7f0620492760 filestore(/mnt/osd0) mount FI=
EMAP ioctl is NOT supported
> 2011-05-10 22:01:13.762276 7f0620492760 filestore(/mnt/osd0) mount de=
tected btrfs
> 2011-05-10 22:01:13.762288 7f0620492760 filestore(/mnt/osd0) mount bt=
rfs CLONE_RANGE ioctl is supported
> *** Caught signal (Terminated) **
> =A0in thread 0x7f061e7b4700. Shutting down.
>
> As you can see with the attached log, I try to restart the cosd at 22=
:01. The service is started but ceph -s doesn't include the osd.
>
> Thanks for your help.
>
> Mark Nigh
> Systems Architect
> Netelligent Corporation
> mnigh@netelligent.com
>
>
>
> This transmission and any attached files are privileged, confidential=
 or otherwise the exclusive property of the intended recipient or Netel=
ligent Corporation. If you are not the intended recipient, any disclosu=
re, copying, distribution or use of any of the information contained in=
 or attached to this transmission is strictly prohibited. If you have r=
eceived this transmission in error, please contact us immediately by re=
sponding to this message or by telephone (314-392-6900) and promptly de=
stroy the original transmission and its attachments.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
