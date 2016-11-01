From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: rgw and the next jewel release v10.2.4
Date: Tue, 1 Nov 2016 10:17:36 +0100
Message-ID: <CABo9giQyGvsYXGs90kLwvE+oekHFNtDZm=T7cPBqPp8cVs=Yow@mail.gmail.com>
References: <5811C853.1070706@dachary.org> <robbat2-20161027T210703-533951955Z@orbis-terrarum.net>
 <581277B8.9020708@dachary.org> <CADRKj5Q3kuF0vKPNnXMy0D7kvsZKSsN-f8Ay3_4hLQ8mjBCDvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37937 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034776AbcKAJRj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2016 05:17:39 -0400
Received: by mail-wm0-f52.google.com with SMTP id n67so274510398wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 01 Nov 2016 02:17:38 -0700 (PDT)
In-Reply-To: <CADRKj5Q3kuF0vKPNnXMy0D7kvsZKSsN-f8Ay3_4hLQ8mjBCDvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, "Robin H. Johnson" <robbat2@gentoo.org>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

https://github.com/ceph/ceph/pull/11280 is merged in master.
Loic, is it still possible to backport it to 10.2.4?

Thanks,
Orit

On Fri, Oct 28, 2016 at 12:05 AM, Yehuda Sadeh-Weinraub
<yehuda@redhat.com> wrote:
> We need to have it in master first. Sadly this one has been
> accidentally closed so we missed some time on it. I'll be happy to see
> it in 10.2.4, but we need to have it merged to master first. Orit is
> supposed to look into that.
>
> Yehuda
>
> On Thu, Oct 27, 2016 at 2:55 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Robin,
>>
>> Since it's not yet merged in master I'm deferring to Yehuda's decision. I'd be happy to delay 10.2.4 if necessary.
>>
>> Cheers
>>
>> On 27/10/2016 23:10, Robin H. Johnson wrote:
>>> On Thu, Oct 27, 2016 at 11:26:43AM +0200, Loic Dachary wrote:
>>>> Hi Yehuda,
>>>>
>>>> The next jewel release as found at
>>>> https://github.com/ceph/ceph/tree/jewel passed the rgw suite
>>>> (http://tracker.ceph.com/issues/17487#note-18). Do you think the jewel
>>>> branch is ready for QE to start their own round of testing ?
>>> Can you please bring in the StaticSites fix in
>>> https://github.com/ceph/ceph/pull/11280
>>>
>>> This issue has been dragging since late August now :-(.
>>> (it got reverted last time because it exposed a test suite bug)
>>>
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
