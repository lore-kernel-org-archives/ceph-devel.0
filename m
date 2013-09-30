From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] fix librados aio read buffer handling
Date: Mon, 30 Sep 2013 08:38:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309300834080.12714@cobra.newdream.net>
References: <l2bire$iue$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53900 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073Ab3I3Pik (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Sep 2013 11:38:40 -0400
In-Reply-To: <l2bire$iue$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>, josh.durgin@inktank.com
Cc: ceph-devel@vger.kernel.org

On Mon, 30 Sep 2013, Rutger ter Borg wrote:
> 
> Dear all,
> 
> please find attached a patch that enables a user to pass user-owned buffers
> into librados' aio_read. The patch (against dumpling) removes the buf and pbl
> data members in AioCompletionImpl.
> 
> * The 'buf' argument to read() used to be passed into AioCompletionImpl, and
> the results would be copied back after reading. This is replaced with the
> creation of a static buffer of that buf.
> 
> * The pbl argument in AioCompletionImpl is removed.
> 
> The patch is tested against an application using librados. I've assumed that
> 'pbl' in
> 
> aio_read( ...., pbl, )
> 
> is allocated by the user. It may even speed things up: a buffer copy is
> prevented.

I am a little worried that one path of aio_read uses c->bl and the other 
doesn't, but that probably is no big deal provided it is noted in the 
structure definition.

My larger concern is that we're about to do some major changes in the 
messenger and other code to use splice/tee/vmsplice to avoid copies 
to/from userspace when possible.  That will involve removing some of the 
currently 'use the existing buffer' code.  I'm hoping it will work out 
that in the librados case we just carry the kernel pages around a bit 
longer and delay the final copy into userspace, but it's hard to say until 
the code gets written.  Josh plans to start working on it this week.

Josh, do you think we should apply this now or wait until we see where 
things end up?

sage
