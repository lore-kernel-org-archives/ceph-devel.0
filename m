From: Wido den Hollander <wido@pcextreme.nl>
Subject: Snapshot in subdirectory lost when removing parent directory
Date: Thu, 03 Jun 2010 11:40:04 +0200
Message-ID: <1275558004.14588.106.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:51045 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758419Ab0FCJkH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jun 2010 05:40:07 -0400
Received: from zarafa.pcextreme.nl (zarafa.pcextreme.nl [79.99.135.237])
	by support.pcextreme.nl (Postfix) with ESMTP id A80118426D
	for <ceph-devel@vger.kernel.org>; Thu,  3 Jun 2010 11:40:05 +0200 (CEST)
Received: from [192.168.5.109] (cable-95-86.zeelandnet.nl [82.176.95.86])
	by zarafa.pcextreme.nl (Postfix) with ESMTPSA id C4D86600009F
	for <ceph-devel@vger.kernel.org>; Thu,  3 Jun 2010 11:40:16 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

When creating a snapshot in a subdirectory, this gets lost when the
parent directory is removed, see the following command sequence:
http://www.pastebin.org/302447

Now, i had a snapshot of the directory "beta" holding my really
important file "randomfile.txt".

Since creating a snapshot of the root directory is not possible i could
loose all my data when someone hacks a box and does a "rm -rf /".

What would you advice in this scenario?

1. Create snapshots of the RADOS pools?
2. Never mount the root directory, but a subdir (mount x.x.x.x:/subdir)
3. Prevent your box from being hacked ;-)

Thanks!

--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
