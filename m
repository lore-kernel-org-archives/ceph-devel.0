From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Ceph 0.23.2 Consolidated questions
Date: Thu, 13 Jan 2011 14:24:32 +1300
Message-ID: <AANLkTi=Xhqo1ASC6ddN4VL2wcjr2HsT+a=utKwjBoqF-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:46884 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756625Ab1AMBYg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jan 2011 20:24:36 -0500
Received: by qwa26 with SMTP id 26so1271603qwa.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jan 2011 17:24:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all:

After some time, I've got several consolidated (hopefully trivial) ques=
tions.
I've tried to cut them short, sorry for asking too many at once.

kernel 2.6.36-02063601-generic (23-Nov-2010)
ceph version 0.23.2 (commit:
5bdae2af8c53adb2e059022c58813e97e7a7ba5d)

1.
about the bug track: http://tracker.newdream.net/issues/479
when using Ext4, I now found that the hang happens when a client runs
on the same machine as the ceph-system.
But the hang does not happen when a client runs on different machine.
i.e.,
- machine1 (MDS,MON,OSD, plus Client mounts) =3D hangs
- machine1 (MDS,MON, OSD, plus separate (machine2) Client mounts) =3D o=
k.
I think this is because of the same IP address (loopback) with some
sync mismatch..?

=46or btrfs, the only no-hang way is to disable journaling (writeahead
and writeparallel).
DD copies keep crashing (mount hangs and makes it pretty much
unmountable again until hard reboot) at about 576MB.


2.
=46or benchmarking the entire ceph system in general, could you
recommend which tools to use, particularly best for Object based
storages?
Would the block based storage benchmark, e.g., Iometer, be a bad
choice?, and why and why not?
I'm running fio (iometer-alike) to do random/sequentail read/write.
I did rados test, too. 'rados -p metadata bench write' command should
be writing to mds node, but it was doing it on osd nodes (i.e,, same
as the data node)
also, 'seq' crashes with lots of errors.


3.
I've got four powerful machines, 2 for osd nodes, 1 for mds/mon
together and 1 for clients. But I was mainly testing for just 1 osd
node for a basic test.
The tests are independently ran for SSDs first and then again for HDDs.
(These disks are connected to HW RAID controllers (but all individual
configured for recommended optimal for servers,
e.g., 8k, directio, directcache, (writethru for ssd, and writeback for =
hdd)
The repl rules are all set to 1x (and again to default 2x). All osds
use 10G journal size (journal write ahead, parallel, and noJournal,
and ext4)
all links are 2Gb links and so I get near 230MB/s iperf.
Once Ceph started, I first do a large single-file dd copy (40GB for
SSDs, and 500GB for HDDs),
twiki.esc.auckland.ac.nz/twiki/bin/view/NDSG/Cephtest

the plot is here, for DD
twiki.esc.auckland.ac.nz/twiki/pub/NDSG/Cephtest/ddplot.pdf

After the files are created, I ran iometer-like (fio) for
random/sequential read/write (RR, SR, RW, and SW) to the file I just
created (i.e., 40GB for ssd and 500GB for hdd)
The results are here, (note, the plot is quite 'concised' and dense!)
twiki.esc.auckland.ac.nz/twiki/pub/NDSG/Cephtest/fioplot.pdf

The only understandable parts are the sequential 'read' parts, writes
are slow, and I'm not necessarily seeing any 'gaps' observed for any
osd change.

Questions.
- When journal size =3D 10000, why does the journal file in the /data/
shows as 1.8GB ?
- Also, journal write ahead or parallel? which mode do I need to set
for ssd or harddisk? (the plot answers, basically ahead/parallel okay)
- Increasing osds (1 to 3 to 6) doesnt seem to increase any
performance at all (if so, hardly by a few %).
- In some cases, 6osds is lower than 3osds (for hdds DD copy in
particular, 1osd to 3osd increase, but 6osds deteriorates badly)

- so I ended up using 2 nodes, with (1+1, 2+2, and 3+3 osd config),
and for hdds it seems to have increased linearly for DD.
- so why is having 6osds in 1 node, is slower than 3+3osds in 2 nodes?
at least some bottlenecks should occur in-between the nodes. Crushmap
appears to be the same.
I was really expecting to see some linear increase or even visible
increase as I add more disks, but appears not at all...

4.
=46or the PG setup, using a simple ceph.conf (just osd[123] to a single=
 machine)
and setting the repl to x1, how would I expect the objects to get
mapped to disks?
How do I really configure and control how things go?
Currently,

rule data {
=A0=A0=A0 ruleset 0
=A0=A0=A0 type replicated
=A0=A0=A0 min_size 1
=A0=A0=A0 max_size 10
=A0=A0=A0 step take root
=A0=A0=A0 step choose firstn 0 type device
=A0=A0=A0 step emit
}

Is it normal for it to be always 'type replicated' ?
Does it supposed to be different when repl set to x2, x3, etc?
How do I check and correctly make sure that the data are distrbuted
among all 3 (or 6) osds? (for both write and read, like the RAID0)

Using crushtool --num_osds 3 -o file --build host straw 0 root straw 0

# buckets
host host0 {
=A0=A0=A0 id -1=A0=A0=A0 =A0=A0=A0 # do not change unnecessarily
=A0=A0=A0 alg straw
=A0=A0=A0 hash 0=A0=A0=A0 # rjenkins1
=A0=A0=A0 item device0 weight 1.000
}
=2E..(omitted for host1 and host2)
root root {
=A0=A0=A0 id -4=A0=A0=A0 =A0=A0=A0 # do not change unnecessarily
=A0=A0=A0 alg straw
=A0=A0=A0 hash 0=A0=A0=A0 # rjenkins1
=A0=A0=A0 item host0 weight 1.000
=A0=A0=A0 item host1 weight 1.000
=A0=A0=A0 item host2 weight 1.000
}
# rules
rule data {
=A0=A0=A0 ruleset 1
=A0=A0=A0 type replicated
=A0=A0=A0 min_size 2
=A0=A0=A0 max_size 2
=A0=A0=A0 step take root
=A0=A0=A0 step chooseleaf firstn 0 type host
=A0=A0=A0 step emit
}

What exactly is the difference between the above and the existing map
(from default ceph.conf)?
Why is the ruleset starts from 1?
Does it have to be different for each rule?
where is this number min/max 2 came from?
why is it set to chooseleaf? (what mode do I set to 'choose'?)
Also, it doesn't list metadata rule, so I had to manually add that in.

I've added --crushmapsrc file.txt when mkcephfs, but when I read it
back from ceph, it seems to return the normal one (i.e., ceph.conf
regenerated)
So I end up using the online approach after the ceph started, and
mounted, but as I write files, it hangs.

5.
Other than the ceph, crush and rados papers, Has there been any ceph
work done on the applications/performances/benchmark comparisons using
others?


Thanks a lot in advance, and again sorry for asking too many.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
