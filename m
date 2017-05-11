From: Dan van der Ster <dan@vanderster.com>
Subject: Re: fs: mandatory client quota
Date: Thu, 11 May 2017 09:42:59 +0200
Message-ID: <CABZ+qqkW97ENR86iayeV7Y0dEuPPX2WZhLJaSyhWYhQ9os920A@mail.gmail.com>
References: <CABZ+qqkk=2Q8p+KCpOEKWw_ZkviPW_v6rgt=ML984O25CFYxOw@mail.gmail.com>
 <CABZ+qqnFwaV9Va-B4WHp=ntPgKZdsDA1P=m67pLPWU7Y9Tyu+Q@mail.gmail.com>
 <alpine.DEB.2.11.1705051456250.3646@piezo.novalocal> <CAJ4mKGZJ0ZJxhuKf9ndhchp4Ca=Y8+QUdkq-tZBvnsCqfCdkTA@mail.gmail.com>
 <CALe9h7cXHxwDo=aBYKJyVn0jo5xeKctBhB8SHTcuqwJ8wjfmSQ@mail.gmail.com> <f0f0b204-0fd3-feb7-4717-5bc42697775a@brockmann-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35600 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdEKHnl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 03:43:41 -0400
Received: by mail-oi0-f50.google.com with SMTP id l18so20805751oig.2
        for <ceph-devel@vger.kernel.org>; Thu, 11 May 2017 00:43:40 -0700 (PDT)
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id b12sm473491oth.4.2017.05.11.00.43.39
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 00:43:39 -0700 (PDT)
Received: by mail-oi0-f43.google.com with SMTP id w10so20962217oif.0
        for <ceph-devel@vger.kernel.org>; Thu, 11 May 2017 00:43:39 -0700 (PDT)
In-Reply-To: <f0f0b204-0fd3-feb7-4717-5bc42697775a@brockmann-consult.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Maloney <peter.maloney@brockmann-consult.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, May 10, 2017 at 10:46 PM, Peter Maloney
<peter.maloney@brockmann-consult.de> wrote:
> On 05/10/17 09:03, John Spray wrote:
>> On Tue, May 9, 2017 at 5:47 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> On Fri, May 5, 2017 at 7:57 AM, Sage Weil <sage@newdream.net> wrote:
>>>> On Fri, 5 May 2017, Dan van der Ster wrote:
>>>>> On Fri, May 5, 2017 at 4:36 PM, Dan van der Ster <dan@vanderster.com>
>>>>> wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> It would be really nice if for Luminous client quotas were always
>>>>>> enabled -- it should be impossible to disable quota enforcement on the
>>>>>> client side.
>>>>>>
>>>>>> From the looks of things, the patch to remove client_quota and
>>>>>> client_quota_df would be trivial.
>>>>>> Is there some reason we need to leave that optional?
>>>>> PR: 14978
>>>> This seems reasonable to me.  Client can of course run modified code so
>>>> it's not really "secure" in that sense but it's certainly inconvenient to
>>>> circumvent.
>>> I'm sure John will comment on this once he gets back from vacation, but
>>> there were some reasons not to enable it by default when this was discussed
>>> by the team last fall. I think it was combined concern about the lack of
>>> server-side enforcement and (more importantly) not wanting to provide
>>> default experiences which differ across the userspace and kernel clients.
>> client_quota has been true by default in master for about a year -- I
>> think at this stage the question is just whether it's important to
>> enable people to disable them, where disabling is really only sensible
>> in cases where someone e.g. hits a quota bug and wants to skip the
>> code.
>>
>> My view is that the simplicity of support (not worrying about users
>> disabling quota and then complaining about it not working) is a good
>> enough motivator to remove the setting.  Making it less convenient for
>> naughty clients to circumvent quota is a bonus.
>>
>> Commenting on PR....
>>
>> John
>>
> I don't think it was mentioned yet...but isn't a pool quota mandatory?
> If so, you could use that for those naughty clients.
>
> I'm using cephfs with a pool quota and found the client just hangs
> waiting for space if the pool quota is hit, and ceph -s gets a warning.
> That's less than desirable, but if combined with the client quota, it
> ought to be friendly.
>

We don't have a unique pool per user (where user in our case == Manila share).
OTOH, quota per RADOS namespace would be usable, if such a thing were
implementable.

Cheers, Dan
