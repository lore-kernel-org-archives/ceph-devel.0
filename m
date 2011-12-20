From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how can I achieve HA with ceph?
Date: Tue, 20 Dec 2011 14:50:09 -0800
Message-ID: <CAF3hT9BuP7AbSVC89VLngQMrwYztMx-p77Cj3sO_Pu1GTN6ayA@mail.gmail.com>
References: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
	<CAF3hT9C_gMsYSbe7L5KeYGqGkPaDxeNV8bdfD7EZPbKDE8pjQQ@mail.gmail.com>
	<CA+o_KftLn70adfmD7FGFoVq6YNfOUaFddGdw--9KTsPL12f8pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50273 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1LTWuJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 17:50:09 -0500
Received: by ggdk6 with SMTP id k6so5133151ggd.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2011 14:50:09 -0800 (PST)
In-Reply-To: <CA+o_KftLn70adfmD7FGFoVq6YNfOUaFddGdw--9KTsPL12f8pQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karoly Horvath <rhswdev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Dec 20, 2011 at 10:07 AM, Karoly Horvath <rhswdev@gmail.com> wr=
ote:
> Hi,
> all test were made with kill -9, killing the active mds (and sometime=
s
> other processes).I waited a couple of minutes between each test to
> make sure that the cluster reached a stable state.(btw: how can I
> check this programmatically?)
You can run "ceph health", which has only a few different values you
can look for. :)

> # =A0KILLED =A0 =A0 =A0 =A0 =A0 result1. mds @ beta =A0 =A0 =A0 OK2. =
mds @ alpha
> OK3. mds+osd @ beta =A0 FAILED=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 switch ok
> {0=3Dalpha=3Dup:active}, but FS not readable=A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 FS
> permanently freezed=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rebooted t=
he whole cluster4.
> mds+mon @ alpha =A0OK (32 sec)=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 rebooted the whole
> cluster5. mds+osd @ beta =A0 OK (25 sec)=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 rebooted the
> whole cluster6. mds+osd @ beta =A0 OK (24 sec)7. mds+osd @ alpha =A0O=
K (30
> sec)8. mds+mon+osd @ beta =A0OK (27 sec)9. power unplug @ alpha FAILE=
D
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stuck in {0=3Dbeta=3Dup:replay} fo=
r a long time
> =A0=A0 =A0 =A0 =A0 finally it's switching to {0=3Dalpha=3Dup:active},=
 but FS not
> readable=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FS permanently freeze=
d, even when bringing
> up alpha...
Your formatting got pretty mangled here, and I'm still not sure what's
going on. Did you restart all the daemons between each kill attempt?
(for instance, it looks like '1' is to kill mds.beta; '2' is to kill
mds.alpha, and then '3' is to kill mds.beta =97 but you already did
that)

> I uploaded test results here:
> http://www.4shared.com/file/5nXMw_sM/cephlogs_mds_test.html?
> If you need any other configuration options changed, let me know
Sorry, I should have been clearer when I said turn on mds logging. Add
"debug mds =3D 20" and "debug ms =3D 1" lines to your ceph.conf MDS
sections. This will spit out a lot more information about what's going
on internally, which will help us diagnose this. :)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
