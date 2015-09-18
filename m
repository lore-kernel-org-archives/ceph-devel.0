From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: nginx for rgw fcgi frontend
Date: Fri, 18 Sep 2015 08:29:12 -0700
Message-ID: <CADRKj5Rzztv0Mhc9or2_iEcBzezi1UgoJVJrtAHM3ktXjS0ZOw@mail.gmail.com>
References: <06681238D8946F44A60AA400760A1CBF020D6923@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36425 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbbIRP3N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Sep 2015 11:29:13 -0400
Received: by obbmp4 with SMTP id mp4so5698818obb.3
        for <ceph-devel@vger.kernel.org>; Fri, 18 Sep 2015 08:29:12 -0700 (PDT)
In-Reply-To: <06681238D8946F44A60AA400760A1CBF020D6923@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Sep 17, 2015 at 11:38 PM, Zhou, Yuan <yuan.zhou@intel.com> wrote:
> Hi Yehuda,
>
> I was trying to do some tests on nginx over rgw and ran into some issue on the PUT side:
>
> $ swift upload con ceph_fuse.cc
> Object PUT failed: http://localhost/swift/v1/con/ceph_fuse.cc 411 Length Required   MissingContentLength
>
> However the GET/HEAD/POST requests are all working. From the history mail in ceph-user nginx should be working well. There's no such issue if switch to civetweb frontend. Is there anything changed in fcgi frontend? I'm testing on the master branch.
>
> here's the request log and the CONTENT_LENGTH is there actually.
>
> http://paste2.org/YDJFYIcp
>
>

What version are you running? Note that you're getting an
HTTP_CONTENT_LENGTH header instead of CONTENT_LENGTH header. There
should be some support for it, but on the other hand there now, but
maybe you can get nginx to send the appropriate header?

Yehuda


>
> rgw part of ceph.conf
> ....
>         rgw frontends = fastcgi
>         rgw dns name = localhost
>         rgw socket path = /var/run/ceph/ceph.radosgw.gateway.fastcgi.sock
>         rgw print continue = false
> ...
>
>
> Nginx site.conf:
>
> server {
>     listen 80;
>
>     client_max_body_size 10g;
>
>     access_log /dev/stdout;
>     error_log /dev/stderr;
>
>     location / {
>         fastcgi_pass_header Authorization;
>         fastcgi_pass_request_headers on;
>
>         if ($request_method = PUT) {
>             rewrite ^ /PUT$request_uri;
>         }
>
>         include fastcgi_params;
>
>         fastcgi_pass unix:/var/run/ceph/ceph.radosgw.gateway.fastcgi.sock;
>     }
>
>     location /PUT/ {
>         internal;
>
>         fastcgi_pass_header Authorization;
>         fastcgi_pass_request_headers on;
>
>         include fastcgi_params;
>         fastcgi_param CONTENT_LENGTH $content_length;
>         fastcgi_param HTTP_CONTENT_LENGTH $content_length;
>
>         fastcgi_pass unix:/var/run/ceph/ceph.radosgw.gateway.fastcgi.sock;
>     }
> }
>
>
>
> Sincerely, Yuan
>
