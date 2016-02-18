From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: Re: rgw and the next infernalis release v9.2.1
Date: Thu, 18 Feb 2016 08:24:57 +0530
Message-ID: <CAP3mxSzyCSQQ7mwVjysTXrbSWWjbKVkyyHkN9MmYHKyncZHrmg@mail.gmail.com>
References: <CAP3mxSw9bgcyfCeSRtQZQctEgLHfbvXJa-VMM9uhMGX9-Zgesg@mail.gmail.com>
	<CAP3mxSwgaVTxAVQT-bXfMiJsC6ABrW2yTVeTAwxnPoD_7TbffQ@mail.gmail.com>
	<CADRKj5S6JPGNevV1Nd1zwjstGbezpNDA1PcLttUno1aAYmnANw@mail.gmail.com>
	<CAMMFjmH1yK4W7mrH7oqtHfBD3A_ELD8ShgU6M7xPYwrHNTdKww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33323 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423886AbcBRCy6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Feb 2016 21:54:58 -0500
Received: by mail-lf0-f54.google.com with SMTP id m1so23838544lfg.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 18:54:57 -0800 (PST)
In-Reply-To: <CAMMFjmH1yK4W7mrH7oqtHfBD3A_ELD8ShgU6M7xPYwrHNTdKww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Hi Yuri,

The RGW test that failed in the upgrade suite run (
http://tracker.ceph.com/issues/13750#note-15 ) can be found here :
http://pulpito.ceph.com/loic-2016-02-05_13:57:02-upgrade:infernalis-infernalis---basic-vps/

Thanks
Abhishek



On Wed, Feb 17, 2016 at 11:21 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Can you point me to the test in question?
>
> Thx
> YuriW
>
> On Wed, Feb 17, 2016 at 7:52 AM, Yehuda Sadeh-Weinraub
> <yehuda@redhat.com> wrote:
>> Yeah, it's fine. Note that the upgrade test failure seems like an
>> issue with the test itself (running radosgw-admin/radosgw while
>> upgrading the libraries).
>>
>> Yehuda
>>
>>
>> On Tue, Feb 16, 2016 at 10:41 PM, Abhishek Varshney
>> <abhishek.varshney@flipkart.com> wrote:
>>> Hi Yehuda,
>>>
>>> A gentle reminder. We are waiting for your response to move ahead with
>>> next infernalis release v9.2.1.
>>>
>>> Thanks
>>> Abhishek
>>>
>>> On Thu, Feb 11, 2016 at 11:47 AM, Abhishek Varshney
>>> <abhishek.varshney@flipkart.com> wrote:
>>>> Hi Yehuda,
>>>>
>>>> The next infernalis release as found at
>>>> https://github.com/ceph/ceph/tree/infernalis passed the rgw suite (
>>>> http://tracker.ceph.com/issues/13750#note-21 ). Do you think the
>>>> infernalis branch is ready for QE to start their own round of testing
>>>> ?
>>>>
>>>> The upgrade suite has a RGW failed test (
>>>> http://tracker.ceph.com/issues/14665 ), is it something that needs to
>>>> be fixed before the release ?
>>>>
>>>> Thanks
>>>> Abhishek
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
