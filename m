From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: Ceph Manager brag module
Date: Thu, 14 Dec 2017 15:44:25 -0800
Message-ID: <549A5D4C-284C-4CA1-9D0A-0F10454795D3@redhat.com>
References: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:46512 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754246AbdLNXo1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Dec 2017 18:44:27 -0500
Received: by mail-ot0-f176.google.com with SMTP id j2so6417888ota.13
        for <ceph-devel@vger.kernel.org>; Thu, 14 Dec 2017 15:44:27 -0800 (PST)
In-Reply-To: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org, lvaz@redhat.com


> On Dec 14, 2017, at 1:24 AM, Wido den Hollander <wido@42on.com> wrote:
> 
> Hi,
> 
> After discussing with Sage I started to work [0] on a 'brag' module for Ceph Manager.
> 
> The intention of this module is to send (after a opt-in!) statistics about a Ceph cluster back to the project every few days.
> 
> My intention is to include:
> 
> - fsid (as identifier)
> - number of MONs
> - number of OSDs
> - FileStore / BlueStore
> - number of pools / PGs
> - data used in bytes
> - data free
> - number of objects,
> - version(s)
> 
> A admin can also say that the report is allowed to be 'public' where you can then visit (for example) https://brag.ceph.com/public/<fsid> and show off your Ceph cluster.
> 
> You could then add a description and we could compile top lists about Ceph systems.
> 
> How do people think about this? Would this be interesting?

Great idea, It would be also nice to have some info on hw/osd tree + rados bench results runs for 2 mins with few profiles which could be displayed alongside (could be optional
and admin’s choice)

> 
> I would try to convince most of my customers to send this information back to the project. The more information we get, the better Ceph can become.
> 
> Wido
> 
> [0]: https://github.com/wido/ceph/commits/mgr-brag
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

