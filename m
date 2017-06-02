From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Missing prettytable during ceph-disk runs
Date: Fri, 2 Jun 2017 10:36:37 -0400
Message-ID: <CAC-Np1y1hBFVnor9OhMxmj+xXZO5cnHvcQz6wAbjJ-7xhLhPBw@mail.gmail.com>
References: <92db6d6a-420d-3f89-9631-8376b5d7d6a2@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35332 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdFBOgj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jun 2017 10:36:39 -0400
Received: by mail-wm0-f50.google.com with SMTP id b84so27334712wmh.0
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jun 2017 07:36:39 -0700 (PDT)
In-Reply-To: <92db6d6a-420d-3f89-9631-8376b5d7d6a2@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jun 2, 2017 at 6:42 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> During run-tox tests, ceph-disk complains that it is missing prettytable.
> It is however installed on my system, and I can load it. So that part
> works. But one way or another it is not loaded into the tox environment.
>
> How or what are all other dependancies loaded?
> Is there a config file where I need to add that this test needs prettytable?

I am not sure what tox file you are running, but tox will create a
virtual environment where it installs dependencies
for the project you are testing. These dependencies should be defined
by the project, the tox file, or by configuring tox to
use dependencies installed system-wide.

For example, in ceph-installer, we tell tox to install a dependency
that is only needed for tests like this:

https://github.com/ceph/ceph-installer/blob/master/tox.ini#L5-L6

I think that prettytable is a Python dependency so you can go ahead
and add it there and it should work.

This also sounds like a bug :)
>
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
