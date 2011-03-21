From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: RPM issues
Date: Mon, 21 Mar 2011 10:14:00 -0700
Message-ID: <20110321171400.GB17804@dreamer>
References: <AANLkTikBxKTBz8OM+gjO5Mx0JJ3TLSxXkLYf=uioBYC1@mail.gmail.com>
 <20110321160950.GA17804@dreamer>
 <AANLkTi=Q=49N5zKB51+VHimOM5K4Vn+TovwtqS_Zz2Oe@mail.gmail.com>
 <Pine.LNX.4.64.1103210929280.15399@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44675 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab1CUROB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 13:14:01 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1103210929280.15399@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Brian Chrisman <brchrisman@gmail.com>, Terrance Hutchinson <terrance.hutchinson@gmail.com>, Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

On Mon, Mar 21, 2011 at 09:32:20AM -0700, Sage Weil wrote:
> > The more annoying dependencies are things like GTK2, which don't
> > really affect the behavior of the rest of the project, but which will
> > have to be "mandatory" in the RPM, it seems.
> 
> We should really break that into a separate package at some point.  The 
> main roadblock there iirc is breaking it into a separate binary.  
> Originally I thought we should have it launched via the ceph tool (similar 
> to the git subcommands) but at this point I don't really care either way.

Well, if you follow the git model, the subcommands are executables in
a specific directory; other source packages could install their
binaries there too.

And to avoid even protocol incompatibilities, gceph, or "ceph gui",
could actually run a git plumbing-style tool underneath, and just
consume it's stdout. Or just build against libceph-dev, that'll work
too.

-- 
:(){ :|:&};:
