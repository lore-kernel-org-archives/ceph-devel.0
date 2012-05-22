From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Designing a cluster guide
Date: Tue, 22 May 2012 08:30:05 +0200
Message-ID: <4FBB326D.5060407@profihost.ag>
References: <4FB75BAD.3080709@profihost.ag>	<8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>	<CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com> <CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35665 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab2EVGaD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 02:30:03 -0400
In-Reply-To: <CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?U8WCYXdvbWlyIFNrb3dyb24=?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org, Tomasz Paszkowski <ss7pro@gmail.com>

Am 21.05.2012 23:22, schrieb S=C5=82awomir Skowron:
> Maybe good for journal will be two cheap MLC Intel drives on Sandforc=
e
> (320/520), 120GB or 240GB, and HPA changed to 20-30GB only for
> separate journaling partitions with hardware RAID1.
> I like to test setup like this, but maybe someone have any real life
> info ??

HPA?

That was also my idea but most of the people here still claim that
they're too slow and you need something MORE powerful like.

zeus ram: http://www.stec-inc.com/product/zeusram.php
fusion io: http://www.fusionio.com/platforms/iodrive2/

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
