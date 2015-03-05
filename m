From: Samuel Just <sjust@redhat.com>
Subject: OSD Sessions at CDS
Date: Thu, 05 Mar 2015 09:23:21 -0800
Message-ID: <1425576201.3944.26.camel@Deepthought>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50180 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756049AbbCERXX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 Mar 2015 12:23:23 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t25HNLAO029474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Thu, 5 Mar 2015 12:23:22 -0500
Received: from [10.3.235.43] (vpn-235-43.phx2.redhat.com [10.3.235.43])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t25HNLet004333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <ceph-devel@vger.kernel.org>; Thu, 5 Mar 2015 12:23:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


There were several OSD sessions at CDS on Wednesday, I'll try to
summarize some of the key points.

======================EC Pool Overwrite Support=======================
https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%
3A_erasure_coding_pool_overwrite_support

One take away from the discussion was that the no overwrite option for
RBD and cephfs may not be feasible since it's not clear that 4MB objects
make sense for an EC pool, and that with cephfs we need to be able to
handle the case where the file is in shared mode.  We'd probably,
therefore, want to use a 2pc approach, but we'd want much more feedback
on use cases before implementing it ourselves.

========================Scrub and Repair==============================

https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%
3A_Scrub_and_Repair

http://pad.ceph.com/p/I-osd-scrub

The discussion focused mainly on a more detailed description of the
scrub state kept by the OSD during peering.  See the etherpad for
details.

=======================Less Intrusive Scrub===========================

https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%
3A_Less_intrusive_scrub

http://pad.ceph.com/p/I-osd-less-intrusive-scrub

Some additional things we can do to reduce the scrub impact came up
and can be found in the above etherpad.

=================Faster Peering/Lower Tail Latency====================

https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%
3A_Faster_Peering

https://wiki.ceph.com/Planning/Blueprints/Infernalis/Improve_tail_latency

http://pad.ceph.com/p/I-faster-peering_tailing

In addition to what is in the blueprint, Sage suggested that the primary
in some cases can keep the peer_info and peer_missing sets which it
already has if the acting set stays the same or shrinks.

We also touched on prepopulating pg_temp at the monitor and setting a
different temp pg primary at the monitor in the map which marks an osd
back up to avoid that pg being primary immediately (and having to block
reads and writes on recovery).

In the ungraceful shutdown case, we could have a watchdog process
(systemd or something else) mark the specific osd instance which stopped
down (ceph osd down-instance <entity_inst_t>).

For EC pools, the consensus seemed to be that the best way to reduce
read latencies is to implement client side reads.

========================Tiering II (Warm->Cold)========================

https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%
3A_Tiering_II_(Warm-%3ECold)

https://wiki.ceph.com/Planning/Blueprints/Infernalis/Dynamic_data_relocation_for_cache_tiering

http://pad.ceph.com/p/I-tiering

Sage and I spent some time comparing the approach above to the approach
from the firefly CDS below.  It's still not clear whether we might want
to do the firefly variant (with the client able to send IO directly to
the cold tier) in addition to the one above (where the cold tier may not
even be a rados pool).

https://wiki.ceph.com/Planning/Blueprints/%3CSIDEBOARD%3E/osd%3A_tiering
%3A_object_redirects

From the discussion, it seemed like it might make sense to expand the
interface somewhat to allow the osd to proxy partial overwrites if the
backend supports it.

The consensus seemed to be that a rados level pin operation to force an
object to stay in the hot tier woudld be a good idea.

-Sam


