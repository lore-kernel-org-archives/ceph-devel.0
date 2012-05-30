From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: OSD deadlock with cephfs client and OSD on same machine
Date: Wed, 30 May 2012 08:59:26 +0200
Message-ID: <201205300859.27181.a.ott@m-privacy.de>
References: <201205290944.33983.a.ott@m-privacy.de> <CADvuQRF5zC78hySCf3gYeJkRWGa+KjMKcY==0hqBxJrLhFv9dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:56877 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979Ab2E3G75 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 02:59:57 -0400
In-Reply-To: <CADvuQRF5zC78hySCf3gYeJkRWGa+KjMKcY==0hqBxJrLhFv9dw@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday 29 May 2012 wrote Tommi Virtanen:
> On Tue, May 29, 2012 at 12:44 AM, Amon Ott <a.ott@m-privacy.de> wrote=
:
> > On Linux, if you run OSD on ext4 filesystem, have a cephfs kernel c=
lient
> > mount on the same system and no syncfs system call (as to be expect=
ed
> > with libc6 < 2.14 or kernel < 2.6.39), OSD deadlocks in sys_sync().=
 Only
> > reboot recovers the system.
>
> This is the classic issue of memory pressure needing free memory to b=
e
> relieved. While syncfs(2) may make the hang less common, I do not
> think having syncfs(2) is enough; nothing sort of having a reserved
> memory pool guaranteed to be big enough to handle the request will,
> and maintaining that solution is hideously complex.

AFAIR, when the deadlocks came, there were some GB of the 12 GB RAM sti=
ll=20
unused, not even for caching. But it might be a problem with low memory=
,=20
because we are running with 32 Bit.

Would it be possible to preallocate a significant amount of RAM for the=
=20
purpose of syncing? I would not mind reserving a few 100 MB for that, b=
ut=20
deadlocks must not happen in any case. Can the size of the journal give=
 a=20
hint on how much is needed?

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=C3=B6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=C3=A4ftsf=C3=BChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
