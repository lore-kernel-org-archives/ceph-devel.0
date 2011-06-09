From: Sage Weil <sage@newdream.net>
Subject: Re: mkcephfs read_conf: failed to open 'ceph.conf': error 2:
Date: Thu, 9 Jun 2011 09:00:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106090900370.28051@cobra.newdream.net>
References: <BANLkTi=3YCqbS48QWxO1JJwGqkU+bMVv6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55956 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab1FIP6y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2011 11:58:54 -0400
In-Reply-To: <BANLkTi=3YCqbS48QWxO1JJwGqkU+bMVv6g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 9 Jun 2011, biyan chen wrote:

> In v0.29 released
> 
> I create cluster
> 
> mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs -k /etc/ceph/keyring.bin
> 
> Error message :
> 
> Building generic osdmap /tmp/mkcephfs.HIn0VHZeWw/conf
>  highest numbered osd in /tmp/mkcephfs.HIn0VHZeWw/conf is osd.1
>  num osd = 2
> 2011-06-09 13:38:19.392016 7fddd3b32720 Errors while parsing config file!
> 2011-06-09 13:38:19.392122 7fddd3b32720 read_conf: failed to open
> 'ceph.conf': error 2: No such file or directory
> /usr/local/bin/osdmaptool: osdmap file '/tmp/mkcephfs.HIn0VHZeWw/osdmap'
> /usr/local/bin/osdmaptool: writing epoch 1 to /tmp/mkcephfs.HIn0VHZeWw/osdmap
> Generating admin key at /tmp/mkcephfs.HIn0VHZeWw/keyring.admin
> creating /tmp/mkcephfs.HIn0VHZeWw/keyring.admin
> 
> Open files mkcephfs in /etc/init.d/
> 
> In the first 342 line
> "	$BINDIR/osdmaptool --createsimple $numosd $dir/osdmap -c ceph.conf "
> 
> Why is ceph. confg rather than $ceph.conf ? When modifying after, can
> build a cluster of success

I pushed a fix for this to the stable branch, commit
7a5201e4b4a1f3fa97ff24ea10afd3815bfa1c8b.

Thanks!
sage
