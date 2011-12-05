From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Client receives 'connection refused' only after heavy use
Date: Mon, 5 Dec 2011 11:36:47 -0800
Message-ID: <CAORUGqATJ=xcs3GPQkdqN5q4MjQcEYewj_aJhq2DVa=m95TLww@mail.gmail.com>
References: <4EDC0ECF.60805@cs.ucsc.edu> <4EDC1853.5080405@cs.ucsc.edu>
 <Pine.LNX.4.64.1112042046280.8414@cobra.newdream.net> <4EDD1437.4030608@cs.ucsc.edu>
 <CAORUGqCZy+j3MUry7ut=E7YXNiPHLGSqRw5qyqaOKR2=12mjhA@mail.gmail.com> <4EDD15EC.1000900@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53746 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab1LEThK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 14:37:10 -0500
Received: by faar15 with SMTP id r15so991606faa.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Dec 2011 11:37:08 -0800 (PST)
In-Reply-To: <4EDD15EC.1000900@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Mon, Dec 5, 2011 at 11:05, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> root@issdm-23:~# lsof -n -p 1394
> COMMAND =C2=A0 PID USER =C2=A0 FD =C2=A0 TYPE =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 DEVICE SIZE/OFF =C2=A0 =C2=A0NODE NAME
> ceph-mds 1394 root =C2=A0 12u =C2=A0sock =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00,6 =C2=A0 =C2=A0 =C2=A00t0 =C2=A0 11560 can=
't
> identify protocol

There's 506 of these guys in the listing. I would say there's a leak
of sockets that get created with socket(2), but don't get bind(2) or
connect(2) called on them.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
