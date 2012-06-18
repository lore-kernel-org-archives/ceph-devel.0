From: Wido den Hollander <wido@widodh.nl>
Subject: Re: extent rbd ls to show size and free space?
Date: Mon, 18 Jun 2012 14:47:26 +0200
Message-ID: <4FDF235E.8030301@widodh.nl>
References: <4FDF1A31.6010606@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:57661 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2FRMr2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 08:47:28 -0400
In-Reply-To: <4FDF1A31.6010606@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

 > Hello list,
 >
 > are there any plans to extent rbd ls in a way that it shows, image size
 > and free space of the pool?
 >

You want something like:

$ rbd ls
NAME		SIZE
alpha		50G
beta		400G
charlie		150G

That is possible, but if you want to see the allocation of an image that 
will be harder, since RBD doesn't know which objects have been written 
to and which haven't.

There is also no such thing as "free pool space", you have to look at 
the free cluster space.

But again, if you cluster has X TB of free space and you have multiple 
pools, your usage will depend on the amount of written data and the 
replication level.

If you want to know the usage of the rbd pool I suggest using "rados df".

The RBD tool could however be modified to show the image size if you 
give another flag.

$ rbd --extended ls

Wido

On 06/18/2012 02:08 PM, Stefan Priebe - Profihost AG wrote:
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

