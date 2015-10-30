From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: why we should use two Mutex in OSD ShardData?
Date: Fri, 30 Oct 2015 23:37:58 +0800
Message-ID: <CANE=7sVH=_ZCcXQwx20dcvK_rTodUOSHVMO11=muZ-un8P=GXg@mail.gmail.com>
References: <CANE=7sWr3c3pa7ZkbJ2NvZPppiXsF=n6maeMQ2=BZQXdoNx_0Q@mail.gmail.com>
	<CO1PR02MB208FE1E509A92D5D5E47B00F42F0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33286 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759598AbbJ3Ph6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Oct 2015 11:37:58 -0400
Received: by obbwb3 with SMTP id wb3so47250665obb.0
        for <ceph-devel@vger.kernel.org>; Fri, 30 Oct 2015 08:37:58 -0700 (PDT)
In-Reply-To: <CO1PR02MB208FE1E509A92D5D5E47B00F42F0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I do not see any improvement by moving to single mutex. I just fell
puzzle why we use two mutex.
But I also do not see any improvement using two mutex in my environment.
Thanks for your explanation.

2015-10-30 22:59 GMT+08:00 Somnath Roy <Somnath.Roy@sandisk.com>:
>
> Hi xinze,
> This is mainly for reducing lock contention on a single mutex. Conditional wakeup on a mutex is expensive and that's why we wanted to make it separate from the mutex protecting Sharddata priority queue and pg_for_processing map.
> Are you seeing any improvement by moving to single mutex ?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of ???
> Sent: Friday, October 30, 2015 6:35 AM
> To: ceph-devel@vger.kernel.org
> Subject: why we should use two Mutex in OSD ShardData?
>
> hi, all:
>
>    There are two Mutex in ShardData, one is sdata_lock and the other one is sdata_op_ordering_lock.
>
>     I wonder could we replace sdata_lock with sdata_op_ordering_lock?
>
> --
> Regards,
> xinze
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
Regards,
xinze
