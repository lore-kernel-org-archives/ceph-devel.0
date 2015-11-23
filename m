From: "Yan, Zheng" <zyan@redhat.com>
Subject: =?utf-8?Q?Re=3A_Ceph-fuse_single_read_limitation=3F=E2=80=8F?=
Date: Mon, 23 Nov 2015 20:16:20 +0800
Message-ID: <A94A04A4-9CE6-4C9E-91EE-C482C436DC90@redhat.com>
References: <SNT146-W62CB5B81C00E768E7348638C190@phx.gbl> <99D7EA2A-9588-4B80-B172-1F92F2A2142E@redhat.com> <SNT146-W180B57DAACA6B1BAFCABB8C070@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60193 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbbKWMQ3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 07:16:29 -0500
In-Reply-To: <SNT146-W180B57DAACA6B1BAFCABB8C070@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Z Zhang <zhangz.david@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> On Nov 23, 2015, at 16:40, Z Zhang <zhangz.david@outlook.com> wrote:
>=20
> Hi Yan, Thanks for the reply. I already tried following settings, but=
 no lock.  client_readahead_min =3D 1048576 client_readahead_max_bytes =
=3D 4194304 Thanks. Zhi Zhang (David) > Subject: Re: Ceph-fuse single r=
ead limitation?=E2=80=8F > From: zyan@redhat.com > Date: Mon, 23 Nov 20=
15 10:22:23 +0800 > CC: ceph-devel@vger.kernel.org > To: zhangz.david@o=
utlook.com > > >> On Nov 21, 2015, at 10:12, Z Zhang wrote: >> >> Hi Gu=
ys, >> >> Now we have a very small cluster with 3 OSDs but using 40Gb N=
IC. We use ceph-fuse as cephfs client and enable readahead, but testing=
 single reading a large file from cephfs via fio, dd or cp can only ach=
ieve ~70+MB/s, even if fio or dd's block size is set to 1MB or 4MB. >> =
>> From the ceph client log, we found each read request's size (ll_read=
) is limited to 128KB, which should be the limitation of kernel fuse's =
=46USE_MAX_PAGES_PER_REQ =3D 32. We may try to increase this value to s=
ee the performance difference, but are there other options we can try t=
o increase single read performance? >> > > try setting client_readahead=
_max_bytes to 4M > > Yan, Zheng > > -- > To unsubscribe from this list:=
 send the line "unsubscribe ceph-devel" in > the body of a message to m=
ajordomo@vger.kernel.org > More majordomo info at http://vger.kernel.or=
g/majordomo-info.html

can you check ceps-fuse log to see if readahead actually happen.

Regards
Yan, Zheng--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
