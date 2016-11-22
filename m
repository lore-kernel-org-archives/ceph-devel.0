From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: uint32_t BlueStore::Extent::logical_offset?
Date: Tue, 22 Nov 2016 20:15:34 +0300
Message-ID: <c0f915a2-dd47-8c4a-8520-b2d919615884@mirantis.com>
References: <8e0b5262-32ef-02a6-6812-a3e82369e9aa@mirantis.com>
 <CAJ4mKGZ8=fikstiyfN_K23n=rBqRx8h-Umri7UOwhM6mfhNe-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34296 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932537AbcKVRPk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 12:15:40 -0500
Received: by mail-yw0-f181.google.com with SMTP id t125so19942779ywc.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 09:15:40 -0800 (PST)
In-Reply-To: <CAJ4mKGZ8=fikstiyfN_K23n=rBqRx8h-Umri7UOwhM6mfhNe-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

But ObjectStore provides 64-bit interface hence such a limit is pretty 
implicit.


On 22.11.2016 20:06, Gregory Farnum wrote:
> On Tue, Nov 22, 2016 at 11:58 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
>> Hi Sage,
>>
>>
>> I'm wondering why BlueStore::Extent::logical_offset is 32-bit wide.
>>
>> IMHO it's to be uint64_t unless we limit onode size to 4Gb.
>>
>> Looks like we have implicit truncate when doing set_lextent/new Extent at
>> the moment and hence some issues with large onodes are possible.
> onodes represent a single RADOS object within BlueStore, don't they?
> So 4GB is much more than we need; the rest of the system on top is
> going to fail well before you reach that size.
> -Greg
>
>> Thanks,
>> Igor
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

