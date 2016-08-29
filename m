From: Milosz Tanski <milosz@adfin.com>
Subject: Re: new boost
Date: Mon, 29 Aug 2016 18:39:37 -0400
Message-ID: <CANP1eJF3dQfTbOSL3bmJ27iQeGzS0NfKLPubSeQ6Rw=EAKFH-A@mail.gmail.com>
References: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
 <CALqRxCzuD+uD4pw=E4Ds1gQh84hxHResMNkuoz7E7fYB9x1BJg@mail.gmail.com>
 <alpine.DEB.2.11.1608291556290.24244@piezo.us.to> <CALqRxCyj1ac648vNyBfKtezrXKWG6k-R4oZowtSSkGtHDN0RZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33359 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756398AbcH2Wjs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 18:39:48 -0400
Received: by mail-lf0-f68.google.com with SMTP id f93so78670lfi.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 15:39:45 -0700 (PDT)
In-Reply-To: <CALqRxCyj1ac648vNyBfKtezrXKWG6k-R4oZowtSSkGtHDN0RZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 29, 2016 at 12:16 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On Mon, Aug 29, 2016 at 10:00 AM, Sage Weil <sweil@redhat.com> wrote:
>> I think this is #4:
>>
>>> 4) #1, with cmake smarts to let you choose the submodule or installed
>>> boost (and possibly autoselect system boost if it's new enough).
>
> Oh cool, sorry I didn't understand that :) Yes, that sounds good.
>
>> The goal should be to eventually drop the submodule as supported distros
>> are brought up to date.  I suspect, though, that we'll find other shiny
>> new features we'll want to start using so this may never happen...
>
> If we're still finding features from the latest boost that we want
> years from now, then I'm ok with that. It means that someone's keeping
> the bundled library up-to-date, the project is still getting value
> from the bundled library, and the asset-vs-liability scale is properly
> balanced IMHO.
>

Boost is one of those projects where there's not too much value in
using the distro package. For starters, Boost is so template heavy
that the vast majority of code ends up getting compiled with the
actual executable. It also makes no guarantees about forwards /
backwards compatibility new version of boost requires a rebuild of all
the apps dependent on it. So all the normal distro arguments about one
library shared across many packages and security updates becomes void.

Because of the lack of forwards/backwards compatibility guarantees
it's also hard to build against against distro versions because every
distro (and then FreeBSD) all end up using different versions. So I
would argue that it's hard to certify correctness unless one version
of Ceph is always using one version of boost.
