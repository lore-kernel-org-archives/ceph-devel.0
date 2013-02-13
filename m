From: Ben Rowland <ben.rowland@gmail.com>
Subject: Write Replication on Degraded PGs
Date: Wed, 13 Feb 2013 11:40:27 +0000
Message-ID: <CAEU8emmTpA7TqYDuQ0=ybN_NkmosWAghn+vu=ggGEFwPeFps9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:51394 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759144Ab3BMLk3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 06:40:29 -0500
Received: by mail-la0-f47.google.com with SMTP id fj20so1065727lab.34
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 03:40:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Apologies that this is a fairly long post, but hopefully all my
questions are similar (or even invalid!)

Does Ceph allow writes to proceed if it's not possible to satisfy the
rules for replica placement across failure domains, as specified in
the CRUSH map?  For example, if my CRUSH map says to place one replica
on each of 2 hosts, and no devices are up on one of the hosts, what
will happen?

=46rom tests on a small cluster, my finding is that Ceph will allow
writes to proceed in this case, even when there are less OSDs "in" the
cluster than the replication size.

If this is the expected behaviour of Ceph, then it seems to prefer
write-availability over read-availability (in this case my data is
only stored on 1 OSD, thus a SPOF).  Is there any way to change this
trade-off, e.g. as you can in Cassandra with its write quorums?

=46rom reading the paper which details the CRUSH replica placement
algorithm, I understand several concepts:

- The CRUSH algorithm loops over n replicas, for each descending from
items in the current set (buckets) until it finds a device
- "CRUSH may reject and reselect items using a modi=EF=AC=81ed input fo=
r three
different reasons: if an item has already been selected in the current
set (a collision..., if a device is failed, or if a device is
overloaded."

I'm not clear on what will happen if these constraints cannot be met,
say in the case mentioned above.  Does Ceph store the object once
only, not meeting the replica size, or does it store the object twice
on the same OSD somehow?  The latter would violate point 2 above,
unless the word "reselect" is appropriate here.

Now, if any details are required (no need to read if my questions are
already answered) ...

I'm running some tests with 2 hosts, each running only 1 OSD. There is
one monitor running on one of the hosts. I have the default CRUSH map
and performing writes via RGW. My understanding of the following
default 'data' crush rule is that Ceph will place 1 copy on each of
the 2 OSDs:

device 0 osd.0
device 1 osd.1

type 0 osd
type 1 host

host squeezeceph1 {
        id -2           # do not change unnecessarily
        # weight 1.000
        alg straw
        hash 0  # rjenkins1
        item osd.0 weight 1.000
}
host squeezeceph2 {
        id -4           # do not change unnecessarily
        # weight 1.000
        alg straw
        hash 0  # rjenkins1
        item osd.1 weight 1.000
}

rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}

I'm using RGW which has a replication size of 2:

root@squeezeceph1:~/crushmaps# ceph osd dump | grep 'rep size'
=2E..
pool 3 '.rgw' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 8
pgp_num 8 last_change 9 owner 18446744073709551615
=2E..

All seems well when the cluster is healthy - any particular PG in my
RGW pool resolves to the two OSD IDs:

root@squeezeceph1:~/crushmaps# ceph osd map .rgw someobjectid
osdmap e52 pool '.rgw' (3) object 'someobjectid' -> pg 3.f31055a1
(3.1) -> up [0,1] acting [0,1]

Now I bring down osd.1, such that PGs are reported as degraded:

root@squeezeceph1:~/crushmaps# ceph health
HEALTH_WARN 632 pgs degraded; 604 pgs stuck unclean; recovery 100/200
degraded (50.000%); 1/2 in osds are down

Now the same PG is mapped as follows:

root@squeezeceph1:~/crushmaps# ceph osd map .rgw someobjectid
osdmap e54 pool '.rgw' (3) object 'someobjectid' -> pg 3.f31055a1
(3.1) -> up [0] acting [0]

This shows only osd.0 occupying the PG.  At this point osd.1 is down
but still 'in' (as reported by "ceph osd tree").  At this point writes
to the RGW succeed which is expected given the statement in the
documentation "If an OSD goes down, Ceph marks each placement group
assigned to the OSD as degraded ... a client can still write a new
object to a degraded placement group if it is active."  I could close
this gap as much as possible by reducing the "mon osd down out
interval" from 300 to 0.

After the 5 minutes have passed, osd.1 is out of the cluster (as
reported by "ceph osd dump").  The command "ceph osd map .rgw
someobjectid" from above returns the same result (the PG is mapped to
only 1 OSD which is fair enough).

At this point writes still succeed; for my use-case they'd ideally
fail.  Is osd.1 still considered 'active' at this point?

Many thanks!

Ben
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
