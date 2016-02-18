From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: rgw and the next infernalis release v9.2.1
Date: Thu, 18 Feb 2016 13:39:36 -0800
Message-ID: <CAMMFjmGhpfhBSMTNkW7Xj-xRY4DYYf1gKFt6JwoGXXrVV8KL4g@mail.gmail.com>
References: <CAP3mxSw9bgcyfCeSRtQZQctEgLHfbvXJa-VMM9uhMGX9-Zgesg@mail.gmail.com>
	<CAP3mxSwgaVTxAVQT-bXfMiJsC6ABrW2yTVeTAwxnPoD_7TbffQ@mail.gmail.com>
	<CADRKj5S6JPGNevV1Nd1zwjstGbezpNDA1PcLttUno1aAYmnANw@mail.gmail.com>
	<CAMMFjmH1yK4W7mrH7oqtHfBD3A_ELD8ShgU6M7xPYwrHNTdKww@mail.gmail.com>
	<CAP3mxSzyCSQQ7mwVjysTXrbSWWjbKVkyyHkN9MmYHKyncZHrmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:35020 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbcBRVjh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Feb 2016 16:39:37 -0500
Received: by mail-io0-f175.google.com with SMTP id g203so88888662iof.2
        for <ceph-devel@vger.kernel.org>; Thu, 18 Feb 2016 13:39:37 -0800 (PST)
In-Reply-To: <CAP3mxSzyCSQQ7mwVjysTXrbSWWjbKVkyyHkN9MmYHKyncZHrmg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

The RGW test that failed in the upgrade suite run should be fixed by
https://github.com/ceph/ceph-qa-suite/pull/826

tests passed on wip branch.

Thx
YuriW

On Wed, Feb 17, 2016 at 6:54 PM, Abhishek Varshney
<abhishek.varshney@flipkart.com> wrote:
> Hi Yuri,
>
> The RGW test that failed in the upgrade suite run (
> http://tracker.ceph.com/issues/13750#note-15 ) can be found here :
> http://pulpito.ceph.com/loic-2016-02-05_13:57:02-upgrade:infernalis-infernalis---basic-vps/
>
> Thanks
> Abhishek
>
>
>
> On Wed, Feb 17, 2016 at 11:21 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Can you point me to the test in question?
>>
>> Thx
>> YuriW
>>
>> On Wed, Feb 17, 2016 at 7:52 AM, Yehuda Sadeh-Weinraub
>> <yehuda@redhat.com> wrote:
>>> Yeah, it's fine. Note that the upgrade test failure seems like an
>>> issue with the test itself (running radosgw-admin/radosgw while
>>> upgrading the libraries).
>>>
>>> Yehuda
>>>
>>>
>>> On Tue, Feb 16, 2016 at 10:41 PM, Abhishek Varshney
>>> <abhishek.varshney@flipkart.com> wrote:
>>>> Hi Yehuda,
>>>>
>>>> A gentle reminder. We are waiting for your response to move ahead with
>>>> next infernalis release v9.2.1.
>>>>
>>>> Thanks
>>>> Abhishek
>>>>
>>>> On Thu, Feb 11, 2016 at 11:47 AM, Abhishek Varshney
>>>> <abhishek.varshney@flipkart.com> wrote:
>>>>> Hi Yehuda,
>>>>>
>>>>> The next infernalis release as found at
>>>>> https://github.com/ceph/ceph/tree/infernalis passed the rgw suite (
>>>>> http://tracker.ceph.com/issues/13750#note-21 ). Do you think the
>>>>> infernalis branch is ready for QE to start their own round of testing
>>>>> ?
>>>>>
>>>>> The upgrade suite has a RGW failed test (
>>>>> http://tracker.ceph.com/issues/14665 ), is it something that needs to
>>>>> be fixed before the release ?
>>>>>
>>>>> Thanks
>>>>> Abhishek
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
