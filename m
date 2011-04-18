From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: mount.ceph: modprobe failed, exit status 127
Date: Mon, 18 Apr 2011 09:28:42 -0700
Message-ID: <20110418162842.GA12900@dreamer>
References: <4DA82A9E.5010504@science-computing.de>
 <4DA8409E.9000808@provocation.net>
 <20110415164315.GA31400@dreamer>
 <loom.20110418T134530-94@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42814 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab1DRQ2m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 12:28:42 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110418T134530-94@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Raible <c.raible@science-computing.de>
Cc: ceph-devel@vger.kernel.org

On Mon, Apr 18, 2011 at 11:50:51AM +0000, Christoph Raible wrote:
> Hi I tried both with root and with a "normal" user.
> 
> Both had the same fault. My PATH-Variable looks like this:
> 
> /usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:
> /bin:/usr/sbin:/usr/bin:/root/bin

I see your PATH has /sbin in it, which is where modprobe is normally
installed. That should work..

Try this as root:

strace -f -o ceph-mount-strace mount -t ceph 10.1.9.46:/ /mnt/ceph

(or whatever your mount command was) and upload the ceph-mount-strace
file somewhere, e.g. pastebin.com. It shouldn't contain anything
secret, in this case.

-- 
:(){ :|:&};:
