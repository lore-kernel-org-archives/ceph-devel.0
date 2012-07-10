From: Tommi Virtanen <tv@inktank.com>
Subject: Re: domino-style OSD crash
Date: Tue, 10 Jul 2012 11:16:02 -0700
Message-ID: <CADvuQRHYb2vYxFeKuztXHc-i1yV8M10jjNYKJvQNMo41iVcdpg@mail.gmail.com>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
 <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com>
 <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
 <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com>
 <4FF3F98C.30602@univ-nantes.fr> <A1B0B821610446B587EA459CA7D88ECF@inktank.com>
 <4FF48317.5030802@univ-nantes.fr> <CAPYLRzg3vJNGYUwBrZ6e9G6x-URCodAxFLfXRL10T8yOqx+wVQ@mail.gmail.com>
 <4FF6919C.8080201@univ-nantes.fr> <CAPYLRzgb7KU5jBjqWS7GiYc2KqNUXXjcOv=kRoD4cEavotaX0Q@mail.gmail.com>
 <4FF7F120.3040708@univ-nantes.fr> <CA+4uBUYGaUdYr97EqEGCLk9ByhUeXuqeeDyp2bzVRN7GeokePg@mail.gmail.com>
 <4FFBF9F5.9050000@univ-nantes.fr> <CADvuQREX5v9r=Bhyqtv9szx3E3V=2h+2eeCbD+fLyaB06M6gaw@mail.gmail.com>
 <4FFC5AB1.8020301@univ-nantes.fr> <CADvuQRGLNfJ5UXMSR141z8Hd3Y7x+vCeZknruCJKE3g4rYrmLw@mail.gmail.com>
 <4FFC6801.40509@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:46958 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2GJSQX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 14:16:23 -0400
Received: by gglu4 with SMTP id u4so318431ggl.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 11:16:23 -0700 (PDT)
In-Reply-To: <4FFC6801.40509@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Samuel Just <sam.just@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 10, 2012 at 10:36 AM, Yann Dupont
<Yann.Dupont@univ-nantes.fr> wrote:
>> Fundamentally, it comes down to this: the two clusters will still have
>> the same fsid, and you won't be isolated from configuration errors or
> (CEPH-PROD is the old btrfs volume ). /CEPH is new xfs volume, completely
> redone & reformatted with mkcephfs. The volumes are totally independant :

Ahh you re-created the monitors too. That changes things, then you
have a new random fsid. I understood you only re-mkfsed the osd.

Doing it like that, your real worry is just the remembered state of
monmaps, osdmaps etc. If the daemons accidentally talk to the wrong
cluster, the fsid *should* protect you from damage; they should get
rejected. Similarly, if you use cephx authentication, the keys won't
match either.

>> Naturally, this practically means giving up on high availability.
> The idea is not just having 2 mon. I'll still use 3 differents machines for
> mon, but with 2 mon instance on each. One for the current ceph, the other
> for the old ceph.
> 2x3 Mon.

That should be perfectly doable.
