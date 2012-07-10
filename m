From: Tommi Virtanen <tv@inktank.com>
Subject: Re: domino-style OSD crash
Date: Tue, 10 Jul 2012 10:11:46 -0700
Message-ID: <CADvuQRGLNfJ5UXMSR141z8Hd3Y7x+vCeZknruCJKE3g4rYrmLw@mail.gmail.com>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
 <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com>
 <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
 <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com>
 <4FF3F98C.30602@univ-nantes.fr> <A1B0B821610446B587EA459CA7D88ECF@inktank.com>
 <4FF48317.5030802@univ-nantes.fr> <CAPYLRzg3vJNGYUwBrZ6e9G6x-URCodAxFLfXRL10T8yOqx+wVQ@mail.gmail.com>
 <4FF6919C.8080201@univ-nantes.fr> <CAPYLRzgb7KU5jBjqWS7GiYc2KqNUXXjcOv=kRoD4cEavotaX0Q@mail.gmail.com>
 <4FF7F120.3040708@univ-nantes.fr> <CA+4uBUYGaUdYr97EqEGCLk9ByhUeXuqeeDyp2bzVRN7GeokePg@mail.gmail.com>
 <4FFBF9F5.9050000@univ-nantes.fr> <CADvuQREX5v9r=Bhyqtv9szx3E3V=2h+2eeCbD+fLyaB06M6gaw@mail.gmail.com>
 <4FFC5AB1.8020301@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52053 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab2GJRMG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 13:12:06 -0400
Received: by pbbrp8 with SMTP id rp8so545955pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 10:12:06 -0700 (PDT)
In-Reply-To: <4FFC5AB1.8020301@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Samuel Just <sam.just@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 10, 2012 at 9:39 AM, Yann Dupont <Yann.Dupont@univ-nantes.fr> wrote:
>> The cluster mechanism was never intended for moving existing osds to
>> other clusters. Trying that might not be a good idea.
> Ok, good to know. I saw that the remaining maps could lead to problem, but
> in 2 words, what are the other associated risks ? Basically If I use 2
> distincts config files,
> with differents & non-overlapping paths, and different ports for OSD, MDS &
> MON, we basically have 2 distincts and independant instances ?

Fundamentally, it comes down to this: the two clusters will still have
the same fsid, and you won't be isolated from configuration errors or
leftover state (such as the monmap) in any way. There's a high chance
that your "let's poke around and debug" cluster wrecks your healthy
cluster.

> By the way, is using 2 mon instance with different ports supported ?

Monitors are identified by ip:port. You can have multiple bind to the
same IP address, as long as they get separate ports.

Naturally, this practically means giving up on high availability.
