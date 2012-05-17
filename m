From: Sage Weil <sage@inktank.com>
Subject: Re: Journal too small
Date: Thu, 17 May 2012 10:33:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205171033060.7019@cobra.newdream.net>
References: <201205171259.55967.karol.jurak@gmail.com>
 <Pine.LNX.4.64.1205170901100.7019@cobra.newdream.net>
 <CADvuQREq_EZHBshxEyWQTFoBnTYy1j_VvW6yUwVXXk1ddBM+NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-795279687-1337276027=:7019"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45291 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760393Ab2EQRdu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 13:33:50 -0400
In-Reply-To: <CADvuQREq_EZHBshxEyWQTFoBnTYy1j_VvW6yUwVXXk1ddBM+NA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Karol Jurak <karol.jurak@gmail.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-795279687-1337276027=:7019
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 May 2012, Tommi Virtanen wrote:
> On Thu, May 17, 2012 at 9:01 AM, Sage Weil <sage@inktank.com> wrote:
> >> 2012-05-12 13:31:04.034144 7f491061d700 =A01 journal check_for_full at
> >> 863363072 : JOURNAL FULL 863363072 >=3D 1048571903 (max_size 104857600=
0
> >> start 863363072)
> >> 2012-05-12 13:31:04.034680 7f491061d700 =A00 journal JOURNAL TOO SMALL=
: item
> >> 1693745152 > journal 1048571904 (usable)
>=20
> > The osds tolerate the full journal. =A0There will be a big latency spik=
e,
> > but they'll recover without risking data. =A0You should definitely incr=
ease
> > the journal size if this happens regulary, though.
>=20
> I propose for your merging pleasure:
> https://github.com/ceph/ceph/commits/journal-too-small
> https://github.com/ceph/ceph/commit/62db60bede8b187e25acb715f6616d2ce7cfc=
97f

Perfect, merged.
--557981400-795279687-1337276027=:7019--
