From: Martin Fick <mogulguy@yahoo.com>
Subject: Replacing DRBD use with RBD
Date: Tue, 4 May 2010 16:46:12 -0700 (PDT)
Message-ID: <801672.55708.qm@web36106.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from web36106.mail.mud.yahoo.com ([66.163.179.220]:34682 "HELO
	web36106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757309Ab0EDXqO convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 May 2010 19:46:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I have a questions with respect to RADOS and RBD and the cluster monito=
r daemons.

1) Is there any chance that the cluster monitor protocol will be enhanc=
ed to work practically with only 2 monitor daemons?=A0 I ask since this=
 seems like it would allow a 2 node RBD based device to effectively rep=
lace a DRBD based device and yet be much more easily expandable to more=
 nodes than DRBD.=A0 Many HA systems (say telco racks) only have two no=
des and it seems silly to miss out on the opportunity to be able to use=
 RBD in those systems.

One suggestion I have would be to do this would be to use some of the s=
ame techniques that heartbeat uses to determine whether a node has gone=
 down or if instead there is network segregation: a serial port connect=
ion, common ping nodes (such as a router)...

I suspect that if reliable 2 node operation were designed into RBD, it =
would eventually replace some of the uses of DRBD.


2) Is there any way of preventing two users of an RBD device from using=
 the device concurrently?=A0 Is there someway to create "locks" with RA=
DOS that would die if a node dies?=A0 If so, this would allow an RBD de=
vice to be safely mounted as a non distributed FS such as ext3 exclusiv=
ely on one of many hosts.=A0 This would open up the use of RBD devices =
for linux containers or linux vservers which could run on any machine i=
n a cluster (similar to the idea of using it with kvm/qemu).

Thanks, I look forward to playing with RBD and ceph!

-Martin



     =20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
