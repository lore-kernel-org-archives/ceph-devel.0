From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Still inconsistant pg's, ceph-osd crashes reliably after trying
 to repair
Date: Thu, 1 Mar 2012 11:03:10 -0800
Message-ID: <CAF3hT9BghHibbH-BQAzXe37_8Kcfonh7zRK5HroaRHiMJ1X8OQ@mail.gmail.com>
References: <4F4FAE96.7030801@filoo.de>
	<7E04D561-51D9-4BD4-ACC9-96063B3B48BF@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41600 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343Ab2CATDL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Mar 2012 14:03:11 -0500
Received: by yenl12 with SMTP id l12so432600yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Mar 2012 11:03:11 -0800 (PST)
In-Reply-To: <7E04D561-51D9-4BD4-ACC9-96063B3B48BF@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

On Thu, Mar 1, 2012 at 10:07 AM, Oliver Francke <Oliver.Francke@filoo.d=
e> wrote:
> Well,
>
> Am 01.03.2012 um 18:15 schrieb Oliver Francke:
>
>> Hi *,
>>
>> after some crashes we still had to care for some remaining inconsist=
ancies reported via
>> =A0 =A0ceph -w
>> and friends.
>> Well, we traced one of them down via
>> =A0 =A0ceph pg dump
>>
>> and we picked 79. pg=3D79.7 and found the corresponding file in the =
/var/log/ceph/osd.2.log.
>> =A0 =A0/data/osd4/current/79.7_head/rb.0.0.00000000136c__head_9FB2FA=
17
>> and the dup on
>> =A0 =A0/data/osd2/...
>> Strange though, they had the same checksum but reported a stat-error=
=2E Anyway. Decided to do a:
>> =A0 =A0ceph pg repair 79.7
>> ... byebye ceph-osd on node2!
>>
>> Here the trace:
>>
>> =3D=3D=3D 8-< =3D=3D=3D
>>
>> 2012-03-01 17:49:13.024571 7f3944584700 -- 10.10.10.14:6802/4892 >> =
10.10.10.10:6802/19139 pipe(0xfcd2c80 sd=3D16 pgs=3D0 cs=3D0 l=3D0).con=
nect protocol version mismatch, my 9 !=3D 0
>> 2012-03-01 17:49:23.674162 7f395001b700 log [ERR] : 79.7 osd.4: soid=
 9fb2fa17/rb.0.0.00000000136c/headextra attr _, extra attr snapset
>
> one clarification by ourselves done: one copy is missing the xattrs, =
checked via
> =A0 =A0 =A0 =A0getfattr
> but why can't it be corrected, and worse this crash happens?

You've got a lot of odd things going on here, some of which are
obviously connected and some of which aren't. Right now Ceph doesn't
automatically handle conflicts like missing xattrs because doing so
with 2x replication is really hard, and even when you have more people
(and can do some form of voting) you have to write some complicated
code to make it actually happen. :) At some point in the future, it
will, but for now we really want the attention anyway.

So the reason it's crashing is because it lost the "_" xattr, which we
could handle, except...losing that xattr is really, really bad. What
backing filesystem are you using? Are you using snapshots?

>> =3D=3D=3D 8-< =3D=3D=3D
>>
>> ... after some journal-replay things calmed down, but:
>>
>> =A0 =A02012-03-01 17:58:29.470446 =A0 log 2012-03-01 17:58:24.242369=
 osd.2 10.10.10.14:6801/3111 368 : [WRN] bad locator @56 on object @79 =
loc @56 op osd_op(client.44350.0:1412387 rb.0.0.00000000136c [write 246=
5792~49152] 56.9fb2fa17) v4

Does the bad locator always look like that, with the @56 and @79 values=
?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
