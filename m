From: Sage Weil <sweil@redhat.com>
Subject: Re: Status of static analysis
Date: Wed, 4 Jan 2017 15:48:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701041547430.10511@piezo.novalocal>
References: <20161219024554.GA6396@rskikr.localdomain> <CAJ4mKGbge38C_EqefK1Mm7Tn6CadC2iy_MBF1FHWJtw1Rc3A0w@mail.gmail.com> <20170104004440.GA6375@rskikr.localdomain> <CAJ4mKGYhMeQ60foLp_fvf7aq=WgXJnW-vEhCqOC4cbdNPSujDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968577AbdADPsy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 4 Jan 2017 10:48:54 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D19503D97C
        for <ceph-devel@vger.kernel.org>; Wed,  4 Jan 2017 15:48:54 +0000 (UTC)
In-Reply-To: <CAJ4mKGYhMeQ60foLp_fvf7aq=WgXJnW-vEhCqOC4cbdNPSujDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 3 Jan 2017, Gregory Farnum wrote:
> On Tue, Jan 3, 2017 at 4:44 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
> >
> >
> > On Wed, Jan 4, 2017 at 10:30 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> >> On Sun, Dec 18, 2016 at 6:45 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
> >>> As you would have noticed in recent weeks we have returned to  running a
> >>> Coverity test over the source tree on a weekly basis. In addition, I have been
> >>> running Clang Static Analyzer and Cppcheck scans. Until we can find a better
> >>> home for these and include at least one of them in our CI processes I will be
> >>> hosting them at http://people.redhat.com/bhubbard/
> >>
> >> So...is there some way for people to feed back into that as we
> >> evaluate stuff? For instance I looked at one of the use-after-free
> >> reports[1] and it's incorrect and I think there's a way to tell
> >> Coverity so, but I've no idea how.
> >> -Greg
> >>
> >> [1]: http://people.redhat.com/bhubbard/scan-build.16-12-30/report-46bfed.html#EndPath
> >
> > Hi Greg,
> >
> > That report is from Clang Static Analyzer (not Coverity) and I am happy to
> > coordinate feedback as best I can for now.
> 
> D'oh, I was just substituting that everywhere in my head for some
> reason. :o Sorry and thanks.

There is also a coverity UI can you can request access to

	https://scan.coverity.com/projects/ceph?tab=overview

but it is probably better to figure out the code annotations so we don't 
rely on state in the tool's database.

sage
