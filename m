From: Vincent Godin <vince.mlist@gmail.com>
Subject: Strange behavior of OSD after an IO error
Date: Wed, 27 Sep 2017 16:37:53 +0200
Message-ID: <CAL2-6bLM8HMNkqPsF401TX2ppANBVtD_h40=kYg1uisAa3ruOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:54684 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbdI0Ohy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Sep 2017 10:37:54 -0400
Received: by mail-qk0-f176.google.com with SMTP id d70so13463225qkc.11
        for <ceph-devel@vger.kernel.org>; Wed, 27 Sep 2017 07:37:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I have a pretty big ceph cluster in jewel 10.2.7 (2 PB) and IO errors
are common. I notice two different behaviors of OSDs when they
encounter an IO error

On JBOD mode, the OSD get the IO error and then abort ... The pgs are
peering on others OSDs, the OSD restart, get it's pgs and everything
is going as usual. Ceph health is OK and the degraded object is not
declared to the cluster. So, if another read is needed on the same
object, the process will restart (abort, perring, restart, peering).
Only a deep-scrub will tell the cluster that one pg have a degraded
object. Then a repair command will repair the pg (only a write
operation can force a disk to reallocate a bad sector). Why the
degraded object is not declared when the first read operation get the
IO error ? If we have multiple IO errors on different OSDs, different
read operations will make them flap till a deep-scrub ... The abort
operation seems to be the current behavior according to the code !!!
How the rbd_client deals with that (IO error or retry till the new
peering of the pg ?)

osd log

IO error and abort

2017-09-27 00:55:52.100678 7faceba7b700 -1
filestore(/var/lib/ceph/osd/ceph-276)
FileStore::read(9.103_head/#9:c086eeb2:::rbd_data.6592c12eb141f2.0000000000058795:head#)
pread error: (5) Input/output error
2017-09-27 00:55:52.128147 7faceba7b700 -1 os/filestore/FileStore.cc:
In function 'virtual int FileStore::read(const coll_t&, const
ghobject_t&, uint64_t, size_t, ceph::bufferlist&, uint32_t, bool) '
thread 7faceba7b700 time 2017-09-27 00:55:52.101208
os/filestore/FileStore.cc: 3016: FAILED assert(0 == "eio on pread")

 ceph version 10.2.6 (656b5b63ed7c43bd014bcafd81b001959d5f089f)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x85) [0x7fad141219f5]
 2: (FileStore::read(coll_t const&, ghobject_t const&, unsigned long,
unsigned long, ceph::buffer::list&, unsigned int, bool)+0xd91)
[0x7fad13df0661]
...

then restart

2017-09-27 00:56:26.859560 7fd53b8b0800  0 osd.276 341224 load_pgs
2017-09-27 00:56:35.881155 7fd53b8b0800  0 osd.276 341224 load_pgs
opened 167 pgs
2017-09-27 00:56:35.881531 7fd53b8b0800  0 osd.276 341224 using 0 op
queue with priority op cut off at 64.
2017-09-27 00:56:35.883165 7fd53b8b0800 -1 osd.276 341224
log_to_monitors {default=true}
2017-09-27 00:56:36.875207 7fd53b8b0800  0 osd.276 341224 done with
init, starting boot process

then deep-scrub (manually)

2017-09-27 10:34:22.481133 7fd50b196700  0 log_channel(cluster) log
[INF] : 9.103 deep-scrub starts
2017-09-27 10:44:05.819995 7fd50b196700 -1 log_channel(cluster) log
[ERR] : 9.103 shard 276: soid
9:c086eeb2:::rbd_data.6592c12eb141f2.0000000000058795:head candidate
had a read error
2017-09-27 10:55:22.272655 7fd508991700 -1 log_channel(cluster) log
[ERR] : 9.103 deep-scrub 0 missing, 1 inconsistent objects
2017-09-27 10:55:22.272663 7fd508991700 -1 log_channel(cluster) log
[ERR] : 9.103 deep-scrub 1 errors

then repair

2017-09-27 11:01:10.648292 7fd50b196700  0 log_channel(cluster) log
[INF] : 9.103 repair starts
2017-09-27 11:08:57.329571 7fd50b196700 -1 log_channel(cluster) log
[ERR] : 9.103 shard 276: soid
9:c086eeb2:::rbd_data.6592c12eb141f2.0000000000058795:head candidate
had a read error
2017-09-27 11:18:42.498541 7fd50b196700 -1 log_channel(cluster) log
[ERR] : 9.103 repair 0 missing, 1 inconsistent objects
2017-09-27 11:18:42.498730 7fd50b196700 -1 log_channel(cluster) log
[ERR] : 9.103 repair 1 errors, 1 fixed


The second behavior is more linked to the hardware and i just want to
give a drawback of using raid0 disk

On our cluster, whe used OSD hosts with JBOD and some olders with RAID0 disks
On RAID0 hosts, we notice than when a IO error occured, the OSD never
catch the information (it only appears in dmesg). On OSD log, we can
only see the thread timing out and blocked requests. The OSD behaviour
then depend of the load. Sometime it survive, sometime not but from a
client side, i think it's an IO error for sure. It's probably linked
to my hardware (SmartArray on HP SL4540) but maybe not ...
