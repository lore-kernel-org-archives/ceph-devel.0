From: biyan chen <riby.chen@gmail.com>
Subject: mkcephfs read_conf: failed to open 'ceph.conf': error 2:
Date: Thu, 9 Jun 2011 13:47:29 +0800
Message-ID: <BANLkTi=3YCqbS48QWxO1JJwGqkU+bMVv6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54009 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab1FIFra convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2011 01:47:30 -0400
Received: by ywe9 with SMTP id 9so566314ywe.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Jun 2011 22:47:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In v0.29 released

I create cluster

mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs -k /etc/ceph/keyri=
ng.bin

Error message :

Building generic osdmap /tmp/mkcephfs.HIn0VHZeWw/conf
 highest numbered osd in /tmp/mkcephfs.HIn0VHZeWw/conf is osd.1
 num osd =3D 2
2011-06-09 13:38:19.392016 7fddd3b32720 Errors while parsing config fil=
e!
2011-06-09 13:38:19.392122 7fddd3b32720 read_conf: failed to open
'ceph.conf': error 2: No such file or directory
/usr/local/bin/osdmaptool: osdmap file '/tmp/mkcephfs.HIn0VHZeWw/osdmap=
'
/usr/local/bin/osdmaptool: writing epoch 1 to /tmp/mkcephfs.HIn0VHZeWw/=
osdmap
Generating admin key at /tmp/mkcephfs.HIn0VHZeWw/keyring.admin
creating /tmp/mkcephfs.HIn0VHZeWw/keyring.admin

Open files mkcephfs in /etc/init.d/

In the first 342 line
"	$BINDIR/osdmaptool --createsimple $numosd $dir/osdmap -c ceph.conf "

Why is ceph. confg rather than $ceph.conf ? When modifying after, can
build a cluster of success


Thanks=A3=A1
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
