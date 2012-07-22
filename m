From: Jonathan Proulx <jon@jonproulx.com>
Subject: getting started with RADOSGW
Date: Sun, 22 Jul 2012 10:43:14 -0400
Message-ID: <CABZB-shn=RtKNFyXEaK5difh=NTfUVzgiF7DGJ8fJJSGO+5pFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36198 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab2GVOnP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Jul 2012 10:43:15 -0400
Received: by obbuo13 with SMTP id uo13so8010207obb.19
        for <ceph-devel@vger.kernel.org>; Sun, 22 Jul 2012 07:43:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

I've created a testuser with testuser:swift subuser, setup apache with
fcgi but client access with either S3 or Swift clients result in HTTP
500 errors on the server:

[Sun Jul 22 10:14:33 2012] [error] [client 128.52.x.x] (2)No such file
or directory: FastCGI: failed to connect to server
"/var/www/s3gw.fcgi": connect() failed
[Sun Jul 22 10:14:33 2012] [error] [client 128.52.x.x] FastCGI:
incomplete headers (0 bytes) received from server "/var/www/s3gw.fcgi"


 ls -lh /var/www/s3gw.fcgi
-rwxrwxr-x 1 root root 79 Jul 10 10:28 /var/www/s3gw.fcgi

cat /var/www/s3gw.fcgi
#!/bin/sh
exec /usr/bin/radosgw -c /etc/ceph/ceph.conf -n client.rados.gateway

/usr/bin/radosgw is in the right place and executable by all
/etc/ceph/ceph.conf is also in the correct location and readable by
all, so I'm a bit confused by the "No such file or directory" error.

I *think* I've followed all the steps but have obviously missed
something, any idea what?

Thanks,
-Jon
