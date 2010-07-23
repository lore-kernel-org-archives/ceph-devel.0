From: Christian Brunner <chb@muc.de>
Subject: Re: [PATCH] qemu-kvm/rbd: add queueing delay based on queuesize
	(using use qemu_mutex_* and qemu_cond_*)
Date: Fri, 23 Jul 2010 20:51:44 +0200
Message-ID: <AANLkTi=zpj9VN7RYfANb4pY8NMi4VYMq5K4NRD-z6M5G@mail.gmail.com>
References: <20100714133545.GA21617@bambus>
	<AANLkTimuA4w0o_jyDJPslhvl4S0wpqTq-cChL2fBs6GF@mail.gmail.com>
	<AANLkTikUykm7LOtlu1BWQwWr28w548tLI-gylJcJs8Mq@mail.gmail.com>
	<4C495931.2090705@redhat.com>
	<Pine.LNX.4.64.1007230941500.6095@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54693 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab0GWSvp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jul 2010 14:51:45 -0400
Received: by wyf19 with SMTP id 19so514631wyf.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Jul 2010 11:51:44 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1007230941500.6095@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Kevin Wolf <kwolf@redhat.com>, Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

2010/7/23 Sage Weil <sage@newdream.net>:
> On Fri, 23 Jul 2010, Kevin Wolf wrote:
>
>> >> Actually we shouldn't be waiting inside the aio handler. We shoul=
d
>> >> probably be feeding the request into some wait queue and have a
>> >> separate thread that drains all those requests out. Though this
>> >> wouldn't help us in throttling the client memory, it's probably a=
 more
>> >> correct way to handle the problem.
>> >
>> > I agree with you, however I don't think that this is worth the eff=
ort.
>> > I've never seen this occur when running a virtual machine, only wh=
en
>> > running qemu-io.
>> >
>> > @Kevin: Did you follow this thread? What is your opinion?
>>
>> No, I'm not subscribed to your mailing list and qemu-devel isn't CCe=
d.
>>
>> I'm not entirely sure what kind of queue this is about, but are you =
sure
>> that it can only happen with large requests as issued by qemu-io? Ca=
n
>> many small requests cause the same, especially with a slow network
>> connection (or it might even go down for some reason?
>
> In theory, small requests can, yes. =A0We haven't seen it in practice=
, I
> don't think.
>
> In any case, I think any waiting/throttling just needs to happen insi=
de
> the librados library, as that is the only place that may have any
> knowledge of the cluster size, throughput, and so forth. =A0This code=
 should
> be dropped from the qemu-kvm/rbd side.

That would be the best solution.

Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
