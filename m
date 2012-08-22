From: Jonathan Proulx <jon@csail.mit.edu>
Subject: Ideal hardware spec?
Date: Wed, 22 Aug 2012 09:55:30 -0400
Message-ID: <20120822135530.GB10015@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from outgoing.csail.mit.edu ([128.30.2.149]:37022 "EHLO
	outgoing.csail.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab2HVNzc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 09:55:32 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

Yes I'm asking the impossible question, what is the "best" hardware
confing.

I'm looking at (possibly) using ceph as backing store for images and
volumes on OpenStack as well as exposing at least the object store for
direct use.  

The openstack cluster exists and is currently in the early stages of
use by researchers here, approx 1500 vCPU (counts hyperthreads
actually 768 physical cores) and 3T or RAM across 64 physical nodes.

On the object store side it would be a new resource for usand hard to
say what people would do with it except that it would be many
different things and the use profile would be constantly changing
(which is true of all our existing storage).

In this sense, even though it's a "private cloud" the somewhat
unpredictable useage profile gives it some charateristics of a small
public cloud.

Size wise I'm hoping to start out with 3 monitors  and  5(+) OSD nodes
to end up with a 20-30T 3x replicated storage (call me paranoid).

So the monitor specs seem relatively easy to come up with.  For the
OSDs it looks like
http://ceph.com/docs/master/install/hardware-recommendations suggests
1 drive, 1 core and  2G RAM per OSD (with multiple OSDs per storage
node).  On list discussions seem to frequently include an SSD for
journaling (which is similar to what we do for our current ZFS back
NFS storage).

I'm hoping to wrap the hardware in a grant and willing to experiment a
bit with different software configurations to tune it up when/if I get
the hardware in.  So my imediate concern is a hardware spec that will
ahve a reasonable processor:memory:disk ratio and opinions (or better
data) on the utility of SSD.

First is the documented core to disk ratio still current best
practice?  Given a platform with more drive slots could 8 cores handle
more disk? would that need/like more memory?

Have SSD been shown to speed performance with this architecture?

If so given the 8 drive slot example with seven OSDs presented in the
docs what is the liklihood that using a high performance SSD for the
OS image and also cutting journal/log partitions out of it for the
remaining 7 2-3T near line SAS drives?

Thanks,
-Jon
