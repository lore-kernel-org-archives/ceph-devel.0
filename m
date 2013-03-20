From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Subject: waiting for 1 open ops to drain
Date: Wed, 20 Mar 2013 14:16:28 +0000
Message-ID: <5149C4BC.7060701@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from i01.ip.uk.com ([86.54.60.3]:44156 "EHLO i01.ip.uk.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839Ab3CTOXg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Mar 2013 10:23:36 -0400
Received: from [81.187.164.216] (helo=[10.0.1.34])
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>)
	id 1UIJob-0002NE-Jn
	for ceph-devel@vger.kernel.org; Wed, 20 Mar 2013 14:16:29 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am using ceph 0.58 and kernel 3.9-rc2 and btrfs on my osds.

I have an osd that starts up but blocks with the log message 'waiting
for 1 open ops to drain'.

This never happens, and I can't get the osd 'up'.

I need to clear this problem. I have recently had an osd go problematic
and I have recreated a fresh btrfs filesystem on the problem osd drive.
I have also added a completely new osd.

The 'waiting for 1 open ops to drain' problem has occurred before the
cluster has recovered from the earlier surgery and I need to get the
data from this osd.

I have increased the number of copies from 2 to 3 to give me more
resilience in the future, but that has not taken effect yet.

Once I get the cluster back to health, I will mkfs.btrfs and rebuild
this osd and one other that is a legacy from earlier kernel/ceph versions.

How can I tell the osd not to bother with waiting for its open ops to drain?

Thank you in anticipation.

David

