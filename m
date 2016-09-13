From: John Spray <jspray@redhat.com>
Subject: Re: Are we ready to move from Trusty to Xenial in the lab?
Date: Wed, 14 Sep 2016 01:25:53 +0530
Message-ID: <CALe9h7d_d_6Er9wY0rE=Bgn+3TxOOdDMN50Pr42wWAKaYY0S1A@mail.gmail.com>
References: <CABq-AyRr-tKgtm9dOF4g2fxL7aR4jPfYtLppBc_12Uh39xJL8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35594 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760296AbcIMT4O (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Sep 2016 15:56:14 -0400
Received: by mail-qk0-f180.google.com with SMTP id t7so84602386qkh.2
        for <ceph-devel@vger.kernel.org>; Tue, 13 Sep 2016 12:56:14 -0700 (PDT)
In-Reply-To: <CABq-AyRr-tKgtm9dOF4g2fxL7aR4jPfYtLppBc_12Uh39xJL8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Meno <gmeno@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 14, 2016 at 12:35 AM, Gregory Meno <gmeno@redhat.com> wrote:
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

Last discussion I remember about this, waiting for edeploy was the
plan, so that there was no big-bang decision to make (runs could be
scheduled on xenial or trusty at will).  Why are we talking about
persistently switching machines to Xenial sooner?

> * python3 isn't quite ready and we'll feel a lot of pain in the short term

I would rephrase that as "folks interested in running tests on Xenial
will need to stabilise the python 3 part first", rather than
entertaining it as a possibly-acceptable side effect of moving
unrelated test suites over to a different distro.

John

>
> Is there something I'm missing here?
> Should we just go ahead and see how it goes?
>
> cheers,
> Gregory
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
