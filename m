From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: new boost
Date: Mon, 29 Aug 2016 10:16:32 -0600
Message-ID: <CALqRxCyj1ac648vNyBfKtezrXKWG6k-R4oZowtSSkGtHDN0RZQ@mail.gmail.com>
References: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
 <CALqRxCzuD+uD4pw=E4Ds1gQh84hxHResMNkuoz7E7fYB9x1BJg@mail.gmail.com> <alpine.DEB.2.11.1608291556290.24244@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34446 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754955AbcH2QQe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 12:16:34 -0400
Received: by mail-ua0-f175.google.com with SMTP id k90so254276863uak.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 09:16:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608291556290.24244@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 29, 2016 at 10:00 AM, Sage Weil <sweil@redhat.com> wrote:
> I think this is #4:
>
>> 4) #1, with cmake smarts to let you choose the submodule or installed
>> boost (and possibly autoselect system boost if it's new enough).

Oh cool, sorry I didn't understand that :) Yes, that sounds good.

> The goal should be to eventually drop the submodule as supported distros
> are brought up to date.  I suspect, though, that we'll find other shiny
> new features we'll want to start using so this may never happen...

If we're still finding features from the latest boost that we want
years from now, then I'm ok with that. It means that someone's keeping
the bundled library up-to-date, the project is still getting value
from the bundled library, and the asset-vs-liability scale is properly
balanced IMHO.

- Ken
