From: Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] libceph: don't set memalloc flags in loopback case
Date: Thu, 2 Apr 2015 00:03:24 +0100
Message-ID: <20150401230323.GD20397@suse.de>
References: <1427908760-7083-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58135 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbbDAXDa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Apr 2015 19:03:30 -0400
Content-Disposition: inline
In-Reply-To: <1427908760-7083-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>, Sage Weil <sage@redhat.com>

On Wed, Apr 01, 2015 at 08:19:20PM +0300, Ilya Dryomov wrote:
> Following nbd and iscsi, commit 89baaa570ab0 ("libceph: use memalloc
> flags for net IO") set SOCK_MEMALLOC and PF_MEMALLOC flags for rbd and
> cephfs.  However it turned out to not play nice with loopback scenario,
> leading to lockups with a full socket send-q and empty recv-q.
> 
> While we always advised against colocating kernel client and ceph
> servers on the same box, a few people are doing it and it's also useful
> for light development testing, so rather than reverting make sure to
> not set those flags in the loopback case.
> 

This does not clarify why the non-loopback case needs access to pfmemalloc
reserves. Granted, I've spent zero time on this but it's really unclear
what problem was originally tried to be solved and why dirty page limiting
was insufficient. Swap over NFS was always a very special case minimally
because it's immune to dirty page throttling.
