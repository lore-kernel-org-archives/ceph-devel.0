From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 11:53:48 +0200
Message-ID: <4FCC85AC.209@univ-nantes.fr>
References: <d1ba3477-a5ed-488a-8785-2a37f4301ffc@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-loi.cpub.univ-nantes.fr ([193.52.103.112]:54647 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756666Ab2FDJxx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 05:53:53 -0400
In-Reply-To: <d1ba3477-a5ed-488a-8785-2a37f4301ffc@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Hannes Reinecke <hare@suse.de>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, Stefan Majer <stefan.majer@gmail.com>

Le 04/06/2012 11:35, Alexandre DERUMIER a =C3=A9crit :
> Hi,
> about this:
>>> Turning off Virtualisation extension in BIOS. Don't know why, but i=
t
>>> gaves us crappy performance. We usually put it on, because we use K=
VM a
>>> lot. In our case, OSD are in bare metal and disabling virtualisatio=
n
>>> extension gives us a very big boost.
>>> It may be a BIOS bug in our machines (DELL M610).
>
> It could be related to iommu, if you pass intel_iommu=3Don in grub.
> I have already had this kind of problem.
>
> When intel_iommu=3Don, Linux (completely unrelated to KVM) adds a new=
 level
> of protection which didn't exist without an IOMMU - the network card,=
 which
> without an IOMMU could write (via DMA) to any memory location, now is
> not allowed - the card can only write to memory locates which the OS
> wanted it to write. Theoretically, this can protect the OS against
> various kinds of attacks. But what happens now is that every time tha=
t
> Linux passes a new buffer to the card, it needs to change the IOMMU
> mappings. This noticably slows down I/O, unfortunately.
>
>

Infortunately, this is not the case. The intel card supports it, but=20
DELL M160 don't.
And I just checked, ou linux command line don't include intel_iommu=3Do=
n.

BTW, it seems that turning on virtualization on bios kills performance=20
on integrated ixgbe driver. Sourceforge one seems less affected. Our=20
tests were circa kernel 3.2 , it may have changed since.

Cheers,



--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
