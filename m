From: Tomasz Kusmierz <tom.kusmierz@gmail.com>
Subject: Performance questions.
Date: Sat, 4 Nov 2017 21:05:33 +0000
Message-ID: <0BAD3738-0B5F-4662-B42A-8D4BDD817911@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:46481 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdKDVFg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Nov 2017 17:05:36 -0400
Received: by mail-wm0-f52.google.com with SMTP id r68so7277414wmr.1
        for <ceph-devel@vger.kernel.org>; Sat, 04 Nov 2017 14:05:36 -0700 (PDT)
Received: from tomaszs-mbp.vixake.com (host86-151-122-47.range86-151.btcentralplus.com. [86.151.122.47])
        by smtp.gmail.com with ESMTPSA id b9sm11484431wrf.59.2017.11.04.14.05.33
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2017 14:05:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Gentleman,=20

I don=E2=80=99t want this to sound too pretentious but when running =
ceph, under certain loads it curiously feels like watching a sci-fi =
movie from 80=E2=80=99s where computers where spitting out letter after =
letter.

I=E2=80=99ve just sat in front of terminal watching=20
rm -rf /certain_folder=20
taking ~23 minutes to delete 88100 files on cephfs. I=E2=80=99ve =
seriously seen file after file being deleted (hence the reference to =
movies like alien etc)

So this is just a simple =E2=80=9Ctest box=E2=80=9D which runs a single =
node ceph installation with 4 osd. There is _nothing_ else running on =
this cephfs =E2=80=A6 machine is stable for 30 minutes before running =
the command =E2=80=A6 It just seems very odd. I use this server (at my =
home) to test stuff before I put it into production.=20

Worst part is that in production on system with 3 node X 4 osd where =
everything sits in RDB (not cephfs) I see pretty much the same behaviour =
=E2=80=A6 writes take way to long than they should, latencies are =
horrendous and when for example CCTV drops 5GB of footage during =
scheduled process - everything grind to a halt and most of other VM=E2=80=99=
s are nearly inaccessible, CCTV can=E2=80=99t even store any file on =
it=E2=80=99s own FS.

I do run everything more or less =E2=80=9Cout of the box=E2=80=9D. Even =
on home setup when I pump large file into cephfs (other pc -> samba -> =
server folder -> mounted cephfs) every 2gb everything just halts and =
ceph tries to =E2=80=9Ccatch up=E2=80=9D because there is no network IO =
but disks are chugging away.

Is there anything a poor schmuck can do to get most out of their =
hardware ? I=E2=80=99ve tried going down the route of enabling async for =
messenger with:
ms_type =3D async
but that seem to give zero benefit.


ps. lot of documentation seems dated, specially that bluestor is just =
=E2=80=9Cmentioned=E2=80=9D few times =E2=80=A6 =20=
