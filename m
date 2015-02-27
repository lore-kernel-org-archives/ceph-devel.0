From: Abhishek Dixit <dixitabhi@gmail.com>
Subject: Re: RGW : Transaction Id in response?
Date: Fri, 27 Feb 2015 16:01:53 +0530
Message-ID: <CAGoDY9=pLMvUyBKSi4-vqx7XqYbOfPBenzLxPmrKCWzV9Kccig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:39905 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbB0KcP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Feb 2015 05:32:15 -0500
Received: by lbvn10 with SMTP id n10so16389802lbv.6
        for <ceph-devel@vger.kernel.org>; Fri, 27 Feb 2015 02:32:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Feb 26, 2015 at 10:51 PM, Yehuda Sadeh-Weinraub
<yehuda@redhat.com> wrote:
>
>
> ----- Original Message -----
>> From: "Abhishek Dixit" <dixitabhi@gmail.com>
>> To: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Sent: Wednesday, February 25, 2015 8:35:40 PM
>> Subject: RGW : Transaction Id in response?
>>
>> Hi,
>>
>> I was doing comparison of Open Stack Swift response headers and Ceph
>> RGW response.
>> This is in regard to X-Trans-Id header in response from Open Stack
>> Swift storage.
>> Swift response to a request always have the header "X-Trans-Id".
>> X-Trans-Id : A unique transaction identifier for this request.
>>
>> X-Trans-Id seems to serve two purpose:
>> 1. Every log messages for a request will carry this and aid in
>> debugging/analyzing.
>> 2. Benchmarking for latency.
>>
>> So, do we have similar unique identifier in Ceph RGW response which
>> associates with each request?
>>
>> Or do we need add support for this?
>>
>
> At the moment there is no such identifier. We can leverage the rados client instance id that each radosgw instance gets when connecting to the backend, and there's also a unique running number that we use to identify each request within that gateway. We can probably concatenate these and return it as the unique identifier.
>
> Yehuda
>


Hi Yehuda,

I will add "X-Trans-Id" as per you suggested approach.
I have opened a new issue particularly for adding "X-Trans-Id" as many
other issues report absence of this header.

I have assigned this to myself.
http://tracker.ceph.com/issues/10970

Thanks
Abhishek Dixit
