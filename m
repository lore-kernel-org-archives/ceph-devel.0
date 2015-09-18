From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: nginx for rgw fcgi frontend
Date: Fri, 18 Sep 2015 06:38:53 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF020D6923@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22324 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbbIRGjS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Sep 2015 02:39:18 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Yehuda Sadeh-Weinraub' <yehuda@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: "Zhou, Yuan" <yuan.zhou@intel.com>

Hi Yehuda,

I was trying to do some tests on nginx over rgw and ran into some issue=
 on the PUT side:

$ swift upload con ceph_fuse.cc
Object PUT failed: http://localhost/swift/v1/con/ceph_fuse.cc 411 Lengt=
h Required =A0 MissingContentLength

However the GET/HEAD/POST requests are all working. From the history ma=
il in ceph-user nginx should be working well. There's no such issue if =
switch to civetweb frontend. Is there anything changed in fcgi frontend=
? I'm testing on the master branch.

here's the request log and the CONTENT_LENGTH is there actually.

http://paste2.org/YDJFYIcp



rgw part of ceph.conf
=2E...
=A0 =A0 =A0 =A0 rgw frontends =3D fastcgi
=A0 =A0 =A0 =A0 rgw dns name =3D localhost
=A0 =A0 =A0 =A0 rgw socket path =3D /var/run/ceph/ceph.radosgw.gateway.=
fastcgi.sock
=A0 =A0 =A0 =A0 rgw print continue =3D false
=2E..


Nginx site.conf:

server {
=A0 =A0 listen 80;

=A0 =A0 client_max_body_size 10g;

=A0 =A0 access_log /dev/stdout;
=A0 =A0 error_log /dev/stderr;

=A0 =A0 location / {
=A0 =A0 =A0 =A0 fastcgi_pass_header Authorization;
=A0 =A0 =A0 =A0 fastcgi_pass_request_headers on;

=A0 =A0 =A0 =A0 if ($request_method =3D PUT) {
=A0 =A0 =A0 =A0 =A0 =A0 rewrite ^ /PUT$request_uri;
=A0 =A0 =A0 =A0 }

=A0 =A0 =A0 =A0 include fastcgi_params;

=A0 =A0 =A0 =A0 fastcgi_pass unix:/var/run/ceph/ceph.radosgw.gateway.fa=
stcgi.sock;
=A0 =A0 }

=A0 =A0 location /PUT/ {
=A0 =A0 =A0 =A0 internal;

=A0 =A0 =A0 =A0 fastcgi_pass_header Authorization;
=A0 =A0 =A0 =A0 fastcgi_pass_request_headers on;

=A0 =A0 =A0 =A0 include fastcgi_params;
=A0 =A0 =A0 =A0 fastcgi_param CONTENT_LENGTH $content_length;
=A0 =A0 =A0 =A0 fastcgi_param HTTP_CONTENT_LENGTH $content_length;

=A0 =A0 =A0 =A0 fastcgi_pass unix:/var/run/ceph/ceph.radosgw.gateway.fa=
stcgi.sock;
=A0 =A0 }
}



Sincerely, Yuan

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
