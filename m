From: Tommi Virtanen <tv@inktank.com>
Subject: Re: host settings in ceph.conf when ipaddress != hostname
Date: Thu, 16 Aug 2012 12:56:16 -0700
Message-ID: <CADvuQRFZRwL4oBvJW2H25VFME3pTk4rDZxr4WzwMT=sp-K8h6g@mail.gmail.com>
References: <CACkq2moqr-VpwLpG2xcTvUfJ4Xm0EKazis4pW_M4FLuATqOHVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42172 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab2HPT4i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 15:56:38 -0400
Received: by vbbff1 with SMTP id ff1so2696254vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 12:56:37 -0700 (PDT)
In-Reply-To: <CACkq2moqr-VpwLpG2xcTvUfJ4Xm0EKazis4pW_M4FLuATqOHVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 16, 2012 at 12:38 PM, Travis Rhoden <trhoden@gmail.com> wrote:
> I've seen a couple threads in the past about /etc/init.d/ceph not
> working right when the output of 'hostname' did not match the 'host'
> entry in ceph.conf.  I'm hoping you can advise me on how to get the
> following setup working.
>
> I have multiple nodes that both a GigE connection and a secondary
> high-speed connection (either 10GbE or IPoIB -- I've got both setups).
>  I want to use the high-speed connection for everything (both node
> replication, and client<-->node traffic), but the hostnames on the
> storage nodes are mapped to the GbE address.  You can think of the
> following being in /etc/hosts:
>
> 10.1.0.1   ceph0
> 10.30.0.1 ceph0-ib
>
>
> If I ssh to ceph0 and type "hostname", the output will be 'ceph0'. I
> think that part is pretty straightforward.  However, I have entries
> like this in ceph.conf:
>
> [mon.a]
>         host = ceph0-ib
>         mon addr = 10.30.0.1:6789
>
> [osd.0]
>         host = ceph0-ib
>
>
> Because these hostnames don't match, things like "ceph -a status"
> don't work as intended.  Although the cluster functions fine, and uses
> the high-speed network.  Is there a different way I should populate
> ceph.conf to get everything to work correct?

ceph.conf host= entries must match the output of "hostname" (strictly,
up to first dot of "hostname -f", which isn't exactly the same as
"hostname", but I'm too late to that fight); that's what the sysvinit
script assumes, and if it ain't right, it won't start your daemons.

It sounds like you want to set set public_network and cluster_network
in [global] both to 10.30.0.0/8.
