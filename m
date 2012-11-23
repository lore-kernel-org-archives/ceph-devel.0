From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: rbd import from stdin
Date: Fri, 23 Nov 2012 11:43:41 +0100
Message-ID: <50AF535D.5080602@profihost.ag>
References: <9a1238da-8eb3-4080-b331-26890d51b9aa@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:43705 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab2KWKnw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 05:43:52 -0500
In-Reply-To: <9a1238da-8eb3-4080-b331-26890d51b9aa@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

ah so right now the size parameter is needed. But i don't know the size=
=20
;-) file is gzip compressed ;-)

Stefan
Am 23.11.2012 11:25, schrieb Alexandre DERUMIER:
>
> import for stdin already work like this:
>
> rbd import --size=3Dxxx - image < stdin
>
> from this patch
>
> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/6315
>
>
> (so I think you just need to specify --size)
>
>
>
> ----- Mail original -----
>
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
> =C3=80: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Vendredi 23 Novembre 2012 11:15:11
> Objet: rbd import from stdin
>
> Hello,
>
> i was looking at the wip-rbd-export-stdout branch which also allows t=
o
> import from stdin.
>
> But it doesn't seem to work:
>
> gzip -d -c vm-101-disk-1.img.gz | rbd import - kvmpool1/vm-101-disk-1
> rbd: unable to get size of file/block device: (25) Inappropriate ioct=
l
> for device
> rbd: import failed: (25) Inappropriate ioctl for device
>
> Greets,
> Stefan
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
