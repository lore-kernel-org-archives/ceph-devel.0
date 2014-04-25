From: Xing <xinglin@cs.utah.edu>
Subject: question about futex calls in OSD
Date: Fri, 25 Apr 2014 11:40:13 -0600
Message-ID: <05766158-8F27-4AAC-A6F2-0CBBE0430D68@cs.utah.edu>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:55018 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbaDYRkP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Apr 2014 13:40:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id CF32D650189
	for <ceph-devel@vger.kernel.org>; Fri, 25 Apr 2014 11:40:14 -0600 (MDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Xing <xinglin@cs.utah.edu>

Hi,

This is Xing, a graduate student at the University of Utah. I am playin=
g with Ceph and have a few questions about futex calls in OSD process. =
I am using Ceph-v0.79. The data node machine has 7 disks, one for OS an=
d the other 6 disks for running 6 OSDs. I set replica size =3D 1, for a=
ll three pools (this is to improve sequential read bandwidth. Since cep=
h is doing replication synchronously, it layouts data in a fashion simi=
lar as RAID 10 with the near format for replica size=3D2 with two OSDs.=
 Each OSD will store exactly the same copy of whole data while during r=
ead back, only half blocks will be read from each OSD: it will read one=
 block, seek over the next block and then read the third block. Ideally=
, to get full disk bandwidth, we should layout data as the far format i=
n RAID 10. I do not know how to do that in Ceph and thus simply tried w=
ith replicasize=3D1). I created a rbd block device, initialized with an=
 ext4 fs, stored a 10GB file into it and then read it back sequentially=
=2E I set the read_ahead to be 128M or 1G, to get the maximum bandwidth=
 for a single rbd block device (I know this is not realistic).=20

While these reads requests are being served, I used strace to capture a=
ll system calls for an OSD thread that actually does reads. I observed =
lots of futex system calls. By specifying -T for strace, it reports tim=
e spent by each system call and I summed it up to come up with total ti=
me spent for each system call. I further break down two main futex call=
s that contributes most to its overhead.
----------
syscall    runtime (s)   call num  average (s)
pread      11.1028       420       0.026435
fgetxattr  0.178381      1680      0.000106
futex      8.83125       5217
total runtime: 21

                           runtime (s)  call num average (s)
futex(WAIT_PRIVATE):       4.97166      1415     0.003513
futex(WAIT_BITSET_PRIVATE  3.79         51       0.0743
----------

The overhead of lock seems to be quite high. I image this could become =
worse as I increase the number of workloads. I was wondering why there =
are so many futex calls and took some time to look into it. It appears =
to me that there are three locks used during the read path in OSD. Thes=
e locks are Mutexes and I believe the futex calls I observed in straces=
 are results of operations on these Mutexes.=20

a. snapset_contexts_lock, used in functions such as get_snapset_context=
() and put_snapset_context()

b. fdcache_lock, used in lfn_open() and such

c. ondisk_read_lock, used in execute_ctx().=20

The one that affects most is the snapset_contexts_lock: this lock seems=
 to be the monolithic lock for controlling access to all object files i=
n a snapset or to all object files within the same placement group and =
belonging to the same snapset (not sure what a =92snapset=92 means. It =
sounds like equivalent to a =92snapshot=92.). To read a block from an o=
bject file, OSD needs to first read two extended attributes (OI_ATTR an=
d SS_ATTR) for that file. For each read of these attributes, it seems t=
he snapset_contexts_lock is involved: the SS_ATTR attribute is read ins=
ide the get_snapset_context() function; the OI_ATTR attribute is read i=
n the function get_object_context() which could be called from the func=
tion find_object_context(). In the find_object_context(), I can also fi=
nd a few calls to get_snapset_context() function. To release a snapset =
context, the snapset_contexts_lock is also involved (in the put_snapset=
_context()).=20

Here are a few questions.
1. What is the snapset_contexts_lock used for? Is it used to control ac=
cesses to all files in a snapset or all files in the same placement gro=
up and belonging to the same snapset? Such a big lock design does not s=
eem to be scale. Any comments?
2. Has anyone noticed the overhead in locking? I tried to comment out t=
he lock in get_snapset_context() and put_snapset_context(), by commenti=
ng the Mutex instantiation statement but that turns the system to be no=
t working: I could not list/mount rbd block devices.=20

Thanks very much for reading this. Any comment is welcome.=20
Thanks,
Xing




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
