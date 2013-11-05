From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: writing a ceph cliente for MS windows
Date: Tue, 5 Nov 2013 13:59:17 -0800
Message-ID: <CABBk=J8gfR0CDQ4fuHmXtkH5Fe3kKOGTi7YgixB7ZSL1JHkYXg@mail.gmail.com>
References: <52780140.6090409@kepler.cl>
	<alpine.DEB.2.00.1311050608020.17874@cobra.newdream.net>
	<52792D7F.20500@kepler.cl>
	<527967FD.1010205@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:64893 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab3KEV7R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Nov 2013 16:59:17 -0500
Received: by mail-vc0-f177.google.com with SMTP id ib11so5954788vcb.22
        for <ceph-devel@vger.kernel.org>; Tue, 05 Nov 2013 13:59:17 -0800 (PST)
In-Reply-To: <527967FD.1010205@kepler.cl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alphe Salas Michels <asalas@kepler.cl>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 5, 2013 at 1:49 PM, Alphe Salas Michels <asalas@kepler.cl> wrote:
> Hello sage,
> I followed your lead and went a bit further in my source code reading and I
> notice serveral problems:
> first most of the id use in ceph osd_clients, mds_clients, mon_client use
> the data type u64 which will be a problem
> as most of the windows in use are windows XP or Windows server 2003 in 32
> bits. As they are used for id tag for
> things like snapshot pages (if I understand well) that can be a problem for
> a port no?
>
> What I read so far was
> mount.ceph files > kernel/fs/ceph files which contains the mds_client files
> and the kernel ioctl interface ... >  include / linux / ceph  files which
> integrates libcephfs.h. and all the needed files
>
> there is three clients, there is auth.h a messenger, a msgpool, buffer,
> rados that depends on msgr that include in every aspect of the messages
> formation  one or more __le64 message.
>
> I m far from understanding the whole code and the interactions betwin all
> the files and which we can skip and which we can keep.
>
> how can we translate those data type into 32bit in order for ceph cluster to
> understand them and ceph-windows-client to transmit them?


It is possible to define 64 bit variables on 32 bit architectures. The
compiler handles it for you.

Yehuda
