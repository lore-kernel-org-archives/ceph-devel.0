From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Designing a cluster guide
Date: Tue, 22 May 2012 08:59:10 +0200
Message-ID: <CAMwB3Tj9RZe7ZYp9hfd9BL7Ma=_6GWbooEwefcBdL+B-TGDvVQ@mail.gmail.com>
References: <4FB75BAD.3080709@profihost.ag>
	<8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
	<CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com>
	<CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
	<4FBB326D.5060407@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40089 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab2EVG7M convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 02:59:12 -0400
Received: by wibhn6 with SMTP id hn6so3164853wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 23:59:11 -0700 (PDT)
In-Reply-To: <4FBB326D.5060407@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Tomasz Paszkowski <ss7pro@gmail.com>

http://en.wikipedia.org/wiki/Host_protected_area

On Tue, May 22, 2012 at 8:30 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Am 21.05.2012 23:22, schrieb S=B3awomir Skowron:
>> Maybe good for journal will be two cheap MLC Intel drives on Sandfor=
ce
>> (320/520), 120GB or 240GB, and HPA changed to 20-30GB only for
>> separate journaling partitions with hardware RAID1.
>> I like to test setup like this, but maybe someone have any real life
>> info ??
>
> HPA?
>
> That was also my idea but most of the people here still claim that
> they're too slow and you need something MORE powerful like.
>
> zeus ram: http://www.stec-inc.com/product/zeusram.php
> fusion io: http://www.fusionio.com/platforms/iodrive2/

But in commodity hardware, or cheap servers, even in mid-range
machines, cost of pci-e flash/ram card is too high even in small
cluster.

>
> Stefan



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
