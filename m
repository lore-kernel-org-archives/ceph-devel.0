From: proguest <proguest1942@hotmail.com>
Subject: Re: ceph radosgw cannot work
Date: Sun, 14 Apr 2013 04:50:18 +0000 (UTC)
Message-ID: <loom.20130414T064556-851@post.gmane.org>
References: <loom.20130413T170940-905@post.gmane.org> <CAC-hyiFe-TgkHYNbXvvZc-7N9Vs7DJVj1yEArSvDBxgoyGvRKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54289 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718Ab3DNEuf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 14 Apr 2013 00:50:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1UREtd-0003MH-IK
	for ceph-devel@vger.kernel.org; Sun, 14 Apr 2013 06:50:34 +0200
Received: from 114-44-229-246.dynamic.hinet.net ([114.44.229.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 14 Apr 2013 06:50:33 +0200
Received: from proguest1942 by 114-44-229-246.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 14 Apr 2013 06:50:33 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Yehuda Sadeh <yehuda <at> inktank.com> writes:

> 
> On Sat, Apr 13, 2013 at 8:20 AM, proguest <proguest1942 <at> hotmail.com> 
wrote:
> 
> try:
> 
> # radosgw -n client.radosgw.gateway
> 

> 
> swift -A http://node71/auth ...
I tried, but it replied:

Auth GET failed: http://node71:80/auth 404 Not Found
> 

> 
> Nope, wouldn't work. You need to point it at your web server.
I don't get understand...
what is 'point it at my web server'
I follow by the step on website, use s3gw.fcgi on apache server to build
a virtual host. Is this the step to point the ceph at my web server?

How can i use restful with swift API?

sorry, i'm a beginner in ceph :(

thank you for reply my question!!
> 

> 
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 



