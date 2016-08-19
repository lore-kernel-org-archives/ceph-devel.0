From: Loic Dachary <loic@dachary.org>
Subject: Re: releasing jewel v10.2.3 ?
Date: Fri, 19 Aug 2016 14:34:03 +0200
Message-ID: <57B6FCBB.2080905@dachary.org>
References: <57B698D0.1050409@dachary.org>
 <CA+H5UW0pmYVaMMCukBU7OZ1C6S5ThYZ2xfT70JXkR8MSBZONOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60343 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbcHSMeJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2016 08:34:09 -0400
In-Reply-To: <CA+H5UW0pmYVaMMCukBU7OZ1C6S5ThYZ2xfT70JXkR8MSBZONOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

On 19/08/2016 13:49, Radoslaw Zarzynski wrote:
> Hello,
> 
> I'd love to see RadosGW v10.2.3 passing RefStack:
> 
> * jewel: rgw: Swift's object versioning doesn't support
>   restoring a previous version on DELETE
>   http://tracker.ceph.com/issues/16393
>   https://github.com/ceph/ceph/pull/10710

It is scheduled to be tested

http://tracker.ceph.com/issues/16344#note-27
http://pulpito.ceph.com/loic-2016-08-17_11:24:55-rgw-jewel-backports-distro-basic-smithi/

as part of the current integration branch

http://tracker.ceph.com/issues/16344#note-23

If we're lucky (i.e. no infrastructure troubles and no rgw pull request disrupt the test in bizarre ways) it will be ready to merge early next week.

Cheers

> 
> Regards,
> Radek
> 
> 
> On Fri, Aug 19, 2016 at 7:27 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Sage,
>>
>> Here are the issues that would be in jewel v10.2.3 if we decided to release it now: http://tracker.ceph.com/versions/518
>> And here is the backport queue : http://tracker.ceph.com/projects/ceph/issues?query_id=96
>>
>> Do you think it is time to cut the release and ask QE to start testing ?
>>
>> Cheers
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
