From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Refuse OSD removal if still up or acting for PG
Date: Wed, 23 Mar 2016 16:37:06 -0700
Message-ID: <CAJ4mKGaOPO=QYe8+N8S_u_kkc7HjwoZNYsAJh_xwd6VcQWJAOQ@mail.gmail.com>
References: <246396009.130901.1458769575985.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33744 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbcCWXhH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2016 19:37:07 -0400
Received: by mail-vk0-f42.google.com with SMTP id k1so38812577vkb.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2016 16:37:07 -0700 (PDT)
In-Reply-To: <246396009.130901.1458769575985.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "wido@42on.com" <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Mar 23, 2016 at 2:46 PM, wido@42on.com <wido@42on.com> wrote:
> Hi,
>
> This week I got a call to recover a Ceph cluster where somebody ran 'ceph osd rm X' for OSDs which were still holding PGs.
>
> He removed multiple OSDs and together they were all the replicas forma certain PG.
>
> This raised the question: Should we refuse a rm for a OSD which is still up or acting for a PG?
>
> If not, what would the use-case be for removing a OSD from the OSDMap when it is still up or acting?

Broken data stores is the obvious one... :/

But yeah, sure, we can make it say "no" by default.
-Greg

>
> I would say that recovery/backfill has to be finished before we allow an OSD to be removed.
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
