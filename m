From: Diego Woitasen <diego@woitasen.com.ar>
Subject: Re: v0.42 released
Date: Mon, 20 Feb 2012 22:50:57 -0300
Message-ID: <CAA7Uhck1u8CJjtwjqUvRYyMFS8EKeQi-0f1FMSwGXYpvzus21g@mail.gmail.com>
References: <Pine.LNX.4.64.1202201001200.30602@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38185 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752624Ab2BUBu6 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Feb 2012 20:50:58 -0500
Received: by lagu2 with SMTP id u2so7028548lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 20 Feb 2012 17:50:57 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1202201001200.30602@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Mon, Feb 20, 2012 at 3:01 PM, Sage Weil <sage@newdream.net> wrote:
> v0.42 is ready! =A0This has mostly been a stabilization release, with=
 a few
> critical bugs fixed. =A0There is also an across-the-board change in d=
ata
> structure encoding that is not backwards-compatible, but is designed =
to
> allow future changes to be (both forwards- and backwards-).
>
> Notable changes include:
>
> =A0* osd: new (non-backwards compatible!) encoding for all structures
> =A0* osd: fixed bug with transactions being non-atomic (leaking acros=
s
> =A0 commit boundaries)
> =A0* osd: track in-progress requests, log slow ones
> =A0* osd: randomly choose pull target during recovery (better load ba=
lance)
> =A0* osd: fixed recovery stall
> =A0* mon: a few recovery bug fixes
> =A0* mon: trim old auth files
> =A0* mon: better detection/warning about down pgs
> =A0* objecter: expose in-process requests via admin socket
> =A0* new infrastructure for testing data structure encoding changes (=
forward
> =A0 and backward compatibility)
>
> Aside from the data structure encoding change, there is relatively li=
ttle
> new code since v0.41. =A0This should be a pretty solid release.
>
> For v0.43, we are working on merging a few big changes. =A0The main o=
ne is a
> new key/value interface for objects: each object, instead of storing =
a
> blob of bytes, would consist of a (potentially large) set of key/valu=
e
> pairs that can be set/queried efficiently. =A0This is going to make a=
 huge
> difference for radosgw performance with large buckets, and will help =
with
> large directories as well. =A0There is also ongoing stabilization wor=
k with
> the OSD and new interfaces for administrators to query the state of t=
he
> cluster and diagnose common problems.
>
> v0.42 can be found from the usual locations:
>
> =A0* Git at git://github.com/NewDreamNetwork/ceph.git
> =A0* Tarball at=A0http://ceph.newdream.net/download/ceph-0.42.tar.gz
> =A0* For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/la=
test/ops/install/mkcephfs/#installing-the-packages
>
> sage

Production ready, right?

:)

--=20
Diego Woitasen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
