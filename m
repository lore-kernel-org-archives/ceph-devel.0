From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: oops in rbd module (con_work in libceph)
Date: Thu, 12 Jul 2012 22:20:30 +0200
Message-ID: <4FFF318E.9090603@univ-nantes.fr>
References: <4FF6A27B.7020808@univ-nantes.fr> <4FF705BA.4080501@univ-nantes.fr> <4FF77FE8.9040408@inktank.com> <4FFB0CBA.6090806@univ-nantes.fr> <4FFB0F2A.6070601@univ-nantes.fr> <CAPYLRzj0=hs5BYrG2veYMBUOaU1HmAJoBRPdwj1y3PuMUveb0w@mail.gmail.com> <4FFDE0C6.50807@univ-nantes.fr> <4FFE7998.9020002@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:46997 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756026Ab2GLUUm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 16:20:42 -0400
In-Reply-To: <4FFE7998.9020002@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Gregory Farnum <greg@inktank.com>, Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 12/07/2012 09:15, Yann Dupont a =E9crit :
> Le 11/07/2012 22:23, Yann Dupont a =E9crit :
>> Le 10/07/2012 19:46, Gregory Farnum a =E9crit :
>>>
>>>
>>> Each time, at the exact date, a bad CRC (they are the only ones for=
=20
>>> this
>>> day, so it seems related)
>>> Yes; a bad CRC should cause the socket to close =97 that's intended
>>> behavior (although you might want to look into why that's happening=
,
>> ah ! very interesting ! 3.2 is ok, 3.4 not (even with latest=20
>> ceph-client patch).
Really 3.3.0 is OK, 3.4.0 not. This was my git bisect starting point.

with a "good kernel", make -j24 on a linux kernel tree is working ok fo=
r=20
at least 10 minutes.
On a "bad kernel", during make -j24 I see quite quickly (some minutes) =
=20
messages about socket closed, and, then , the kernel oops.

>> the 8 nodes are similar (poweredge M610, intel 10 Gb), but the clien=
t=20
>> is not : Also M610 (older) but with brocade 10Gb.
>>
> It is broadcom 10 Gb, not brocade . sorry for the confusion
>
Probably not related.

here is the offending patch as found by git bisect. It's a merge, not=20
containing code by itself :/
commit : 69e1aaddd63104f37021d0b0f6abfd9623c9134c. It's ext4 related .=20
Not sure ext4 itself is to blame, I'm thinking of a race with rbd.

I wish it was an individual patch, not a merge request ? but I'm not a=20
git expert, I've done the git bisect manually. Maybe I missed a bad=20
kernel during my test.

BTW, the patch just before this one (show by  git log ) is
56b59b429b4c26e5e730bc8c3d837de9f7d0a966 which is a ceph merge, maybe=20
related too ?



here is the git bisect log if that matters:

git bisect start
# bad: [76e10d158efb6d4516018846f60c2ab5501900bc] Linux 3.4
git bisect bad 76e10d158efb6d4516018846f60c2ab5501900bc
# good: [c16fa4f2ad19908a47c63d8fa436a1178438c7e7] Linux 3.3
git bisect good c16fa4f2ad19908a47c63d8fa436a1178438c7e7
# good: [141124c02059eee9dbc5c86ea797b1ca888e77f7] Delete all instances=
=20
of asm/system.h
git bisect good 141124c02059eee9dbc5c86ea797b1ca888e77f7
# bad: [55a320308902f7a0746569ee57eeb3f254e6ed16] Merge branch=20
'irqdomain/merge' of git://git.secretlab.ca/git/linux-2.6
git bisect bad 55a320308902f7a0746569ee57eeb3f254e6ed16
# good: [281b05392fc2cb26209b4d85abaf4889ab1991f3] Merge tag 'soc' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 281b05392fc2cb26209b4d85abaf4889ab1991f3
# bad: [a8364d5555b2030d093cde0f07951628e55454e1] slub: only IPI CPUs=20
that have per cpu obj to flush
git bisect bad a8364d5555b2030d093cde0f07951628e55454e1
# good: [66f03c614c0902ccf7d6160459362a9352f33271] Merge tag 'dt' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 66f03c614c0902ccf7d6160459362a9352f33271
# good: [30eebb54b13ef198a3f1a143ee9dd68f295c60de] Merge branch 'next'=20
of git://git.monstr.eu/linux-2.6-microblaze
git bisect good 30eebb54b13ef198a3f1a143ee9dd68f295c60de
# good: [56b59b429b4c26e5e730bc8c3d837de9f7d0a966] Merge branch=20
'for-linus' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client
git bisect good 56b59b429b4c26e5e730bc8c3d837de9f7d0a966
# good: [31d4f3a2f3c73f279ff96a7135d7202ef6833f12] ext4: check for zero=
=20
length extent
git bisect good 31d4f3a2f3c73f279ff96a7135d7202ef6833f12
# good: [21e7fd22a5a0ca83befe12c58cced21975dab213] ext4: fix trimmed=20
block count accunting
git bisect good 21e7fd22a5a0ca83befe12c58cced21975dab213
# bad: [69e1aaddd63104f37021d0b0f6abfd9623c9134c] Merge tag=20
'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso=
/ext4
git bisect bad 69e1aaddd63104f37021d0b0f6abfd9623c9134c
# good: [1b8b9750f07cdd6e13f12c06ae7ec853f2abbe6c] ext4: do not mark=20
superblock as dirty unnecessarily
git bisect good 1b8b9750f07cdd6e13f12c06ae7ec853f2abbe6c
# good: [182f514f883abb5f942c94e61c371c4b406352d4] ext4: remove useless=
=20
s_dirt assignment
git bisect good 182f514f883abb5f942c94e61c371c4b406352d4
# good: [9d547c35799a4ddd235f1565cec2fff6c9263504] vfs: remove unused=20
superblock helpers


Tomorrow I'll try to see if I made errors on my git bisect. I'll also=20
try to format the rbd with xfs to see if it's really ext4 related.

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber :Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
