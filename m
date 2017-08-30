From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: increasingly large packages and longer build times
Date: Wed, 30 Aug 2017 11:17:52 -0600
Message-ID: <CALqRxCzhwwzTiypeHNQWxo3qMrcdBDiK7TSPyrsTzYTYEQMc=w@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com>
 <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
 <71c7b782-6d7e-1e06-e889-bbbf9004ebfe@suse.cz> <CAJE9aONTxPVcyOfoXDw7ZBQrgpWEXpE29b++cct1X816LVY3+w@mail.gmail.com>
 <CAC-Np1w22udazP7Pg0PFqgRj+tEOFiRwXncQNVNigPaZpBUejQ@mail.gmail.com>
 <CAJE9aOMXRGU0L3z_LaMYgX3voDNLuvy5++W3p3Pon+Rbq7Gyug@mail.gmail.com>
 <CAC-Np1zLsgWG=PznwRtFh8tSkh8Z-xc7T+NeBYQrLQBizjiLhA@mail.gmail.com>
 <alpine.DEB.2.11.1708241327080.20435@piezo.novalocal> <CAF-wwdH7ummeA96zovQn3hu2pyaAG=gvgyqDVDSfz=e0Ua7OHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:32823 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbdH3RRy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 13:17:54 -0400
Received: by mail-vk0-f42.google.com with SMTP id j7so19288007vke.0
        for <ceph-devel@vger.kernel.org>; Wed, 30 Aug 2017 10:17:53 -0700 (PDT)
In-Reply-To: <CAF-wwdH7ummeA96zovQn3hu2pyaAG=gvgyqDVDSfz=e0Ua7OHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Alfredo Deza <adeza@redhat.com>, kefu chai <tchaikov@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Aug 27, 2017 at 4:30 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
> Should we ship a ceph-boost, etc. package then that does not overwrite
> distro packages (installs in a different location)?

On the RPM side, ceph depends on the libboost_* sonames directly. So
our ceph-boost package would need to provide those, and Yum may still
prefer it over the standard system boost.

What is the specific risk of overriding RHEL's and Ubuntu's system
boost? (Are there some common packages that users typically install on
ceph nodes that would also depend on the old system boost?)

- Ken
