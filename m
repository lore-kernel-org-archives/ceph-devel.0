From: Niklas Goerke <niklas@niklasgoerke.de>
Subject: PG distribution scattered
Date: Thu, 10 Oct 2013 11:22:40 +0200
Message-ID: <4120b8bc5ae688af65d616f5a487e9bd@niklasgoerke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from niklasgoerke.de ([46.38.232.61]:39497 "EHLO niklasgoerke.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598Ab3JJJ3x (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Oct 2013 05:29:53 -0400
Received: from mail.niklasgoerke.de (localhost.localdomain [127.0.0.1])
	by niklasgoerke.de (Postfix) with ESMTP id 7EA2A28DE021
	for <ceph-devel@vger.kernel.org>; Thu, 10 Oct 2013 09:22:40 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi there

I'm currently evaluating ceph and started filling my cluster for the 
first time. After filling it up to about 75%, it reported some OSDs 
being "near-full".
After some evaluation I found that the PGs are not distributed evenly 
over all the osds.

My Setup:
* Two Hosts with 45 Disks each --> 90 OSDs
* Only one newly created pool with 4500 PGs and a Replica Size of 2 --> 
should be about 100 PGs per OSD

What I found was that one OSD only had 72 PGs, while another had 123 
PGs [1]. That means that - if I did the math correctly - I can only fill 
the cluster to about 81%, because thats when the first OSD is completely 
full[2].

I did some experimenting and found, that if I add another pool with 
4500 PGs, each OSD will have exacly doubled the amount of PGs as with 
one pool. So this is not an accident (tried it multiple times). On 
another test-cluster with 4 Hosts and 15 Disks each, the Distribution 
was similarly worse. I also tried that on a different cluster and got 
very similar results.

To me it looks like the rjenkins algorithm is not working as it - in my 
opinion - should be.

Am I doing anything wrong?
Is this behaviour to be expected?
Can I do something about it?

Thank you very much in advance
Niklas

P.S.: I did ask on ceph-users before:
http://comments.gmane.org/gmane.comp.file-systems.ceph.user/4317
http://comments.gmane.org/gmane.comp.file-systems.ceph.user/4496

[1] I built a small script that will parse pgdump and output the amount 
of pgs on each osd: http://pastebin.com/5ZVqhy5M
[2] I know I should not fill my cluster completely but I'm talking 
about theory and adding a margin only makes it worse.
