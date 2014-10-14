From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: the state of cephfs in giant
Date: Tue, 14 Oct 2014 09:31:56 +0200
Message-ID: <543CD16C.6060708@m-privacy.de>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.155.129]:60395 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbaJNHiX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Oct 2014 03:38:23 -0400
In-Reply-To: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, ceph-users@ceph.com

Am 13.10.2014 20:16, schrieb Sage Weil:
> We've been doing a lot of work on CephFS over the past few months. Th=
is
> is an update on the current state of things as of Giant.
=2E..
> * Either the kernel client (kernel 3.17 or later) or userspace (ceph-=
fuse
>   or libcephfs) clients are in good working order.

Thanks for all the work and specially for concentrating on CephFS! We
have been watching and testing for years by now and really hope to
change our Clusters to CephFS soon.

=46or kernel maintenance reasons, we only want to run longterm stable
kernels. And for performance reasons and because of severe known
problems we want to avoid Fuse. How good are our chances of a stable
system with the kernel client in the latest longterm kernel 3.14? Will
there be further bugfixes or feature backports?

Thanks again,

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Werner-Vo=DF-Damm 62       Fax: +49 30 99296856
12101 Berlin             http://www.m-privacy.de

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
