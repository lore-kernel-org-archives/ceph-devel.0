From: John Spray <john.spray@redhat.com>
Subject: Re: [ceph-calamari] disk failure prediction
Date: Thu, 19 Feb 2015 08:56:25 +0000
Message-ID: <54E5A539.1060803@redhat.com>
References: <alpine.DEB.2.00.1502181514400.24259@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55176 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961AbbBSI42 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Feb 2015 03:56:28 -0500
In-Reply-To: <alpine.DEB.2.00.1502181514400.24259@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org, ceph-calamari@ceph.com


On 18/02/2015 23:20, Sage Weil wrote:
> We wouldn't see
> quite the same results since our "raid sets" are effectively entire pools
I think we could do better than pool-wide, e.g. if multiple drives in 
one chassis are at risk (where PG stores at most one copy per chassis), 
we can identify that as less severe than the general case where multiple 
at-risk drives might be in the same PG.  Making it CRUSH-aware like this 
would be a good hook for users to take advantage of the ceph/calamari 
SMART monitoring rather than rolling their own.

John

