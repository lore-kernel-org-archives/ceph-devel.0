From: Gregory Farnum <greg@gregs42.com>
Subject: Re: QoS Control for RBD I/Os?
Date: Thu, 15 Jan 2015 10:12:12 -0800
Message-ID: <CAC6JEv-N6W-rzWS+xYbMyjeDG0uUuy08X937d9hAcUXpbtFsUw@mail.gmail.com>
References: <E5173F87-4790-4151-9B2A-3FE6E8F11E96@gmail.com>
	<CAC6JEv9Cmnpoopghpdb=tmuXk-DQGy8LaJaY3qyOn-v0Qexbnw@mail.gmail.com>
	<CAC13JXboOGQjgjJAcjT-oHovpG9kp6c3hSMhuLHkkkykccrYiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36420 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbbAOSMO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 13:12:14 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so15926123igj.4
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 10:12:13 -0800 (PST)
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com. [209.85.213.172])
        by mx.google.com with ESMTPSA id d125sm1400918iod.8.2015.01.15.10.12.13
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 10:12:13 -0800 (PST)
Received: by mail-ig0-f172.google.com with SMTP id l13so16442150iga.5
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 10:12:12 -0800 (PST)
In-Reply-To: <CAC13JXboOGQjgjJAcjT-oHovpG9kp6c3hSMhuLHkkkykccrYiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cheng Cheng <ccheng.leo@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

At some point you still need to do the actual promotion of the block
from the base image to the child image. The only time you get a
conflict is if there's a client op trying to happen at the same time.
So I guess you could try to avoid starting any promotion while there
are client ops pending, but if they come in during the promote they're
still stuck until it finishes.

There is a mechanism which lets you set different priorities on
messages and operations that result from them; you could perhaps try
and hack things up so that the client performing the flatten assigns a
much lower priority to its messages than regular rbd clients do.
Search for the CEPH_MSG_PRIO* stuff in the code base if you want to
explore that (and it will involve some coding; I don't think we have
any config options that will make it easy).
-Greg

On Thu, Jan 15, 2015 at 10:06 AM, Cheng Cheng <ccheng.leo@gmail.com> wr=
ote:
> Hi Greg,
>
> Thanks for sharing the insight.
>
> If we limit the scope of QoS to a RBD image, some QoS mechanism will
> still be beneficial. As there is an effort to asynchronously flattern
> a image, the priority for flattern operation should be lower than
> normal I/O to limit the latency, right?
>
> Cheng
> Cheng
>
>
>
> On Thu, Jan 15, 2015 at 12:59 PM, Gregory Farnum <greg@gregs42.com> w=
rote:
>> On Thu, Jan 15, 2015 at 9:53 AM, Cheng Cheng <ccheng.leo@gmail.com> =
wrote:
>>> Hi Ceph,
>>>
>>> I am wondering is there a mechanism to prioritize the rbd_aio_write=
/rbd_aio_read I/Os? Currently all RBD I/Os are issued in FIFO to rados =
layer, and there is NO QoS mechanism to control the priority of these I=
/Os.
>>>
>>> A QoS mechanism will be beneficial when performing certain manageme=
nt operations, such as flatten. When flatten a image, the outstanding I=
/Os do get throttled by =E2=80=9Crbd_concurrent_management_ops=E2=80=9D=
=2E However this won't guarantee normal I/Os are not affected, as outst=
anding normal I/Os are still competing with concurrent management ops.
>>>
>>> Anyone know how/where to implement this QoS mechanism?
>>
>> Sadly, there's no QoS in RBD right now. It sounds like you're more
>> concerned about preventing management from impacting client IO, but
>> even in this case it's a distributed problem (flatten for instance
>> involves moving data between storage machines), which is still an op=
en
>> research topic as far as I know. I don't think you'll ever be able t=
o
>> get a guarantee, and simply doing one movement at a time is probably
>> as good as you can get in the medium term. :(
>> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
