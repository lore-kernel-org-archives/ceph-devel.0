From: proguest <proguest1942@hotmail.com>
Subject: Re: rados gateway
Date: Wed, 17 Apr 2013 15:46:19 +0000 (UTC)
Message-ID: <loom.20130417T174440-91@post.gmane.org>
References: <loom.20130417T164538-81@post.gmane.org> <CABBk=J8-H9DYTcdca1OjqA5X1q_Zs1oOhjEUDZJVpJSfYx6kNw@mail.gmail.com> <loom.20130417T170632-546@post.gmane.org> <CABBk=J_evJc11twOEgBN51SPq9v_aiSyf=OzYW2i9Ghd5oFhBA@mail.gmail.com> <loom.20130417T172954-546@post.gmane.org> <CABBk=J8o83Srortoe_ouR3jZX7ObtgZ+yEhez5Cz24o-2EK2jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35502 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965236Ab3DQPqd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Apr 2013 11:46:33 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1USUZ3-0005Ca-EC
	for ceph-devel@vger.kernel.org; Wed, 17 Apr 2013 17:46:29 +0200
Received: from 114-44-219-144.dynamic.hinet.net ([114.44.219.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 17:46:29 +0200
Received: from proguest1942 by 114-44-219-144.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 17:46:29 +0200
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
> > I missed. It's /etc/apache2/sites-enabled/rgw.conf
> > The document said
> > #sudo a2ensite rgw.conf
> > #sudo a2dissite default
> > so there's only one configure in sites-enabled
> >
> did you restart apache after reconfiguring it?
Yeap, I restart radosgw ceph apache2 every time I changed configures 



