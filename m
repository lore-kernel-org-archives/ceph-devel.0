From: Wido den Hollander <wido@42on.com>
Subject: Re: preparing v0.80.11
Date: Wed, 03 Jun 2015 20:22:01 +0200
Message-ID: <556F45C9.7080003@42on.com>
References: <5562DEEC.5060602@dachary.org> <5564D772.9080909@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:49384 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728AbbFCSWE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Jun 2015 14:22:04 -0400
In-Reply-To: <5564D772.9080909@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 05/26/2015 10:28 PM, Nathan Cutler wrote:
> Hi Loic:
> 
> The first round of 0.80.11 backports, including all trivial backports
> (where "trivial" is defined as those I was able to do by myself without
> help), is now ready for integration testing in the "firefly-backports"
> branch of the SUSE fork:
> 
> https://github.com/SUSE/ceph/commits/firefly-backports
> 
> The non-trivial backports (on which I hereby solicit help) are:
> 
> http://tracker.ceph.com/issues/11699 Objecter: resend linger ops on split
> http://tracker.ceph.com/issues/11700 make the all osd/filestore thread
> pool suicide timeouts separately configurable
> http://tracker.ceph.com/issues/11704 erasure-code: misalignment
> http://tracker.ceph.com/issues/11720 rgw deleting S3 objects leaves
> __shadow_ objects behind
> 

Could I also ask for this one to be backported?

https://github.com/ceph/ceph/pull/4844

It breaks a couple of setups I know of. It's not in master yet, but it's
a very trivial fix.

> Nathan
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
