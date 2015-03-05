From: Dennis Chen <kernel.org.gnu@gmail.com>
Subject: Re: The project of ceph client file system porting from Linux to AIX
Date: Thu, 5 Mar 2015 17:55:45 +0800
Message-ID: <CA+U0gVh2=Ck2wT_TYncCfXPUGvXDSSOg_6ETnfgehRT7Jv0sHA@mail.gmail.com>
References: <CA+U0gVhWKjxMUBAw91B1vkYrF9s=pna1eZ3HfV+vBJ5aMhKWQw@mail.gmail.com>
 <CAM9_UU-ayOpVsKCnzaBRGoc2NOj=URStHqW33zzw5CqShq4mpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41448 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbbCEJ4G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2015 04:56:06 -0500
Received: by pablj1 with SMTP id lj1so35157069pab.8
        for <ceph-devel@vger.kernel.org>; Thu, 05 Mar 2015 01:56:05 -0800 (PST)
In-Reply-To: <CAM9_UU-ayOpVsKCnzaBRGoc2NOj=URStHqW33zzw5CqShq4mpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ketor D <d.ketor@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>

Hello Ketor,

About 1 more years ago, I need a free DFS can be used in AIX
environment as a tiered storage solution for Bank DC, that why the
project.
This project just port the CephFS in Linux kernel to AIX kernel(maybe
RBD in future), so it's a kernel mode AIX cephfs.
But I have multiple projects at hand now, so the AIX cephfs project is
in pending status... It's open, anyone can make changes from this
project if he want.

On Thu, Mar 5, 2015 at 3:11 PM, Ketor D <d.ketor@gmail.com> wrote:
> Hi Dennis,
>       I am interested in your project.
>       I wrote a Win32 cephfs client https://github.com/ceph/ceph-dokan.
>       But ceph-dokan runs in user-mode. I see you port code from
> kernel cephfs, are you planning to write a kernel mode AIX-cephfs?
>
> Thanks!
>
>
> 2015-03-04 17:59 GMT+08:00 Dennis Chen <kernel.org.gnu@gmail.com>:
>> Hello,
>>
>> The ceph cluster now can only be used by Linux system AFAICT, so I
>> planed to port the ceph client file system from Linux to AIX as a
>> tiered storage solution in that platform. Below is the source code
>> repository I've done, which is still in progress. 3 important modules:
>>
>> 1. aixker: maintain a uniform kernel API beteween the Linux and AIX
>> 2. net: as a data transfering layer between the client and cluster
>> 3. fs: as an adaptor to make the AIX can recognize the Linux file system.
>>
>> https://github.com/Dennis-Chen1977/aix-cephfs
>>
>> Welcome any comments or anything...
>>
>> --
>> Den
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Den
