From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: ceph-disk and 'make'
Date: Tue, 20 Sep 2016 12:04:13 -0600
Message-ID: <CALqRxCy629qBDOobD==3B9M_-QkLjeg7xuPcVkkOQ1ycrotVrw@mail.gmail.com>
References: <alpine.DEB.2.11.1609190036390.3215@piezo.us.to>
 <57DF7DA0.2050007@dachary.org> <57DF9525.5050904@dachary.org>
 <CAJ4mKGb4ELCPgQOeiC_RWGtBZ44L1anrKX4eRJZx=p25cVCyMg@mail.gmail.com> <CAJE9aONfH9uWx4vtYUTjJMo_udRU_vEOMBYag8H6gY8+jGNSCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34124 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755672AbcITSEW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2016 14:04:22 -0400
Received: by mail-vk0-f48.google.com with SMTP id o139so47414850vka.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2016 11:04:22 -0700 (PDT)
In-Reply-To: <CAJE9aONfH9uWx4vtYUTjJMo_udRU_vEOMBYag8H6gY8+jGNSCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Marcus Watts <mwatts@redhat.com>, Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 20, 2016 at 9:28 AM, kefu chai <tchaikov@gmail.com> wrote:
> agreed, actually, a test-ready ceph-disk needs venv which pip to install the
> dependencies, but debian pbuilder uses a cleanroom for building packages
> in which no network access is allowed by default.

I'm curious why we need a virtualenv at all (or why we "pip install" anything) ?

The distros should have all the packaged python-* and python3-*
dependencies already, right?

If we could switch to using the packaged python dependencies for
everything, we'd fix the pbuilder USENETWORK issue, and avoid the
indeterminate nature of depending on whatever happens to be going on
with pypi. Maybe I'm missing something, though?

- Ken
