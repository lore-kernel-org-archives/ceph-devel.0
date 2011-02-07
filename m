From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: [PATCH 17/46] fs: Use rename lock and RCU for multi-step operations
Date: Mon, 7 Feb 2011 13:35:43 -0800
Message-ID: <AANLkTin2dbSVaEHoQr9d+rOgZt7Bca4r=+noYj7MEsvK@mail.gmail.com>
References: <cover.1290852958.git.npiggin@kernel.dk>
	<d44ddcf1d1e0813b3ce2b3872c7c702a31b62894.1290852959.git.npiggin@kernel.dk>
	<AANLkTi=pj-pLYVSrU+6+BtioCWLod2ueZecNaap619fw@mail.gmail.com>
	<AANLkTik3ScP5rvR2bOXOEEH8SNZGg+xO6Gy32CW3XmU6@mail.gmail.com>
	<AANLkTinVP=OuJ-3u9pHdDuuKJoVrP4Unr5Dx1x=qHtXC@mail.gmail.com>
	<AANLkTimUjC8B0=nn5+yDshzp0hy6Zk1wxYHWEZbk83Tf@mail.gmail.com>
	<AANLkTi=or1Ya21Am8Dr4KVHgqkwvNxFwgn407=wxRfVa@mail.gmail.com>
	<AANLkTinmaojfNDYk1i4jMP33MmEQDur9XZvFp=qhV01e@mail.gmail.com>
	<1297104732.15475.60.camel@sale659.sandia.gov>
	<AANLkTinhfZcr-Mz2jAZodSrH-914D7iJREmVSD-i8Fb-@mail.gmail.com>
	<1297114279.15475.65.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55160 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab1BGVfp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Feb 2011 16:35:45 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 557D1C065
	for <ceph-devel@vger.kernel.org>; Mon,  7 Feb 2011 13:35:45 -0800 (PST)
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	by mail.hq.newdream.net (Postfix) with ESMTP id 04696C063
	for <ceph-devel@vger.kernel.org>; Mon,  7 Feb 2011 13:35:44 -0800 (PST)
Received: by wwa36 with SMTP id 36so5303460wwa.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 Feb 2011 13:35:43 -0800 (PST)
In-Reply-To: <1297114279.15475.65.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Feb 7, 2011 at 1:31 PM, Jim Schutt <jaschut@sandia.gov> wrote:
>
> On Mon, 2011-02-07 at 14:04 -0700, Yehuda Sadeh Weinraub wrote:
>> It does look like this specific problem.
>> You can try cherry-pick commit 9c3db35 off the ceph git. It is just =
a
>> temporary workaround, and it wasn't tested too much. Hopefully Nick
>> will push his fix soon so that it wouldn't be needed.
>
> That commit doesn't seem to be in
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
>
> Maybe there's another tree I should be looking at?
>
> Thanks -- Jim
Yep:
ceph.newdream.net:/git/ceph-client.git
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
