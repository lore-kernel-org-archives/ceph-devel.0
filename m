From: Sage Weil <sage@newdream.net>
Subject: Re: gmock issues when switching Git branches
Date: Tue, 13 Dec 2016 12:51:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612131249060.32565@piezo.novalocal>
References: <1172024124.4367.1481629902991@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56759 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbcLMMvI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 07:51:08 -0500
In-Reply-To: <1172024124.4367.1481629902991@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 13 Dec 2016, Wido den Hollander wrote:
> Hi,
> 
> I've been seeing this multiple times when switching Git branches on git Git repo:
> 
> wido@wido-desktop:~/repos/ceph$ git branch
>   firefly
>   hammer
>   jewel
> * master
> wido@wido-desktop:~/repos/ceph$ git checkout jewel
> error: Updating the following directories would lose untracked files in it:
> 	src/gmock
> 
> Aborting
> wido@wido-desktop:~/repos/ceph$
> 
> The gmock submodule is often preventing me from switching branches.
> 
> Since I don't work with Git submodules that much I usually end up 
> removing the directory and going a submodule update.

That's what I do too.  :)  The problem is that the submodule structure 
changed after jewel.

> Is that the good way to go? And am I the only one running into this?

I just keep a separate checkout for jewel (and each other release), e.g. 

 git clone git@github.com:ceph/ceph ceph.jewel
 git clone git@github.com:ceph/ceph ceph.hammer

That reduces the amount of rebuilding I have to do (at the expense of disk 
space).

sage
