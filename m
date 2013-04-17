From: proguest <proguest1942@hotmail.com>
Subject: Re: rados gateway
Date: Wed, 17 Apr 2013 16:33:53 +0000 (UTC)
Message-ID: <loom.20130417T183106-585@post.gmane.org>
References: <loom.20130417T164538-81@post.gmane.org> <CABBk=J8-H9DYTcdca1OjqA5X1q_Zs1oOhjEUDZJVpJSfYx6kNw@mail.gmail.com> <loom.20130417T170632-546@post.gmane.org> <CABBk=J_evJc11twOEgBN51SPq9v_aiSyf=OzYW2i9Ghd5oFhBA@mail.gmail.com> <loom.20130417T172954-546@post.gmane.org> <CABBk=J8o83Srortoe_ouR3jZX7ObtgZ+yEhez5Cz24o-2EK2jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48000 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab3DQQeH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Apr 2013 12:34:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1USVJ8-00020L-It
	for ceph-devel@vger.kernel.org; Wed, 17 Apr 2013 18:34:06 +0200
Received: from 114-44-219-144.dynamic.hinet.net ([114.44.219.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 18:34:06 +0200
Received: from proguest1942 by 114-44-219-144.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 18:34:06 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Yehuda Sadeh <yehuda <at> inktank.com> writes:

> 
> On Wed, Apr 17, 2013 at 8:33 AM, proguest <proguest1942 <at> hotmail.com> 
wrote:
> > Yehuda Sadeh <yehuda <at> inktank.com> writes:
> >
> >>
> >> On Wed, Apr 17, 2013 at 8:13 AM, proguest <proguest1942 <at> 
hotmail.com>
> > wrote:
> >> > Yehuda Sadeh <yehuda <at> inktank.com> writes:
> >> >
> >> >>
> >> >> Hard to know without additional info. It looks though as you might
> >> >> have apache config issues (if you're using apache).
> >> >>
> >> >> Yehuda
> >> > hi Yehuda
> >> >
> >> > thanks for replied me.
> >> > It's only stardard setting with radosgw document.
> >> > here's /etc/apache2/httpd.conf  only 1 line
> >> >
> >> > ServerName node74
> >> >
> >> > and here's /etc/apache2/sites-enabled  (just follow the website)
> >>
> >> is that the actual file name, or is that the directory where this
> >> config file resides? do you have by any chance another default web
> >> site set up under sites-enabled? did you restart apache after
> >> configuring?
> > I missed. It's /etc/apache2/sites-enabled/rgw.conf
> > The document said
> > #sudo a2ensite rgw.conf
> > #sudo a2dissite default
> > so there's only one configure in sites-enabled
> >
> did you restart apache after reconfiguring it?
Yeap, I always restart ceph apache2 radosgw after modified the file


by the way, I found apache error.log has something wrong while start apache

[Wed Apr 17 16:53:59 2013] [notice] caught SIGTERM, shutting down
[Wed Apr 17 16:53:59 2013] [alert] FastCGI: read() from pipe failed (0)
[Wed Apr 17 16:53:59 2013] [alert] FastCGI: the PM is shutting down, Apache 
seems to have disappeared - bye
[Wed Apr 17 16:54:00 2013] [notice] FastCGI: process manager initialized 
(pid 4768)
[Wed Apr 17 16:54:00 2013] [notice] Apache/2.2.17 (Ubuntu) 
mod_fastcgi/mod_fastcgi-SNAP-0910052141 mod_ssl/2.2.17 OpenSSL/0.9.8o 
configured -- resuming normal operations

But I don't know what is it means?
I think s3gw.fcgi is right, and I also enable fastcgi in apache2



