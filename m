From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Infiniband 40GB
Date: Thu, 7 Jun 2012 13:33:27 +0200
Message-ID: <201206071333.28197.a.ott@m-privacy.de>
References: <4FCB1C0A.4050504@profihost.ag> <201206061257.34525.a.ott@m-privacy.de> <4FCF38C7.8000802@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:51973 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760760Ab2FGLdi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 07:33:38 -0400
In-Reply-To: <4FCF38C7.8000802@profihost.ag>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On Wednesday 06 June 2012 wrote Stefan Priebe - Profihost AG:
> Am 06.06.2012 12:57, schrieb Amon Ott:
> > On Wednesday 06 June 2012 wrote Stefan Priebe - Profihost AG:
> >> Hi Amon,
> >>
> >> i've added your patch:
> >> # strings /lib/libc-2.11.3.so |grep -i syncfs
> >> syncfs
> >>
> >> But configure of ceph still claims there is no syncfs support.
> >>
> >> # ./configure |grep -i sync
> >> checking for syncfs... no
> >> checking for sync_file_range... yes
> >>
> >> Any ideas?
> >
> > Did you also install the new libc6-dev, which contains the new head=
er
> > files?
>
> Yes.
>
> /usr/include/unistd.h:
> extern int syncfs (int __fd) __THROW;
>
> /usr/include/gnu/stubs-64.h:
> #define __stub_syncfs

Are you building on 32 or 64 Bit? We have 32 here.

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
