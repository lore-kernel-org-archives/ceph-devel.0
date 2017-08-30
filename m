From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: increasingly large packages and longer build times
Date: Thu, 31 Aug 2017 07:59:45 +1000
Message-ID: <CAF-wwdH--aJPtj3vdz6xoMvNjn__hMBO9oP5a=puqDcnC_n0dw@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com>
 <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
 <71c7b782-6d7e-1e06-e889-bbbf9004ebfe@suse.cz> <CAJE9aONTxPVcyOfoXDw7ZBQrgpWEXpE29b++cct1X816LVY3+w@mail.gmail.com>
 <CAC-Np1w22udazP7Pg0PFqgRj+tEOFiRwXncQNVNigPaZpBUejQ@mail.gmail.com>
 <CAJE9aOMXRGU0L3z_LaMYgX3voDNLuvy5++W3p3Pon+Rbq7Gyug@mail.gmail.com>
 <CAC-Np1zLsgWG=PznwRtFh8tSkh8Z-xc7T+NeBYQrLQBizjiLhA@mail.gmail.com>
 <alpine.DEB.2.11.1708241327080.20435@piezo.novalocal> <CAF-wwdH7ummeA96zovQn3hu2pyaAG=gvgyqDVDSfz=e0Ua7OHA@mail.gmail.com>
 <CALqRxCzhwwzTiypeHNQWxo3qMrcdBDiK7TSPyrsTzYTYEQMc=w@mail.gmail.com> <CALe9h7ff+J4AL4NykNcsNh0R-ET8hQ48L57LqM0xPf3PA3GyYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36868 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdH3V7s (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 17:59:48 -0400
Received: by mail-lf0-f52.google.com with SMTP id y128so23736131lfd.4
        for <ceph-devel@vger.kernel.org>; Wed, 30 Aug 2017 14:59:47 -0700 (PDT)
In-Reply-To: <CALe9h7ff+J4AL4NykNcsNh0R-ET8hQ48L57LqM0xPf3PA3GyYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, Sage Weil <sage@newdream.net>, Alfredo Deza <adeza@redhat.com>, kefu chai <tchaikov@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 31, 2017 at 3:53 AM, John Spray <jspray@redhat.com> wrote:
> On Wed, Aug 30, 2017 at 6:17 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
>> On Sun, Aug 27, 2017 at 4:30 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
>>> Should we ship a ceph-boost, etc. package then that does not overwrite
>>> distro packages (installs in a different location)?
>>
>> On the RPM side, ceph depends on the libboost_* sonames directly. So
>> our ceph-boost package would need to provide those, and Yum may still
>> prefer it over the standard system boost.
>>
>> What is the specific risk of overriding RHEL's and Ubuntu's system
>> boost? (Are there some common packages that users typically install on
>> ceph nodes that would also depend on the old system boost?)
>
> The thing is, our boost could easily end up being the "old" one, if
> the distro is shipping security updates to theirs.  Our
> higher-numbered boost packages would potentially block the distro's
> updates to their lower-numbered boost packages.  If we ship our own
> separate boost, then maybe Ceph is stuck with an un-patched boost, but
> other applications on the system are not.
>
> It's not necessarily intolerable, but if the goal is packaging hygiene
> then it's a bit self-defeating.

I'm looking into this, as well as other options to reduce the size
(hopefully). Open to any further ideas of course :)

>
> John
>
>>
>> - Ken
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
