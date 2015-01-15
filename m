From: Cheng Cheng <ccheng.leo@gmail.com>
Subject: Re: QoS Control for RBD I/Os?
Date: Thu, 15 Jan 2015 13:06:14 -0500
Message-ID: <CAC13JXboOGQjgjJAcjT-oHovpG9kp6c3hSMhuLHkkkykccrYiw@mail.gmail.com>
References: <E5173F87-4790-4151-9B2A-3FE6E8F11E96@gmail.com> <CAC6JEv9Cmnpoopghpdb=tmuXk-DQGy8LaJaY3qyOn-v0Qexbnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:53777 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbbAOSGg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 13:06:36 -0500
Received: by mail-la0-f53.google.com with SMTP id gm9so15038722lab.12
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 10:06:34 -0800 (PST)
In-Reply-To: <CAC6JEv9Cmnpoopghpdb=tmuXk-DQGy8LaJaY3qyOn-v0Qexbnw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,

Thanks for sharing the insight.

If we limit the scope of QoS to a RBD image, some QoS mechanism will
still be beneficial. As there is an effort to asynchronously flattern
a image, the priority for flattern operation should be lower than
normal I/O to limit the latency, right?

Cheng
Cheng



On Thu, Jan 15, 2015 at 12:59 PM, Gregory Farnum <greg@gregs42.com> wro=
te:
> On Thu, Jan 15, 2015 at 9:53 AM, Cheng Cheng <ccheng.leo@gmail.com> w=
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
>
> Sadly, there's no QoS in RBD right now. It sounds like you're more
> concerned about preventing management from impacting client IO, but
> even in this case it's a distributed problem (flatten for instance
> involves moving data between storage machines), which is still an ope=
n
> research topic as far as I know. I don't think you'll ever be able to
> get a guarantee, and simply doing one movement at a time is probably
> as good as you can get in the medium term. :(
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
