From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH 0/2] Distribute re-replicated objects evenly after
 OSD failure
Date: Thu, 10 May 2012 16:38:24 -0600
Message-ID: <1336689506-15029-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:33031 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761692Ab2EJWiv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 18:38:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: sam.just@dreamhost.com, ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

Hi Sage,

I've been trying to solve the issue mentioned in tracker #2047, which I 
think is the same as I described in
  http://www.spinics.net/lists/ceph-devel/msg05824.html

The attached patches seem to fix it for me.  I also attempted to 
address the local search issue you mentioned in #2047.

I'm testing this using a cluster with 3 rows, 2 racks/row, 2 hosts/rack,
4 osds/host. I tested against a CRUSH map with the rules:
	step take root
	step chooseleaf firstn 0 type rack
	step emit

I'm in the processes of testing this as follows:

I wrote some data to the cluster, then started shutting down OSDs using
"init-ceph stop osd.n". For the first rack's worth, I shut OSDs down
sequentially.  I waited for recovery to complete each time before
stopping the next OSD.  For the next rack I shut down the first 3 OSDs
on a host at the same time, waited for recovery to complete, then shut
down the last OSD on that host.  For the next racks, I shut down all
the OSDs on the hosts in the rack at the same time.

Right now I'm waiting for recovery to complete after shutting down
the third rack.  Once recovery completed after each phase so far,
there were no degraded objects.

So, this is looking fairly solid to me so far.  What do you think?

Thanks -- Jim

Jim Schutt (2):
  ceph: retry CRUSH map descent before retrying bucket
  ceph: retry CRUSH map descent from root if leaf is failed

 src/crush/mapper.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

-- 
1.7.8.2


