From: Koleos Fuscus <koleosfuscus@gmail.com>
Subject: Re: erasure code and coefficients
Date: Sun, 29 Jun 2014 20:38:53 +0200
Message-ID: <CACUN8h3rxRmBkMD7dWJgp3yiJ6Qm9TvJptGSfsUgL-bAyoQi8Q@mail.gmail.com>
References: <53AFDC99.9010009@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33182 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbaF2Siy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Jun 2014 14:38:54 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so3582195igb.5
        for <ceph-devel@vger.kernel.org>; Sun, 29 Jun 2014 11:38:53 -0700 (PDT)
In-Reply-To: <53AFDC99.9010009@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>, Ceph Development <ceph-devel@vger.kernel.org>

Hello Loic,
Dimakis (one of the authors of xorbas) is talking about coefficients
because they want to find a way to reduce the storage overhead used
with LRC. In the simple case used in Fig. 2, a RS (k=3D10, m=3D4) has
14/10 storage overhead but when using LRC, the overhead increases to
17/10 because you also need to store s1, s2 and s3. Basically, the
idea is to find specific coefficients c1..c10 that permit to obtain s3
through s1 and s2. In other words, get some s1 and s2 that when xored
together give s3. If you find such coefficients, you don't need to
store s3 and the storage overhead of LRC is 1.6x instead of 1.7x.

Dimakis said that for the Reed Solomon implementation used in HDFS
RAID they can simple set all coefficients with value '1' and use xor.

This cannot be the case of the Reed Solomon implemented by you (I
understood is the jerasure library by Plank) but that I am not sure. I
guess we need the help of a mathematician or at least check and
compare both implementations.

=46inally, apparently for xorbas they only implemented the configuratio=
n
RS(10,4) and not other combinations. Unfortunately, the wiki page of
the project is empty http://wiki.apache.org/hadoop/ErasureCode and the
main page says 'erasure coding under development'.

I recommend you to watch the xorbas presentation video
http://smahesh.com/HadoopUSC/ (a very clear explanation of xorbas) and
use the Dimakis wiki page to check the large collection of paper they
have: http://storagewiki.ece.utexas.edu/

Best,

koleosfuscus

________________________________________________________________
"My reply is: the software has no known bugs, therefore it has not
been updated."
Wietse Venema


On Sun, Jun 29, 2014 at 11:30 AM, Loic Dachary <loic@dachary.org> wrote=
:
> Hi Andreas,
>
> In http://anrg.usc.edu/~maheswaran/Xorbas.pdf I get the idea of compu=
ting local coding chunks the way it is implemented in https://github.co=
m/ceph/ceph/pull/1921 (i.e. delegating encoding / decoding to other plu=
gins). However, there are theoretical aspects of the paper that I do no=
t understand and I'm hoping you can shed some light on it. In particula=
r, I don't know what "coefficients" are about. For instance in the cont=
ext of Figure 2 caption : "The main theoretical challenge is to choose =
the coeffi cients c(i) to maximize the fault tolerance of the code."
>
> Would you recommend a paper to read to better understand this ? Also =
I'd like to understand what "coefficients" mean in the context of jeras=
ure or if they do not apply.
>
> Thanks for you help :-)
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
