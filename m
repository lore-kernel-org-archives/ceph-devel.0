From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Write to Secondary Zone?
Date: Mon, 2 Oct 2017 13:09:19 +0300
Message-ID: <CABo9giQt1SUNeg4PPgAthrUtAwvTGsuTeVuN_Odx9jgPHCL9Fg@mail.gmail.com>
References: <CAKRxpuv1CtoEJHhsp3tk3Az1PrWZ3bP9kOT_fiAOmXutzPsXrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:56346 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdJBKJU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 06:09:20 -0400
Received: by mail-qt0-f182.google.com with SMTP id e19so2695383qta.13
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 03:09:20 -0700 (PDT)
In-Reply-To: <CAKRxpuv1CtoEJHhsp3tk3Az1PrWZ3bP9kOT_fiAOmXutzPsXrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 29, 2017 at 6:41 PM, Two Spirit <twospirit6905@gmail.com> wrote:
> Is it now supported to be able to write to a secondary zone without problems?
>

yes from Jewel.

> If not supported, is there a timeframe that this (being able to write
> to secondary zones) would be supported?
>
> It also looks like the federated solution does not scale well with
> multi region all in sync.
>

We moved to a new implementation in Jewel (because of problems with
the old federated solution).
Region is  now called zonegroup to avoid confusion with AWS region.
A zone in RGW is like an AWS region.

> Is there support in Ceph for region-to-region syncing. Based on the
> figure in the documentation, it appears that zone to zone syncing does
> not happen across a slow wan link (as there are 3 MONs in the backend,
> and unified Ceph cluster is not recommended across a WAN)

Yes. This is zone to zone sync in RGW.
RGW geo replication was designed speciflicly to handle slow WAN link.
Each zone is a complete and separates Ceph cluster.

For more details see:
http://docs.ceph.com/docs/master/radosgw/multisite/
http://events.linuxfoundation.org/sites/events/files/slides/Linuxcon_multisitev2.pdf

Regards,
Orit

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
