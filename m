From: lixiaobing10@otcaix.iscas.ac.cn
Subject: Problems when startup ceph - mds always in creating status
Date: Fri, 23 Mar 2012 17:24:47 +0800 (CST)
Message-ID: <2d863c.50.1363edf5dd6.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [124.16.137.195] ([124.16.137.195]:42624 "EHLO
	otcaix.iscas.ac.cn" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab2CWJck convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Mar 2012 05:32:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi ceph-devel,

When I followed the instruction from 'Using Hadoop with Ceph' wiki to l=
et hadoop use ceph, I encountered a problem when I started ceph. Using =
'ceph -s' command, I found that mds was always in 'creating' status, an=
d could not enter 'active=A1=AF status. The output of 'ceph -s' is like=
 following:

pg v9: 6 pgs: 6 active+clean+degraded; 0 KB data, 376 KB used, 5118 MB =
/ 5119 MB avail
mds e3: 1/1/1 up {0=3D0=3Dup:creating}
osd e3: 1 osds: 1 up, 1 in
log 2012-03-23 10:36:25.411393 osd.0 192.168.122.100:6801/19407 6 : [IN=
=46] 2.1p0 scrub ok
mon e1: 1 mons at {0=3D192.168.122.100:6789/0}

I set the debug level to 20 to get everything in log files. But I am to=
o new to ceph, and cannot locate the error. Could someone give me any g=
uidance? Thank you very much!

Best,
Xiaobing

P.S.=20
My experiment environment is xen-4.1.2, Dom0 kernel 3.2.12, and DomU is=
 Fedora14; and I installed ceph all in one DomU;=20
I use =A1=AEmkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs=A1=AF to forma=
t ceph; and =A1=AEinit-ceph -c /etc/ceph/ceph.conf -a start=A1=AF to st=
art ceph;

P.P.S.
Because my mail with attachment could not reach ceph-devel@vger.kernel.=
org , I can send you them separately if you need them. Thanks for your =
attention and time!



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
