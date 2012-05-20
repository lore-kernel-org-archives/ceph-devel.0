From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Designing a cluster guide
Date: Sun, 20 May 2012 09:56:21 +0200
Message-ID: <4FB8A3A5.5090809@profihost.ag>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54707 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab2ETH4U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 May 2012 03:56:20 -0400
In-Reply-To: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Gregory Farnum <greg@inktank.com>

Am 19.05.2012 18:15, schrieb Alexandre DERUMIER:
> Hi,
>
> For your journal , if you have money, you can use
>
> stec zeusram ssd drive. (around 2000=E2=82=AC /8GB / 100000 iops read=
/write with 4k block).
> I'm using them with zfs san, they rocks for journal.
> http://www.stec-inc.com/product/zeusram.php
>
> another interessesting product is ddrdrive
> http://www.ddrdrive.com/

Great products but really expensive. The question is do we really need=20
this in case of rbd block device.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
