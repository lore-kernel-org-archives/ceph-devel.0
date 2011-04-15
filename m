From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: vstart problem in master branch
Date: Fri, 15 Apr 2011 14:27:43 -0700
Message-ID: <20110415212743.GB31400@dreamer>
References: <B6DAFB0C-A321-499A-A21E-7CA59EFCDA5B@cs.ucsc.edu>
 <054B710EFF18497CB0B964DC9819B556@gmail.com>
 <20110331180652.GA12850@dreamer>
 <0A340955-01D3-4E72-AC72-0F9EFBC94227@cs.ucsc.edu>
 <loom.20110415T225346-950@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53377 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757129Ab1DOV1l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 17:27:41 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110415T225346-950@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ankur Kemkar <ankur.kemkar@emc.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Apr 15, 2011 at 09:02:20PM +0000, Ankur Kemkar wrote:
> sysadmin@ubuntu3:~$ mount
> /dev/sda1 on / type ext4 (rw,user_xattr,errors=remount-ro)
...
> /dev/sdb on /data/osd2 type btrfs (rw,noatime) <---  the directory is still
> empty as above. So what is this?

Quick guess -- perhaps you didn't have /data/osd2 mounted at the time
you ran mkcephfs, and the files were created in a subdirectory of your
root filesystem.

Shut down ceph, do umount /data/osd2, and ls /data/osd2; if the files
are there, then that was what happened.

-- 
:(){ :|:&};:
