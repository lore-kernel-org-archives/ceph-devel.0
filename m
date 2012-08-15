From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: v0.48.1 argonaut stable update released
Date: Wed, 15 Aug 2012 16:06:30 +0200
Message-ID: <502BACE6.6090707@filoo.de>
References: <alpine.DEB.2.00.1208141116420.18862@cobra.newdream.net> <440738CF-7DDB-44D2-A35B-782D289D5B28@filoo.de> <alpine.DEB.2.00.1208141225220.18862@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:47648 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab2HOOGd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Aug 2012 10:06:33 -0400
In-Reply-To: <alpine.DEB.2.00.1208141225220.18862@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Well,

On 08/14/2012 09:29 PM, Sage Weil wrote:
> On Tue, 14 Aug 2012, Oliver Francke wrote:
>> Hi Sage,
>>
>> I just updated to debian-testing/0.50 this afternoon, after some hin=
t:
>>
>> * osd: better tracking of recent slow operations
> This is actually about the admin socket command to dump operations in
> flight (more useful information is reported for diagnosis/debugging).
>
>> and it is hereby confirmed to be better in my testing environment.
>> Before I had requests, which could be there for >480 seconds? not an=
y
>> more.
> That great news!  That is probably Sam's refactor of the OSD threadin=
g at
> work.  There were also a few bugs fixed in 0.48.1 that were causing
> somewhat similar symptoms (ops blocked indefinitely) due to peering
> problems, but that doesn't sound like it's the same thing.
>
>> How's about this fix in 0.48.X?
> It's a huge set of changes, and definitely won't go into the 0.48 ser=
ies,
> sorry!  (In fact, the pending change was one motivation for doing 0.4=
8
> when we did.)  It will be in bobtail, though, which is probably about=
 a
> month away from freeze.
>
> Please let us know what your experience is like with 0.50 (and beyond=
).

the more detailed picture is: it works and is stable, so far no problem=
s=20
with my torture-tests.
Sporadically I see a line ala:

--- 8-< ---
delete error: image still has watchers
This means the image is still open or the client using it crashed. Try=20
again after closing/unmapping it or waiting 30s for the crashed client=20
to timeout.
2012-08-15 15:57:22.072729 7f9fe82a2760 -1 librbd: error removing=20
header: (16) Device or resource busy
--- 8-< ---

even from long ago stopped VM's.

Regards,

Oliver.

>
> Thanks!
> sage
>
>
>> Thnx in @vance,
>>
>> Oliver - Thus being too lazy to read all change logs - Francke.
>>
>> Am 14.08.2012 um 20:18 schrieb Sage Weil <sage@inktank.com>:
>>
>>> We've built and pushed the first update to the argonaut stable rele=
ase.
>>> This branch has a range of small fixes for stability, compatibility=
, and
>>> performance, but no major changes in functionality.  The stability =
fixes
>>> are particularly important for large clusters with many OSDs, and f=
or
>>> network environments where intermittent network failures are more c=
ommon.
>>>
>>> The highlights include:
>>>
>>> * mkcephfs: use default `keyring', `osd data', `osd journal' paths =
when
>>>    not specified in conf
>>> * msgr: various fixes to socket error handling
>>> * osd: reduce scrub overhead
>>> * osd: misc peering fixes (past_interval sharing, pgs stuck in `pee=
ring'
>>>    states)
>>> * osd: fail on EIO in read path (do not silently ignore read errors=
 from
>>>    failing disks)
>>> * osd: avoid internal heartbeat errors by breaking some large
>>>    transactions into pieces
>>> * osd: fix osdmap catch-up during startup (catch up and then add da=
emon
>>>    to osdmap)
>>> * osd: fix spurious `misdirected op' messages
>>> * osd: report scrub status via `pg # query'
>>> * rbd: fix race when watch registrations are resent
>>> * rbd: fix rbd image id assignment scheme (new image data objects h=
ave
>>>    slightly different names)
>>> * rbd: fix perf stats for cache hit rate
>>> * rbd tool: fix off-by-one in key name (crash when empty key specif=
ied)
>>> * rbd: more robust udev rules
>>> * rados tool: copy object, pool commands
>>> * radosgw: fix in usage stats trimming
>>> * radosgw: misc compatibility fixes (date strings, ETag quoting, sw=
ift
>>>    headers, etc.)
>>> * ceph-fuse: fix locking in read/write paths
>>> * mon: fix rare race corrupting on-disk data
>>> * config: fix admin socket `config set' command
>>> * log: fix in-memory log event gathering
>>> * debian: remove crush headers, include librados-config
>>> * rpm: add ceph-disk-{activate, prepare}
>>>
>>> The fix for the radosgw usage trimming is incompatible with v0.48 (=
which
>>> was effectively broken).  You now need to use the v0.48.1 version o=
f
>>> radosgw-admin to initiate usage stats trimming.
>>>
>>> There are a range of smaller bug fixes as well.  For a complete lis=
t of
>>> what went into this release, please see the release notes and chang=
elog.
>>>
>>> You can get this stable update from the usual locations:
>>>
>>> * Git at git://github.com/ceph/ceph.git
>>> * Tarball at http://ceph.newdream.net/download/ceph-0.48.1.tar.gz
>>> * For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/mas=
ter/install/debian
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
