From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to integrate ceph with opendedup.
Date: Tue, 31 Jul 2012 11:22:12 +0200
Message-ID: <5017A3C4.5060406@widodh.nl>
References: <loom.20120731T111530-776@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:50202 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999Ab2GaJWO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 05:22:14 -0400
In-Reply-To: <loom.20120731T111530-776@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org



On 07/31/2012 11:18 AM, ramu wrote:
> Hi all,
>
> I want to integrate ceph with opendedup(sdfs) using java-rados.
> Please help me to integration of ceph with opendedup.

What is the exact use-case for this? I get the point of de-duplication, 
but having a filesystem running on top of RADOS and not using CephFS?

That doesn't seem like a trivial integration.

Wido

>
> Thanks,
> Ramu.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
