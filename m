From: Sage Weil <sweil@redhat.com>
Subject: Re: boost submodule update
Date: Thu, 29 Sep 2016 16:27:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609291626050.19850@piezo.us.to>
References: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to> <CAC-Np1w-6CR4YBsg3J7pY=CZcEdfYMm5493gMH2SXoDd+X8VZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755518AbcI2Q1d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 29 Sep 2016 12:27:33 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0DABC05490C
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2016 16:27:32 +0000 (UTC)
In-Reply-To: <CAC-Np1w-6CR4YBsg3J7pY=CZcEdfYMm5493gMH2SXoDd+X8VZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 29 Sep 2016, Alfredo Deza wrote:
> On Thu, Sep 29, 2016 at 12:00 PM, Sage Weil <sweil@redhat.com> wrote:
> > Hi everyone,
> >
> > Matt has a working boost submodule branch ready; I've pushed it to
> > wip-boost in ceph.git to ensure the gitbuilders are happy and tagged it
> > needs-qa.
> >
> > Just so there are no surprises:
> >
> >  * This change increases the initial checkout + clone time by about
> > **three minutes**.  Boost is structured as several dozen submodules and it
> > takes a while to clone them all.  It's painful on the first checkout, but
> > fine after that.  This pain only applies to developers.
> >
> >  * We are using boost 1.61 + a few things.  There are still some
> > outstanding warnings.  They appear to be issues in boost 1.61 itself, and
> > do not appear to be significant.  (And the warnings are in parts of boost
> > we're not using yet: asio and serialization.)
> >
> >  * There is still the option to use a system boost via a cmake option.  I
> > doubt anyone will opt for this in practice given the distros tend to lag,
> > but they can if they want.
> 
> What does this mean for actual builds/releases? It seems there is a
> potential for a disconnect between what a developer
> expects from the submodule vs. what the distribution may provide.
> 
> Or are builds supposed to embed boost and not use the distro-provided 
> version?

It will link statically by default.  In practice almost all of boost is in 
headers anyway so there's not much point in dynamic linking.

So, no changes are needed on the build end of things.

sage

