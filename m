From: =?GB2312?B?wdbTycfl?= <linyouqing7@gmail.com>
Subject: what's wrong with radosgw ??
Date: Thu, 18 Aug 2011 09:01:09 +0800
Message-ID: <CADSLUZn8_sVRz=4u_mNcVZ1oE1Y85-XheoX=vgO9ZwLKVMMpxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50445 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab1HRBBK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2011 21:01:10 -0400
Received: by pzk37 with SMTP id 37so2033698pzk.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2011 18:01:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

These days, I want install radosgw on two virtual machines.
one is Centos 5.4 i386 with ceph-0.25.1 , another is fedora 14 i686
with ceph-0.32

while I input command # ./configure --with-radosgw
meet a problem:

configure: error: --with-radosgw was given but libfcgi (libfcgi-dev on
debian) not found
See `config.log' for more details.

so I input  # yum install fcgi-devel

[root@monitor2 ~]# yum list | grep fcgi
fcgi.i686                                2.4.0-15.fc15                  @fedora
fcgi-devel.i686                          2.4.0-15.fc15                  @fedora
mod_fcgid.i686                           2.3.6-3.fc15                   @fedora
spawn-fcgi.i686                          1.6.3-2.fc15                   @fedora
fcgi-perl.i686                           2.4.0-15.fc15                  fedora

[root@ceph-monitor1 ~]# yum list | grep fcgi
fcgi.i386                             2.4.0-12.el5            installed
fcgi-devel.i386                       2.4.0-12.el5            installed
fcgi-perl.i386                        2.4.0-12.el5            installed
mod_fcgid.i386                        2.2-11.el5              installed
spawn-fcgi.i386                       1.6.3-1.el5             installed

as shown above,I have install fcgi-devel in two machines, but the
problem is still unsolved.
