From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] ceph: use the OSD time as the object mtime instead of the
 client time
Date: Tue, 29 Jul 2014 12:02:49 -0400
Message-ID: <CAPYLRzh3EfcTeVuZB-StY2dfQ=4B9a6CspX9bXefxsQeSUm1iw@mail.gmail.com>
References: <06E7D85B3BA36C4DB207FEDE871C534891D8CB@SHSMSX101.ccr.corp.intel.com>
	<alpine.DEB.2.00.1407290844430.27871@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:37742 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaG2QCv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 12:02:51 -0400
Received: by mail-wg0-f42.google.com with SMTP id l18so9041985wgh.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jul 2014 09:02:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407290844430.27871@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 29, 2014 at 11:46 AM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 29 Jul 2014, Wang, Zhiqiang wrote:
>> This fixes a bug when the time of the OSDs and clients are not synch=
ronized
>> (especially when client is ahead of OSD), and the cache tier dirty r=
atio
>> reaches the threshold, the agent skips the flush work because it thi=
nks
>> the object is too young.
>>
>> The skipping flush code is as following:
>>
>>   if (obc->obs.oi.mtime + utime_t(pool.info.cache_min_flush_age, 0) =
> now) {
>>     dout(20) << __func__ << " skip (too young) " << obc->obs.oi << d=
endl;
>>     osd->logger->inc(l_osd_agent_skip);
>>     return false;
>>   }
>
> Hmm, I think the use of the client mtime is an important property we =
want
> to maintain for the benefit of the rest of the system.  Two other
> possibilities:

This was my initial thought as well =E2=80=94 but I don't think we're a=
ctually
relying on that any more (e.g., we used to use the client times for
file recovery in the MDS, but the rest of CephFS is now using MDS
times anyway). Are there scenarios other than CephFS recovery?

>
> 1) If cache_min_flush_age is 0, skip the check, so we avoid mtimes in=
 the
> future in that case.
>
> 2) Add an additional field to object_info_t that is an mtime based on=
 the
> OSD's clock, and use that for these checks.

But option 2 is probably still a good idea.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
