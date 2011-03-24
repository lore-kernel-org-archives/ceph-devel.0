From: huang jun <hjwsm1989@gmail.com>
Subject: a question about laggy mds
Date: Thu, 24 Mar 2011 10:18:37 +0800
Message-ID: <AANLkTikFcmEcyEjoVcT_s-3dTvqLsiy8MhmXW-ZSD6to@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40737 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915Ab1CXCSi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2011 22:18:38 -0400
Received: by vws1 with SMTP id 1so6154994vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 19:18:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all=A3=AC
There are two mds in the ceph cluster=A3=ACone is active and the other =
is
standby.  In my test,  I found the mds0 was marked as laggy, and it
was taken over by the standby soon. And it will take a long time for
the standby to become active if there are a great many of requests
from the client. I want to know under what circumstances mds would be
marked as laggy.
Here is my software version and ceph.conf.
Ceph version 0.24.3
Linux kernel 2.6.35.9

 Ceph.conf
    [global]
       pid file =3D  ar/run/ceph/$name.pid
       debug ms =3D 1
[mon]
        mon data =3D /data/mon$id
[mon.0]
       host =3D ceph1
        mon addr =3D 192.168.1.101:6789
[mds]
      debug ms =3D 1
      debug mds =3D 10
      debug mds balancer =3D 10
      debug mds log =3D 10
      debug mds_migrator =3D 10
      debug monc =3D 10
[mds0]
        host =3D ceph1
[mds1]
        host =3D ceph2
 [osd]
        sudo =3D true
        osd data =3D /data/osd$id
        osd journal =3D /data/osd$id/journal
[osd0]
        host =3D ceph3
        btrfs devs =3D /dev/sda3
[osd1]
        host =3D ceph4
        btrfs devs =3D /dev/sda3

 Thanks
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
