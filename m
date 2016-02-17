From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: rgw and the next infernalis release v9.2.1
Date: Wed, 17 Feb 2016 09:51:30 -0800
Message-ID: <CAMMFjmH1yK4W7mrH7oqtHfBD3A_ELD8ShgU6M7xPYwrHNTdKww@mail.gmail.com>
References: <CAP3mxSw9bgcyfCeSRtQZQctEgLHfbvXJa-VMM9uhMGX9-Zgesg@mail.gmail.com>
	<CAP3mxSwgaVTxAVQT-bXfMiJsC6ABrW2yTVeTAwxnPoD_7TbffQ@mail.gmail.com>
	<CADRKj5S6JPGNevV1Nd1zwjstGbezpNDA1PcLttUno1aAYmnANw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:32876 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161411AbcBQRvb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Feb 2016 12:51:31 -0500
Received: by mail-io0-f178.google.com with SMTP id z135so45707524iof.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 09:51:31 -0800 (PST)
In-Reply-To: <CADRKj5S6JPGNevV1Nd1zwjstGbezpNDA1PcLttUno1aAYmnANw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Abhishek Varshney <abhishek.varshney@flipkart.com>, Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Can you point me to the test in question?

Thx
YuriW

On Wed, Feb 17, 2016 at 7:52 AM, Yehuda Sadeh-Weinraub
<yehuda@redhat.com> wrote:
> Yeah, it's fine. Note that the upgrade test failure seems like an
> issue with the test itself (running radosgw-admin/radosgw while
> upgrading the libraries).
>
> Yehuda
>
>
> On Tue, Feb 16, 2016 at 10:41 PM, Abhishek Varshney
> <abhishek.varshney@flipkart.com> wrote:
>> Hi Yehuda,
>>
>> A gentle reminder. We are waiting for your response to move ahead with
>> next infernalis release v9.2.1.
>>
>> Thanks
>> Abhishek
>>
>> On Thu, Feb 11, 2016 at 11:47 AM, Abhishek Varshney
>> <abhishek.varshney@flipkart.com> wrote:
>>> Hi Yehuda,
>>>
>>> The next infernalis release as found at
>>> https://github.com/ceph/ceph/tree/infernalis passed the rgw suite (
>>> http://tracker.ceph.com/issues/13750#note-21 ). Do you think the
>>> infernalis branch is ready for QE to start their own round of testing
>>> ?
>>>
>>> The upgrade suite has a RGW failed test (
>>> http://tracker.ceph.com/issues/14665 ), is it something that needs to
>>> be fixed before the release ?
>>>
>>> Thanks
>>> Abhishek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
