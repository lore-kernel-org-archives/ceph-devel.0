From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Ceph hangs when accessed
Date: Tue, 27 Sep 2011 09:32:24 -0700
Message-ID: <CAORUGqAoe1=DTNMw43e9LRbaLVrEqw_4koYZiYfVrwJfmUzXCg@mail.gmail.com>
References: <1801183894.301109.1316793492464.JavaMail.root@zmbs4.inria.fr>
 <1316798414.2822.33.camel@wido-laptop> <AB162BB9-8DFB-42CF-93E7-85460723CE7C@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50062 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab1I0Qcp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Sep 2011 12:32:45 -0400
Received: by wyg34 with SMTP id 34so7392613wyg.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Sep 2011 09:32:44 -0700 (PDT)
In-Reply-To: <AB162BB9-8DFB-42CF-93E7-85460723CE7C@inria.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?C=C3=A9dric_Morandin?= <cedric.morandin@inria.fr>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Mon, Sep 26, 2011 at 14:23, C=C3=A9dric Morandin <cedric.morandin@in=
ria.fr> wrote:
> 2011-09-26 23:07:49.404867 =C2=A0 osd e13: 4 osds: 2 up, 4 in
=2E..
> 2011-09-26 22:57:06.822182 7faf6a6f8700 -- 138.96.126.92:6802/3157 >>=
 138.96.126.93:6801/3162 pipe(0x7faf50001320 sd=3D20 pgs=3D0 cs=3D0 l=3D=
0).accept connect_seq 2 vs existing 1 state 3
> 2011-09-26 23:07:09.084901 7faf8e1b5700 FileStore: sync_entry timed o=
ut after 600 seconds.
> =C2=A0ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f=
6d6)

And earlier you said the OSDs are using btrfs. That definitely sounds
like a btrfs bug, then.

Do the osd machines have anything interesting in dmesg or /var/log/kern=
=2Elog ?

You may want to try a newer kernel, or running on ext4 for now.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
