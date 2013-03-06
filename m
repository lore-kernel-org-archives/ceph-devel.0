From: Wido den Hollander <wido@42on.com>
Subject: Re: stuff for v0.56.4
Date: Wed, 06 Mar 2013 09:37:45 +0100
Message-ID: <51370059.4050403@42on.com>
References: <alpine.DEB.2.00.1303051503480.1162@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:45155 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452Ab3CFIhs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Mar 2013 03:37:48 -0500
In-Reply-To: <alpine.DEB.2.00.1303051503480.1162@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/06/2013 12:10 AM, Sage Weil wrote:
> There have been a few important bug fixes that people are hitting or
> want:
>
> - the journal replay bug (5d54ab154ca790688a6a1a2ad5f869c17a23980a)
> - the - _ pool name vs cap parsing thing that is biting openstack users
> - ceph-disk-* changes to support latest ceph-deploy
>
> If there are other things that we want to include in 0.56.4, lets get them
> into the bobtial branch sooner rather than later.
>
> Possible items:
>
> - pg log trimming (probably a conservative subset) to avoid memory bloat
> - omap scrub?
> - pg temp collection removal?
> - buffer::cmp fix from loic?
>
> Are there other items that we are missing?
>

I'm still seeing #3816 on my systems. The fix in wip-3816 did not 
resolve it for me.

Wido

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
