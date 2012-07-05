From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Osd placement rule questions
Date: Thu, 05 Jul 2012 15:45:22 +1200
Message-ID: <4FF50DD2.6030507@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:46854 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2GEDve (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 23:51:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 40BAE31FF5
	for <ceph-devel@vger.kernel.org>; Thu,  5 Jul 2012 15:45:23 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LuwAiAOVfUh3 for <ceph-devel@vger.kernel.org>;
	Thu,  5 Jul 2012 15:45:22 +1200 (NZST)
Received: from [IPv6:2404:130:0:1000:982:3f18:550f:4cb] (unknown [IPv6:2404:130:0:1000:982:3f18:550f:4cb])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id A67D631D04
	for <ceph-devel@vger.kernel.org>; Thu,  5 Jul 2012 15:45:22 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I am experimenting with ceph (rbd only for now), and have a few 
questions about what is possible via placement rules.

For example I am looking at a setup with a local datacenter 
(datacenter0) and a remote one (datacenter1). I'm using a placement rule:

rule rbd {
         ruleset 2
         type replicated
         min_size 1
         max_size 10
         step take datacenter0
         step chooseleaf firstn -1 type host
         step emit
         step take datacenter1
         step chooseleaf firstn 1 type host
         step emit
}

and I have the rdb pool set to size 3.

So I *think* I am saying I want 2 replicas in datacenter0 and one in 
datacenter1 [1].

The questions I have are:

1/ I would like to be able to have a way to say something like: Make 2 
copies at datacenter0, 1 at datacenter1 - wait for the ones at 
datacenter0 to be written but not the ones at datacenter1 (so 
asynchronous for the latter). Is this possible, or planned?

2/ Also I would like to be able to say make my number of copies 3, but 
if I lose datacenter0 (where 2 copies are), don't try to have 3 copies 
at datacenter1 (so run degraded in that case). Is that possible?

Cheers

Mark

[1] Might make more sense to have 2 copies at each, but I'm just trying 
to see how this placement business works at this point...


