From: Wido den Hollander <wido@42on.com>
Subject: Re: Ceph Manager brag module
Date: Sat, 16 Dec 2017 10:06:24 +0100
Message-ID: <66182937-f760-b806-763e-ac41024fdc9c@42on.com>
References: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
 <549A5D4C-284C-4CA1-9D0A-0F10454795D3@redhat.com>
 <CA+z5Dsx+dAePE9rwyevWR2eBFQ0wtWF3xd_F4Vhskas0g14x5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se01-out.mail.pcextreme.nl ([185.66.251.200]:46023 "EHLO
        se01-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750907AbdLPJGe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 16 Dec 2017 04:06:34 -0500
In-Reply-To: <CA+z5Dsx+dAePE9rwyevWR2eBFQ0wtWF3xd_F4Vhskas0g14x5g@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>, Vasu Kulkarni <vakulkar@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, lvaz@redhat.com



On 12/15/2017 09:14 AM, Blair Bethwaite wrote:
> I would sign up to have a regular rados bench or similar run at a 
> configurable time on our clusters.

I would have to look into that as I don't know how much the manager can 
access.

At first we just want to gather metadata and send it back so that we get 
a feeling of how Ceph is used and how big/small the systems are.

Thanks for the input!

Wido

> 
> On 15 Dec. 2017 10:44 am, "Vasu Kulkarni" <vakulkar@redhat.com 
> <mailto:vakulkar@redhat.com>> wrote:
> 
> 
>      > On Dec 14, 2017, at 1:24 AM, Wido den Hollander <wido@42on.com
>     <mailto:wido@42on.com>> wrote:
>      >
>      > Hi,
>      >
>      > After discussing with Sage I started to work [0] on a 'brag'
>     module for Ceph Manager.
>      >
>      > The intention of this module is to send (after a opt-in!)
>     statistics about a Ceph cluster back to the project every few days.
>      >
>      > My intention is to include:
>      >
>      > - fsid (as identifier)
>      > - number of MONs
>      > - number of OSDs
>      > - FileStore / BlueStore
>      > - number of pools / PGs
>      > - data used in bytes
>      > - data free
>      > - number of objects,
>      > - version(s)
>      >
>      > A admin can also say that the report is allowed to be 'public'
>     where you can then visit (for example)
>     https://brag.ceph.com/public/<fsid> and show off your Ceph cluster.
>      >
>      > You could then add a description and we could compile top lists
>     about Ceph systems.
>      >
>      > How do people think about this? Would this be interesting?
> 
>     Great idea, It would be also nice to have some info on hw/osd tree +
>     rados bench results runs for 2 mins with few profiles which could be
>     displayed alongside (could be optional
>     and admin’s choice)
> 
>      >
>      > I would try to convince most of my customers to send this
>     information back to the project. The more information we get, the
>     better Ceph can become.
>      >
>      > Wido
>      >
>      > [0]: https://github.com/wido/ceph/commits/mgr-brag
>     <https://github.com/wido/ceph/commits/mgr-brag>
>      > --
>      > To unsubscribe from this list: send the line "unsubscribe
>     ceph-devel" in
>      > the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>      > More majordomo info at http://vger.kernel.org/majordomo-info.html
>     <http://vger.kernel.org/majordomo-info.html>
> 
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>     <http://vger.kernel.org/majordomo-info.html>
> 
