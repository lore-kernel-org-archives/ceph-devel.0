From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Latest bobtail branch still crashing KVM VMs in bh_write_commit()
Date: Wed, 20 Mar 2013 21:14:22 +0100
Message-ID: <514A189E.7070802@profihost.ag>
References: <CACkq2mrSvLyy9j3HMAEiCHnuktnB_EQbnQ-JvAZcyLcjmjn3uQ@mail.gmail.com> <514A13A8.7010002@profihost.ag> <CACkq2mppEb=N=dKGNWLx-pm2nZGp44D-SEYBoVhxMNDxUjE5sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:47916 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab3CTUOW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 16:14:22 -0400
In-Reply-To: <CACkq2mppEb=N=dKGNWLx-pm2nZGp44D-SEYBoVhxMNDxUjE5sw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: bcampbell@axcess-financial.com, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

> In this case, they are format 2. And they are from cloned snapshots.
> Exactly like the following:
>
> # rbd ls -l -p volumes
> NAME                                                         SIZE
> PARENT                                           FMT PROT LOCK
> volume-099a6d74-05bd-4f00-a12e-009d60629aa8                 5120M
> images/b8bdda90-664b-4906-86d6-dd33735441f2@snap   2
>
> I'm doing an OpenStack boot-from-volume setup.

OK i've never used cloned snapshots so maybe this is the reason.

>> strange i've never seen this. Which qemu version?
>
> # qemu-x86_64 -version
> qemu-x86_64 version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008 Fabrice Bellard
>
> that's coming from Ubuntu 12.04 apt repos.

maybe you should try qemu 1.4 there are a LOT of bugfixes. qemu-kvm does 
not exist anymore it was merged into qemu with 1.3 or 1.4.

Stefan
