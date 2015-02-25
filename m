From: Tom Deneau <tom.deneau@amd.com>
Subject: Re: [ceph-users] who is using radosgw with civetweb?
Date: Wed, 25 Feb 2015 22:50:13 +0000 (UTC)
Message-ID: <loom.20150225T233013-453@post.gmane.org>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net> <CAANLjFpHND2uyUvdzJ-pz4QOXp6SpYK=sD1WQz=rT-Two6izqw@mail.gmail.com> <alpine.DEB.2.00.1502251348170.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47519 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbbBYWzH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Feb 2015 17:55:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YQkr9-0001lz-DO
	for ceph-devel@vger.kernel.org; Wed, 25 Feb 2015 23:55:04 +0100
Received: from 165.204.77.1 ([165.204.77.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 23:55:03 +0100
Received: from tom.deneau by 165.204.77.1 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 23:55:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sweil <at> redhat.com> writes:

> 
> On Wed, 25 Feb 2015, Robert LeBlanc wrote:
> > We tried to get radosgw working with Apache + mod_fastcgi, but due to
> > the changes in radosgw, Apache, mode_*cgi, etc and the documentation
> > lagging and not having a lot of time to devote to it, we abandoned it.
> > Where it the documentation for civetweb? If it is appliance like and
> > easy to set-up, we would like to try it to offer some feedback on your
> > question.
> 
> In giant and hammer, it is enabled by default on port 7480.  On firefly, 
> you need to add the line
> 
>  rgw frontends = fastcgi, civetweb port=7480
> 
> to ceph.conf (you can of course adjust the port number if you like) and 
> radosgw will run standalone w/ no apache or anything else.
> 
> sage
> 

Like Robert, I have had trouble getting the gateway working with the Apache
methods.  So civetweb is something we would like to try.

I am running 0.92 built from sources using rpmbuild.  (This is on arm64). 
So I assume I do not need any rgw frontends line in ceph.conf.

It would be good to document what steps from
http://docs.ceph.com/docs/master/radosgw/config/ are still required when
using civetweb.

-- Tom



