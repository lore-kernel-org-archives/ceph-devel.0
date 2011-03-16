From: Ben De Luca <bdeluca@gmail.com>
Subject: crushmap problem
Date: Wed, 16 Mar 2011 22:08:17 +0000
Message-ID: <AANLkTimjPG41SSSFvCqEqVVqo9Z78=bnb8f51b3y7hd-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51851 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1CPWIS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2011 18:08:18 -0400
Received: by bwz15 with SMTP id 15so1968832bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2011 15:08:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi there, am setting up a new ceph cluster.
I wondered if there was a problem with the following crushmap, my
clients immediately lock up when I use this.
I have 4 nodes each with 2 disks and 2 osd's


# devices
device 0 device0
device 1 device1
device 2 device2
device 3 device3
device 4 device4
device 5 device5
device 6 device6
device 7 device7
# types
type 0 device
type 1 host
type 2 root
# buckets
host host0 {
id -1 # do not change unnecessarily
alg straw
hash 0 # rjenkins1
item device0 weight 1.000
item device1 weight 1.000
}
host host1 {
id -2 # do not change unnecessarily
alg straw
hash 0 # rjenkins1
item device2 weight 1.000
item device3 weight 1.000
}
host host2 {
id -3 # do not change unnecessarily
alg straw
hash 0 # rjenkins1
item device4 weight 1.000
item device5 weight 1.000
}
host host3 {
id -4 # do not change unnecessarily
alg straw
hash 0 # rjenkins1
item device6 weight 1.000
item device7 weight 1.000
}
root root {
id -5 # do not change unnecessarily
alg straw
hash 0 # rjenkins1
item host0 weight 2.000
item host1 weight 2.000
item host2 weight 2.000
item host3 weight 2.000
}
# rules
rule data {
ruleset 1
type replicated
min_size 2
max_size 2
step take root
step chooseleaf firstn 0 type host
step emit
}
# end crush map
