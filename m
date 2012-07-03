From: Tommi Virtanen <tv@inktank.com>
Subject: Re: domino-style OSD crash
Date: Tue, 3 Jul 2012 12:42:02 -0700
Message-ID: <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
 <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com> <4FF2AFEB.1010403@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:42748 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab2GCTmY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 15:42:24 -0400
Received: by ghrr11 with SMTP id r11so5719286ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 12:42:23 -0700 (PDT)
In-Reply-To: <4FF2AFEB.1010403@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 3, 2012 at 1:40 AM, Yann Dupont <Yann.Dupont@univ-nantes.fr=
> wrote:
> Upgraded the kernel to 3.5.0-rc4 + some patches, seems btrfs is OK ri=
ght
> now.
>
> Tried to restart osd with 0.47.3, then next branch, and today with 0.=
48.
>
> 4 of 8 nodes fails with the same message :
>
> ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2b=
f2030)
> =C2=A01: /usr/bin/ceph-osd() [0x701929]
=2E..
> =C2=A013: (leveldb::InternalKeyComparator::FindShortestSeparator(std:=
:string*,
> leveldb::Slice const&) const+0x4d) [0x6e811d]

That looks like http://tracker.newdream.net/issues/2563 and the best
we have for that ticket is "looks like you have a corrupted leveldb
file". Is this reproducible with a freshly mkfs'ed data partition?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
