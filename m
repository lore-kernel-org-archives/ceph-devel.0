From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: domino-style OSD crash
Date: Mon, 09 Jul 2012 21:05:04 +0200
Message-ID: <4FFB2B60.5000201@univ-nantes.fr>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com> <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com> <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com> <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com> <4FF3F98C.30602@univ-nantes.fr> <CADvuQRFQCrQn3dF=r6VLPo3Q5vBVvCROowa99Rfak=qkbXb0rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:41968 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751242Ab2GITFN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 15:05:13 -0400
In-Reply-To: <CADvuQRFQCrQn3dF=r6VLPo3Q5vBVvCROowa99Rfak=qkbXb0rA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 09/07/2012 19:43, Tommi Virtanen a =C3=A9crit :
> On Wed, Jul 4, 2012 at 1:06 AM, Yann Dupont <Yann.Dupont@univ-nantes.=
fr> wrote:
>> Well, I probably wasn't clear enough. I talked about crashed FS, but=
 i was
>> talking about ceph. The underlying FS (btrfs in that case) of 1 node=
 (and
>> only one) has PROBABLY crashed in the past, causing corruption in ce=
ph data
>> on this node, and then the subsequent crash of other nodes.
>>
>> RIGHT now btrfs on this node is OK. I can access the filesystem with=
out
>> errors.
> But the LevelDB isn't. It's contents got corrupted, somehow somewhere=
,
> and it really is up to the LevelDB library to tolerate those errors;
> we have a simple get/put interface we use, and LevelDB is triggering
> an internal error.
Yes, understood.

>> One node had problem with btrfs, leading first to kernel problem , p=
robably
>> corruption (in disk/ in memory maybe ?) ,and ultimately to a kernel =
oops.
>> Before that ultimate kernel oops, bad data has been transmitted to o=
ther
>> (sane) nodes, leading to ceph-osd crash on thoses nodes.
> The LevelDB binary contents are not transferred over to other nodes;
Ok thanks for the clarification ;
> this kind of corruption would not spread over the Ceph clustering
> mechanisms. It's more likely that you have 4 independently corrupted
> LevelDBs. Something in the workload Ceph runs makes that corruption
> quite likely.
Very likely : since I reformatted my nodes with XFS I don't have=20
problems so far.
>
> The information here isn't enough to say whether the cause of the
> corruption is btrfs or LevelDB, but the recovery needs to handled by
> LevelDB -- and upstream is working on making it more robust:
> http://code.google.com/p/leveldb/issues/detail?id=3D97
Yes, saw this. It's very important. Sometimes, s... happens. In respect=
=20
to the size ceph volumes can reach, having a tool to restart damaged=20
nodes (for whatever reason) is a must.

Thanks for the time you took to answer. It's much clearer for me now.

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
