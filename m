From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Ceph on btrfs 3.4rc
Date: Mon, 30 Apr 2012 12:54:31 +0200
Message-ID: <201204301254.32510.a.ott@m-privacy.de>
References: <CAJafhzSVZ3+1ApgJU=sQu6gM62BeWVGG4mqFPNYRHx79czYJtQ@mail.gmail.com> <CAFKYj4d2YvpttC-Z58-MY0ZC4tug3bQft-9z8_RRrrmJAm2T8A@mail.gmail.com> <CAJafhzT8D9Hk0atMRWQpCK5Gr_=O+XqMEkPKQzCr351Gf+v3_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:34575 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab2D3LEE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 07:04:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id AE22163F57
	for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 12:54:40 +0200 (CEST)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 29483-02 for <ceph-devel@vger.kernel.org>;
 Mon, 30 Apr 2012 12:54:32 +0200 (CEST)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id BA7B263F54
	for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 12:54:32 +0200 (CEST)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id B4E2C20E93
	for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 12:54:33 +0200 (CEST)
In-Reply-To: <CAJafhzT8D9Hk0atMRWQpCK5Gr_=O+XqMEkPKQzCr351Gf+v3_Q@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Monday 30 April 2012 wrote Christian Brunner:
> Metadata fragmentation was a big problem (for us) in the past. With
> the "big metatdata feature" (mkfs.btrfs -l 64k -n 64k) these problems
> seem to be solved. We do not use it in production yet, but my stress
> test didn't show any degradation. The only remaining issues I've seen
> are these warnings.

Where exactly are the metadata stored, in the leaf (-l 64k) or in the n=
ode (-n=20
64k)? I would like to avoid wasting space and disk bandwidth and only u=
se one=20
of these options, if that makes sense.

After reading the short man page I would have tried -n.

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
