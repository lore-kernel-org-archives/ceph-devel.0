From: Ravi Pinjala <pstatic@gmail.com>
Subject: Re: v0.24 released
Date: Mon, 20 Dec 2010 21:15:43 -0800
Message-ID: <AANLkTikz3=Zbf09F9brLcT2FxWyVwOFq+oVRgaszHsoa@mail.gmail.com>
References: <Pine.LNX.4.64.1012201828110.29684@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:39106 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab0LUFPo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Dec 2010 00:15:44 -0500
Received: by bwz16 with SMTP id 16so4134185bwz.4
        for <ceph-devel@vger.kernel.org>; Mon, 20 Dec 2010 21:15:43 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1012201828110.29684@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The debian package doesn't install on ubuntu 10.10 - it depends on
libcrypto++7, which seems not to be available anymore. (Makes me miss
Gentoo :( )

--Ravi

On Mon, Dec 20, 2010 at 6:28 PM, Sage Weil <sage@newdream.net> wrote:
> We've released v0.24, just in time for the holidays! =C2=A0Big change=
s this
> time around include:
>
> =C2=A0* mds: many fixes with clustered failure recovery
> =C2=A0* mds: bloom filter to reduce directory reads
> =C2=A0* mds: configurable directory hash functions (for fragmentation=
)
> =C2=A0* rbd: import/export tools are smart about holes (i.e., use FIE=
MAP)
> =C2=A0* osd: many recovery improvements, mostly making data available=
 more
> =C2=A0 quickly
> =C2=A0* osd: automatic background scrubbing when load is low
> =C2=A0* osd: fixes with dedicated backend replication network
> =C2=A0* osd: use new (2.6.37) btrfs ioctls for async snapshot creatio=
n
> =C2=A0* replaced openssl dependency with libcrypto++ (licensing issue=
)
> =C2=A0* librados: "zero-copy" reads
> =C2=A0* misc bug fixes, man pages, and code cleanup
>
> The focus for the next release (v0.25) is on OSD and MDS stability,
> directory fragmentation recovery, and fsck preliminaries; see the roa=
dmap
> for more details.
>
> Relevant URLs:
> =C2=A0* Direct download at: http://ceph.newdream.net/download/ceph-0.=
24.tar.gz
> =C2=A0* For Debian packages, see http://ceph.newdream.net/wiki/Debian
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
