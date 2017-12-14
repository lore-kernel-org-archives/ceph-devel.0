From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Ceph Manager brag module
Date: Fri, 15 Dec 2017 01:08:30 +1100
Message-ID: <CA+z5DsxiAAEyN8kBis80ZjvJP+8JYOE9bnDv+prYW4UCgQYFjw@mail.gmail.com>
References: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36447 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbdLNOIv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Dec 2017 09:08:51 -0500
Received: by mail-qt0-f171.google.com with SMTP id a16so8073889qtj.3
        for <ceph-devel@vger.kernel.org>; Thu, 14 Dec 2017 06:08:51 -0800 (PST)
In-Reply-To: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, lvaz@redhat.com

Nice idea.

I definitely agree that the submission mechanism needs to support HTTP
proxies. I imagine many (most?) ceph-mgr daemons are on private
networks, and not everyone has NAT.

On 14 December 2017 at 20:24, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> After discussing with Sage I started to work [0] on a 'brag' module for Ceph
> Manager.
>
> The intention of this module is to send (after a opt-in!) statistics about a
> Ceph cluster back to the project every few days.
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
> A admin can also say that the report is allowed to be 'public' where you can
> then visit (for example) https://brag.ceph.com/public/<fsid> and show off
> your Ceph cluster.
>
> You could then add a description and we could compile top lists about Ceph
> systems.
>
> How do people think about this? Would this be interesting?
>
> I would try to convince most of my customers to send this information back
> to the project. The more information we get, the better Ceph can become.
>
> Wido
>
> [0]: https://github.com/wido/ceph/commits/mgr-brag
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
~Blairo
