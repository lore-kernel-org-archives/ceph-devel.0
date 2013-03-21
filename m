From: "Jacky.He" <jacky.he@gmail.com>
Subject: RE: Latest bobtail branch still crashing KVM VMs in bh_write_commit()
Date: Thu, 21 Mar 2013 08:58:52 +0800
Message-ID: <514a5b4b.e5b6440a.5925.24ac@mx.google.com>
References: <CACkq2mrSvLyy9j3HMAEiCHnuktnB_EQbnQ-JvAZcyLcjmjn3uQ@mail.gmail.com> <514A13A8.7010002@profihost.ag> <CACkq2mppEb=N=dKGNWLx-pm2nZGp44D-SEYBoVhxMNDxUjE5sw@mail.gmail.com> <514A189E.7070802@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:50900 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3CUBES (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 21:04:18 -0400
Received: by mail-pb0-f41.google.com with SMTP id um15so1802923pbc.14
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 18:04:17 -0700 (PDT)
In-Reply-To: <514A189E.7070802@profihost.ag>
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Stefan Priebe' <s.priebe@profihost.ag>, 'Travis Rhoden' <trhoden@gmail.com>
Cc: bcampbell@axcess-financial.com, 'ceph-devel' <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Stefan Priebe
> Sent: Thursday, March 21, 2013 4:14 AM
> To: Travis Rhoden
> Cc: bcampbell@axcess-financial.com; ceph-devel
> Subject: Re: Latest bobtail branch still crashing KVM VMs in
bh_write_commit()
> 
> Hi,
> 
> > In this case, they are format 2. And they are from cloned snapshots.
> > Exactly like the following:
> >
> > # rbd ls -l -p volumes
> > NAME                                                         SIZE
> > PARENT                                           FMT PROT LOCK
> > volume-099a6d74-05bd-4f00-a12e-009d60629aa8                 5120M
> > images/b8bdda90-664b-4906-86d6-dd33735441f2@snap   2
> >
> > I'm doing an OpenStack boot-from-volume setup.
> 
> OK i've never used cloned snapshots so maybe this is the reason.
> 
> >> strange i've never seen this. Which qemu version?
> >
> > # qemu-x86_64 -version
> > qemu-x86_64 version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008
> > Fabrice Bellard
> >
> > that's coming from Ubuntu 12.04 apt repos.
> 
> maybe you should try qemu 1.4 there are a LOT of bugfixes. qemu-kvm does
not
> exist anymore it was merged into qemu with 1.3 or 1.4.
> 
[jacky_he] I also encountered the same issue, ceph version is 0.56.3.
I have tried Qemu 1.3.1 and Qemu 1.4.0, KVM VM with format 2 cloned image
crashs.
My host OS is ubuntu 12.04, guest OS are CentOS 6.3 and Windows XP/Windows 7

> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of
> a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 
> 
> __________ Information from ESET NOD32 Antivirus, version of virus
signature
> database 8141 (20130320) __________
> 
> The message was checked by ESET NOD32 Antivirus.
> 
> http://www.eset.com
> 

