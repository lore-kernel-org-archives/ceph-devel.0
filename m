From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Missing prettytable during ceph-disk runs
Date: Sun, 28 Jan 2018 18:46:32 +1000
Message-ID: <CAF-wwdG8jEWX_u4UaDiJsO_GsR7Dwx4kthmXfVjL1tjwCtj5PQ@mail.gmail.com>
References: <92db6d6a-420d-3f89-9631-8376b5d7d6a2@digiware.nl>
 <CAC-Np1y1hBFVnor9OhMxmj+xXZO5cnHvcQz6wAbjJ-7xhLhPBw@mail.gmail.com>
 <alpine.DEB.2.11.1706021539070.3646@piezo.novalocal> <5f1c8ae2-f112-4ae4-60c1-ed3f57274d44@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:45249 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeA1Iqe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Jan 2018 03:46:34 -0500
Received: by mail-lf0-f42.google.com with SMTP id x196so5659887lfd.12
        for <ceph-devel@vger.kernel.org>; Sun, 28 Jan 2018 00:46:34 -0800 (PST)
In-Reply-To: <5f1c8ae2-f112-4ae4-60c1-ed3f57274d44@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Sage Weil <sage@newdream.net>, Alfredo Deza <adeza@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Jun 3, 2017 at 2:01 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>

Hi Willem,

Sorry to bump an old thread but I was wondering if you could test
something for me?

> I have a soluution that works for me.
>
> ceph-disk: add required py-module for tox-testing #15433
>
> It that is the way to follow, I do not know, because there are a zillion
> place to add a requirement. And I just think this is the one.
> Asuming that it also tells tox that prettytable is required durign
> regular running.
> But that is open for any better suggestions.

Would you mind testing replacing "sitepackages=True" with
"whitelist_externals = prettyprint".

When "sitepackages=True" on fc27 and you already have python2-pytest
and python2-coverage installed (as I currently do) the environment
tries to use the system packages and fails horribly.

>
> Once you add this, you atleast need to run "make tests" to rebuild the
> tox env.

You should be able to just...

$ rm ../src/ceph-disk/.tox -rf
$ ctest -R ceph-disk --output-on-failure

> --WjW

-- 
Cheers,
Brad
