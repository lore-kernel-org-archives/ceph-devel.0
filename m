From: Sage Weil <sage@newdream.net>
Subject: Re: GIT /testing branch current?
Date: Mon, 3 Jan 2011 14:46:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101031443550.7281@cobra.newdream.net>
References: <AANLkTi=-JoVV9WWSE0kPQMkTZ1V=R5vmCkEW0iYzgYoA@mail.gmail.com>
 <1293792328.2732.1.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36007 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab1ACWkf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jan 2011 17:40:35 -0500
In-Reply-To: <1293792328.2732.1.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Matthew Roy <imjustmatthew@gmail.com>, ceph-devel@vger.kernel.org

Hi Matthew,

The testing branch is now updated.  Basically:

 master - last release (currently v0.24)
 testing - last release + bugfixes, will become next bugfix release (v0.24.1)
 rc - next major release candidate
 unstable - random new stuff

The only caveat is that 'rc' is only maintained when we get closer to 
release and we start separating out bugfixes (rc) from features 
(unstable).

sage


On Fri, 31 Dec 2010, Wido den Hollander wrote:

> Hi Matthew,
> 
> The unstable branch is the really unstable branch, that is where all the
> new stuff goes in.
> 
> The rc branch has the code which has been tested a bit more.
> 
> I'm not sure what the testing branch is doing atm, but i'd stick with rc
> or unstable.
> 
> Wido
> 
> On Fri, 2010-12-31 at 00:18 -0500, Matthew Roy wrote:
> > Is the /testing branch in GIT still being used? It looks like it's
> > pretty far from from HEAD and /rc (which seems like where things are
> > being built from now).
> > 
> > I just want to be sure I'm not missing something before changing the
> > docs on the wiki.
> > 
> > Matthew
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
