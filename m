From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: recovery test behavior in cbt
Date: Wed, 16 Mar 2016 20:43:01 +0000
Message-ID: <DM2PR12MB0556336D92A161F36851D6819B8A0@DM2PR12MB0556.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0078.outbound.protection.outlook.com ([65.55.169.78]:28224
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755686AbcCPUnF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 16:43:05 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "cbt@lists.ceph.com" <cbt@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I am experimenting with the recovery_test feature in CBT, with repeat set to True.
For those unfamiliar with CBT, this feature starts a background thread which for some set of osds
goes thru the following steps (when repeat is True),

   * ceph osd set noup
   * ceph osd down osd_set
   * ceph osd out  osd_set

Then waits up to 60 seconds to see if cluster goes unhealthy
and then wait as long as needed for the cluster to be healthy
(logging ceph health output to a file while waiting)

then
   * ceph osd unset noup
   * ceph osd up osd_set (or at least tries this but this doesn't exist at least in 9.2)
   * ceph osd in  osd_set 

again waits up to 60 seconds to see if cluster goes unhealthy
and then wait as long as needed for the cluster to be healthy
(logging ceph health output to a file while waiting)

and loop back to top (when Repeat is True)

I'm doing this:
   * on a small test cluster, only 2 nodes with 3 osds each, chooseleaf_type=0 (osd)
   * In my case, the "osd_set" to mark out and back in was a single osd, id 0.
   * While this is going on, I'm running a few librados-based scripts which are reading and writing on a single replicated=2 pool.

I've noticed that the first time thru the loop there is indeed a time required
to "heal" after the osd is marked down and out and then again another healing
time after the osd is marked back in.

But on the second and higher times thru the loop, there is no "healing" after the osd is marked down and out
i.e. no time when the status is unhealthy. If I do ceph osd df, I can see
that there is nothing on osd 0.

Then when the osd is marked back in there is a healing again and ceph osd df does show objects on osd 0 again.

This pattern continues on all succeeding loops.

Is this a normal behavior when the same osd is marked out and then in, over and over?

-- Tom

