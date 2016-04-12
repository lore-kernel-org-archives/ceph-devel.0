From: Zhiqiang Wang <wonzhq@gmail.com>
Subject: Re: Evict op on a watched object
Date: Tue, 12 Apr 2016 14:56:25 +0800
Message-ID: <CA+cZ7sgv3t2wP79EbNbyi6nMLxOHt61QFBTs-RuWL8kqWft-jw@mail.gmail.com>
References: <CA+cZ7sid2YxNRcNzXS3CF=qPx3UWUw0jC0DaEpV9mxZ3E_piJw@mail.gmail.com>
	<322414041.49670668.1460387920039.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:35862 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbcDLG40 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 02:56:26 -0400
Received: by mail-io0-f175.google.com with SMTP id u185so16515917iod.3
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2016 23:56:26 -0700 (PDT)
In-Reply-To: <322414041.49670668.1460387920039.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel@vger.kernel.org

Thanks Jason.

Looks like in the osd side, the only difference between 'watch' and
'legacy watch' is whether 'will_ping' is set. Can we use this to check
for 'legacy watch'? Or as we don't use 'legacy watch' any more, we
just don't care about it?

(forgot to cc the mail list, sorry for the dup mails)

2016-04-11 23:18 GMT+08:00 Jason Dillaman <dillaman@redhat.com>:
>> Currently it is not allowed to issue an evict op
>> (CEPH_OSD_OP_CACHE_EVICT) on an object which has watchers (e.g. the
>> rbd header). EBUSY is returned in this case. This leads to the the
>> flush-evict-all failure during removing a cache tier, something like
>> below:
>>
>> rbd_header.4fc06b8b4567
>> failed to evict /rbd_header.4fc06b8b4567: (16) Device or resource busy
>>
>> My question is that do we actually need to do so? The object in the
>> base pool should have the watcher information as well after the flush.
>> Probably we could remove this 'watcher' check to make flush-evict-all
>> happy?
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> I opened a ticket [1] a couple of months ago to address this issue.
>
> [1] http://tracker.ceph.com/issues/14865
>
> --
>
> Jason Dillaman
