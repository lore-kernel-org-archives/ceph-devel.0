From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: mount.ceph: modprobe failed, exit status 127
Date: Fri, 15 Apr 2011 09:43:15 -0700
Message-ID: <20110415164315.GA31400@dreamer>
References: <4DA82A9E.5010504@science-computing.de>
 <4DA8409E.9000808@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37291 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab1DOQnS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 12:43:18 -0400
Content-Disposition: inline
In-Reply-To: <4DA8409E.9000808@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Apr 15, 2011 at 02:57:02PM +0200, Zenon Panoussis wrote:
> > Now when I want to mount a Ceph filesystem with
> >     mount -t ceph 10.1.9.46:/ /mnt/ceph
> > I got following error:
> >     "mount.ceph: modprobe failed, exit status 127"
> 
> Since ceph and libceph are already in the kernel, it seems logical that loading
> them would fail; after all, there are no modules to be loaded. Then again, it
> doesn't make sense that mount tries to load them anyway and fails.

If modprobe didn't find the module, he'd be getting exit status 1.

If ceph was built-in to the kernel, modprobe would see that and claim
success.

Exit status 127 means the command was not found; for some reason, the
executable "modprobe" is not in PATH when mount.ceph is run.

Are you perhaps trying to mount as non-root? That's not going to work.

-- 
:(){ :|:&};:
