From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: domino-style OSD crash
Date: Wed, 04 Jul 2012 10:06:36 +0200
Message-ID: <4FF3F98C.30602@univ-nantes.fr>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com> <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com> <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com> <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls2-lmb.cpub.univ-nantes.fr ([193.52.103.111]:56687 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933681Ab2GDIGr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 04:06:47 -0400
In-Reply-To: <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 03/07/2012 23:38, Tommi Virtanen a =C3=A9crit :
> On Tue, Jul 3, 2012 at 1:54 PM, Yann Dupont <Yann.Dupont@univ-nantes.=
fr> wrote:
>> In the case I could repair, do you think a crashed FS as it is right=
 now is
>> valuable for you, for future reference , as I saw you can't reproduc=
e the
>> problem ? I can make an archive (or a btrfs dump ?), but it will be =
quite
>> big.
> At this point, it's more about the upstream developers (of btrfs etc)
> than us; we're on good terms with them but not experts on the on-disk
> format(s). You might want to send an email to the relevant mailing
> lists before wiping the disks.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
Well, I probably wasn't clear enough. I talked about crashed FS, but i=20
was talking about ceph. The underlying FS (btrfs in that case) of 1 nod=
e=20
(and only one) has PROBABLY crashed in the past, causing corruption in=20
ceph data on this node, and then the subsequent crash of other nodes.

RIGHT now btrfs on this node is OK. I can access the filesystem without=
=20
errors.

=46or the moment, on 8 nodes, 4 refuse to restart .
1 of the 4 nodes was the crashed node , the 3 others didn't had broblem=
=20
with the underlying fs as far as I can tell.

So I think the scenario is :

One node had problem with btrfs, leading first to kernel problem ,=20
probably corruption (in disk/ in memory maybe ?) ,and ultimately to a=20
kernel oops. Before that ultimate kernel oops, bad data has been=20
transmitted to other (sane) nodes, leading to ceph-osd crash on thoses=20
nodes.

If you think this scenario is highly improbable in real life (that is,=20
btrfs will probably be fixed for good, and then, corruption can't=20
happen), it's ok.

But I wonder if this scenario can be triggered with other problem, and=20
bad data can be transmitted to other sane nodes (power outage, out of=20
memory condition, disk full... for example)

That's why I proposed you a crashed ceph volume image (I shouldn't have=
=20
talked about a crashed fs, sorry for the confusion)

Talking about btrfs, there is a lot of fixes in btrfs between 3.4 and=20
3.5rc. After the crash, I couldn't mount the btrfs volume. With 3.5rc I=
=20
can , and there is no sign of problem on it. It does'nt mean data is=20
safe there, but i think it's a sign that at least, some bugs have been=20
corrected in btrfs code.

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
