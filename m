From: Wido den Hollander <wido@42on.com>
Subject: Re: final mon issues
Date: Fri, 26 Apr 2013 21:53:24 +0200
Message-ID: <517ADB34.1020105@42on.com>
References: <alpine.DEB.2.00.1304261240460.13630@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:35791 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756097Ab3DZTx0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 26 Apr 2013 15:53:26 -0400
In-Reply-To: <alpine.DEB.2.00.1304261240460.13630@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: greg@inktank.com, ceph-devel@vger.kernel.org, mike.dawson@scholarstack.com

On 04/26/2013 09:43 PM, Sage Weil wrote:
> I've merged the double-forward fix.  I still have one remaining problem
> that I can reproduce with my tests which looks like an overlap of mon
> overload forwarded message priorities; I'm testing two possible fixes to
> see which are necessary to resolve it.
>
> The memory issues with people using the gitbuilder appear to be because
> our gitbuilders weren't linking in tcmalloc.  The latest 'next' build
> *does* link it now, so if you are one of those people, please re-test!
>
> I don't think either of those problems is related to the sync issues Mike
> is seeing, though.  I believe that is the final outstanding issue...?
>

I think I also just noticed a sync issue, reported it as: 
http://tracker.ceph.com/issues/4837

This e-mail and my report just crossed each other I think.

> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
