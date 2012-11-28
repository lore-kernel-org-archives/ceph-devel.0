From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: Multiple CEPH roles on single platform
Date: Wed, 28 Nov 2012 22:22:32 +0100
Message-ID: <CAN04cT5+18s-2SfrinJvMT0kTJCU7RviLCAPV34MUTBmyPF=fw@mail.gmail.com>
References: <DC700C5A3AE74041B17F41EE35500AB90C8ABDE8@SACEXCMBX03-PRD.hq.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45671 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab2K1VWd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Nov 2012 16:22:33 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so8534449vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Nov 2012 13:22:32 -0800 (PST)
In-Reply-To: <DC700C5A3AE74041B17F41EE35500AB90C8ABDE8@SACEXCMBX03-PRD.hq.netapp.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Snider, Tim" <Tim.Snider@netapp.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Tim,

It's all up to you whether you assign more roles to a system or not.
What actually happens is that you need to start a daemon for each
of the ceph services. Each of the systems in your ceph cluster will
most likely run at least one of those daemons, but it is not required
that all system run all ceph daemons (as a matter of fact, that's highly
unlikely as you will probably have most systems running the ceph-osd
service since they actually contain the block storage devices...)

For instance, see the example config here;
http://ceph.com/docs/master/rados/configuration/ceph-conf/#example-ceph-conf

You have to to be aware of a few things though. Mainly; you need
at least one and preferably 3 or 5 different systems (odd number!)
running the monitor service (ceph-mon). Failovers for the metadata
service is also nice of course, and a cluster with one system running
the ceph-osd daemon is... well... not a ceph cluster  :-)

It all boils down to the load (usage, size) on your cluster how many
systems you want to have performing which role. Ceph doesn't constrain
you to one particular setup.


- Roald


On Wed, Nov 28, 2012 at 8:10 PM, Snider, Tim <Tim.Snider@netapp.com> wrote:
>
> Another rookie question: What's the thinking on having the same server perform multiple CEPH roles (e.g. osd(s), and monitor roles)? I think this would mainly be a facto for smaller/cost sensitive environments.
>
> Tim
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
