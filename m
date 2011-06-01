From: Sage Weil <sage@newdream.net>
Subject: Re: cfuse and ceph.conf
Date: Tue, 31 May 2011 21:18:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105312115330.21311@cobra.newdream.net>
References: <4DE5613E.4010602@ufm.su> <20110531231155.GC12733@dreamer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52286 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab1FAEQk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 00:16:40 -0400
In-Reply-To: <20110531231155.GC12733@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

On Tue, 31 May 2011, Tommi Virtanen wrote:
> On Wed, Jun 01, 2011 at 12:44:30AM +0300, Fyodor Ustinov wrote:
> > As I understand with -m key cfuse should not require ceph.conf.
> 
> It does need a config, to even know whether it should attempt
> cryptographic authentication or not (and where to find the key, etc).
> 
> It could be changed to do things more like the kernel client,
> but as is, it always requires a config file.
> 
> > root@st8:~# cfuse -c /dev/null -m 10.5.51.230:6789 /stor01
> ...
> > root@st8:~# ls -al /stor01/
> > total 1
> > drwxr-xr-x 1 root root 0 2011-06-01 00:22 .
> > drwxr-xr-x 1 root root 0 2011-05-31 01:27 bbb
> > root@st8:~#
> > 
> > P.S. BTW, where ".." directory?
> 
> Oh, heh, that's interesting.
> 
> It seems "." and ".." are optional, according to POSIX:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_name=E1O3s82-0008BY-MW%40pomaz-ex.szeredi.hu&forum_name=fuse-devel

I couldn't figure out how to make a (correct) .. when writing the 
original fuse glue layer way back when.

Hmm, it looks like sshfs generates one, so it's at lesat possible.  It's 
probably simple enough to fix.

sage
