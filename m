From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: removing 'rados cppool' command
Date: Fri, 6 May 2016 14:48:05 -0700
Message-ID: <CADRKj5TNvkzuaLF5qMct8dE_h8iv_eUAQ1wGT=X_PUj9DzCVzQ@mail.gmail.com>
References: <alpine.DEB.2.11.1605061538160.1841@cpach.fuggernut.com>
	<CADRKj5TO=TwyGqVC4wVfhN-09+SXwzeBftY7+HbtSgBRZwhuhw@mail.gmail.com>
	<alpine.DEB.2.11.1605061726250.15518@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33236 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758265AbcEFVsH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 17:48:07 -0400
Received: by mail-vk0-f45.google.com with SMTP id o133so5879502vka.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 May 2016 14:48:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605061726250.15518@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Fri, May 6, 2016 at 2:27 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 6 May 2016, Yehuda Sadeh-Weinraub wrote:
>> On Fri, May 6, 2016 at 12:41 PM, Sage Weil <sweil@redhat.com> wrote:
>> > This PR
>> >
>> >         https://github.com/ceph/ceph/pull/8975
>> >
>> > removes the 'rados cppool' command.  The main problem is that the command
>> > does not make a faithful copy of all data because it doesn't preserve the
>> > snapshots (and snapshot related metadata).  That means if you copy an RBD
>> > pool it will render the images somewhat broken (snaps won't be present and
>> > won't work properly).  It also doesn't preserve the user_version field
>> > that some librados users may rely on.
>> >
>> > Since it's obscure and of limited use, this PR just removes it.
>> >
>> > Alternatively, we could add safeguards so that it refuses to make a copy
>> > if there are any selfmanaged_snaps, and/or generate some warnings.
>> >
>> > Any objections?
>>
>> I prefer the alternative. I found this command pretty useful for
>> testing config upgrade scenarios with rgw. After generating config
>> scenarios in older versions, I used this command to store the config
>> on another pool, and then I could get the different config whenever
>> needed.
>
> Keep in mind that all of these calls in rgw
>
>         rgw/rgw_rados.cc:  epoch = ref.ioctx.get_last_version();
>
> may be subtley broken by cppool because user_version is not preserved...
>

Right, but these calls are done in the bucket index pool, not at the
root or metadata pools that are relevant to the system config. While
it may not be the perfect tool for everything, I still find it useful
from time to time.

Yehuda
