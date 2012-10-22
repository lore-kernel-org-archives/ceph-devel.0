From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-commit] [ceph/ceph] 66bda1: auth: change default: require
 'cephx' for daemons
Date: Mon, 22 Oct 2012 11:27:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210221126430.31573@cobra.newdream.net>
References: <50841d54c416e_32141173ae4158726@sh2.rs.github.com.mail> <CAPYLRziveMKeoGpD3TcyZqw8+Lt3WM033AdpHUK=jgE5VtK-8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58676 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab2JVS1O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 14:27:14 -0400
In-Reply-To: <CAPYLRziveMKeoGpD3TcyZqw8+Lt3WM033AdpHUK=jgE5VtK-8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 22 Oct 2012, Gregory Farnum wrote:
> On Sun, Oct 21, 2012 at 9:05 AM, GitHub <noreply@github.com> wrote:
> >   Branch: refs/heads/master
> >   Home:   https://github.com/ceph/ceph
> >   Commit: 66bda162e1acad34d37fa97e3a91e277df174f42
> >       https://github.com/ceph/ceph/commit/66bda162e1acad34d37fa97e3a91e277df174f42
> >   Author: Sage Weil <sage@inktank.com>
> >   Date:   2012-10-21 (Sun, 21 Oct 2012)
> >
> >   Changed paths:
> >     M src/common/config_opts.h
> >
> >   Log Message:
> >   -----------
> >   auth: change default: require 'cephx' for daemons
> >
> > Daemons will require cephx.
> >
> > Clients will require nothing (i.e., will be able to connect to a cluster
> > with auth disabled).
> >
> > See #3136
> >
> > Signed-off-by: Sage Weil <sage@inktank.com>
> 
> I know we've talked about doing this in the past, but delayed until
> Cephx was better documented (and easier to work with?). Are we sure
> that we've passed the point where this is going to work for users on
> the first try?

I think we're close.  In any case, though, this is going into bobtail one 
way or another, and I want to get more testing on the code side.

s
