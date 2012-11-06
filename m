From: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Subject: Re: Ubuntu 12.04.1 + xfs + syncfs is still not our friend
Date: Tue, 06 Nov 2012 19:46:42 +0100
Message-ID: <50995B12.9040409@filoo.de>
References: <50993755.8060800@filoo.de> <CAJH6TXgcsi4QT+wKtGqjrCYF1M8Ruar9LaJ1Z7_3yQct3t1SkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-7.de-punkt.de ([93.190.64.37]:49772 "EHLO
	mail-7.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab2KFSx0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 13:53:26 -0500
In-Reply-To: <CAJH6TXgcsi4QT+wKtGqjrCYF1M8Ruar9LaJ1Z7_3yQct3t1SkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, ceph-devel@vger.kernel.org

On 06.11.2012 18:33, Gandalf Corvotempesta wrote:
> 2012/11/6 Oliver Francke <Oliver.Francke@filoo.de>:
>> 2012-11-06 17:05:51.863921 7f5cc52e3780  0 filestore(/data/osd6-3) m=
ount
>> syncfs(2) syscall not support by glibc
>> 2012-11-06 17:05:51.863925 7f5cc52e3780  0 filestore(/data/osd6-3) m=
ount no
>> syncfs(2), must use sync(2).
> Could you please try to run "ldd --version" and test if "man syncfs"
> is working ?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Here is the output:

ldd --version
ldd (Ubuntu EGLIBC 2.15-0ubuntu10.3) 2.15

After installing manpages-dev i get the man page for syncfs (with  "man
syncfs")

Distribution is a normal Ubuntu 12.04.1

--=20
mit freundlichen Gr=FCssen

Jens Rehp=F6hler

----------------------------------------------------------------------
=46iloo GmbH
Moltkestr. 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | Dr. C.Kunz
Telefon: +49 5241 8673012 | Mobil: +49 151 54645798
=46ax: +49 5241 8673020

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
