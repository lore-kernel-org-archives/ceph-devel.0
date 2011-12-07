From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Client receives 'connection refused' only after heavy use
Date: Tue, 6 Dec 2011 21:49:23 -0800
Message-ID: <CAF3hT9A=cRttnho5DhF991+UnwCfxGO5sDtvU8AmBXMfEhg_Qg@mail.gmail.com>
References: <4EDC0ECF.60805@cs.ucsc.edu>
	<4EDC1853.5080405@cs.ucsc.edu>
	<Pine.LNX.4.64.1112042046280.8414@cobra.newdream.net>
	<4EDD1437.4030608@cs.ucsc.edu>
	<CAORUGqCZy+j3MUry7ut=E7YXNiPHLGSqRw5qyqaOKR2=12mjhA@mail.gmail.com>
	<4EDD15EC.1000900@cs.ucsc.edu>
	<CAORUGqATJ=xcs3GPQkdqN5q4MjQcEYewj_aJhq2DVa=m95TLww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62095 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab1LGFtY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 00:49:24 -0500
Received: by iakc1 with SMTP id c1so375551iak.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2011 21:49:23 -0800 (PST)
In-Reply-To: <CAORUGqATJ=xcs3GPQkdqN5q4MjQcEYewj_aJhq2DVa=m95TLww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Looks like these are all sockets that don't get closed because we send
the associated Pipes into reconnect, but they never actually do so
(and never move on out of it into shutting down). We made some changes
to how reconnect and cleanup are done that probably weren't
complete/missed a case. (Maybe only clients actually try to reconnect,
but everybody goes into that state?)
=46or tomorrow!

On Mon, Dec 5, 2011 at 11:36 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Mon, Dec 5, 2011 at 11:05, Noah Watkins <jayhawk@cs.ucsc.edu> wrot=
e:
>> root@issdm-23:~# lsof -n -p 1394
>> COMMAND =A0 PID USER =A0 FD =A0 TYPE =A0 =A0 =A0 =A0 =A0 =A0 DEVICE =
SIZE/OFF =A0 =A0NODE NAME
>> ceph-mds 1394 root =A0 12u =A0sock =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00,=
6 =A0 =A0 =A00t0 =A0 11560 can't
>> identify protocol
>
> There's 506 of these guys in the listing. I would say there's a leak
> of sockets that get created with socket(2), but don't get bind(2) or
> connect(2) called on them.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
