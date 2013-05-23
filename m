From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: ceph-deploy:  how to change filesystem type from xfs to btrfs using --fs-type option
Date: Thu, 23 May 2013 10:13:11 -0700 (PDT)
Message-ID: <1369329191.34870.YahooMailNeo@web121902.mail.ne1.yahoo.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm23-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.57]:32923 "EHLO
	nm23-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757813Ab3EWRSb convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 13:18:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>




Hello, the link at http://ceph.com/docs/master/rados/deployment/ceph-de=
ploy-osd/ say that you can use

--fs-type

option to change the default filesystem from xfs to either btrfs or ext=
4 but when i tried the following syntax, they all failed:


1)

[root@g1 wkd]# ceph-deploy osd prepare --fs-type btrfs gluster3:sdd:/de=
v/sdb1
usage: ceph-deploy [-h] [-v | -q] [-n] [--overwrite-conf] [--cluster NA=
ME]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 COMMAND ...
ceph-deploy: error: unrecognized arguments: --fs-type

2)
[root@g1 wkd]# ceph-deploy --fs-type btrfs osd prepare=A0 gluster3:sdd:=
/dev/sdb1
usage: ceph-deploy [-h] [-v | -q] [-n] [--overwrite-conf] [--cluster NA=
ME]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 COMMAND ...
ceph-deploy:
 error: argument COMMAND: invalid choice: 'btrfs' (choose from=20
'purgedata', 'mds', 'forgetkeys', 'purge', 'admin', 'mon', 'install',=20
'gatherkeys', 'new', 'disk', 'config', 'osd', 'uninstall')


3)=A0
[root@g1 wkd]# ceph-deploy osd create --fs-type btrfs gluster3:sdd:/dev=
/sdb1
usage: ceph-deploy [-h] [-v | -q] [-n] [--overwrite-conf] [--cluster NA=
ME]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 COMMAND ...
ceph-deploy: error: unrecognized arguments: --fs-type


4)

[root@g1 wkd]# ceph-deploy --fs-type btrfs osd create gluster3:sdd:/dev=
/sdb1
usage: ceph-deploy [-h] [-v | -q] [-n] [--overwrite-conf] [--cluster NA=
ME]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 COMMAND ...
ceph-deploy:
 error: argument COMMAND: invalid choice: 'btrfs' (choose from=20
'purgedata', 'mds', 'forgetkeys', 'purge', 'admin', 'mon', 'install',=20
'gatherkeys', 'new', 'disk', 'config', 'osd', 'uninstall')

Is the --fs-type option working? if yes, then what is the proper syntax=
? Thanks


Isaac

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
