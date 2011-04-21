From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: mds crash
Date: Thu, 21 Apr 2011 12:08:04 -0700
Message-ID: <20110421190804.GD9431@dreamer>
References: <B828A4C02BE12543ACDFCF7EB0C693C6788452D627@NC-SVR-09.netelligent.com>
 <Pine.LNX.4.64.1104190917010.3238@cobra.newdream.net>
 <B828A4C02BE12543ACDFCF7EB0C693C6788452D75C@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34596 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab1DUTID (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 15:08:03 -0400
Content-Disposition: inline
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C6788452D75C@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Apr 20, 2011 at 09:00:34AM -0500, Mark Nigh wrote:
> That seems to fix the problem. Both of my mds are up and active.
> 
> mds e1838: 2/2/2 up {0=up:active,1=up:active}
> 
> The only thing that doesn't seem right to me (I am not a developer
> so my understanding of git is limited) is that my version is of the
> following....
> 
> ceph version 0.26-303-g36f0068 (commit:36f00685633a6f953b046106f5dd31a9169c82d4)
> 
> I don't think this is correct?

I can confirm that your ceph build now includes the commit
d55399ffec224206ea324e83bb8ead1e9ca1eddc Sage asked you to test, so
all should be good.

> 1. What is the proper way to upgrade from version to version. Has
> anyone documentation the proper procedure?

We try pretty hard not to break anything, so you should be able just
grab new releases, either as tarballs or via git (for git, run
something like "git fetch && git checkout v0.26"), build them, and
restart your cluster. However, Ceph is still going through rapid
changes, read the release notes carefully.

> 2. If I just want to test out the file system capabilities, do I
> need to install all the packages or is there some I can do
> without. I have been currently installing the following packages
> (Ubuntu v10.10) in this order.
> 
> sudo dpkg -i libcrush1_0.26-1_amd64.deb
> sudo dpkg -i libceph1_0.26-1_amd64.deb
> sudo dpkg -i ceph-fuse_0.26-1_amd64.deb
> sudo dpkg -i librados2_0.26-1_amd64.deb
> sudo dpkg -i librbd1_0.26-1_amd64.deb
> sudo dpkg -i ceph_0.26-1_amd64.deb

The server side needs ceph.deb.

For in-kernel client side, you need a fresh enough kernel, and
mount.ceph in ceph-client-tools makes it nicer to use.

For FUSE client side, you need libfuse.

librados is a client library for the object store, you don't seem to
be using it.

librbd is a client library for things like QEMU/KVM, you don't seem to
be using it.

I don't see any of our packages actually needing libcrush or libceph
(I guess that means they bundle the library in the binary directly),
so you shouldn't need those either (at least right now; some day we
may wish to wrestle the Automake monster and change that).

-- 
:(){ :|:&};:
