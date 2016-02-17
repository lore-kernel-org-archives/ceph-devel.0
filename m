From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw and the next infernalis release v9.2.1
Date: Wed, 17 Feb 2016 07:52:56 -0800
Message-ID: <CADRKj5S6JPGNevV1Nd1zwjstGbezpNDA1PcLttUno1aAYmnANw@mail.gmail.com>
References: <CAP3mxSw9bgcyfCeSRtQZQctEgLHfbvXJa-VMM9uhMGX9-Zgesg@mail.gmail.com>
	<CAP3mxSwgaVTxAVQT-bXfMiJsC6ABrW2yTVeTAwxnPoD_7TbffQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36462 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422764AbcBQPw5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Feb 2016 10:52:57 -0500
Received: by mail-vk0-f49.google.com with SMTP id c3so18009398vkb.3
        for <ceph-devel@vger.kernel.org>; Wed, 17 Feb 2016 07:52:56 -0800 (PST)
In-Reply-To: <CAP3mxSwgaVTxAVQT-bXfMiJsC6ABrW2yTVeTAwxnPoD_7TbffQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Yeah, it's fine. Note that the upgrade test failure seems like an
issue with the test itself (running radosgw-admin/radosgw while
upgrading the libraries).

Yehuda


On Tue, Feb 16, 2016 at 10:41 PM, Abhishek Varshney
<abhishek.varshney@flipkart.com> wrote:
> Hi Yehuda,
>
> A gentle reminder. We are waiting for your response to move ahead with
> next infernalis release v9.2.1.
>
> Thanks
> Abhishek
>
> On Thu, Feb 11, 2016 at 11:47 AM, Abhishek Varshney
> <abhishek.varshney@flipkart.com> wrote:
>> Hi Yehuda,
>>
>> The next infernalis release as found at
>> https://github.com/ceph/ceph/tree/infernalis passed the rgw suite (
>> http://tracker.ceph.com/issues/13750#note-21 ). Do you think the
>> infernalis branch is ready for QE to start their own round of testing
>> ?
>>
>> The upgrade suite has a RGW failed test (
>> http://tracker.ceph.com/issues/14665 ), is it something that needs to
>> be fixed before the release ?
>>
>> Thanks
>> Abhishek
