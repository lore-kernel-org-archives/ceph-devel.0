From: kefu chai <tchaikov@gmail.com>
Subject: Re: increasingly large packages and longer build times
Date: Tue, 22 Aug 2017 23:26:22 +0800
Message-ID: <CAJE9aOPevF-h74Lks1k_3PET=w7yFPtOUmGpvGJg_xnDkUCDvQ@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com>
 <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
 <71c7b782-6d7e-1e06-e889-bbbf9004ebfe@suse.cz> <CAJE9aONTxPVcyOfoXDw7ZBQrgpWEXpE29b++cct1X816LVY3+w@mail.gmail.com>
 <CAKOnarkVWxVXSrs+Kbuczie_ob3tDc7hMFRSXDG=5mLy26MeYA@mail.gmail.com> <d036108b-f38d-109a-5a87-8aa4542dd7fd@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32840 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932946AbdHVP0X (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Aug 2017 11:26:23 -0400
Received: by mail-oi0-f43.google.com with SMTP id f11so189062279oic.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Aug 2017 08:26:23 -0700 (PDT)
In-Reply-To: <d036108b-f38d-109a-5a87-8aa4542dd7fd@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Matt Benjamin <mbenjami@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>, Ken Dreyer <kdreyer@redhat.com>

On Tue, Aug 22, 2017 at 10:09 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 22-8-2017 15:52, Matt Benjamin wrote:
>> ++kefu
>>
>> Matt
>>
>> On Tue, Aug 22, 2017 at 9:35 AM, kefu chai <tchaikov@gmail.com> wrote:
>>> On Tue, Aug 22, 2017 at 4:27 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>>>>> my main concern would be the downstream. how shall we accommodate the
>>>>> packaging of downstream? for example, what if the boost package
>>>>> maintainers of SuSE/fedora/debian/ubuntu are not ready to package the
>>>>> boost version we want to use in future?
>>>>>
>>>>> but as long as we don't require newer boost to build, we are safe on
>>>>> debian and ubuntu at this moment. as boost 1.61 is required for
>>>>> building ceph, and both debian unstable and ubuntu artful package
>>>>> boost v1.62.
>>>>
>>>>
>>>> The very latest cutting-edge versions of the distros may ship boost >= 1.61
>>>> but the stable versions most likely do not.
>
> For FreeBSD I use the ports version = 1.64.
> Thus far no problems.
>
> And since we are talking about boost....
>
> How do I prevent `git submodule ` from downloading all this Boost stuff
> that I'm not going to use it anyways?
> So downloading this massive git-tree over and over, is a waste of time
> and bandwidth.

Willem, probably you could have a local change to remove that submodule?

also, FYI, i was trying to build the boost using its release tarball
in PR#15376 [0], so we don't need to pull the full repo of it. but i
didn't get enough bandwidth on updating the "make-dist" script to
accommodate the change. so the change stopped at building boost as an
external project.

but before we have a plan for fixing the boost building process , i am
not sure it's advisable to continue working on removing the boost
submodule and updating the "make-dist" script, etc.

---
[0] https://github.com/ceph/ceph/pull/15376


-- 
Regards
Kefu Chai
