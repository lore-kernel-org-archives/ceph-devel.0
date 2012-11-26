From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Mon, 26 Nov 2012 14:29:53 +0100
Message-ID: <50B36ED1.1020108@filoo.de>
References: <50B36C9F.80107@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-5.de-punkt.de ([93.190.64.35]:55446 "EHLO
	mail-5.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab2KZN3z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 08:29:55 -0500
In-Reply-To: <50B36C9F.80107@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Dan Mick <dan.mick@inktank.com>

Well...

On 11/26/2012 02:20 PM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> i know branch wip-rbd-export-stdout is work in progress but it is mor=
e=20
> than useful ;-)
>
> When i try to import an image i get:
>
> # gzip -dc vm-101-disk-1.img.gz | rbd import --format=3D2=20
> --size=3D42949672960 - kvmpool1/vm-101-disk-1
> rbd: error reading file: (29) Illegal seek
> Importing image: 0% complete...failed.
> rbd: import failed: (29) Illegal seek
>
> Anything i've tried wrong?

I would assume, that size is already in MiB? Seems to be a slightly too=
=20
big value... Not tried myself, though...

Oliver.

>
> Greets,
> Stefan
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
