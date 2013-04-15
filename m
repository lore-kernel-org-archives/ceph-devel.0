From: proguest <proguest1942@hotmail.com>
Subject: Re: ceph radosgw cannot work
Date: Mon, 15 Apr 2013 18:17:52 +0000 (UTC)
Message-ID: <loom.20130415T201144-963@post.gmane.org>
References: <loom.20130413T170940-905@post.gmane.org> <CAC-hyiFe-TgkHYNbXvvZc-7N9Vs7DJVj1yEArSvDBxgoyGvRKg@mail.gmail.com> <loom.20130414T064556-851@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46341 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755931Ab3DOSSQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 15 Apr 2013 14:18:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1URnyh-0000QY-FU
	for ceph-devel@vger.kernel.org; Mon, 15 Apr 2013 20:18:08 +0200
Received: from 114-44-229-246.dynamic.hinet.net ([114.44.229.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 20:18:07 +0200
Received: from proguest1942 by 114-44-229-246.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 20:18:07 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

proguest <proguest1942 <at> hotmail.com> writes:

> 
> Yehuda Sadeh <yehuda <at> inktank.com> writes:
> 
> > 
> > On Sat, Apr 13, 2013 at 8:20 AM, proguest <proguest1942 <at> 
hotmail.com> 
> wrote:
> > 
> > try:
> > 
> > # radosgw -n client.radosgw.gateway
> > 
> > 
> > swift -A http://node71/auth ...
> I tried, but it replied:
> 
> Auth GET failed: http://node71:80/auth 404 Not Found
> > 
> 
> > 
> > Nope, wouldn't work. You need to point it at your web server.
> I don't get understand...
> what is 'point it at my web server'
> I follow by the step on website, use s3gw.fcgi on apache server to build
> a virtual host. Is this the step to point the ceph at my web server?
> 
> How can i use restful with swift API?
> 
> sorry, i'm a beginner in ceph :(
> 
> thank you for reply my question!!
> > 
> 
> > 
> > Yehuda
I tried a lot recently, but still cannot fix the problems.
I don't know how to do now...

#swift -A http://node71/auth -U richard:swift -K 
0OZ4dUcgCIvpucKRNixG1nkoe+RXncngj3Kfo6DE post test

only reply Auth GET failed: http://node71:80/auth 404 Not Found

and #swift -A http://node71 -U richard:swift -K 
0OZ4dUcgCIvpucKRNixG1nkoe+RXncngj3Kfo6DE post test

only reply 
Traceback (most recent call last):
  File "/usr/bin/swift", line 1853, in <module>
    error_queue)
  File "/usr/bin/swift", line 1533, in st_post
    conn.post_container(args[0], headers=headers)
  File "/usr/bin/swift", line 853, in post_container
    return self._retry(None, post_container, container, headers)
  File "/usr/bin/swift", line 790, in _retry
    self.http_conn = self.http_connection()
  File "/usr/bin/swift", line 778, in http_connection
    return http_connection(self.url)
  File "/usr/bin/swift", line 163, in http_connection
    parsed = urlparse(url)
  File "/usr/lib/python2.7/urlparse.py", line 135, in urlparse
    tuple = urlsplit(url, scheme, allow_fragments)
  File "/usr/lib/python2.7/urlparse.py", line 174, in urlsplit
    i = url.find(':')
AttributeError: 'NoneType' object has no attribute 'find'

apache error.log:
[Tue Apr 16 01:47:20 2013] [notice] caught SIGTERM, shutting down
[Tue Apr 16 01:47:20 2013] [alert] FastCGI: read() from pipe failed (0)
[Tue Apr 16 01:47:20 2013] [alert] FastCGI: the PM is shutting down, Apache 
seems to have disappeared - bye
[Tue Apr 16 01:47:21 2013] [notice] FastCGI: process manager initialized 
(pid 29952)
[Tue Apr 16 01:47:21 2013] [notice] Apache/2.2.20 (Ubuntu) 
mod_fastcgi/mod_fastcgi-SNAP-0910052141 mod_ssl/2.2.20 OpenSSL/1.0.0e 
configured -- resuming normal operations

I dont know what's it means.
Can someone help me to fix it :(


