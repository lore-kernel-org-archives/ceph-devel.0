From: Sage Weil <sage@newdream.net>
Subject: Re: read performance not perfect
Date: Thu, 4 Aug 2011 12:53:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108041252230.26398@cobra.newdream.net>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>
 <Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>
 <CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com>
 <Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>
 <loom.20110804T213454-854@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35320 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab1HDTss (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2011 15:48:48 -0400
In-Reply-To: <loom.20110804T213454-854@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Thu, 4 Aug 2011, Fyodor Ustinov wrote:
> Sage Weil <sage <at> newdream.net> writes:
> 
> > 
> > Hi,
> > 
> > I've just pushed a wip-readahead branch to ceph-client.git that rewrites 
> > ceph_readpages (used for readahead) to be fully asynchronous.  This should 
> > let us take full advantage of whatever the readahead window is.  I'm still 
> > doing some testing on this end, but things look good so far.
> 
> As I understand it's available only in kernel 3.1 ?

The current patches are on top of v3.0, but you should be able to rebase 
the readahead stuff on top of anything reasonably recent.

sage
