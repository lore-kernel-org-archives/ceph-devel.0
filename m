From: Mark Nigh <mnigh@netelligent.com>
Subject: Verification of Crush Rules
Date: Tue, 5 Jul 2011 09:34:37 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C678862E5E48@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.netelligent.com ([199.255.228.152]:32381 "EHLO
	NC-SVR-132.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752941Ab1GEOem convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Jul 2011 10:34:42 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have created a cluster with 2 nodes and 6 osds each.

I would like to verify if my pgs are being placed on the correct nodes based on my crushmap. I would like to make sure that my replication (x2, default) is not placed on the same host. Osd.0 through 5 is on host0 and osd.6 through osd.11 is on host1.

Here is my crushmap.

# begin crush map

# devices
device 0 device0
device 1 device1
device 2 device2
device 3 device3
device 4 device4
device 5 device5
device 6 device6
device 7 device7
device 8 device8
device 9 device9
device 10 device10
device 11 device11

# types
type 0 device
type 1 host
type 2 root

# buckets
host host0 {
        id -1           # do not change unnecessarily
        # weight 6.000
        alg straw
        hash 0  # rjenkins1
        item device0 weight 1.000
        item device1 weight 1.000
        item device2 weight 1.000
        item device3 weight 1.000
        item device4 weight 1.000
        item device5 weight 1.000
}
host host1 {
        id -2           # do not change unnecessarily
        # weight 6.000
        alg straw
        hash 0  # rjenkins1
        item device6 weight 1.000
        item device7 weight 1.000
        item device8 weight 1.000
        item device9 weight 1.000
        item device10 weight 1.000
        item device11 weight 1.000
}
root root {
        id -3           # do not change unnecessarily
        # weight 6.000
        alg straw
        hash 0  # rjenkins1
        item host0 weight 1.000
        item host1 weight 1.000
}

# rules
rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take root
        step chooseleaf firstn 0 type host
        step emit
}
rule metadata {
        ruleset 1
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type host
        step emit
}
rule rbd {
        ruleset 2
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type host
        step emit
}

# end crush map

The end of "ceph pg dump -o -" shows the following which doesn't look correct.

osdstat kbused  kbavail kb      hb in   hb out
0       0       0       0       []      []
1       393884  2927750484      2930265540      [0,2,3,4,5]     [0,2,3,4,5]
2       304580  2927838884      2930265540      [0,1,3,4,5]     [0,1,3,4,5]
3       0       0       0       []      []
4       0       0       0       []      []
5       158908  2927983588      2930265540      [0,1,2,3,4]     [0,1,2,3,4]
6       496     2892788952      2894914980      []      []
7       504     2928139544      2930265540      []      []
8       504     2928139544      2930265540      []      []
9       504     2928139544      2930265540      []      []
10      504     2928139544      2930265540      []      []
11      504     2928139544      2930265540      []      []
 sum    860388  26317059628     26337039300

Which brings me to a couple of questions.

1. what is "hb in" and "hb out"?
2. The original crush map examples shows "type device". The new versions of ceph show the first type as osds? I changed my back to device, but how do you define an osd or this automatically done for you. I mean by "define" is the section in the crush map that shows all the devices, device 0 device0.
3. In the new default crushmap, there is a domain bucket. What is that intended for? Host?

Thank you.


This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
