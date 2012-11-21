From: Wido den Hollander <wido@widodh.nl>
Subject: Re: how to create snapshots
Date: Wed, 21 Nov 2012 22:29:10 +0800
Message-ID: <50ACE536.8040809@widodh.nl>
References: <50ACE037.5010806@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:54434 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab2KUO3R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 09:29:17 -0500
In-Reply-To: <50ACE037.5010806@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 11/21/2012 10:07 PM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> i tried to create a snapshot of my disk vm-113-disk-1:
>
> [: ~]# rbd -p kvmpool1 ls
> vm-113-disk-1
>
> [: ~]# rbd -p kvmpool1 snap create BACKUP vm-113-disk-1
> rbd: extraneous parameter vm-113-disk-1
>
> [: ~]# rbd -p kvmpool1 snap create vm-113-disk-1 BACKUP
> rbd: extraneous parameter BACKUP
>
> What's wrong here?

Use:

$ rbd -p kvmpool1 snap create --image vm-113-disk-1 BACKUP

"rbd -h" also tells:

<image-name>, <snap-name> are [pool/]name[@snap], or you may specify
individual pieces of names with -p/--pool, --image, and/or --snap.

Never tried it, but you might be able to use:

$ rbd -p kvmpool1 snap create vm-113-disk-1@BACKUP

I don't have access to a running Ceph cluster now to verify this.

Wido

>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
