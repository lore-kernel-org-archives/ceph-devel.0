From: Sage Weil <sage@inktank.com>
Subject: Re: test osd on zfs
Date: Wed, 17 Apr 2013 08:19:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net>
References: <516E7D5C.7080309@nazarianin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33508 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab3DQPTw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 11:19:52 -0400
In-Reply-To: <516E7D5C.7080309@nazarianin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksey Leonov <aleonov@nazarianin.com>
Cc: ceph-devel@vger.kernel.org

Hey,

Can you test with the wip-debug-xattr branch?  Set debug filestore = 30 
and it will dump the xattr values to the log on set and get, so we can see 
what is going on.

Also/alternatively, strace with -f -v -x, which will (I think) include the 
full value of the get/setxattr args..

Thanks!
sage


On Wed, 17 Apr 2013, Aleksey Leonov wrote:

>      Hi all,
> 
>      I create test VM for try run ceph osd on zfs.
>      mkcephfs run ok. Osd down 2 minutes after start.
> 
> ceph.conf
> [global]
>          max open files = 131072
>          log file = /var/log/ceph/$name.log
>          pid file = /var/run/ceph/$name.pid
> [mon]
>          mon data = /ceph/mon/$name
> [mon.alpha]
>          host = ct1
>          mon addr = 10.10.10.2:6789
> [mds]
> [mds.alpha]
>          host = ct1
> [osd]
>          debug filestore = 20
>          filestore xattr use omap = true
>          osd data = /ceph/osd/$name
>          osd journal = /ceph/osd/$name/journal
>          osd journal size = 2000 ; journal size, in megabytes
>          journal dio = false
>          journal aio = false
> 
> [osd.0]
>          host = ct1
> 
> 
> 
> 
> 
