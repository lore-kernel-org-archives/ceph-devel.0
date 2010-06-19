From: Sage Weil <sage@newdream.net>
Subject: Re: creation of ./.snap/test creates something in ./subdir/.snap/
Date: Sat, 19 Jun 2010 08:40:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006190833230.17737@cobra.newdream.net>
References: <hvhrh3$n0a$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38061 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab0FSPjw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jun 2010 11:39:52 -0400
In-Reply-To: <hvhrh3$n0a$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Sat, 19 Jun 2010, Thomas Mueller wrote:
> hi
> 
> i was looking for a way to list all snapshots*.
> 
> then i discovered this:
> 
> 
> mkdir ./.snap/test
> 
> then i found this:
> ./.snap/test
> ./subdir/.snap/_test_1099511630280
> 
> 
> the subdir/.snap/_test_1099511630280 vanishes if i delete the ./.snap/
> test.

This is expected, because subdir's contents are contained by the 'test' 
snap, and we want the .snap/ dir to show you all snaps that contain 
copies of the current directory.  The name is mangled 
(_$snap_$snap_root_ino) to avoid collisions with the current directory's 
snap namespace.  Snaps beginning with _ are disallowed.

> find ./ -type d -print0 | \
> 	xargs -0 -I% -n1 find %/.snap -mindepth 1 -maxdepth 1

find ./ -type d -print0 | \
	xargs -0 -I% -n1 find %/.snap -mindepth 1 -maxdepth 1 \
                         \( ! -name "_*" \)

should do it, I think.  
sage
