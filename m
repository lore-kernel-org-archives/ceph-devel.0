From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw boto issue
Date: Thu, 17 Jan 2013 13:47:12 -0800
Message-ID: <CAC-hyiGOdY=F7a74u=f3=BK1VH2rB15SkDG+ezALhHd04tVRZw@mail.gmail.com>
References: <50F86DA5.4070502@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:51477 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755608Ab3AQVrN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 16:47:13 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so808704iac.7
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 13:47:13 -0800 (PST)
In-Reply-To: <50F86DA5.4070502@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: derek@umiacs.umd.edu
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 17, 2013 at 1:31 PM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
> Hi,
>
> Has anyone used boto (python amazon S3 library) to upload files to
> radosgw?  I have recently upgraded to 0.56.1 and my javascript code that
> I wrote to upload from within the browser is working fine.
>
> When I use the boto library I am getting 500 errors in my apache error logs
>
> FastCGI: comm with server "/var/www/ceph/s3gw.fcgi" aborted: error
> parsing headers: duplicate header 'Status'
>
> I have captured the incoming request and it seems valid.
>
> PUT /zeta/rhel5.list HTTP/1.1
> Host: myobjstore.mydomain.com
> Accept-Encoding: identity
> Content-Length: 15909
> Content-MD5: UZj3mZeD8WbVeeqFqS81vA==
> Expect: 100-Continue
> Date: Thu, 17 Jan 2013 19:00:37 GMT
> User-Agent: Boto/2.6.0 (linux2)
> Content-Type: application/octet-stream
> Authorization: AWS ###:###
>
> Found this ticket which seems very similar but is 2 years old.
>
>   http://tracker.newdream.net/issues/439
>
> Currently radosgw does not seem to have much in the way of logging of
> the connection. It has a log file but I have never been able to get it
> to log anything.  Is there anyway to get it to spit out a bit more of
> what it is doing or what it is sending back to the client?
>

Are you using apache? What fastcgi module are you using? If it's just
a default mod_fastcgi/mod_fcgid then set the following in your
ceph.conf (under the radosgw related section):

 rgw print continue = false

Yehuda
