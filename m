From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Ceph 0.94.8 Hammer released
Date: Mon, 29 Aug 2016 08:00:35 -0400
Message-ID: <CAC-Np1yQN3C0kojOKqDUQL9RSscEGTtCdMjjFF4b6d4pNFsyug@mail.gmail.com>
References: <alpine.DEB.2.11.1608262128480.27294@piezo.us.to> <robbat2-20160826T225027-679783010Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37679 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932523AbcH2MAh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 08:00:37 -0400
Received: by mail-wm0-f53.google.com with SMTP id i5so88073261wmg.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 05:00:36 -0700 (PDT)
In-Reply-To: <robbat2-20160826T225027-679783010Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Aug 26, 2016 at 6:52 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> On Fri, Aug 26, 2016 at 09:31:45PM +0000, Sage Weil wrote:
>> * For packages, see http://ceph.com/docs/master/install/get-packages
> I don't see any .8 packages for Debian/Ubuntu yet in the older path:
> https://download.ceph.com/debian-hammer/pool/main/c/ceph/
>
> And the flavors variant path:
> https://download.ceph.com/debian-hammer/flavors/default/pool/main/c/ceph/
> does not contain Hammer builds for Precise yet.

The "flavors variant" was introduced with recent changes to support
the unified CI build system. So packages got built, signed, and
published
but to the wrong place.

Those have been removed and should be re-published soon. Thanks for catching it!


>
> --
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
