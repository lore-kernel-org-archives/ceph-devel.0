From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: ceph, slow (cheap) and fast (expensive) storage?
Date: Tue, 08 Jun 2010 12:53:33 +0200
Message-ID: <1275994413.1933.1.camel@wido-desktop>
References: <4C0E1BAC.8070306@wpkg.org>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:35633 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0FHKxe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jun 2010 06:53:34 -0400
In-Reply-To: <4C0E1BAC.8070306@wpkg.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: ceph-devel@vger.kernel.org

Hi,

I'm not aware of any of those features in Ceph and i don't think that i=
t
will be possible in the near future.

But while thinking about it, is ZFS an option for you? You could then
use a lot of SATA disks and add some SAS disks for your caching. ZFS
will then place the most used blocks on the SAS disks.

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


On Tue, 2010-06-08 at 10:30 +0000, Tomasz Chmielewski wrote:
> I'd like to build a cluster for storing large amounts of data.
>=20
> The cluster would consist of slow (cheap) storage and fast (expensive=
)=20
> storage.
>=20
> I would like to migrate data from fast (expensive) storage to slow=20
> (cheap) storage if it wasn't accessed for, say, 6 months.
>=20
> Would ceph somehow help me achieve that?
>=20
> If not, do you know anything which comes to mind?
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
