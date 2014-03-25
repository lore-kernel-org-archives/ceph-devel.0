From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [librbd] Add interface of get the snapshot size?
Date: Mon, 24 Mar 2014 20:22:23 -0700
Message-ID: <5330F66F.30008@inktank.com>
References: <CACJqLybccTqhcumeP33LTY8_s7zxjyuodU-bdKFL9a1cM28dVg@mail.gmail.com> <53303822.20800@xdel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33753 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaCYDW0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Mar 2014 23:22:26 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so17196198ykp.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Mar 2014 20:22:26 -0700 (PDT)
In-Reply-To: <53303822.20800@xdel.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>, Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/24/2014 06:50 AM, Andrey Korolyov wrote:
> On 03/24/2014 05:30 PM, Haomai Wang wrote:
>> Hi all,
>>
>> As we know, snapshot is a lightweight resource in librbd and we
>> doesn't have any statistic informations about it. But it causes some
>> problems to the cloud management.
>>
>> We can't measure the size of snapshot, different snapshot will occur
>> different space. So we don't have way to estimate the resource usage
>> of user.
>>
>> Maybe we can have a counter to record space usage when volumn created.
>> When creating snapshot, the counter is freeze and store as the size of
>> snapshot. New counter will assign to zero for the volume.
>>
>> Any feedback is appreciate!
>>
>
> I believe that there is a rough estimation over 'rados df'. Per-image
> statistics would be awesome, though precise stats will be neither rough
> too(# of rbd object clones per volume) or introduce new counter
> mechanism. Dealing with discard for the filestore, it looks even more
> difficult to calculate right estimation, as with XFS preallocation feature.

diff_iterate() will let you see what extents exist in the image at a
given snapshot or between snapshots. It's not perfect, but it'll be more
accurate than other methods.

A better long term solution might be to leverage something like a
bitmap of object existence. This could be marked dirty (i.e.
unreliable) when opening an image, maintained in memory, and saved with
a snapshot and when closing an image as clean.

With xfs preallocation hints, the usage will be pretty close to object
size * num objects.

Josh
