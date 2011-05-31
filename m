From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: cfuse and ceph.conf
Date: Tue, 31 May 2011 16:11:55 -0700
Message-ID: <20110531231155.GC12733@dreamer>
References: <4DE5613E.4010602@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:45496 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878Ab1EaXL5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2011 19:11:57 -0400
Content-Disposition: inline
In-Reply-To: <4DE5613E.4010602@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Wed, Jun 01, 2011 at 12:44:30AM +0300, Fyodor Ustinov wrote:
> As I understand with -m key cfuse should not require ceph.conf.

It does need a config, to even know whether it should attempt
cryptographic authentication or not (and where to find the key, etc).

It could be changed to do things more like the kernel client,
but as is, it always requires a config file.

> root@st8:~# cfuse -c /dev/null -m 10.5.51.230:6789 /stor01
...
> root@st8:~# ls -al /stor01/
> total 1
> drwxr-xr-x 1 root root 0 2011-06-01 00:22 .
> drwxr-xr-x 1 root root 0 2011-05-31 01:27 bbb
> root@st8:~#
> 
> P.S. BTW, where ".." directory?

Oh, heh, that's interesting.

It seems "." and ".." are optional, according to POSIX:

http://sourceforge.net/mailarchive/forum.php?thread_name=E1O3s82-0008BY-MW%40pomaz-ex.szeredi.hu&forum_name=fuse-devel

-- 
:(){ :|:&};:
