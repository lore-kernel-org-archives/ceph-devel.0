From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: how to pass mount options in ceph-deploy osd create or prepare commands
Date: Thu, 23 May 2013 11:05:32 -0700 (PDT)
Message-ID: <1369332332.27682.YahooMailNeo@web121906.mail.ne1.yahoo.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm7-vm2.bullet.mail.ne1.yahoo.com ([98.138.90.155]:46957 "EHLO
	nm7-vm2.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757440Ab3EWSFe convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 14:05:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



I see ceph-deploy mounts the ceph data drives as


/dev/sdc1 on /var/lib/ceph/osd/ceph-2 type xfs (rw,noatime)
/dev/sdd1 on /var/lib/ceph/osd/ceph-3 type xfs (rw,noatime)


how do i add a mount option (like -o inode64, ...etc ) to ceph-deploy i=
n the


ceph-deploy osd create

or=A0

ceph-deploy osd prepare
ceph-deploy osd activate

commands=A0 to use when it is mounting the ceph data drives. Thank you.

Isaac
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
