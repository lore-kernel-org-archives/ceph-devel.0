From: kefu chai <tchaikov@gmail.com>
Subject: Re: increasingly large packages and longer build times
Date: Tue, 22 Aug 2017 21:35:22 +0800
Message-ID: <CAJE9aONTxPVcyOfoXDw7ZBQrgpWEXpE29b++cct1X816LVY3+w@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com>
 <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com> <71c7b782-6d7e-1e06-e889-bbbf9004ebfe@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34348 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932825AbdHVNfX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Aug 2017 09:35:23 -0400
Received: by mail-oi0-f47.google.com with SMTP id j144so57753369oib.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Aug 2017 06:35:23 -0700 (PDT)
In-Reply-To: <71c7b782-6d7e-1e06-e889-bbbf9004ebfe@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>, Ken Dreyer <kdreyer@redhat.com>

On Tue, Aug 22, 2017 at 4:27 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> my main concern would be the downstream. how shall we accommodate the
>> packaging of downstream? for example, what if the boost package
>> maintainers of SuSE/fedora/debian/ubuntu are not ready to package the
>> boost version we want to use in future?
>>
>> but as long as we don't require newer boost to build, we are safe on
>> debian and ubuntu at this moment. as boost 1.61 is required for
>> building ceph, and both debian unstable and ubuntu artful package
>> boost v1.62.
>
>
> The very latest cutting-edge versions of the distros may ship boost >= 1.61
> but the stable versions most likely do not.

yeah. but, IIRC, debian stable does not accepts new packages unless
they contain critical bug fixes. the new packages will go to the
unstable or experimental distribution first. so, presumably, debian
will be fine. guess ubuntu is using similar strategy for including
packages in its LTS distros.

>
> For luminous we (SUSE) need to support the latest stable versions of
> openSUSE and SLE, i.e. Leap 42.3 and SLE-12-SP3. Both of these come with
> boost 1.54.

yeah, then we need to package libboost in one way or another.

>
> Nathan



-- 
Regards
Kefu Chai
