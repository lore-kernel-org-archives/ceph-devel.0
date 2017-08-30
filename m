From: John Spray <jspray@redhat.com>
Subject: Re: increasingly large packages and longer build times
Date: Thu, 31 Aug 2017 00:09:18 +0100
Message-ID: <CALe9h7cPVXoXj8Ekq+nv=riXeF1qfh_F7_EnZ_Tn34Rs1FdA1A@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com>
 <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
 <71c7b782-6d7e-1e06-e889-bbbf9004ebfe@suse.cz> <CAJE9aONTxPVcyOfoXDw7ZBQrgpWEXpE29b++cct1X816LVY3+w@mail.gmail.com>
 <CAC-Np1w22udazP7Pg0PFqgRj+tEOFiRwXncQNVNigPaZpBUejQ@mail.gmail.com>
 <CAJE9aOMXRGU0L3z_LaMYgX3voDNLuvy5++W3p3Pon+Rbq7Gyug@mail.gmail.com>
 <CAC-Np1zLsgWG=PznwRtFh8tSkh8Z-xc7T+NeBYQrLQBizjiLhA@mail.gmail.com>
 <alpine.DEB.2.11.1708241327080.20435@piezo.novalocal> <CAF-wwdH7ummeA96zovQn3hu2pyaAG=gvgyqDVDSfz=e0Ua7OHA@mail.gmail.com>
 <CALqRxCzhwwzTiypeHNQWxo3qMrcdBDiK7TSPyrsTzYTYEQMc=w@mail.gmail.com>
 <CALe9h7ff+J4AL4NykNcsNh0R-ET8hQ48L57LqM0xPf3PA3GyYg@mail.gmail.com> <CALqRxCyB4joTgKu1ciuXXXLF_Mqbk0OqEHkFNFUYm=LnWR26uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33653 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdH3XJk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 19:09:40 -0400
Received: by mail-wm0-f49.google.com with SMTP id r202so4747951wmd.0
        for <ceph-devel@vger.kernel.org>; Wed, 30 Aug 2017 16:09:39 -0700 (PDT)
In-Reply-To: <CALqRxCyB4joTgKu1ciuXXXLF_Mqbk0OqEHkFNFUYm=LnWR26uA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Sage Weil <sage@newdream.net>, Alfredo Deza <adeza@redhat.com>, kefu chai <tchaikov@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Aug 30, 2017 at 11:07 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On Wed, Aug 30, 2017 at 11:53 AM, John Spray <jspray@redhat.com> wrote:
>> The thing is, our boost could easily end up being the "old" one, if
>> the distro is shipping security updates to theirs.  Our
>> higher-numbered boost packages would potentially block the distro's
>> updates to their lower-numbered boost packages.  If we ship our own
>> separate boost, then maybe Ceph is stuck with an un-patched boost, but
>> other applications on the system are not.
>
> That scenario is theoretically possible, and it's good that you bring
> it up for consideration. I'm trying to understand the likelihood of
> the effort/disruption there. Do you have specific applications in mind
> that would benefit in the way you describe? Ones that require boost
> and are often co-installed on Ceph nodes?

Lots of things depend on boost.  Naturally I don't know what
specifically people run on their Ceph servers apart from Ceph.  It's
risky to blow away distro packages in favour of our own, precisely
because of that lack of knowledge about what else is going on on the
servers.

I'm really just pointing out that there's a degree of risk that our
users would be taking on, in exchange for the (not inconsiderable)
benefit of knocking 500MB out of a fully checked out tree.

John
