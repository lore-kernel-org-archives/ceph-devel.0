From: John Spray <john.spray@redhat.com>
Subject: ceph-fuse remount issues
Date: Thu, 19 Feb 2015 22:23:21 +0000
Message-ID: <54E66259.9040501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57954 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343AbbBSWXX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Feb 2015 17:23:23 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1JMNNxj021906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Thu, 19 Feb 2015 17:23:23 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, zyan@redhat.com, Gregory Farnum <gfarnum@redhat.com>


Background: a while ago, we found (#10277) that existing cache 
expiration mechanism wasn't working with latest kernels.  We used to 
invalidate the top level dentries, which caused fuse to invalidate 
everything, but an implementation detail in fuse caused it to start 
ignoring our repeated invalidate calls, so this doesn't work any more.  
To persuade fuse to dirty its entire metadata cache, Zheng added in a 
system() call to "mount -o remount" after we expire things from our 
client side cache.

However, this was a bit of a hack and has created problems:
  * You can't call mount -o remount unless you're root, so we are less 
flexible than we used to be (#10542)
  * While the remount is happening, unmounts sporadically fail and the 
fuse process can become unresponsive to SIGKILL (#10916)

The first issue was maybe an acceptable compromise, but the second issue 
is just painful, and it seems like we might not have seen the last of 
the knock on effects -- upstream maintainers certainly aren't expecting 
filesystems to remount themselves quite so frequently.

We probably have an opportunity to get something upstream in fuse to 
support a direct call to trigger the invalidation we want, if we can 
work out what that should look like.  Thoughts?

John
