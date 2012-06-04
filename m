From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 09:26:32 +0200
Message-ID: <4FCC6328.3020606@profihost.ag>
References: <4FCB1C0A.4050504@profihost.ag> <4FCB5EED.30909@inktank.com> <4FCC5431.6070002@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:36279 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab2FDH0f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 03:26:35 -0400
In-Reply-To: <4FCC5431.6070002@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 04.06.2012 08:22, schrieb Hannes Reinecke:
> Hehe.
> Good luck with that.
>
> We've tried on 10GigE with _disastrous_ results.
> Up to the point where 1GigE was actually _faster_.

So you mean you've tried 10GBE or 10GB ipoib with Infiniband?

> - osd-server is calling 'fsync' on each and every write request.
>    Does wonders for performance ...
Already talked to the ceph guys?

Stefan
