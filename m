From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Creating the filesystem and tweaking configurations
Date: Mon, 28 Mar 2011 16:49:56 -0700
Message-ID: <20110328234956.GA32587@dreamer>
References: <loom.20110328T213028-664@post.gmane.org>
 <Pine.LNX.4.64.1103281340050.20362@cobra.newdream.net>
 <AANLkTimJn0kp4e=CKKdx2g=fDD-JpDPgXwvMqCxFJc8F@mail.gmail.com>
 <20110328212124.GC10768@dreamer>
 <AANLkTinjhwqzLs8PLUdnJLAPXwvT-6yRE=6QAx1eE9Xk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38595 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab1C1XuB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 19:50:01 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinjhwqzLs8PLUdnJLAPXwvT-6yRE=6QAx1eE9Xk@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steena Monteiro <steena.m@aggiemail.usu.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Mon, Mar 28, 2011 at 04:33:57PM -0600, Steena Monteiro wrote:
> Thanks, that worked. However, I'm getting a mount error now when I'm finally
> trying to mount the ceph file system.
> 
> sudo mount -t ceph 127.0.0.1:/ /ceph
> mount error 5 = Input/output error
> 
> Inspite of this, I can still see data move around with ceph -w ...

Input/output error is the generic "I couldn't talk to the server"
error message from Ceph mounts, there are multiple reasons for it.
Perhaps there is something useful in the kernel logs, see
/var/log/kern.log. You may have for example configured the server to
demand authentication, and the above mount line is without
authentication.

What you see with ceph -w is the clusters internal heartbeat etc
traffic.


Also, note that we don't recommend using the kernel client on the same
machine that is serving the Ceph cluster -- there are known deadlocks
there, under memory pressure, unrelated to Ceph (NFS would trigger the
same problem). Cfuse should be safe.

-- 
:(){ :|:&};:
