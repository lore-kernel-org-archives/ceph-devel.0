From: John Leach <john@brightbox.co.uk>
Subject: Re: master branch in git
Date: Wed, 26 Jan 2011 21:51:37 +0000
Message-ID: <1296078697.1802.37.camel@dogen>
References: <1296076567.1802.16.camel@dogen>
	 <AANLkTimjgPj2wQhtw1zg8NK-jsLPk1RUHiRcjA0XH8RV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp171.iad.emailsrvr.com ([207.97.245.171]:42826 "EHLO
	smtp171.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab1AZVvk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 16:51:40 -0500
In-Reply-To: <AANLkTimjgPj2wQhtw1zg8NK-jsLPk1RUHiRcjA0XH8RV@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 2011-01-26 at 13:22 -0800, Gregory Farnum wrote:
> You're talking about the userspace Ceph repository?
> I wasn't aware there was a master or stable branch (heh). I thought
> Sage had just recently cleaned up the old branches, but we may still
> have a bit of a mess as we adjusted to a larger team size and more
> formal releases. You're generally going to want one of testing,
> unstable, rc.
> 
> Unstable is the branch we do dev work on. It has the newest shiny
> stuff and is far more likely to be broken than the other branches, to
> get commits erased, etc.
> Testing is the previous release plus bugfixes, and will eventually
> become the next point release (eg, v.24.3).
> rc is maintained when we're approaching a major release (eg, v.25) and
> contains the features we expect to go into that branch. This branch
> comes off of unstable but once it branches it's a fairly stable
> branch.

thanks for the clarification Greg.

It's a bit weird seeing the master branch like that. It just looks a bit
abandoned, and it's the branch most people (and git clients) go to
first.

Example: http://ceph.newdream.net/git/?p=ceph.git;a=summary  :)

Not sure what to do about it though.

weird seeing the "stable" branch be 3 months old too.

http://ceph.newdream.net/git/?p=ceph.git;a=shortlog;h=refs/heads/stable

I think it'd be nice to see each tagged release get merged to stable,
and perhaps unstable commits on master? Not sure.

sorry to complain, just trying to help :)

John.

> 
> On Wed, Jan 26, 2011 at 1:16 PM, John Leach <john@brightbox.co.uk> wrote:
> > Hi,
> >
> > what's the master branch used for in the git repository? It's currently
> > at "v0.24". It's not had 0.24.1 or 0.24.2 merged into it so it doesn't
> > seem to be stable.
> >
> > There is a stable branch but it's not been updated since September.
> >
> > John.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



