From: ZHOU Yuan <dunk007@gmail.com>
Subject: Re: RGW : Transaction Id in response?
Date: Sat, 28 Feb 2015 09:24:28 +0800
Message-ID: <CADTt810yeHs88c4-D53z3mOU-aSfU9pu-gi9p4Qi_4w6jLGDtQ@mail.gmail.com>
References: <CAGoDY9=pLMvUyBKSi4-vqx7XqYbOfPBenzLxPmrKCWzV9Kccig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:62602 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbB1BYs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Feb 2015 20:24:48 -0500
Received: by mail-oi0-f48.google.com with SMTP id a3so18637042oib.7
        for <ceph-devel@vger.kernel.org>; Fri, 27 Feb 2015 17:24:48 -0800 (PST)
In-Reply-To: <CAGoDY9=pLMvUyBKSi4-vqx7XqYbOfPBenzLxPmrKCWzV9Kccig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Dixit <dixitabhi@gmail.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 27, 2015 at 6:31 PM, Abhishek Dixit <dixitabhi@gmail.com> wrote:
> On Thu, Feb 26, 2015 at 10:51 PM, Yehuda Sadeh-Weinraub
> <yehuda@redhat.com> wrote:
>>
>>
>> ----- Original Message -----
>>> From: "Abhishek Dixit" <dixitabhi@gmail.com>
>>> To: "ceph-devel" <ceph-devel@vger.kernel.org>
>>> Sent: Wednesday, February 25, 2015 8:35:40 PM
>>> Subject: RGW : Transaction Id in response?
>>>
>>> Hi,
>>>
>>> I was doing comparison of Open Stack Swift response headers and Ceph
>>> RGW response.
>>> This is in regard to X-Trans-Id header in response from Open Stack
>>> Swift storage.
>>> Swift response to a request always have the header "X-Trans-Id".
>>> X-Trans-Id : A unique transaction identifier for this request.
>>>
>>> X-Trans-Id seems to serve two purpose:
>>> 1. Every log messages for a request will carry this and aid in
>>> debugging/analyzing.
>>> 2. Benchmarking for latency.
>>>
>>> So, do we have similar unique identifier in Ceph RGW response which
>>> associates with each request?
>>>
>>> Or do we need add support for this?
>>>
>>
>> At the moment there is no such identifier. We can leverage the rados client instance id that each radosgw instance gets when connecting to the backend, and there's also a unique running number that we use to identify each request within that gateway. We can probably concatenate these and return it as the unique identifier.
>>
>> Yehuda
>>
>
>
> Hi Yehuda,
>
> I will add "X-Trans-Id" as per you suggested approach.
> I have opened a new issue particularly for adding "X-Trans-Id" as many
> other issues report absence of this header.
>
> I have assigned this to myself.
> http://tracker.ceph.com/issues/10970
>


Hi Yehuda, Abhishek,

may be we should follow the swift way considering the goal is to keep
compatible with swift? This might make the log analysis a bit easier
for swift cluster operators.

def generate_trans_id(trans_id_suffix):
    return 'tx%s-%010x%s' % (
        uuid.uuid4().hex[:21], time.time(), quote(trans_id_suffix))

The trans_id_suffix is configurable in swift setup.

Thanks, -yuan

> Thanks
> Abhishek Dixit
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
