From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: Snapshot in subdirectory lost when removing parent directory
Date: Fri, 04 Jun 2010 09:06:36 +0200
Message-ID: <1275635196.1496.1.camel@wido-desktop>
References: <1275558004.14588.106.camel@wido-laptop.pcextreme.nl>
	 <Pine.LNX.4.64.1006030731160.18396@cobra.newdream.net>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:38095 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab0FDHGk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jun 2010 03:06:40 -0400
In-Reply-To: <Pine.LNX.4.64.1006030731160.18396@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Yes, that would be an option. But only on directories which holds
snapshots.

If you would give a ENOTEMPTY message on "alpha", where the subdirector=
y
"beta" holds the snapshot it will be pretty difficult when you have a
large tree.

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


On Thu, 2010-06-03 at 14:32 +0000, Sage Weil wrote:
> On Thu, 3 Jun 2010, Wido den Hollander wrote:
> > Hi,
> >=20
> > When creating a snapshot in a subdirectory, this gets lost when the
> > parent directory is removed, see the following command sequence:
> > http://www.pastebin.org/302447
> >=20
> > Now, i had a snapshot of the directory "beta" holding my really
> > important file "randomfile.txt".
> >=20
> > Since creating a snapshot of the root directory is not possible i c=
ould
> > loose all my data when someone hacks a box and does a "rm -rf /".
> >=20
> > What would you advice in this scenario?
> >=20
> > 1. Create snapshots of the RADOS pools?
> > 2. Never mount the root directory, but a subdir (mount x.x.x.x:/sub=
dir)
> > 3. Prevent your box from being hacked ;-)
>=20
> Hmm.  What about returning ENOTEMPTY when you try to rmdir(2) a direc=
tory=20
> that contains snapshots?
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
