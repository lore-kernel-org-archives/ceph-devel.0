From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Infiniband 40GB
Date: Tue, 5 Jun 2012 09:08:21 +0200
Message-ID: <201206050908.22970.a.ott@m-privacy.de>
References: <4FCB1C0A.4050504@profihost.ag> <201206041147.22993.a.ott@m-privacy.de> <4FCCD74D.2030309@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:45452 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641Ab2FEHIc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 03:08:32 -0400
In-Reply-To: <4FCCD74D.2030309@profihost.ag>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Yann Dupont <Yann.Dupont@univ-nantes.fr>, ceph-devel@vger.kernel.org

On Monday 04 June 2012 wrote Stefan Priebe:
> Hi Amon,
>
> thanks for your backported patch. At least it doesn't cleanly apply t=
o
> debian squeeze stable as it wants a glic 2.12 in Versions.def but Deb=
ian
> is only at 2.11? Do you use another patch too?

I ripped the patch right out of our previously built 2.11.3-3 source tr=
ee. It=20
needs to be last in the series file, because several existing Debian pa=
tches=20
modify the sources at various places. I could also make our compiled pa=
ckages=20
available to you for download.

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
