From: Rutger ter Borg <rutger@terborg.net>
Subject: Re: Multiple concurrent async ops per IoCtx?
Date: Thu, 30 Aug 2012 14:16:53 +0200
Message-ID: <k1nljm$2ks$1@ger.gmane.org>
References: <k1ksi5$q2p$1@ger.gmane.org> <503E2A18.5000603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36451 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897Ab2H3MRF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Aug 2012 08:17:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T73gH-00015T-N4
	for ceph-devel@vger.kernel.org; Thu, 30 Aug 2012 14:17:05 +0200
Received: from 82-169-160-32.ip.telfort.nl ([82.169.160.32])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 14:17:05 +0200
Received: from rutger by 82-169-160-32.ip.telfort.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 14:17:05 +0200
In-Reply-To: <503E2A18.5000603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2012-08-29 16:41, Josh Durgin wrote:

> Yes, all the asynchronous functions can run in parallel. An IoCtx
> has little bearing on performance - it mostly just saves you from
> specifying the full set of parameters (i.e. pool, snapshot id, snapshot
> context, etc.) for each operation.
>
> Are you seeing behavior that looks like the aio operations aren't being
> run in parallel?
>
> Josh

Thanks, that's all I wanted to check at this point!

Cheers,

Rutger





