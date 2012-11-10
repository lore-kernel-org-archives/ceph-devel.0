From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Limited IOP/s on Dual Xeon KVM Host
Date: Sat, 10 Nov 2012 07:41:13 -0600
Message-ID: <509E5979.3070508@inktank.com>
References: <509E0A65.1040903@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:44551 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab2KJNlQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Nov 2012 08:41:16 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so3389376iag.19
        for <ceph-devel@vger.kernel.org>; Sat, 10 Nov 2012 05:41:15 -0800 (PST)
In-Reply-To: <509E0A65.1040903@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "pve-devel@pve.proxmox.com" <pve-devel@pve.proxmox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/10/2012 02:03 AM, Stefan Priebe wrote:
> Hello lists,
>
> on a dual Xeon KVM Host i get max 6000 IOP/s random 4k writes AND reads.
> On a Single Xeon KVM Host i get 17.000-18.000 IOP/s write and read. I
> already tried to pin the kvm process using numactl and also the fio
> process but it doesn't help on the dual xeon.
>
> 10GBE Network is fine. I get 9.8Gbit/s on both hosts. Kernel is also he
> same on both.
>
> Anybody an idea?

When you say KVM host, do you mean the underlying node or the virtual 
machine instance?

If you mean underlying node, it could be remote memory access or if you 
are on a last gen xeon if you have dual io hubs, you could be hitting a 
remote io hub for the network card.  I wouldn't think that would cause 
such a big hit, but those are things to look into.

If you mean that a single Xeon VM instance on a dual Xeon node is faster 
than a dual Xeon VM instance, I'm not really sure what to tell you since 
you've already tried pinning the processes.

>
> Greets
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

