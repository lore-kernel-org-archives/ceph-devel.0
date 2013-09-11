From: David Disseldorp <ddiss@suse.de>
Subject: Re: ocfs2 for OSDs?
Date: Wed, 11 Sep 2013 21:55:11 +0200
Message-ID: <20130911215511.3ae4e85a@plati.site>
References: <CAE63xUNKj7JnU_Kypnh39j4z6qVPh2ZLCdiEvfis3_9fDBZ2FA@mail.gmail.com>
	<alpine.DEB.2.00.1309110916180.23522@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57938 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754387Ab3IKTzR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Sep 2013 15:55:17 -0400
In-Reply-To: <alpine.DEB.2.00.1309110916180.23522@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ugis <ugis22@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Sage,

On Wed, 11 Sep 2013 09:18:13 -0700 (PDT)
Sage Weil <sage@inktank.com> wrote:

> > REFLINKs (inode-based writeable snapshots)  
> 
> This is the one item on this list I see that the ceph-osds could take real 
> advantage of; it would make object clones triggered by things like RBD 
> snapshots faster.  What is missing from this list that would be similarly 
> (or more) useful is a volume/fs snapshot feature.

I must be missing something here, but I don't see how this would offer
any advantage over Btrfs, which provides the same feature via
BTRFS_IOC_CLONE and BTRFS_IOC_CLONE_RANGE.

Cheers, David
