From: Tom Deneau <tom.deneau@amd.com>
Subject: Re: journal writes when running rados bench seq on ec pool
Date: Wed, 10 Jun 2015 18:47:47 +0000 (UTC)
Message-ID: <loom.20150610T204623-690@post.gmane.org>
References: <BC97738F8E7C8742BABED7F06FB9DF9166442D87@SATLEXDAG01.amd.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8BFBD@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47740 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbbFJSr6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Jun 2015 14:47:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Z2l2a-0004CF-5W
	for ceph-devel@vger.kernel.org; Wed, 10 Jun 2015 20:47:57 +0200
Received: from 165.204.77.1 ([165.204.77.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2015 20:47:56 +0200
Received: from tom.deneau by 165.204.77.1 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2015 20:47:56 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Somnath Roy <Somnath.Roy <at> sandisk.com> writes:

> 
> Tom,
> Good that you brought this up !
> I was also seeing the small writes during reads but forgot to mention in
my last report on EC.
> Basically, Ceph code base seems to be issuing small writes during reads
and it is basically going to both
> data/jounal (considering filestore backend) ..But, since data partition is
syncing on every 5 sec , it is
> not obvious there.
> 
> Loic,
> Could you please explain a bit more on this ? What exactly we are writing
during reads ?
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: ceph-devel-owner <at> vger.kernel.org [mailto:ceph-devel-owner <at>
vger.kernel.org] On Behalf Of
> Deneau, Tom
> Sent: Wednesday, May 13, 2015 4:40 PM
> To: ceph-devel
> Subject: journal writes when running rados bench seq on ec pool
> 
> I am running a rados bench seq read benchmark on an erasure-coded pool
(k=2, m=1),
> and recording the disk activity.   I notice that I always see a small
number of writes
> to the journal partitions during the seq read run.  (I always drop the
caches on the osd nodes before starting
> the seq read run).
> 
> I never see this journal write behavior with a replicated pool and I
didn't think there would be any journal
> writes with either kind of pool on a read benchmark.
> 
> The write activity is low enough that it's probably not that important
performance-wise but I as just
> curious as to what would cause this.
> 

Was anyone able to explain these journal/data writes that occur during EC
pool reads?




