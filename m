From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Fixing NFS
Date: Thu, 3 Feb 2011 09:52:42 -0800
Message-ID: <20110203175242.GA6348@dreamer>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
 <Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:45260 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161Ab1BCRwd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Feb 2011 12:52:33 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Brian Chrisman <brchrisman@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Feb 03, 2011 at 09:29:32AM -0800, Sage Weil wrote:
> Which leaves us with a final problem: what if the fh is generated for
> /foo/bar, but bar is renamed to /baz/bar, bar drops out of all caches, and
> the client tries to use the fh.  We're still stuck with ESTALE in that
> case.  The only real solution there is to include a backpointer on the
> file's data object.  This is doable, but comes at a cost.  We could make
> it optional, and/or mitigate it somewhat (backpointer is only created once
> a file is renamed, or something like that).
>
> I'm not really sure to what lengths a server is supposed to go to avoid 
> ESTALE.  I seem to remember that NFSv4 has a different class of fh's that 
> are allowed to expire.  I'm not sure how that helps, though; it seems 
> likeif a client has a file open that is renamed by another node and then 
> idle for long enough and then tries to read it'll still be screwed, 
> regardless of what the server does/does not promise the client.

NFSv4 volatile filehandles move away from the whole "stale"
terminology into "expiring" filehandles, which a client SHOULD recover
from, and that's said with fairly strong language in RFC3530. The
volatile filehandles may go away at any moment (for FH4_VOLATILE_ANY).

The RFC suggests clients remember the full path of every volatile
filehandle, and points out that doesn't let you recover if someone
else renamed the file.. which means your "final problem" above is
still a problem, and smells unavoidable. But at least shifting
responsibility for remembering the path to the client makes recovery
easy in the typical case.

If the real-world support is there, I'd say NFSv4 is the way to go,
for future Ceph re-exporting.

-- 
:(){ :|:&};:
