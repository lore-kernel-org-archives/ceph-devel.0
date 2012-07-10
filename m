From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: domino-style OSD crash
Date: Tue, 10 Jul 2012 19:36:01 +0200
Message-ID: <4FFC6801.40509@univ-nantes.fr>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com> <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com> <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com> <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com> <4FF3F98C.30602@univ-nantes.fr> <A1B0B821610446B587EA459CA7D88ECF@inktank.com> <4FF48317.5030802@univ-nantes.fr> <CAPYLRzg3vJNGYUwBrZ6e9G6x-URCodAxFLfXRL10T8yOqx+wVQ@mail.gmail.com> <4FF6919C.8080201@univ-nantes.fr> <CAPYLRzgb7KU5jBjqWS7GiYc2KqNUXXjcOv=kRoD4cEavotaX0Q@mail.gmail.com> <4FF7F120.3040708@univ-nantes.fr> <CA+4uBUYGaUdYr97EqEGCLk9ByhUeXuqeeDyp2bzVRN7GeokePg@mail.gmail.com> <4FFBF9F5.9050000@univ
 -nantes.fr> <CADvuQREX5v9r=Bhyqtv9szx3E3V=2h+2eeCbD+fLyaB06M6gaw@mail.gmail.com> <4FFC5AB1.8020301@univ-nantes.fr> <CADvuQRGLNfJ5UXMSR141z8Hd3Y7x+vCeZknruCJKE3g4rYrmLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls2-lmb.cpub.univ-nantes.fr ([193.52.103.111]:40672 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752421Ab2GJRgH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 13:36:07 -0400
In-Reply-To: <CADvuQRGLNfJ5UXMSR141z8Hd3Y7x+vCeZknruCJKE3g4rYrmLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Le 10/07/2012 19:11, Tommi Virtanen a =C3=A9crit :
> On Tue, Jul 10, 2012 at 9:39 AM, Yann Dupont <Yann.Dupont@univ-nantes=
=2Efr> wrote:
>>> The cluster mechanism was never intended for moving existing osds t=
o
>>> other clusters. Trying that might not be a good idea.
>> Ok, good to know. I saw that the remaining maps could lead to proble=
m, but
>> in 2 words, what are the other associated risks ? Basically If I use=
 2
>> distincts config files,
>> with differents & non-overlapping paths, and different ports for OSD=
, MDS &
>> MON, we basically have 2 distincts and independant instances ?
> Fundamentally, it comes down to this: the two clusters will still hav=
e
> the same fsid, and you won't be isolated from configuration errors or

Ah I understand. This is not the case : see :

root@chichibu:~# cat /CEPH/data/osd.0/fsid
f00139fe-478e-4c50-80e2-f7cb359100d4
root@chichibu:~# cat /CEPH-PROD/data/osd.0/fsid
43afd025-330e-4aa8-9324-3e9b0afce794

(CEPH-PROD is the old btrfs volume ). /CEPH is new xfs volume,=20
completely redone & reformatted with mkcephfs. The volumes are totally=20
independant :

if you want the gore details :

root@chichibu:~# lvs
   LV              VG             Attr   LSize   Origin Snap%  Move Log=
=20
Copy%  Convert
   ceph-osd        LocalDisk      -wi-a- 225,00g
   mon-btrfs       LocalDisk      -wi-ao 10,00g
   mon-xfs         LocalDisk      -wi-ao 10,00g
   data            ceph-chichibu  -wi-ao   5,00t    <- OLD btrfs,=20
mounted on /CEPH-PROD
   data            xceph-chichibu -wi-ao   4,50t   <- NEW xfs, mounted=20
on /CEPH

> leftover state (such as the monmap) in any way. There's a high chance
> that your "let's poke around and debug" cluster wrecks your healthy
> cluster.

Yes I understand the risk.

>> By the way, is using 2 mon instance with different ports supported ?
> Monitors are identified by ip:port. You can have multiple bind to the
> same IP address, as long as they get separate ports.
>
> Naturally, this practically means giving up on high availability.

The idea is not just having 2 mon. I'll still use 3 differents machines=
=20
for mon, but with 2 mon instance on each. One for the current ceph, the=
=20
other for the old ceph.
2x3 Mon.

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
