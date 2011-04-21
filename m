From: Sage Weil <sage@newdream.net>
Subject: Re: libceph API
Date: Wed, 20 Apr 2011 22:03:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51594 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab1DUFDl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 01:03:41 -0400
In-Reply-To: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org, Brian Chrisman <brchrisman@gmail.com>

On Wed, 20 Apr 2011, Colin McCabe wrote:
> Hi guys,
> 
> I pushed a branch with a revised libceph API. The main changes:
> 
> * similar appearance to librados. It should be intuitive if you've
> used librados.
> * The new API allows multiple ceph clusters to be open at once
> (although the implementation doesn't support this yet)
> * ability to pass a "root" argument to ceph_mount
> * add support for reading configuration files and choosing whether to parse argv
> * simpler ceph_getcwd
> * unmount can't fail (the library always cleans up after itself)
> 
> The branch is at
> http://ceph.newdream.net/git/?p=ceph.git;a=shortlog;h=refs/heads/libceph_api
> 
> Let me know what you think!

Can we combine the ceph_connect() and ceph_mount() into one thing?  Does 
that make sense?  If so, maybe it should be ceph_mount_t and not 
ceph_cluster_t or something.

The (re/ab)use of DIR* was possibly not the wisest choice in the original 
API (and Client.h for that matter?).  Now might be the time to use a more 
reasonably named typedef.

A few of the methods can probably go away (things like ceph_mkdirs) or be 
cleaned up (the layout get/set stuff).

Otherwise looks good!  Brian?

sage
