From: Fyodor Ustinov <ufm@ufm.su>
Subject: CRUSH
Date: Mon, 23 May 2011 19:20:03 +0300
Message-ID: <4DDA8933.4070504@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:57811 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756358Ab1EWQUH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 May 2011 12:20:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 8688B600485
	for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 19:20:04 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1IlTFazRkIf for <ceph-devel@vger.kernel.org>;
	Mon, 23 May 2011 19:20:04 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 5ECE1600484
	for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 19:20:04 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

Two questions.

1-st. As I understand it - any usable changes of CRUSH map on active 
cluster can't destruct data? In the worst case (for example, I managed 
to put two osd in one rack, and now I have two copies of the data in a 
single rack) I get information about the degradation and this will be 
fixed automatically?

2-nd. How to correct edit crush map in case "rack"?

Let's say I have such a map:

device 0 device0
device 1 device1
device 2 device2
device 3 device3
device 4 device4

# types
type 0 device
type 1 host
type 2 rack
type 3 root

# buckets
host host0 {
         id -1
         alg straw
         hash 0  # rjenkins1
         item device0 weight 1.000
}
...
host host4 {
         id -5
         alg straw
         hash 0  # rjenkins1
         item device4 weight 1.000
}
rack rack0 {
         id -6
         alg straw
         hash 0  # rjenkins1
         item host0 weight 1.000
}
...
rack rack4 {
         id -10          # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item host4 weight 1.000
}
root root {
         id -11          # do not change unnecessarily
         alg straw
         hash 0  # rjenkins1
         item rack0 weight 1.000
         item rack1 weight 1.000
         item rack2 weight 1.000
         item rack3 weight 1.000
         item rack4 weight 1.000
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

And now i want add one "rack" and add one "osd" to this rack. How should 
I deal with "id"?

WBR,
     Fyodor.
