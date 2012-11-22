From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: how to create snapshots
Date: Thu, 22 Nov 2012 11:42:44 +0100
Message-ID: <50AE01A4.8000505@profihost.ag>
References: <50ACE037.5010806@profihost.ag> <50ACE536.8040809@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45395 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755982Ab2KVTmy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:42:54 -0500
In-Reply-To: <50ACE536.8040809@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Am 21.11.2012 15:29, schrieb Wido den Hollander:
> Use:
>
> $ rbd -p kvmpool1 snap create --image vm-113-disk-1 BACKUP
>
> "rbd -h" also tells:
>
> <image-name>, <snap-name> are [pool/]name[@snap], or you may specify
> individual pieces of names with -p/--pool, --image, and/or --snap.
>
> Never tried it, but you might be able to use:
>
> $ rbd -p kvmpool1 snap create vm-113-disk-1@BACKUP

This does not work but:
rbd snap create kvmpool1/vm-113-disk-1@BACKUP

works fine. Thanks!

Stefan
