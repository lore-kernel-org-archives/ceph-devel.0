From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: updating the documentation
Date: Wed, 12 Jul 2017 21:22:46 +0200
Message-ID: <20170712192246.GA10000@mailware>
References: <alpine.DEB.2.11.1707121823111.3424@piezo.novalocal>
 <CA+2bHPaRDo=HLpui_4jcMXcFCzgR6UsmetpX7B6t2L-160oV=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:60752 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752673AbdGLTWt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Jul 2017 15:22:49 -0400
Content-Disposition: inline
In-Reply-To: <CA+2bHPaRDo=HLpui_4jcMXcFCzgR6UsmetpX7B6t2L-160oV=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Wed, Jul 12, 2017 at 11:37:32AM -0700, Patrick Donnelly wrote:
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

For sure it could fail if a PR changes config_opts.h and doesn't carry any
doc update -- lack of docs for config options is probably the most common
and most annoying issue among Ceph users.

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
