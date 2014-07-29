From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH] ceph: use the OSD time as the object mtime instead of the
 client time
Date: Tue, 29 Jul 2014 14:54:42 -0400
Message-ID: <CANP1eJH8KOgJdkRaSgecr-Esjf7GjOVNM7=T1y52SFMKic5ZuA@mail.gmail.com>
References: <06E7D85B3BA36C4DB207FEDE871C534891D8CB@SHSMSX101.ccr.corp.intel.com>
	<alpine.DEB.2.00.1407290844430.27871@cobra.newdream.net>
	<CAPYLRzh3EfcTeVuZB-StY2dfQ=4B9a6CspX9bXefxsQeSUm1iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:38334 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbaG2Syo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 14:54:44 -0400
Received: by mail-lb0-f169.google.com with SMTP id s7so67964lbd.28
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jul 2014 11:54:42 -0700 (PDT)
In-Reply-To: <CAPYLRzh3EfcTeVuZB-StY2dfQ=4B9a6CspX9bXefxsQeSUm1iw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sweil@redhat.com>, "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Off the top of my head... the fscache code (read only) in the CephFS
kclient uses the mtime to see if the item is valid (there was not an
object change version counter at the time). I don't know if / how that
would be affected of the top of my head.

- M

On Tue, Jul 29, 2014 at 12:02 PM, Gregory Farnum <greg@inktank.com> wro=
te:
> On Tue, Jul 29, 2014 at 11:46 AM, Sage Weil <sweil@redhat.com> wrote:
>> On Tue, 29 Jul 2014, Wang, Zhiqiang wrote:
>>> This fixes a bug when the time of the OSDs and clients are not sync=
hronized
>>> (especially when client is ahead of OSD), and the cache tier dirty =
ratio
>>> reaches the threshold, the agent skips the flush work because it th=
inks
>>> the object is too young.
>>>
>>> The skipping flush code is as following:
>>>
>>>   if (obc->obs.oi.mtime + utime_t(pool.info.cache_min_flush_age, 0)=
 > now) {
>>>     dout(20) << __func__ << " skip (too young) " << obc->obs.oi << =
dendl;
>>>     osd->logger->inc(l_osd_agent_skip);
>>>     return false;
>>>   }
>>
>> Hmm, I think the use of the client mtime is an important property we=
 want
>> to maintain for the benefit of the rest of the system.  Two other
>> possibilities:
>
> This was my initial thought as well =E2=80=94 but I don't think we're=
 actually
> relying on that any more (e.g., we used to use the client times for
> file recovery in the MDS, but the rest of CephFS is now using MDS
> times anyway). Are there scenarios other than CephFS recovery?
>
>>
>> 1) If cache_min_flush_age is 0, skip the check, so we avoid mtimes i=
n the
>> future in that case.
>>
>> 2) Add an additional field to object_info_t that is an mtime based o=
n the
>> OSD's clock, and use that for these checks.
>
> But option 2 is probably still a good idea.
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
