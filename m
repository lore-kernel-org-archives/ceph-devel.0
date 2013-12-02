From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: question about the data structure of crush_map
Date: Mon, 2 Dec 2013 12:25:20 +0800
Message-ID: <CAMm-wcLVHFX-5w_UnkA=UnAdPixSB14WFhbH21WgS7zeP4FDqA@mail.gmail.com>
References: <CAJqA8gvBkq7F=nJBvSaVjwXJQYguHQjp4zQOPSgpvYbwOza=kA@mail.gmail.com>
	<CAMm-wcKBvJ4F5hBo_+4FyXEuumePHwz8EtOsPo=aYUBXwB+NiA@mail.gmail.com>
	<CAJqA8gvo7AndWL6RacmTVs+Q+jAsS8H=uOWnnCc=LSbx6RwFNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59763 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab3LBEZW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Dec 2013 23:25:22 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so9517319wgh.17
        for <ceph-devel@vger.kernel.org>; Sun, 01 Dec 2013 20:25:21 -0800 (PST)
In-Reply-To: <CAJqA8gvo7AndWL6RacmTVs+Q+jAsS8H=uOWnnCc=LSbx6RwFNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lipeng Wan <lipengwan86@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

In my opinion, w[i] is less than -1.

On 2 December 2013 11:53, Lipeng Wan <lipengwan86@gmail.com> wrote:
> Hi Dong,
>
> Thanks for your reply. Then is it valid to access the memory space
> specified by that negative id?
>
> L Wan
>
> On Sun, Dec 1, 2013 at 10:31 PM, Dong Yuan <yuandong1222@gmail.com> wrote:
>> If my memory serves me well, negative id means buckets (root, room,
>> rack, cabinet, etc.), well positive means osds.
>>
>> On 2 December 2013 11:20, Lipeng Wan <lipengwan86@gmail.com> wrote:
>>> Hi guys,
>>>
>>> I am reading the source code of ceph and trying to understand the data
>>> structure of crush_map. Now I am confused by the use of "struct
>>> crush_bucket **buckets" in function "int crush_do_rule(...)" in
>>> src/crush/mapper.c. It seems that the index of array "map->buckets[]"
>>> could be negative (see line 551, src/crush/mapper.c). I was wondering
>>> if anyone could explain why the index of this array can be negative
>>> and how those buckets were added into this array. Thanks.
>>>
>>> Best,
>>> L. Wan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Dong Yuan
>> Email:yuandong1222@gmail.com



-- 
Dong Yuan
Email:yuandong1222@gmail.com
