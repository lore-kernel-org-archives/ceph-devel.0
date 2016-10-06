From: John Spray <jspray@redhat.com>
Subject: Re: new naming convention for building repos and binaries from branches
Date: Thu, 6 Oct 2016 18:10:35 +0200
Message-ID: <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32942 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964802AbcJFQK5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 12:10:57 -0400
Received: by mail-qk0-f173.google.com with SMTP id n189so20251872qke.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 09:10:56 -0700 (PDT)
In-Reply-To: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 6, 2016 at 5:43 PM, Alfredo Deza <adeza@redhat.com> wrote:
> Hi all,
>
> The (current) behavior with gitbuilders is that it builds every commit
> of every branch in Github.
>
> With the new CI system, although we can cope with the demand as the
> Ceph project grows in contributions, we are planning on only building
> branches that really need to be built.
>
> This keeps the whole system going as fast as possible (we are
> currently getting full repositories in about 1 hour) and very
> efficient.
>
> We need to come up with a naming convention for branches to be built.
> At the moment we are building everything and that is preventing us
> from enabling other features in the system like all the other
> "flavors" (e.g. tcmalloc).
>
> Branch names for builds will need certain restrictions. Because the
> system is based on HTTP components, no HTTP reserved chars can be used
> (e.g. historic/libradosgw would be a no-go). Other invalid chars are:
> & , ; ? = + $ :
>
> We could keep the implicit convention for `wip-*` or maybe something similar?

Building everything that starts with wip-* sounds fine to me.  But
isn't that usually everything that we push to the ceph/ceph
repository?  What is is that we're trying to avoid building?

John

> Ideas welcomed :)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
