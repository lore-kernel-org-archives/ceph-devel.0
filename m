From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: domino-style OSD crash
Date: Tue, 10 Jul 2012 11:46:29 +0200
Message-ID: <4FFBF9F5.9050000@univ-nantes.fr>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com> <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com> <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com> <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com> <4FF3F98C.30602@univ-nantes.fr> <A1B0B821610446B587EA459CA7D88ECF@inktank.com> <4FF48317.5030802@univ-nantes.fr> <CAPYLRzg3vJNGYUwBrZ6e9G6x-URCodAxFLfXRL10T8yOqx+wVQ@mail.gmail.com> <4FF6919C.8080201@univ-nantes.fr> <CAPYLRzgb7KU5jBjqWS7GiYc2KqNUXXjcOv=kRoD4cEavotaX0Q@mail.gmail.com> <4FF7F120.3040708@univ-nantes.fr> <CA+4uBUYGaUdYr97EqEGCLk9ByhUeXuqeeDyp2bzVRN7GeokePg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-lmb.cpub.univ-nantes.fr ([193.52.103.110]:33745 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753613Ab2GJJqh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 05:46:37 -0400
In-Reply-To: <CA+4uBUYGaUdYr97EqEGCLk9ByhUeXuqeeDyp2bzVRN7GeokePg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 09/07/2012 19:14, Samuel Just a =E9crit :
> Can you restart the node that failed to complete the upgrade with

Well, it's a little big complicated ; I now run those nodes with XFS,=20
and I've long-running jobs on it right now, so I can't stop the ceph=20
cluster at the moment.

As I've keeped the original broken btrfs volumes, I tried this morning=20
to run the old osd in parrallel, using the $cluster variable. I only=20
have partial success.
I tried using different port for the mons, but ceph want to use the old=
=20
mon map. I can edit it (epoch 1) but it seems to use 'latest' instead,=20
the format isn't compatible with monmaptool and I don't know how to=20
"inject" the modified on a non running cluster.

Anyway, osd seems to start fine, and I can reproduce the bug :
> debug filestore =3D 20
> debug osd =3D 20
>

I've put it in [global], is it sufficient ?

>
> and post the log after an hour or so of running?  The upgrade process
> might legitimately take a while.
> -Sam
Only 15 minutes running, but ceph-osd is consumming lots of cpu, and a=20
strace shows lots of pread.

Here is the log :

[..]
2012-07-10 11:33:29.560052 7f3e615ac780  0=20
filestore(/CEPH-PROD/data/osd.1) mount syncfs(2) syscall not support by=
=20
glibc
2012-07-10 11:33:29.560062 7f3e615ac780  0=20
filestore(/CEPH-PROD/data/osd.1) mount no syncfs(2), but the btrfs SYNC=
=20
ioctl will suffice
2012-07-10 11:33:29.560172 7f3e615ac780 -1=20
filestore(/CEPH-PROD/data/osd.1) FileStore::mount : stale version stamp=
=20
detected: 2. Proceeding, do_update is set, performing disk format upgra=
de.
2012-07-10 11:33:29.560233 7f3e615ac780  0=20
filestore(/CEPH-PROD/data/osd.1) mount found snaps <3744666,3746725>
2012-07-10 11:33:29.560263 7f3e615ac780 10=20
filestore(/CEPH-PROD/data/osd.1)  current/ seq was 3746725
2012-07-10 11:33:29.560267 7f3e615ac780 10=20
filestore(/CEPH-PROD/data/osd.1)  most recent snap from=20
<3744666,3746725> is 3746725
2012-07-10 11:33:29.560280 7f3e615ac780 10=20
filestore(/CEPH-PROD/data/osd.1) mount rolling back to consistent snap=20
3746725
2012-07-10 11:33:29.839281 7f3e615ac780  5=20
filestore(/CEPH-PROD/data/osd.1) mount op_seq is 3746725


=2E.. and nothing more.

I'll let him running for 3 hours. If I have another message, I'll let=20
you know.

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
