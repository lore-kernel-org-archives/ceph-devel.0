From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: master branch in git
Date: Wed, 26 Jan 2011 13:34:28 -0800
Message-ID: <20110126213428.GA18855@dreamer>
References: <1296076567.1802.16.camel@dogen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40542 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1AZVe1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 16:34:27 -0500
Content-Disposition: inline
In-Reply-To: <1296076567.1802.16.camel@dogen>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Leach <john@brightbox.co.uk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 26, 2011 at 09:16:07PM +0000, John Leach wrote:
> what's the master branch used for in the git repository? It's currently
> at "v0.24". It's not had 0.24.1 or 0.24.2 merged into it so it doesn't
> seem to be stable.
> 
> There is a stable branch but it's not been updated since September.

You know, that confused me too when I was starting to look at ceph.

The branches that are actively used are "unstable" and "testing".  I
guess "stable" will get some life, well, once we consider Ceph stable
;)

To clear up this issue, I'd suggest we either:

1. start using "master" for what is now called "unstable" (which is
   the typical git usage elsewhere)

2. remove the branch "master", and update
   ceph.newdream.net:/git/ceph.git/HEAD to say "ref: refs/heads/unstable"

I personally vote for #1, unless somebody can come up with a
convincing historical argument..

-- 
:(){ :|:&};:
