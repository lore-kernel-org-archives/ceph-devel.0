From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph-osd cpu usage
Date: Thu, 15 Nov 2012 13:19:52 +0100
Message-ID: <50A4DDE8.8040506@profihost.ag>
References: <7840e3d1-17b2-4618-ae1f-ff3dbdff71f6@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53761 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767606Ab2KOMUB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 07:20:01 -0500
In-Reply-To: <7840e3d1-17b2-4618-ae1f-ff3dbdff71f6@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

Am 15.11.2012 12:18, schrieb Alexandre DERUMIER:
> cpu usage is same for read and write  ?

no for read it is just around 25%. And i get "full" (limited by rbd /=20
librbd) 23.000 iops per vm.


> ----- Mail original -----
>
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
> =C3=80: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Jeudi 15 Novembre 2012 11:56:37
> Objet: ceph-osd cpu usage
>
> Hello list,
>
> my main problem right now is that ceph does not scale for me (more vm=
s
> using rbd). It does not scale as the ceph-osd is using all my CPU cor=
e
> all the time (8 cores) with just 4 SSDs. The SSDs are far away from
> being loaded.
>
> What is the best way to find out what the ceph-osd process is doing a=
ll
> the time?
>
> A gperf graph is attached.
>
> Greets,
> Stefan
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
