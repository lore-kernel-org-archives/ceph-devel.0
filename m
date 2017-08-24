From: kefu chai <tchaikov@gmail.com>
Subject: Re: increasingly large packages and longer build times
Date: Thu, 24 Aug 2017 16:41:18 +0800
Message-ID: <CAJE9aOMXRGU0L3z_LaMYgX3voDNLuvy5++W3p3Pon+Rbq7Gyug@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com>
 <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
 <71c7b782-6d7e-1e06-e889-bbbf9004ebfe@suse.cz> <CAJE9aONTxPVcyOfoXDw7ZBQrgpWEXpE29b++cct1X816LVY3+w@mail.gmail.com>
 <CAC-Np1w22udazP7Pg0PFqgRj+tEOFiRwXncQNVNigPaZpBUejQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33572 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdHXIlU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Aug 2017 04:41:20 -0400
Received: by mail-oi0-f42.google.com with SMTP id k77so10708158oib.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Aug 2017 01:41:19 -0700 (PDT)
In-Reply-To: <CAC-Np1w22udazP7Pg0PFqgRj+tEOFiRwXncQNVNigPaZpBUejQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ken Dreyer <kdreyer@redhat.com>

On Wed, Aug 23, 2017 at 2:58 AM, Alfredo Deza <adeza@redhat.com> wrote:
> On Tue, Aug 22, 2017 at 9:35 AM, kefu chai <tchaikov@gmail.com> wrote:
>> On Tue, Aug 22, 2017 at 4:27 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>>>> my main concern would be the downstream. how shall we accommodate the
>>>> packaging of downstream? for example, what if the boost package
>>>> maintainers of SuSE/fedora/debian/ubuntu are not ready to package the
>>>> boost version we want to use in future?
>>>>
>>>> but as long as we don't require newer boost to build, we are safe on
>>>> debian and ubuntu at this moment. as boost 1.61 is required for
>>>> building ceph, and both debian unstable and ubuntu artful package
>>>> boost v1.62.
>>>
>>>
>>> The very latest cutting-edge versions of the distros may ship boost >= 1.61
>>> but the stable versions most likely do not.
>>
>> yeah. but, IIRC, debian stable does not accepts new packages unless
>> they contain critical bug fixes. the new packages will go to the
>> unstable or experimental distribution first. so, presumably, debian
>> will be fine. guess ubuntu is using similar strategy for including
>> packages in its LTS distros.
>
> Why are you concerned with distros and the availability to have a
> package at the version that we need?
>
> We publish our own repos, where we could have whatever boost version
> we need. Distro package maintainers have to
> decide what they can or can't do. For us it shouldn't matter.
>

i think it matters. and i believe it'd be desirable if Ceph can be
easier for downstream to package. if the downstream finds that Ceph is
too difficult to package, and give up, that's surely not the end of
the world. but it could decrease the popularity level of ceph, and in
long term, it might hurt Ceph.

-- 
Regards
Kefu Chai
