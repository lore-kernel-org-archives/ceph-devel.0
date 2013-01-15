From: Gregory Farnum <greg@inktank.com>
Subject: Re: Grid data placement
Date: Tue, 15 Jan 2013 10:16:34 -0800
Message-ID: <CAPYLRzhZdP6ehio9MgOZ7VnPSnMa05NUPmaRG3D_+tmWhe+oYA@mail.gmail.com>
References: <50F59431.3000401@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:48908 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab3AOSQf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 13:16:35 -0500
Received: by mail-qa0-f42.google.com with SMTP id hg5so2618929qab.8
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 10:16:34 -0800 (PST)
In-Reply-To: <50F59431.3000401@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 15, 2013 at 9:38 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:
> Hi everyone,
>
> quick question: can I get ceph to replicate a bunch of files to every
> host in compute cluster and then have those hosts read those files from
> local disk?
>
> TFM looks like a custom crush map should get the files to [osd on] every
> host, but I'm not clear on the read step: do I need an mds on every host
> and mount the fs off localhost's mds?
>
> (We've $APP running on the cluster, normally one instance/cpu core, that
> mmap's (read only) ~30GB of binary files. I/O over NFS kills the cluster
> even with a few hosts. Currently the files are rsync'ed to every host at
> the start of the batch; that'll only scale to a few dozen hosts at best.)

There's a "read from replicas" operation flag that allows reading data
off the local node, although I don't think there's a way to turn it on
in the standard filesystem clients right now. It wouldn't be hard for
somebody to add. I'm not sure you actually need it though; Ceph unlike
NFS distributes the data over all the OSDs in the cluster so you could
scale the number of suppliers as you scale the number of consumers.
You would definitely not need to run an MDS on each node; just one
should be fine.

Rather more importantly however, Inktank still doesn't consider the
CephFS filesystem to be production-ready, so you will want to tread
with care in checking it out. :)
-Greg
