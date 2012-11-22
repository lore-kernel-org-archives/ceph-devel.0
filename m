From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 14:29:03 +0100
Message-ID: <50AE289F.2040403@profihost.ag>
References: <CAOLwVUmJGZNaZsySsw8eQmLy1ZCha+AAGCp-5i42=mr0aKHMyA@mail.gmail.com> <3210b770-431e-44ed-8d86-4610de89dd92@mailpro> <CAOLwVUn5EAC4QaWgU+TkodcJea7ayKUANUpfzWUG+cTBunao5g@mail.gmail.com> <50ACF8C8.7020908@inktank.com> <50AD02AC.60802@inktank.com> <50ADFC23.2030208@profihost.ag> <CAOLwVUmp7wrfead8qX2BZPbyeN_JY_XBN+wkEWmbY6q1-5u0fw@mail.gmail.com> <50AE1107.5060606@profihost.ag> <CAOLwVU=VpDPg6iuZM=UFy5bcDm-Rm_dVRkeZrAu-DoFXp9cDKw@mail.gmail.com> <50AE2546.9050902@profihost.ag> <CAOLwVUkwVSv-Ven2CTjnTN2J573TBTD2SLDY7df0h7ncJZQgpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42874 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779Ab2KVSzx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:55:53 -0500
In-Reply-To: <CAOLwVUkwVSv-Ven2CTjnTN2J573TBTD2SLDY7df0h7ncJZQgpQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>

Am 22.11.2012 14:22, schrieb S=E9bastien Han:
>     And RAMDISK devices are too expensive.
>
> It would make sense in your infra, but yes they are really expensive.

We need something like tmpfs - running in local memory but support dio.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
