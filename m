From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] fiemap bug on giant
Date: Tue, 25 Nov 2014 10:17:09 +0800
Message-ID: <CACJqLybhFGaDss3kxxbcMJT=ZT6drvBWXo=Mcgyriv_kpWnEig@mail.gmail.com>
References: <CA+4uBUbDywTkuFfhY2uCBWcXRCYjcitDQE7SVZRVjm9NwuXOBA@mail.gmail.com>
	<CACJqLyY05osh5N=OGau9UAwRUuomL9adD39n6S63LSs5Xmu40w@mail.gmail.com>
	<alpine.DEB.2.00.1411241759520.24772@cobra.newdream.net>
	<CACJqLyanb-omTYxBHDUEdWw=F9o5omoDdyxfbLRMpLKi-Ce3Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:62149 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaKYCRL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 21:17:11 -0500
Received: by mail-wg0-f46.google.com with SMTP id x12so14029108wgg.33
        for <ceph-devel@vger.kernel.org>; Mon, 24 Nov 2014 18:17:09 -0800 (PST)
In-Reply-To: <CACJqLyanb-omTYxBHDUEdWw=F9o5omoDdyxfbLRMpLKi-Ce3Hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: sjust@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Oh, sorry. This series seemed that already backported...

On Tue, Nov 25, 2014 at 10:14 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Backport this series(https://github.com/yuandong1222/ceph/commit/3f8fb85b341726ae7bb44b4c699707333cd63ccd)
> and test again ? Or....
>
> Actually, my up to ten ceph clusters open this option for nearly one year.....
>
> On Tue, Nov 25, 2014 at 10:05 AM, Sage Weil <sweil@redhat.com> wrote:
>> [dropping ceph-users]
>>
>> On Tue, 25 Nov 2014, Haomai Wang wrote:
>>> It's surprised that the test machine run on a very new kernel but
>>> occur this problem:
>>>
>>> plana 47 is 12.04.5 with kernel 3.18.0-rc6-ceph-00024-geb0e5fd
>>>
>>> plana 50 is 12.04.4 with kernel 3.17.0-rc6-ceph-00002-ge8acad6
>>>
>>> Which local filesystem is ran on?
>>
>> This run was XFS.  It looks like it returned a mapping for fewer bytes
>> than it was asked for... 54548 turned into 53904.  That's a bit
>> disconcerting!  Maybe teh issue is that the start offset wasn't aligned?
>>
>> sage
>>
>>
>>
>>>
>>> On Tue, Nov 25, 2014 at 5:03 AM, Samuel Just <sam.just@inktank.com> wrote:
>>> > Bug #10166 (http://tracker.ceph.com/issues/10166) can cause recovery
>>> > to result in incorrect object sizes on giant if the setting 'filestore
>>> > fiemap' is set to true.  This setting is disabled by default.  This
>>> > should be fixed in a future point release, though filestore fiemap
>>> > will probably continue to default to false.
>>> > -Sam
>>> > _______________________________________________
>>> > ceph-users mailing list
>>> > ceph-users@lists.ceph.com
>>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>>
>>> Wheat
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>>
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
