From: Sage Weil <sage@newdream.net>
Subject: Re: bug report: potential null deref send_mds_reconnect()
Date: Thu, 13 May 2010 21:22:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005132116580.25892@cobra.newdream.net>
References: <20100513233615.GD5695@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52724 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab0ENETc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 May 2010 00:19:32 -0400
In-Reply-To: <20100513233615.GD5695@bicker>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 14 May 2010, Dan Carpenter wrote:
> This is a Smatch thing.
> 
> fs/ceph/mds_client.c +2217 send_mds_reconnect(82) error: we previously assumed 'session' could be null.
>   2176          down_read(&mdsc->snap_rwsem);
>   2177
>   2178          if (!session)
>   2179                  goto send;
> 
> 	If we hit this goto then we will dereference session and oops.
> 
>   2180          dout("session %p state %s\n", session,
>   2181               session_state_name(session->s_state));

Yeah, this is a bit of a mess.  There is already a fix (and big cleanup of 
this function) in the unstable branch, queued up for the next merge 
window.  I forgot it's theoretically possible to hit this with the current 
code (although only with the clustered mds).  If I send a final set fixes 
for .34 I'll include something for this too...

Thanks!
sage
