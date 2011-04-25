From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: v0.27 released
Date: Mon, 25 Apr 2011 09:56:54 -0700
Message-ID: <20110425165654.GC23965@dreamer>
References: <Pine.LNX.4.64.1104232136330.9549@cobra.newdream.net>
 <BANLkTikwGrOX1SHLgcC4RPJ=n7OFQfajCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60650 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab1DYQ4V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Apr 2011 12:56:21 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikwGrOX1SHLgcC4RPJ=n7OFQfajCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Sun, Apr 24, 2011 at 11:55:33PM +1200, DongJin Lee wrote:
> In v0.27
> When I run mkcephfs -c -a, I get
> 
> temp dir is /tmp/mkcephfs.Mts3TZhEwG
> preparing monmap in /tmp/mkcephfs.Mts3TZhEwG/monmap
> /usr/local/bin/monmaptool --create --clobber --add 0 --print
> /tmp/mkcephfs.Mts3TZhEwG/monmap
> /usr/local/bin/monmaptool: invalid ip:port '--print'
> rm: cannot remove `/tmp/mkcephfs.Mts3TZhEwG/*': No such file or directory
> 
> and so I cannot start ceph up. But It was working till v0.26. Thanks

It seems you have a monitor defined without "mon addr" set in the
config file.

mkcephfs could use better error handling; I'll add that.

-- 
:(){ :|:&};:
