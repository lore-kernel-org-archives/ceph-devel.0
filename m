From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Where to run ceph for openstack
Date: Fri, 10 Aug 2012 10:17:17 +0200
Message-ID: <5024C38D.4050607@widodh.nl>
References: <CAJ_JamA4XjMN816Gbk79FPApLXywwAzA0utWUtu+icpB2Cx97g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:43699 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757569Ab2HJIRY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Aug 2012 04:17:24 -0400
In-Reply-To: <CAJ_JamA4XjMN816Gbk79FPApLXywwAzA0utWUtu+icpB2Cx97g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Curtis C." <serverascode@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 08/10/2012 03:33 AM, Curtis C. wrote:
> Hi All,
>
> My workplace is considering deploying Ceph for OpenStack block storage
> to try to provide volume and vm migration.
>

Disclaimer: I have never worked with OpenStack, only with CloudStack.

> Immediately I decided, perhaps wrongly, that this meant a dedicated
> Ceph cluster of physical servers. But a colleague suggested that
> perhaps it would be better to run Ceph on the compute nodes instead of
> a distinct, separate cluster.
>

I think it's common to run Ceph on dedicated hardware, but it is not 
mandatory.

There is however a situation where running Kernel-RBD or the Ceph 
filesystem on an OSD leads into a lock situation (still valid?), but 
with Qemu RBD this shouldn't be a problem.

> Is one of these a more appropriate solution (in a perfect world)? Or
> is this a half-dozen one way, six the other type situation?
>
> I can definitely understand trying to make compute and storage generic
> and plentiful by keeping them on the same node. But I also feel like
> it's ok to split things out sometimes too.
>

You should be able to run the OSD daemons on compute nodes, but you will 
need a cluster of monitors (3 recommended), I'd not run those on the 
compute nodes.

Be aware however that OSDs can eat a lot of memory and CPU. They 
sometimes eat so much memory that they can press a machine out of 
memory. Won't be nice if it took a couple of your instances with it.

So, technically you can run the OSDs on Compute nodes, but in terms of 
stability I wouldn't recommend it.

Wido

> Any thoughts, suggestions, or reference architecture pointers?
>
> Thanks for any help,
> Curtis.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

