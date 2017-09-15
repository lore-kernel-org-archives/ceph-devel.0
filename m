From: Sage Weil <sweil@redhat.com>
Subject: Re: CephFS HA support network appliance
Date: Fri, 15 Sep 2017 18:43:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709151841580.16664@piezo.novalocal>
References: <CAKRxpuuBHzqHK0YvTcWdR3LrsOLFYMqp8GzAg0CnPN9QgQ6sng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-597392942-1505500997=:16664"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55803 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751443AbdIOSnS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 15 Sep 2017 14:43:18 -0400
In-Reply-To: <CAKRxpuuBHzqHK0YvTcWdR3LrsOLFYMqp8GzAg0CnPN9QgQ6sng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-597392942-1505500997=:16664
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2017, Two Spirit wrote:
> Sage, My email is bounced back saying there is a virus. I don't think the
> mailing list likes ascii art so I'm resending directly to you.
> cephfs with posix fs works great
> 
> [ host1 auto/mount ] --+-- [ceph 1]
>                        |
> [ host2 auto/mount ] --+-- [ceph 2] 
>                        |
>                        +-- [ceph 3]
> 
> automount can automatically connect to available ceph node. Network device
> that doesn't support ceph or cephx needs access to ceph, I can export it
> through NFS/SMB
> 
> NetAppliance ----exports--[ host1 auto/mount ] --+-- [ceph 1]
>                                                  |
>                         --[ host2 auto/mount ] --+-- [ceph 2] 
>                                                  |
>                                                  +-- [ceph 3]
> 
> 
> host 1 becomes a single point of failure. host 1 goes down,
> ceph=unavailable. Solution is to create virtual ip with heartbeats for high
> availability.
> 
> NetAppliance --[VIP]--+---[ host1 auto/mount ] --+-- [ceph 1]
>                       |                          |
>                       +---[ host2 auto/mount ] --+-- [ceph 2]  
>                                                  |
>                                                  +-- [ceph 3]
> 
> Is this scenario possible with CephFS since thet NetAppliance doesn't
> support mounting ceph nor cephx, nor round robin mounting multiple IP.
> 
> [ host1 auto/mount ] --+-- [ceph 1]
>                        |
> [ host2 auto/mount ] --+-- [ceph 2] 
>                        |
>   [ NetAppliance ] ----+-- [ceph 3]

NetAppliance == host re-exporting cephfs via nfs.  The recommended way to 
do this is with nfs-ganesha.  There is a bunch of info about how to do 
this in an HA way (with N active servers even) but I'm not sure it is well 
collated on docs.ceph.com.

sage

--8323329-597392942-1505500997=:16664--
