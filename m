From: Tim Flavin <tim.flavin@gmail.com>
Subject: Building and starting ceph: init-ceph and
Date: Fri, 31 Aug 2012 11:47:13 -0400
Message-ID: <CAEj+kbnh_-iO-gJJzqD=zZQ9CRv-B+goR8scJJ6Ku69ET4oy=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48167 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab2HaPrO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 11:47:14 -0400
Received: by vbbff1 with SMTP id ff1so3339128vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 08:47:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I build ceph from a tar file, currently ceph-0.48.1argonaut.   After
doing a make install, everything winds up in the right place except
for the startup file /etc/init.d/ceph.   I have to manually copy
~/ceph-0.48.1argonaut/src/init-ceph to /etc/init.d.

Also after running mkcephfs -a -c ceph.conf, the command: service ceph
start complains that ceph is not configured unless I copy ceph.conf to
/usr/local/etc/ceph/ceph.conf.  (mkcephfs copies it into
/etc/ceph.conf.

Am I confused or doing something wrong?
