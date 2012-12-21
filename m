From: Amon Ott <ao@m-privacy.de>
Subject: Re: ceph stability
Date: Fri, 21 Dec 2012 11:07:55 +0100
Message-ID: <50D434FB.4020909@m-privacy.de>
References: <CAD5ewrosrMWD3jxznaMhab=VTL4VzQ7savVk42KDe374VSSzbA@mail.gmail.com> <50D1C09E.9000504@inktank.com> <CAD5ewrryqXEDv_HDGK8RettDmi7LwH_eEOCNCx_1jduj61_=cA@mail.gmail.com> <50D3213A.2080401@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:47389 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab2LUKIF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 21 Dec 2012 05:08:05 -0500
In-Reply-To: <50D3213A.2080401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>, ceph-devel@vger.kernel.org

Am 20.12.2012 15:31, schrieb Mark Nelson:
> On 12/20/2012 01:08 AM, Roman Hlynovskiy wrote:
>> Hello Mark,
>>
>> for multi-mds solutions do you refer to multi-active arch or 1 activ=
e
>> and many standby arch?
>=20
> That's a good question!  I know we don't really recommend multi-activ=
e
> right now for production use.  Not sure what our current recommendati=
ons
> are for multi-standby.  As far as I know it's considered to be more
> stable.  I'm sure Greg or Sage can chime in with a more accurate
> assessment.

We have been testing a lot with multi-standby, because a single MDS doe=
s
not make a lot of sense in a cluster. Maybe the clue is to have only on=
e
standby, making SPOF a DPOF?

Up to 0.55 with some of Yan's fixes, Ceph has been too instable wheneve=
r
it came to MDS failover. As long as the same MDS has been kept active,
it was quite stable.

We are really hoping for 0.56 with the additional MDS fixes and also
fixed kernel 3.8 code. We have been waiting to replace our existing
cluster fs with CephFS for at least one and a half years, but it has
never been stable enough in our setup with standby MDS and takeover, le=
t
alone multi-active. We do not want to risk a complete cluster failure.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 99296856
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
