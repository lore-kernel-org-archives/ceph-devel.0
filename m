From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-qa] ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 15:00:04 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604131458180.29593@cpach.fuggernut.com>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com> <570E4843.8000102@dachary.org> <CAJ4mKGZ72SOiFt_t+ErWBWuGLQSDMYGyKJDyFnRKpUGJ+oORUw@mail.gmail.com> <CALe9h7fmWL0TQxzjct2q26gUuX8z1D56w3QPFkbCK-AN2TTsjQ@mail.gmail.com>
 <CAN=+7FVtCyDDOx-fHhgEfX=rdne32kG0bJ2UZnnRYt8xgC2iLA@mail.gmail.com> <alpine.DEB.2.11.1604131436160.29593@cpach.fuggernut.com> <CAJ4mKGYqESJxZNwbnxgv0oBER76L-R_Dr-=deo9ttmikNiJUDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34120 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754835AbcDMTAH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Apr 2016 15:00:07 -0400
In-Reply-To: <CAJ4mKGYqESJxZNwbnxgv0oBER76L-R_Dr-=deo9ttmikNiJUDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>, Samuel Just <sjust@redhat.com>

On Wed, 13 Apr 2016, Gregory Farnum wrote:
> On Wed, Apr 13, 2016 at 11:38 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Wed, 13 Apr 2016, Samuel Just wrote:
> >> It also doesn't seem like it would actually present a problem in any case.
> >
> > The reason we didn't do this before was because we wanted to revise tests
> > independently of the thing being tested.  But as John points out,
> > specifying a test branch should accomplish that, at least for testing.
> >
> > It might be nice to preserve the ability specify an alternate repo with
> > totally out-of-tree tests.  Maybe that can be done with a simple reorg of
> > the repo, like putting everything under qa/, so that tasks/ and suites/
> > don't appear at the top level (of ceph.git or ceph-qa-suite.git).
> 
> I shudder to suggest it, but would we get what we're really after by
> including a ceph-qa-suite submodule in ceph.git, and having the
> teuthology scheduling refer to that? Then we can update ceph-qa-suite
> independently while still having an atomic switch for the tests that
> goes into the same Ceph branch which makes the changes requiring them.

Not really.  The workflow for updating submodules is really painful.  
Something like

 - commit to sub.git
 - push to branch in public sub.git
 - commit to main.git updating submodule sha
 - push to branch in main.git
 ...
 - merge main.git branch
 - merge sub.git branch (if you remember)

...and there are no "merge" semantics if there are racing sub.git updates.

Submodules only really work for things that are infrequently updated...

sage
