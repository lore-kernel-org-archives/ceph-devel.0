From: Sage Weil <sage@inktank.com>
Subject: Re: Building and starting ceph: init-ceph and
Date: Fri, 31 Aug 2012 09:12:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208310910590.1531@cobra.newdream.net>
References: <CAEj+kbnh_-iO-gJJzqD=zZQ9CRv-B+goR8scJJ6Ku69ET4oy=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47231 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab2HaQMc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 12:12:32 -0400
In-Reply-To: <CAEj+kbnh_-iO-gJJzqD=zZQ9CRv-B+goR8scJJ6Ku69ET4oy=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Flavin <tim.flavin@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 31 Aug 2012, Tim Flavin wrote:
> I build ceph from a tar file, currently ceph-0.48.1argonaut.   After
> doing a make install, everything winds up in the right place except
> for the startup file /etc/init.d/ceph.   I have to manually copy
> ~/ceph-0.48.1argonaut/src/init-ceph to /etc/init.d.

'make install' doesn't install it because it's system-dependent 
(/etc/init.d on debian, /etc/rc.d/init.d or something like that on redhat, 
etc.).  

> Also after running mkcephfs -a -c ceph.conf, the command: service ceph
> start complains that ceph is not configured unless I copy ceph.conf to
> /usr/local/etc/ceph/ceph.conf.  (mkcephfs copies it into
> /etc/ceph.conf.

./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --sbindir=/sbin

sage


> Am I confused or doing something wrong?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
