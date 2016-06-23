From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: remove cryptopp support?
Date: Thu, 23 Jun 2016 14:23:33 -0600
Message-ID: <CALqRxCyxRUC8cdN91rpmZjc7POazH9R8iA62=_EOhoQ+QipjnQ@mail.gmail.com>
References: <alpine.DEB.2.11.1606231824050.14068@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34351 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbcFWUXf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jun 2016 16:23:35 -0400
Received: by mail-vk0-f51.google.com with SMTP id c2so92771725vkg.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jun 2016 13:23:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606231824050.14068@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I'm biased since the RPMs are built --with-nss :) In general I'm all
for simplifying config options and removing this.

- Ken

On Thu, Jun 23, 2016 at 12:26 PM, Sage Weil <sage@redhat.com> wrote:
> Right now you can build against either libnss or cryptopp for crypto
> support.  We always build packages with nss, mainly because it has some
> certifications that governments and distros care about.  I don't think
> anybody builds with cryptopp any more, but I may be wrong.
>
> Would anyone object if we just ripped out support for cryptopp?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
