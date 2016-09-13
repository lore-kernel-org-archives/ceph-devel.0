From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Are we ready to move from Trusty to Xenial in the lab?
Date: Tue, 13 Sep 2016 12:47:32 -0700
Message-ID: <CAJ4mKGZBENbrtbzkM-Pbmqa=KwvAK2QvMc8h3-GJ0+SnQdfH9w@mail.gmail.com>
References: <CABq-AyRr-tKgtm9dOF4g2fxL7aR4jPfYtLppBc_12Uh39xJL8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36132 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759880AbcIMTre (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Sep 2016 15:47:34 -0400
Received: by mail-yw0-f171.google.com with SMTP id u124so99861320ywg.3
        for <ceph-devel@vger.kernel.org>; Tue, 13 Sep 2016 12:47:33 -0700 (PDT)
In-Reply-To: <CABq-AyRr-tKgtm9dOF4g2fxL7aR4jPfYtLppBc_12Uh39xJL8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Meno <gmeno@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 13, 2016 at 12:05 PM, Gregory Meno <gmeno@redhat.com> wrote:
> Hello readers,
>
> I am aware that our nightly tests are running on centos7 and trusty in
> the sepia lab. xenial has been the lastest LTS release of Ubuntu for
> some time now. It seems like we should move the nightly testing on to
> xenial
>
> Here are some benefits to moving the nightlies up to xenial:
>
> * Quicker feedback of issues before we release
> * Easier access to reproduce issues that are reported after release
> * provide an easy way to judge readiness for a Python3 world
>
> Some things that might prevent us from going there this week.
>
> * we should wait till we have a mechanism to re-image bare metal lab
> machines on the fly before each test (edeploy --
> https://github.com/redhat-cip/edeploy)
> * python3 isn't quite ready and we'll feel a lot of pain in the short term

We'll still have python2 available, right? What's the specific pain point here?

I'm thinking of stuff like ceph-mgr and CephVolumeClient (...and
calamari?) which are still python 2 and don't have any work scheduled
to update them yet. If that's a blocker, that would be a reason. But I
think it just means teuthology needs to install python2 and use it
easily?

Anyway, as Mark said we don't need to move everything. We can image
the new machines and put them in a different pool and run all the
suites through to see if there's trouble, or just do it on a couple
testnodes or something.
-Greg
