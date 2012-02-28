From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: RadosGW problems with copy in s3
Date: Tue, 28 Feb 2012 09:18:42 -0800
Message-ID: <CAC-hyiHSUYv-Mk7RxB-_a8ObePrf9osLRFjj-G2_9Dz6z8v6Vw@mail.gmail.com>
References: <CAMwB3ThF2kTWNDJM9zYOVh0ud29nAoib4yTwNRgiJuacDKh=7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61383 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965403Ab2B1RSn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 12:18:43 -0500
Received: by bkcik5 with SMTP id ik5so1474341bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 09:18:42 -0800 (PST)
In-Reply-To: <CAMwB3ThF2kTWNDJM9zYOVh0ud29nAoib4yTwNRgiJuacDKh=7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Feb 28, 2012 at 3:43 AM, S=B3awomir Skowron
<slawomir.skowron@gmail.com> wrote:
> After some parallel copy command via botto for many files everything,
> going to slow down, and eventualy got timeout from nginx@radosgw.
>
> # ceph -s
> 2012-02-28 12:16:57.818566 =A0 =A0pg v20743: 8516 pgs: 8516 active+cl=
ean;
> 2154 MB data, 53807 MB used, 20240 GB / 21379 GB avail
> 2012-02-28 12:16:57.845274 =A0 mds e1: 0/0/1 up
> 2012-02-28 12:16:57.845307 =A0 osd e719: 78 osds: 78 up, 78 in
> 2012-02-28 12:16:57.845512 =A0 log 2012-02-28 12:14:41.578889 osd.24
> 10.177.64.4:6839/2063 20 : [WRN] old request
> osd_op(client.62138.0:1162 3_.archive/1330427624.13/37828,serwisy.htm=
l
> [delete,create 0~0,setxattr user.rgw.acl (62),setxattr
> user.rgw.content_type (10),setxattr user.rgw.etag (33),setxattr
> user.rgw.idtag,setxattr user.rgw.x-amz-copy-source (33),setxattr
> user.rgw.x-amz-meta-checksum (33),setxattr
> user.rgw.x-amz-metadata-directive (5),setxattr
> user.rgw.x-amz-storage-class (9),setxattr user.rgw.idtag (32),setxatt=
r
> user.rgw.shadow_name (74),clonerange 0~17913 from
> 3_.archive/1330427624.13/37828,serwisy.html_g8DHGgLP7Dhi7YSAzYtu_FGT_=
96NsiF/head
> offset 0] 7.645e07f5) v4 received at 2012-02-28 12:14:10.683511
> currently waiting for sub ops
> 2012-02-28 12:16:57.845622 =A0 mon e3: 3 mons at
> {0=3D10.177.64.4:6789/0,1=3D10.177.64.6:6789/0,2=3D10.177.64.8:6789/0=
}
>
> and other one from ceph -s
>
> 2012-02-28 12:32:16.697642 =A0 =A0pg v21010: 8516 pgs: 8516 active+cl=
ean;
> 2161 MB data, 53839 MB used, 20240 GB / 21379 GB avail
> 2012-02-28 12:32:16.722796 =A0 mds e1: 0/0/1 up
> 2012-02-28 12:32:16.722938 =A0 osd e719: 78 osds: 78 up, 78 in
> 2012-02-28 12:32:16.723204 =A0 log 2012-02-28 12:28:30.015814 osd.24
> 10.177.64.4:6839/2063 78 : [WRN] old request
> osd_op(client.62020.0:3344 .dir.3 [call rgw.bucket_complete_op]
> 7.ccb26a35) v4 received at 2012-02-28 12:27:59.458121 currently
> waiting for sub ops

Looks like osd op takes too long to complete. After how many copies
did this happen?

> 2012-02-28 12:32:16.723327 =A0 mon e3: 3 mons at
> {0=3D10.177.64.4:6789/0,1=3D10.177.64.6:6789/0,2=3D10.177.64.8:6789/0=
}
>
> from nginx timeout after 33 seconds.
>
> 10.177.8.12 - - - [28/Feb/2012:12:14:19 +0100] "PUT
> /www.onet.pl/.archive/1330427624.13/_d/dodatki/887184387c048cb30c88f2=
2169f0f74d%2Cwyslij_belka.gif
> HTTP/1.1" rlength: 528 bsent: 0 rtime: 33.001 urtime: - status: 499
> bbsent: 0 httpref: "-" useragent: "Boto/2.2.2 (linux2)"
>
> Inside attachment logs from radosgw in debug mode.
>
> In normal put, get, head etc, everything works OK. Only parallel copy
> going to be mess i think :).
>
> I see some in radosgw log:
>
> 2012-02-28 12:27:34.774107 7ff99bfef700 can't clone object
> www.onet.pl:.archive/1330428452.43/_d/dodatki/887184387c048cb30c88f22=
169f0f74d,wyslij_belka.gif
> to shadow object, tag/shadow_obj haven't been set

That's normal.

>
> and
>
> 2012-02-28 12:27:52.798272 7ff99bfef700 prepare_atomic_for_write_impl=
:
> state is not atomic. state=3D0x7ff93c02cd58

That's normal too.
>
> I use ceph 0.42 with ext4 as local filesystems, maybe xattr in ext4
> make that problem ??.
>

Don't think so. Looking above, the used xattrs size are much less than
that. Can you reproduce with 'debug ms =3D 1', and provide the osd logs
too?

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
