From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Bug #1047 reproduced
Date: Fri, 27 Jan 2012 15:23:52 +0100
Message-ID: <201201271523.54502.a.ott@m-privacy.de>
References: <201112010937.37642.a.ott@m-privacy.de> <CAF3hT9BrL8WJbG2cgDADfSZk02HWwi4Q2MgK_yu6fiDSyZrwRg@mail.gmail.com> <201112291230.59323.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:57513 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702Ab2A0OYF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2012 09:24:05 -0500
In-Reply-To: <201112291230.59323.a.ott@m-privacy.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thursday 29 December 2011 wrote Amon Ott:
> I finally got the test cluster freed up for more Ceph testing.
>
> On Friday 23 December 2011 wrote Gregory Farnum:
> > Unfortunately there's not enough info in this log either. If you ca=
n
> > reproduce it with "mds debug =3D 20" and put that log somewhere, it
> > ought to be enough to work out what's going on, though. Sorry. :(
> > -Greg
>
> Here is what MDS logs with debug 20. No idea if it really helps. The
> cluster is still in the broken state, should I try to reproduce with =
a
> recreated ceph fs and debug 20? This could be GBs of logs.

Update: I recreated the Ceph FS with release 0.40. It broke only becaus=
e of a=20
btrfs bug hitting two of the four nodes (after ca. one day of heavy loa=
d) and=20
recovered without problems when the nodes were back. Then I recreated w=
ith=20
ext4 as osd storage area and have not managed to break it within four d=
ays,=20
two of these under heavy load.

This means that this bug is probably fixed. It might be related to the=20
automatic reconnect of mds, which avoids meta data inconsistencies. :)

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
