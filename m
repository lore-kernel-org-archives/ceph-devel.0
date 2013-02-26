From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 3/3] ceph: fix vmtruncate deadlock
Date: Tue, 26 Feb 2013 19:05:45 +0800
Message-ID: <512C9709.2030200@intel.com>
References: <1361498899-15831-1-git-send-email-zheng.z.yan@intel.com> <1361498899-15831-4-git-send-email-zheng.z.yan@intel.com> <CAPYLRziAgfT0F2cdNe+sMbiphBMz20Sm3oSgqkdwNcJL-K--DQ@mail.gmail.com> <51284624.9050007@intel.com> <CAPYLRzinxnLg9+c-2Bh2f=S6vjqdTi+WjGsf02FTkj1sJK0iSQ@mail.gmail.com> <512C1AB1.1090307@intel.com> <alpine.DEB.2.00.1302252051300.6167@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34667 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753754Ab3BZLFt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 Feb 2013 06:05:49 -0500
In-Reply-To: <alpine.DEB.2.00.1302252051300.6167@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/26/2013 01:00 PM, Sage Weil wrote:
> On Tue, 26 Feb 2013, Yan, Zheng wrote:
>>> It looks to me like truncates can get queued for later, so that's n=
ot the case?
>>> And how could the client receive a truncate while in the middle of
>>> writing? Either it's got the write caps (in which case nobody else =
can
>>> truncate), or it shouldn't be writing...I suppose if somebody enabl=
es
>>> lazyIO that would do it, but again in that case I imagine we'd rath=
er
>>> do the truncate before writing:
>>
>> Commit 22cddde104 make buffered write get/put caps for individual pa=
ge. So the MDS can
>> revoke the write caps in the middle of write.
>>
>>>
>>>> I think it's better to do vmtruncate after write finishes.
>>> What if you're writing past the truncate point? Then your written d=
ata
>>> would be truncated off even though it should have been a file
>>> extension.
>>>
>> I was wrong, I thought the order of write and truncate is not import=
ant.=20
>> Now I'm worry about the correctness of commit 22cddde104, we probabl=
y=20
>> should revert that commit.
>=20
> I'm sorry I haven't had time to dig into this thread.  Do you think w=
e=20
> should revert that commit for this merge window?

No, that commit fixes a i_size update bug, it is more important than th=
e deadlock.
But I think the eventual fix is revert that commit and also remove the =
optimization
that drops Fw caps early (to avoid slow cap revocation caused by balanc=
e_dirty_pages)

>=20
> My gut feeling is that the whole locking scheme here needs to be rewo=
rked. =20
> I suspect where we'll end up is something more like XFS, where there =
is an=20
> explicit truncate (or other) mutex that is separate from i_mutex.  Th=
e=20
> fact that we were relying on i_mutex serialization from the VFS was=20
> fragile and (as we can see) ultimately a flawed approach.  And the lo=
cking=20
> and races between writes, mmap, and truncation in the page cache code=
 are=20
> fragile and annoying.  The only good thing going for us is that fsx i=
s=20
> pretty good at stress testing the code.  :)

If we want to keep write operation atomic, write and vmtruncate need to=
 be
protected by a mutex. I don't think introducing a new mutex makes thing=
 simple.

>=20
>>> Oh, you're right about the locking (I think, anyway?). However, i_s=
ize=20
>>> doesn't protect us ? we might for instance have truncated to zero a=
nd=20
>>> then back up to the original file size. :( But that doesn't look li=
ke=20
>>> it's handled correctly anyway (racy) ? am I misreading that badly o=
r=20
>>> is the infrastructure in fact broken in that case?
>>
>> You are right. probably we can fix the race by disallowing both read=
 and=20
>> write when there is pending truncate.
>=20
> FWIW, I think the high-level strategy before should still be basicall=
y=20
> sound: we can queue a truncation without blocking, and any write path=
 will=20
> apply a pending truncation under the appropriate lock.  But I think i=
t's=20
> going to mean carefully documenting the locking requirements for the=20
> various paths and working out a new locking structure.
>=20
> Yan, is this something you are able to put some time into?  I would l=
ike=20
> to work on it, but it's going to be hard for me to find the time in t=
he=20
> next several weeks to get to it.

OK=EF=BC=8C I will work on it.

Regards
Yan, Zheng

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
