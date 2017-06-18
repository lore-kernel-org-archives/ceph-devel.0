From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Pecan dependency
Date: Mon, 19 Jun 2017 09:00:59 +1000
Message-ID: <CAF-wwdGKxgSu-1h4ndnuRyn1qLRd-FFriWGOY-XcgBnF+3cG2Q@mail.gmail.com>
References: <CAF-wwdGBn4i=-jD7qKJAhmCL8_fEXiMNgc+z=9+4gj2FwA7RFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34826 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbdFRXBB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Jun 2017 19:01:01 -0400
Received: by mail-io0-f178.google.com with SMTP id k93so54192214ioi.2
        for <ceph-devel@vger.kernel.org>; Sun, 18 Jun 2017 16:01:00 -0700 (PDT)
In-Reply-To: <CAF-wwdGBn4i=-jD7qKJAhmCL8_fEXiMNgc+z=9+4gj2FwA7RFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Please ignore this, we already install this as a dependency via
install-deps.sh, I was misreading the situation I'm afraid :)

So I'm not sure any action is required at this stage.

On Mon, Jun 19, 2017 at 8:37 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> http://tracker.ceph.com/issues/20322 is caused by an unsatisfied pecan
> dependency for the MGR restful module. Given the error message is rather cryptic
> and not immediately relatable to a missing pecan module we should address this
> in some way, shape, or fashion.
>
> Willem reported this issue here,
> https://www.spinics.net/lists/ceph-devel/msg37057.html and submitted a PR which
> resolves the issue for FreeBSD by installing pecan with pip.
>
> There are several approaches we could take, most of which provided by John Spray
> in the tracker.
>
> 1. Make pecan a required dependency for ceph.
>
> 2. Test for the availability of the module in vstart and warn if it is not
> available and/or disable the restful module parts.
>
> 3. Make the restful parts configurable within vstart and *disable* them by
> default.
>
> Which way would we like to jump?
>
> --
> Cheers,
> Brad



-- 
Cheers,
Brad
