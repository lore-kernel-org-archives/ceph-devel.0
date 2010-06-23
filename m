From: "Jim Schutt" <jaschut@sandia.gov>
Subject: crushmap rule issue: choose vs. chooseleaf
Date: Wed, 23 Jun 2010 13:20:01 -0600
Message-ID: <1277320801.29400.26.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:40332 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab0FWTUS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jun 2010 15:20:18 -0400
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1749050FFA5
	for <ceph-devel@vger.kernel.org>; Wed, 23 Jun 2010 13:20:15 -0600 (MDT)
Received: from mail.sandia.gov (cas1.sandia.gov [134.253.165.159]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o5NJK0qJ000411 for
 <ceph-devel@vger.kernel.org>; Wed, 23 Jun 2010 13:20:00 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I've been trying to get custom CRUSH maps to work, based on
http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH

I've not had any success until I dumped the map from
a simple 4 device setup.  I noticed that map had a
rule using:
  step choose firstn 0 type device

whereas all the custom maps I was trying to build used
chooseleaf rather than choose.  So I modified those
default 4 device map rules to be:
  step chooseleaf firstn 0 type device

and built a new file system using that map.
It would not start.

I.e., a file system built using this CRUSH map works
for me:

# begin crush map

# devices
device 0 device0
device 1 device1
device 2 device2
device 3 device3

# types
type 0 device
type 1 domain
type 2 pool

# buckets
domain root {
        id -1           # do not change unnecessarily
        alg straw
        hash 0  # rjenkins1
        item device0 weight 1.000
        item device1 weight 1.000
        item device2 weight 1.000
        item device3 weight 1.000
}

# rules
rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type device
        step emit
}
rule metadata {
        ruleset 1
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type device
        step emit
}
rule casdata {
        ruleset 2
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type device
        step emit
}
rule rbd {
        ruleset 3
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type device
        step emit
}

# end crush map

but a file system built using this CRUSH map this one 
does not:

# begin crush map

# devices
device 0 device0
device 1 device1
device 2 device2
device 3 device3

# types
type 0 device
type 1 domain
type 2 pool

# buckets
domain root {
        id -1           # do not change unnecessarily
        alg straw
        hash 0  # rjenkins1
        item device0 weight 1.000
        item device1 weight 1.000
        item device2 weight 1.000
        item device3 weight 1.000
}

# rules
rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take root
        step chooseleaf firstn 0 type device
        step emit
}
rule metadata {
        ruleset 1
        type replicated
        min_size 1
        max_size 10
        step take root
        step chooseleaf firstn 0 type device
        step emit
}
rule casdata {
        ruleset 2
        type replicated
        min_size 1
        max_size 10
        step take root
        step chooseleaf firstn 0 type device
        step emit
}
rule rbd {
        ruleset 3
        type replicated
        min_size 1
        max_size 10
        step take root
        step chooseleaf firstn 0 type device
        step emit
}

# end crush map


Based on that, I reworked some of test maps with deeper device
hierarchies I had been trying, and got them to work
(i.e. the file system started) when I avoided chooseleaf rules.

E.g. with a device hierarchy like this
(a device here is a partition, as I am still
testing on limited hardware):

type 0 device
type 1 disk
type 2 controller
type 3 host
type 4 root

a map with rules like this worked:

rule data {
        ruleset 0
        type replicated
        min_size 2
        max_size 2
        step take root
        step choose firstn 0 type host
        step choose firstn 0 type controller
        step choose firstn 0 type disk
        step choose firstn 0 type device
        step emit
}

but a map with rules like this didn't:

rule data {
        ruleset 0
        type replicated
        min_size 2
        max_size 2
        step take root
        step chooseleaf firstn 0 type controller
        step emit
}


Am I missing something?

Thanks -- Jim


