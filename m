From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/2] Add resource agents to debian build, trivial C&P
 error
Date: Thu, 5 Jan 2012 13:47:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201051346420.2101@cobra.newdream.net>
References: <1325799212-14675-1-git-send-email-florian@hastexo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34466 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932376Ab2AEVrW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2012 16:47:22 -0500
In-Reply-To: <1325799212-14675-1-git-send-email-florian@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org, gcs@debian.hu

Applied, thanks!

Lazslo, let me know if anything is amiss with the Debian bits.

Thanks!
sage



On Thu, 5 Jan 2012, Florian Haas wrote:

> Hi,
> 
> please consider two follow-up patches to the OCF resource agents: the
> first adds them to the Debian build, as a separate package
> "ceph-resource-agents" that depends on resource-agents, the second
> fixes a trivial (and embarassing, however harmless) cut and paste
> error. Thanks!
> 
> Cheers,
> Florian
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
