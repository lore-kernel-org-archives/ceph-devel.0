From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: cgroups to prevent OSD from taking down a whole machine
Date: Fri, 08 Feb 2013 08:52:24 -0600
Message-ID: <51151128.4060707@inktank.com>
References: <51150FCE.7050501@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:55730 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758687Ab3BHOwZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 09:52:25 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc18so3906049obb.22
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 06:52:24 -0800 (PST)
In-Reply-To: <51150FCE.7050501@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've been thinking about using this for machines where people want to 
run OSDS and VMs on the same nodes.  Keep Ceph and the VMs in separate 
cgroups to help keep them from interfering with each other.

It won't help with memory or QPI/hypertransport throughput (unless you 
have them segmented on different sockets), but it should help in some 
other cases.

Mark

On 02/08/2013 08:46 AM, Wido den Hollander wrote:
> Hi,
>
> Has anybody tried this yet?
>
> Running into the memory leaks during scrubbing[0] I started thinking
> about a way to limit OSDs to a specific amount of memory.
>
> A machine has 32GB of memory, 4 OSDs, so you might want to limit each
> OSD to 8GB so it can't take the whole machine down and would only kill
> itself.
>
> I think I'll give it a try on a couple of machines, but I just wanted to
> see if anybody has tried this already or sees any downsides to this?
>
> We use cgroups in the CloudStack project (through libvirt) to prevent
> that a memory leak in one KVM proces can take down a whole hypervisor,
> it works pretty well there.
>
> Suggestions or comments?
>
> Wido
>
> [0]: http://tracker.ceph.com/issues/3883
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

