From: Fyodor Ustinov <ufm@ufm.su>
Subject: CRUSH. What wrong?
Date: Sun, 29 May 2011 16:21:38 +0300
Message-ID: <4DE24862.5080109@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:34770 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab1E2NVm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 29 May 2011 09:21:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 117F9600485
	for <ceph-devel@vger.kernel.org>; Sun, 29 May 2011 16:21:40 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8XM3IUUfIbaW for <ceph-devel@vger.kernel.org>;
	Sun, 29 May 2011 16:21:39 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id CF09F600484
	for <ceph-devel@vger.kernel.org>; Sun, 29 May 2011 16:21:39 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

Now, I made an attempt to create my own CRUSH.

After I applied it to existing cluster everything stopped (rebalance not 
start, unable to mount cluster)

"Ok", I said and created new cluster with this crush.

Cluster turned out as the real thing. But id did not work (initial 
scrubbing not start, unable to mount).

What I did wrong?

My crush map:

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

# types
type 0 device
type 1 host
type 2 rack
type 3 root

# buckets
host host0 {
         id -1           # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item device0 weight 3.842
}
host host1 {
         id -2           # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item device1 weight 3.842
}
host host2 {
         id -3           # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item device2 weight 3.842
}
host host3 {
         id -4           # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item device3 weight 3.842
}
host host4 {
         id -5           # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item device4 weight 3.842
}
host host5 {
         id -6           # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item device5 weight 3.842
}
host host6 {
         id -7           # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
}
host host7 {
         id -8           # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item device7 weight 3.842
         item device8 weight 3.905
         item device9 weight 3.905
         item device10 weight 3.905
}
rack rack0 {
         id -9           # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item host0 weight 3.844
}
rack rack1 {
         id -10          # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item host1 weight 3.844
}
rack rack2 {
         id -11          # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item host2 weight 3.842
}
rack rack3 {
         id -12          # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item host3 weight 3.842
}
rack rack4 {
         id -13          # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item host4 weight 3.842
}
rack rack5 {
         id -14          # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item host5 weight 3.842
}
rack rack6 {
         id -15          # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item host6 weight 3.842
}
rack rack7 {
         id -16          # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item host7 weight 15.557
}
root root {
         id -17          # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item rack0 weight 3.844
         item rack1 weight 3.844
         item rack2 weight 3.842
         item rack3 weight 3.842
         item rack4 weight 3.842
         item rack5 weight 3.842
         item rack6 weight 3.842
         item rack7 weight 15.557
}

# rules
rule data {
         ruleset 0
         type replicated
         min_size 1
         max_size 10
         step take root
         step choose firstn 0 type rack
         step emit
}
rule metadata {
         ruleset 1
         type replicated
         min_size 1
         max_size 10
         step take root
         step choose firstn 0 type rack
         step emit
}
rule rbd {
         ruleset 2
         type replicated
         min_size 1
         max_size 10
         step take root
         step choose firstn 0 type rack
         step emit
}

# end crush map

WBR,
     Fyodor.
