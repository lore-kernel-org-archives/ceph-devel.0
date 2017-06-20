From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Tue, 20 Jun 2017 13:39:10 -0700
Message-ID: <CAJ4mKGZCQP0FXh5NWA8429mFmZq3=oqFX=eJMRCPoapmEVJULg@mail.gmail.com>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com>
 <CADRKj5RCQf8wv+Y3VsL=e_gB9URYzK0SkzGRVfTFQwcJn-OL4g@mail.gmail.com>
 <alpine.DEB.2.11.1706141943490.32269@piezo.novalocal> <CA+aFP1B0ngk-Wkfy0KXnkyRP2XZJqvce1qhdBfpL+5PcjmGNoQ@mail.gmail.com>
 <alpine.DEB.2.11.1706191924150.32269@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36422 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdFTUjM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jun 2017 16:39:12 -0400
Received: by mail-io0-f171.google.com with SMTP id y77so92200242ioe.3
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 13:39:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706191924150.32269@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Jason Dillaman <dillaman@redhat.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 19, 2017 at 12:26 PM, Sage Weil <sweil@redhat.com> wrote:
> I wrote up a quick proposal at
>
>         http://pad.ceph.com/p/service-map
>
> Basic idea:
>
>  - generic ServiceMap of service -> daemon -> metadata and status
>  - managed/persisted by mon
>  - librados interface to register as service X name Y (e.g., 'rgw.foo')
>  - librados will send regular beacon to mon to keep entry alive
>  - various mon commands to dump all or part of the service map

I am deeply uncomfortable with putting this stuff into the monitor (at
least, directly). The main purpose we've discussed is to enable
manager dashboard display of these services, along with stats
collection, and there's no reason for that to go anywhere other than
the manager — in fact, routing it through the monitor is inimical to
timely updates of statistics. Why do you want to do that instead of
letting it be handled by the manager, which can aggregate and persist
whatever data it likes in a convenient form — and in ways which are
mindful of monitor IO abilities?
(The librados interface looks fine to me, though.)
-Greg
