From: Cheng Cheng <ccheng.leo@gmail.com>
Subject: Re: QoS Control for RBD I/Os?
Date: Thu, 15 Jan 2015 13:06:50 -0500
Message-ID: <CAC13JXacRyj9RoBcYu6E8dR5S8k3M+nL1XciiZC5Y8nY0zbUFA@mail.gmail.com>
References: <E5173F87-4790-4151-9B2A-3FE6E8F11E96@gmail.com> <CACJqLyZyGxY82caFT01iCoV7u4+RUDk3JMdW6rUYL=96A3WDbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:39872 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbbAOSHM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 13:07:12 -0500
Received: by mail-la0-f43.google.com with SMTP id s18so15047386lam.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 10:07:10 -0800 (PST)
In-Reply-To: <CACJqLyZyGxY82caFT01iCoV7u4+RUDk3JMdW6rUYL=96A3WDbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Haomai,

Yes, let take a look into it and see what we can do.

Cheng
Cheng



On Thu, Jan 15, 2015 at 12:57 PM, Haomai Wang <haomaiwang@gmail.com> wr=
ote:
> Hi Cheng cheng,
>
> There already exists a
> bp(wiki.ceph.com/Planning/Blueprints/Giant/Add_QoS_capacity_to_librbd=
)
> but still no one to implement it.
>
> If you are interested in this, I think we can make it father. If not,
> I would like to pick it up later. :-)
>
>
> On Fri, Jan 16, 2015 at 1:53 AM, Cheng Cheng <ccheng.leo@gmail.com> w=
rote:
>> Hi Ceph,
>>
>> I am wondering is there a mechanism to prioritize the rbd_aio_write/=
rbd_aio_read I/Os? Currently all RBD I/Os are issued in FIFO to rados l=
ayer, and there is NO QoS mechanism to control the priority of these I/=
Os.
>>
>> A QoS mechanism will be beneficial when performing certain managemen=
t operations, such as flatten. When flatten a image, the outstanding I/=
Os do get throttled by =E2=80=9Crbd_concurrent_management_ops=E2=80=9D.=
 However this won't guarantee normal I/Os are not affected, as outstand=
ing normal I/Os are still competing with concurrent management ops.
>>
>> Anyone know how/where to implement this QoS mechanism?
>>
>> Thanks!
>> Cheng
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards,
>
> Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
