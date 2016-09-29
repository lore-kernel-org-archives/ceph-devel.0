From: Alfredo Deza <adeza@redhat.com>
Subject: Re: boost submodule update
Date: Thu, 29 Sep 2016 12:13:35 -0400
Message-ID: <CAC-Np1w-6CR4YBsg3J7pY=CZcEdfYMm5493gMH2SXoDd+X8VZg@mail.gmail.com>
References: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35223 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbcI2QNh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2016 12:13:37 -0400
Received: by mail-wm0-f42.google.com with SMTP id b4so38244601wmb.0
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2016 09:13:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 29, 2016 at 12:00 PM, Sage Weil <sweil@redhat.com> wrote:
> Hi everyone,
>
> Matt has a working boost submodule branch ready; I've pushed it to
> wip-boost in ceph.git to ensure the gitbuilders are happy and tagged it
> needs-qa.
>
> Just so there are no surprises:
>
>  * This change increases the initial checkout + clone time by about
> **three minutes**.  Boost is structured as several dozen submodules and it
> takes a while to clone them all.  It's painful on the first checkout, but
> fine after that.  This pain only applies to developers.
>
>  * We are using boost 1.61 + a few things.  There are still some
> outstanding warnings.  They appear to be issues in boost 1.61 itself, and
> do not appear to be significant.  (And the warnings are in parts of boost
> we're not using yet: asio and serialization.)
>
>  * There is still the option to use a system boost via a cmake option.  I
> doubt anyone will opt for this in practice given the distros tend to lag,
> but they can if they want.

What does this mean for actual builds/releases? It seems there is a
potential for a disconnect between what a developer
expects from the submodule vs. what the distribution may provide.

Or are builds supposed to embed boost and not use the distro-provided version?

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
