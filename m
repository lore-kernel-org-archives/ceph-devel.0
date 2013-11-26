From: Ketor D <d.ketor@gmail.com>
Subject: Re: [PATCH]ceph:init-ceph can't start osds after using mkcephfs
 created cluster
Date: Wed, 27 Nov 2013 00:20:18 +0800
Message-ID: <CAM9_UU-+k8n_0toK9uB0iByqHXj+eNKt6ZQxqOQKBx33pukKgw@mail.gmail.com>
References: <CAM9_UU9RJouy7X0A296neNC_Jdm29tEra7aGb-GHFEuq9yrikw@mail.gmail.com>
 <alpine.DEB.2.00.1311242202370.2298@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:41949 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757253Ab3KZQUt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Nov 2013 11:20:49 -0500
Received: by mail-la0-f42.google.com with SMTP id ec20so4436765lab.15
        for <ceph-devel@vger.kernel.org>; Tue, 26 Nov 2013 08:20:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311242202370.2298@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 25, 2013 at 2:04 PM, Sage Weil <sage@inktank.com> wrote:
> Hi Ketor,
>
> Can you tell what is making the ceph command fail at this point?  If the
> mons are started before the OSDs, the crush map update ought to succeed...
>
> Thanks!
> sage

I use "service ceph -a start" to start ceph cluster after using
mkcephfs script maked the ceph cluster.I think in /etc/init.d/ceph the
mon is started first and then the osds will be started after.

Is than right?

The same opertions on ceph v0.67.4 has no errors. And if I patched the
init-ceph.in like the first mail, all is ok.

Thanks.

> On Mon, 11 Nov 2013, Ketor D wrote:
>
>> Hi Sage:
>>         We always use mkcephfs to create out ceph cluster. Before
>> 0.72, all is ok.
>> But in 0.72, we found the osds can't start up useing "service ceph -a
>> start". After viewing the init-ceph.in script , I found that a return
>> value errro caused osds can't startup.And if we modifiy a little code
>> like 0.67.4 do, the osds can startup.
>>
>>          Regards!
>>
>> Here is the patch:
>>
>> Signed-off-by: Ketor D <d.ketor@gmail.com>
>> ---
>> diff --git "a/src/init-ceph.in" "b/src/init-ceph.in"
>> index 7399abb..cf2eaa6 100644
>> --- "a/src/init-ceph.in"
>> +++ "b/src/init-ceph.in"
>> @@ -331,7 +331,8 @@ for name in $what; do
>>   -- \
>>   $id \
>>   ${osd_weight:-${defaultweight:-1}} \
>> - $osd_location"
>> + $osd_location \
>> + || :"
>>   fi
>>      fi
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
