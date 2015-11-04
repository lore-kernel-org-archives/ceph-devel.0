From: Sage Weil <sweil@redhat.com>
Subject: Re: civetweb upstream/downstream divergence
Date: Wed, 4 Nov 2015 15:54:34 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511041549470.5830@cobra.newdream.net>
References: <5631E4A5.9020003@suse.cz> <CADRKj5T5ZZBb+Mhut2jnzKoBEtTjw0tGWptqWVamgoLWaQfpgQ@mail.gmail.com> <20151029225738.51b8b2e5@lembas.zaitcev.lan> <CALqRxCwPNA0WFYu0oJ-70L3vgR0G8WLs4paU=K1xZCyf=a3Fjw@mail.gmail.com> <1446486438.12033.24.camel@millnert.se>
 <56387CDD.9070605@suse.cz> <alpine.DEB.2.00.1511030320340.32232@cobra.newdream.net> <CALqRxCzhOOKziRML1DtptXSNyP1GJ-JHBqn69Q=aFeg7i2wr9g@mail.gmail.com> <CALqRxCwfoeak4QhAxacyd=XM8t3RhiVUwfCN+p76xiYNTYu7zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49727 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932491AbbKDXyi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 Nov 2015 18:54:38 -0500
In-Reply-To: <CALqRxCwfoeak4QhAxacyd=XM8t3RhiVUwfCN+p76xiYNTYu7zw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Martin Millnert <martin@millnert.se>, Pete Zaitcev <zaitcev@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 4 Nov 2015, Ken Dreyer wrote:
> On Wed, Nov 4, 2015 at 1:25 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> > On Tue, Nov 3, 2015 at 4:22 AM, Sage Weil <sweil@redhat.com> wrote:
> >> On Tue, 3 Nov 2015, Nathan Cutler wrote:
> >>> IMHO the first step should be to get rid of the evil submodule. Arguably
> >>> the most direct path leading to this goal is to simply package up the
> >>> downstream civetweb (i.e. 1.6 plus all the downstream patches) for all
> >>> the supported distros. The resulting package would be Ceph-specific,
> >>> obviously, so it could be called "civetweb-ceph".
> >>>
> >>> Like Ken says, the upstreaming effort can continue in parallel.
> >>
> >> I'm not sure I agree.  As long as everything is not upstream and we are
> >> running a fork, what is the value of having it in a separate package?
> >> That just means all of the effort of managing the package dependency and
> >> making sure it is in all of the appropriate distros (and similar pain for
> >> those building manually) without any of the benefits (upstream bug fixes,
> >> etc.).
> >
> > I think there's value in getting the packaging bits ready ahead of
> > time and letting those "bake in" in Fedora/Ubuntu/Debian/SUSE while we
> > continue to merge Ceph's civetweb changes to Civetweb upstream.
> >
> > Now that Civetweb with RGW is mainstream, I'm looking forward to
> > eventually using a pre-built civetweb package that can shave time off
> > our Ceph Gitbuilder/Jenkins runs :)
> 
> Oh, I just re-read this, and Nathan's proposing to package up
> "civetweb-ceph" as a fork... I'm not sure that's worth it (at least,
> speaking for packaging in Fedora).
> 
> When I was talking about a "parallel effort", what I meant is that
> we'd get vanilla civetweb upstream into the distros, and we'd also
> continue to bundle civetweb in Ceph, until we can reliably use the
> upstream Civetweb package.

Ah, this sounds better to me.  There may be some work to build civetweb as 
a shared library (currently it's just a statically linked module) but 
probably not too bad.

sage
