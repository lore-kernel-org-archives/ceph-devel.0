From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 12:48:23 +0100
Message-ID: <50AE1107.5060606@profihost.ag>
References: <CAOLwVUmJGZNaZsySsw8eQmLy1ZCha+AAGCp-5i42=mr0aKHMyA@mail.gmail.com> <3210b770-431e-44ed-8d86-4610de89dd92@mailpro> <CAOLwVUn5EAC4QaWgU+TkodcJea7ayKUANUpfzWUG+cTBunao5g@mail.gmail.com> <50ACF8C8.7020908@inktank.com> <50AD02AC.60802@inktank.com> <50ADFC23.2030208@profihost.ag> <CAOLwVUmp7wrfead8qX2BZPbyeN_JY_XBN+wkEWmbY6q1-5u0fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54206 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab2KVTAd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:00:33 -0500
In-Reply-To: <CAOLwVUmp7wrfead8qX2BZPbyeN_JY_XBN+wkEWmbY6q1-5u0fw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>

Am 22.11.2012 11:49, schrieb S=E9bastien Han:
> @Alexandre: cool!
>
> @ Stefan: Full SSD cluster and 10G switches?
Yes

> Couple of weeks ago I saw
> that you use journal aio, did you notice performance improvement with=
 it?
journal is running on tmpfs to me but that changes nothing.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
