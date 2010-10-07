From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v4)
Date: Thu, 7 Oct 2010 13:47:08 -0700
Message-ID: <AANLkTimW98qPTYZ=Bct7k7XqaOXswC51QdQOW6fLsWkQ@mail.gmail.com>
References: <20100802194631.GA4923@chb-desktop>
	<alpine.LNX.2.00.1008030033550.2664@linmac>
	<20100803201407.GD1475@chb-desktop>
	<4CADD567.9010606@codemonkey.ws>
	<AANLkTikuNq1ApT+2ML6s6NXXpTZaedgJDG1xq_=oBQPK@mail.gmail.com>
	<4CAE13BA.70707@codemonkey.ws>
	<AANLkTim2qfA+MncyF9Cx1oGYEzgW2TugG9sFTLP8T=J-@mail.gmail.com>
	<4CAE24C5.8030007@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51781 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab0JGUrK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Oct 2010 16:47:10 -0400
In-Reply-To: <4CAE24C5.8030007@codemonkey.ws>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Christian Brunner <chb@muc.de>, malc <av1474@comtv.ru>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, ceph-devel@vger.kernel.org

On Thu, Oct 7, 2010 at 12:51 PM, Anthony Liguori <anthony@codemonkey.ws=
> wrote:
> On 10/07/2010 01:41 PM, Yehuda Sadeh Weinraub wrote:
>>
>> On Thu, Oct 7, 2010 at 11:38 AM, Anthony Liguori<anthony@codemonkey.=
ws>
>> =A0wrote:
>>
>>>
>>> On 10/07/2010 01:08 PM, Yehuda Sadeh Weinraub wrote:
>>>
>>>> On Thu, Oct 7, 2010 at 7:12 AM, Anthony Liguori<anthony@codemonkey=
=2Ews>
>>>
=2E..
>>> There's no fd at all? =A0 How do you get notifications about an
>>> asynchronous
>>> event completion?
>>>
>>> Regards,
>>>
>>> Anthony Liguori
>>>
>>>
>>
>> (resending to list, sorry)
>>
>> The fd is hidden deep under in librados. We get callback notificatio=
ns
>> for events completion.
>>
>
> How is that possible? =A0Are the callbacks delivered in the context o=
f a
> different thread? =A0If so, don't you need locking?

Not sure I'm completely following you. The callbacks are delivered in
the context of a different thread, but won't run concurrently. Do you
see any specific concurrency issue? We can add some mutex protection
around at the aio callback, so that if librados turns multithreaded at
this point we're covered.


Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
