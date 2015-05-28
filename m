From: Wido den Hollander <wido@42on.com>
Subject: Re: preparing v0.80.11
Date: Thu, 28 May 2015 06:53:47 +0200
Message-ID: <55669F5B.8050309@42on.com>
References: <5562DEEC.5060602@dachary.org> <5564D772.9080909@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:33204 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbbE1Ext (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 May 2015 00:53:49 -0400
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

Would it be possible to backport this as well to 0.80.11:

http://tracker.ceph.com/issues/9792#change-46498

And I think this commit would be the easiest to backport:
https://github.com/ceph/ceph/commit/6b982e4cc00f9f201d7fbffa0282f8f3295f2309

This way we add a simple safeguard against pool removal into Firefly as
well.

Wido

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
