From: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Subject: Questions about hash functions of CRUSH
Date: Fri, 13 Apr 2012 17:36:11 +0800
Message-ID: <CALwGbPJPxT+q0ThYQ0H+Th4j=J0PE=q+byCf4YTw=THtCdkqpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48508 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933437Ab2DMJgL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Apr 2012 05:36:11 -0400
Received: by obbta14 with SMTP id ta14so339745obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Apr 2012 02:36:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi everyone.

I'm still reading CRUSH source code.

When reading src/crush/hash.c, I've got some questions about the hash f=
unction.

1. There are several magic numbers there, like=A01315423911, 231232,
1232. Are they arbitrary or do they really mean something in theory?

2.=A0crush_hashmix macro is a part of Jenkins hash function. In the
series of crush_hash_rjenkins1_* functions, why input parameters are
mixed this way instead of something else?=A0Are they arbitrary or do
they really mean something in theory?

> For example
>=A0 crush_hashmix(a, b, hash);
>=A0 crush_hashmix(c, d, hash);
>=A0 crush_hashmix(e, x, hash);
>=A0 crush_hashmix(y, a, hash);
>=A0 crush_hashmix(b, x, hash);
>=A0 crush_hashmix(y, c, hash);
>=A0 crush_hashmix(d, x, hash);
>=A0 crush_hashmix(y, e, hash);
>=A0Do the order and combinations matter something?

3. I read the phrase "funneling hash", but I don't quite understand
what does it mean.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
