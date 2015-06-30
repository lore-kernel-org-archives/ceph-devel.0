From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Inline dedup/compression
Date: Tue, 30 Jun 2015 16:38:53 +0200 (CEST)
Message-ID: <829734455.4198040.1435675133732.JavaMail.zimbra@oxygem.tv>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com> <CACJqLybMy1Tfr8baZMbv268gbmeBpG7uJuvbkrnQ9pjdn-AOvA@mail.gmail.com> <99767EA2E27DD44DB4E9F9B9ACA458C03B3198B4@SSIEXCH-MB3.ssi.samsung.com> <CACJqLyY2P0_O-MRs9MoH1oVg8jESc0EoAjSq4dYmVjH=K0a0mQ@mail.gmail.com> <99767EA2E27DD44DB4E9F9B9ACA458C03B319BBA@SSIEXCH-MB3.ssi.samsung.com> <CACJqLyY_FYYx9AvK5ShfN+NUKiz25S=w4qPa36sEYN8hFOy-jg@mail.gmail.com> <CA+z5Dsw5_5zNKwDiGA22jGaRYh=KhD8u0not0u36iw=nqT7h5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:59460 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbbF3OjA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jun 2015 10:39:00 -0400
In-Reply-To: <CA+z5Dsw5_5zNKwDiGA22jGaRYh=KhD8u0not0u36iw=nqT7h5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

>>I like the idea of having a compress option implemented in e.g. librb=
d
>>and rgw, both of these cases involve scale-out clients and so concern=
s
>>of performance overhead can be largely brushed aside (e.g., most
>>OpenStack hypervisors seem to have plenty of free CPU).

Keep in mind that qemu use only 1 thread by disk, so I'm pretty sure th=
at compression on librbd side will impact performance a lot for 1 vm di=
sk.
(of course it'll scale with a lof vms)



----- Mail original -----
De: "Blair Bethwaite" <blair.bethwaite@gmail.com>
=C3=80: "Haomai Wang" <haomaiwang@gmail.com>
Cc: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, "ceph-devel" <ce=
ph-devel@vger.kernel.org>
Envoy=C3=A9: Mardi 30 Juin 2015 08:20:47
Objet: Re: Inline dedup/compression

On 30 June 2015 at 16:03, Haomai Wang <haomaiwang@gmail.com> wrote:=20
> On Tue, Jun 30, 2015 at 4:55 AM, James (Fei) Liu-SSI=20
> <james.liu@ssi.samsung.com> wrote:=20
>> Hi Haomai,=20
>> Thanks for moving the idea forward. Regarding to the compression. Ho=
wever, if we do compression on the client level, it is not global. And =
the compression was only applied to the local client, am I right? I thi=
nk there is pros and cons in two solutions and we can get into details =
more for each solution.=20
>=20
> Yes, I think a lot myself about compression with Ceph. At firstly, we=
=20
> could easily use objectstore backend to implement compress like=20
> filestore with zfs/btrfs and keyvaluestore with leveldb/rocksdb etc.=20
> The advantages are we can enjoy it now. The cons are we may lose too=20
> much for benefit of compression especially for performance.=20

If you were going to compress at the OSD I imagine the main=20
performance concern would be about adding to write latency? That might=20
be mitigated by only compressing the actual datastore and not the=20
journal?=20

I like the idea of having a compress option implemented in e.g. librbd=20
and rgw, both of these cases involve scale-out clients and so concerns=20
of performance overhead can be largely brushed aside (e.g., most=20
OpenStack hypervisors seem to have plenty of free CPU).=20

--=20
Cheers,=20
~Blairo=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
