From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Ubuntu 12.04.1 + xfs + syncfs is still not our friend
Date: Tue, 6 Nov 2012 19:50:00 +0100
Message-ID: <265D4F1A-7218-4137-98BE-6AF6BEF11F7C@filoo.de>
References: <50993755.8060800@filoo.de> <CAJH6TXgcsi4QT+wKtGqjrCYF1M8Ruar9LaJ1Z7_3yQct3t1SkQ@mail.gmail.com> <50995B12.9040409@filoo.de>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:57131 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab2KFSuA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 13:50:00 -0500
In-Reply-To: <50995B12.9040409@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?windows-1252?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, ceph-devel@vger.kernel.org

Hi Jens,

sorry for the double work=85 answered off-list already ;)

Oliver.

Am 06.11.2012 um 19:46 schrieb Jens Rehp=F6hler <jens.rehpoehler@filoo.=
de>:

> On 06.11.2012 18:33, Gandalf Corvotempesta wrote:
>> 2012/11/6 Oliver Francke <Oliver.Francke@filoo.de>:
>>> 2012-11-06 17:05:51.863921 7f5cc52e3780  0 filestore(/data/osd6-3) =
mount
>>> syncfs(2) syscall not support by glibc
>>> 2012-11-06 17:05:51.863925 7f5cc52e3780  0 filestore(/data/osd6-3) =
mount no
>>> syncfs(2), must use sync(2).
>> Could you please try to run "ldd --version" and test if "man syncfs"
>> is working ?
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Here is the output:
>=20
> ldd --version
> ldd (Ubuntu EGLIBC 2.15-0ubuntu10.3) 2.15
>=20
> After installing manpages-dev i get the man page for syncfs (with  "m=
an
> syncfs")
>=20
> Distribution is a normal Ubuntu 12.04.1
>=20
> --=20
> mit freundlichen Gr=FCssen
>=20
> Jens Rehp=F6hler
>=20
> ---------------------------------------------------------------------=
-
> Filoo GmbH
> Moltkestr. 25a
> 33330 G=FCtersloh
> HRB4355 AG G=FCtersloh
>=20
> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | Dr. C.Kunz
> Telefon: +49 5241 8673012 | Mobil: +49 151 54645798
> Fax: +49 5241 8673020
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
