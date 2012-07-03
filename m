From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: domino-style OSD crash
Date: Tue, 03 Jul 2012 22:54:25 +0200
Message-ID: <4FF35C01.4070400@univ-nantes.fr>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com> <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com> <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:43344 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752673Ab2GCUyf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 16:54:35 -0400
In-Reply-To: <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 03/07/2012 21:42, Tommi Virtanen a =C3=A9crit :
> On Tue, Jul 3, 2012 at 1:40 AM, Yann Dupont <Yann.Dupont@univ-nantes.=
fr> wrote:
>> Upgraded the kernel to 3.5.0-rc4 + some patches, seems btrfs is OK r=
ight
>> now.
>>
>> Tried to restart osd with 0.47.3, then next branch, and today with 0=
=2E48.
>>
>> 4 of 8 nodes fails with the same message :
>>
>> ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2=
bf2030)
>>   1: /usr/bin/ceph-osd() [0x701929]
> ...
>>   13: (leveldb::InternalKeyComparator::FindShortestSeparator(std::st=
ring*,
>> leveldb::Slice const&) const+0x4d) [0x6e811d]
> That looks like http://tracker.newdream.net/issues/2563 and the best
> we have for that ticket is "looks like you have a corrupted leveldb
> file". Is this reproducible with a freshly mkfs'ed data partition?
Probably not. I have multiple data volumes on each nodes (I was plannin=
g=20
xfs vs ext4 vs btrfs benchmarks before being ill) and thoses nodes star=
t=20
OK with another data partition .

It's very probable that there is corruption somewhere, due to kernel bu=
g=20
, probably triggered by btrfs.

Issue 2563 is probably the same.

I'd like to restart those nodes without formatting them, not because th=
e=20
data is valuable, but because if the same thing happens in production, =
a=20
method similar to "fsck" the node could be of great value.

I saw the method to check the leveldb. Will try tomorrow without garant=
ees.

In the case I could repair, do you think a crashed FS as it is right no=
w=20
is valuable for you, for future reference , as I saw you can't reproduc=
e=20
the problem ? I can make an archive (or a btrfs dump ?), but it will be=
=20
quite big.

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
