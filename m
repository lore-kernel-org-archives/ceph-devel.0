From: Sage Weil <sweil@redhat.com>
Subject: Re: updating the documentation
Date: Wed, 12 Jul 2017 19:28:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707121926150.32272@piezo.novalocal>
References: <alpine.DEB.2.11.1707121823111.3424@piezo.novalocal> <CA+2bHPaRDo=HLpui_4jcMXcFCzgR6UsmetpX7B6t2L-160oV=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbdGLT25 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Jul 2017 15:28:57 -0400
In-Reply-To: <CA+2bHPaRDo=HLpui_4jcMXcFCzgR6UsmetpX7B6t2L-160oV=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Wed, 12 Jul 2017, Patrick Donnelly wrote:
> On Wed, Jul 12, 2017 at 11:29 AM, Sage Weil <sweil@redhat.com> wrote:
> > In the meantime, we can also avoid making the problem worse by requiring
> > that all pull requests include any relevant documentation updates.  This
> > means (1) helping educate contributors that doc updates are needed, (2)
> > helping maintainers and reviewers remember that doc updates are part of
> > the merge criteria (it will likely take a bit of time before this is
> > second nature), and (3) generally inducing developers to become aware of
> > the documentation that exists so that they know what needs to be updated
> > when they make a change.
> 
> There was a joke to add a bot which automatically fails PRs for no
> documentation but I think there is an way to make that work in a
> reasonable way. Perhaps the bot could simply comment on all PRs
> touching src/ that documentation is required and where to look, and
> then fails a doc check. A developer must comment on the PR to say it
> passes documentation requirements before the bot changes the check to
> pass.
> 
> This addresses all three points in an automatic way.

This is a great idea.  Greg brought up the idea of a bot but we 
didn't think of a "docs ok"-type comment to make it happy.

Anybody interested in coding it up?

Piotr makes a good point about config_opts.h, although that problem is 
about to go away (or at least change) with John's config update:

	https://github.com/ceph/ceph/pull/16211

(Config options will be documented in the code where the schema is 
defined, and docs.ceph.com .rst will eventually be auto-generated from 
that.)

sage
