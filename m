From: Wido den Hollander <wido@widodh.nl>
Subject: Questions about CRUSH
Date: Thu, 07 Oct 2010 22:08:43 +0200
Message-ID: <1286482123.2633.17.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+eoS9VGHtpl43M7bYVNk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:56104 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0JGUIp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Oct 2010 16:08:45 -0400
Received: from [79.99.132.153] (unknown [79.99.132.153])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id 02E2141014
	for <ceph-devel@vger.kernel.org>; Thu,  7 Oct 2010 22:08:43 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-+eoS9VGHtpl43M7bYVNk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

I'm working on a crushmap where I have my hosts spread out over 3 racks
(leafs).

I have 9 physical machines, each with one OSD, spread out over three
racks.

The replication level I intend to use is 3, my goal with this crushmap
is to prevent two replicas being stored in the same rack.

Now, this map seems fine to me, but what if one of the racks fails and
the cluster starts to fix itself, then I would get two replicas in the
same rack, wouldn't I?

Is it better to have: leafs at root = (max replication level + 1) ?

So, if I have my replication level set to 3, I should have 4 racks with
each 3 OSD's, then the cluster could restore from a complete rack
failure, without compromising my data safety.

When a complete leaf (rack) fails, the other leafs should be able to
store all the data, so if my replication level is set to 3, I should
always have at least 1/3 of free space, otherwise a full recovery won't
be possible, correct? (OSD's run out of disk space).

Am I missing something here or is this the right approach?

And I'm not completely sure about:

rule placein3racks {
        ruleset 0
        type replicated
        min_size 2
        max_size 2
        step take root
        step chooseleaf firstn 0 type rack
        step emit
}

Is that correct? Here I say that the first step should be to choose a
rack where the replica should be saved. Should I also specify to choose
a host afterwards?

Thank you,

Wido

--=-+eoS9VGHtpl43M7bYVNk
Content-Disposition: attachment; filename="crushmap_3_racks.txt"
Content-Type: text/plain; name="crushmap_3_racks.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

device 0 device0
device 1 device1
device 2 device2
device 3 device3
device 4 device4
device 5 device5
device 6 device6
device 7 device7
device 8 device8

type 0 device
type 1 host
type 2 rack
type 3 root

# hosts
host host0 {
	id -1
	alg straw
	hash 0
	item device0 weight 1.000
}
host host1 {
	id -2
	alg straw
	hash 0
	item device1 weight 1.000
}
host host2 {
	id -3
	alg straw
	hash 0
	item device2 weight 1.000
}
host host3 {
	id -4
	alg straw
	hash 0
	item device3 weight 1.000
}
host host4 {
	id -5
	alg straw
	hash 0
	item device4 weight 1.000
}
host host5 {
	id -6
	alg straw
	hash 0
	item device5 weight 1.000
}
host host6 {
	id -7
	alg straw
	hash 0
	item device6 weight 1.000
}
host host7 {
	id -8
	alg straw
	hash 0
	item device7 weight 1.000
}
host host8 {
	id -8
	alg straw
	hash 0
	item device8 weight 1.000
}

rack rack0 {
        id -9
        alg straw
        hash 0
        item host0
        item host1
        item host2
}

rack rack1 {
        id -10
        alg straw
        hash 0
        item host3
        item host4
	item host5
}

rack rack2 {
        id -11
        alg straw
        hash 0
        item host6
        item host7
	item host8
}


root root {
	id -12
	alg straw
	hash 0
	item rack0
	item rack1
	item rack2
}

rule placein3racks {
	ruleset 0
	type replicated
	min_size 2
	max_size 2
	step take root
	step chooseleaf firstn 0 type rack
	step emit
}

--=-+eoS9VGHtpl43M7bYVNk--

