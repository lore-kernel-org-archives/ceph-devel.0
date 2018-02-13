From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Building dashboard_v2
Date: Tue, 13 Feb 2018 13:35:34 -0700
Message-ID: <CALqRxCy37KJeaFn5Zq-vYByKonPXOFZ_ETGoaYo2fGH8GZiCKg@mail.gmail.com>
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:46202 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965858AbeBMUfg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 15:35:36 -0500
Received: by mail-vk0-f47.google.com with SMTP id e125so11590709vkh.13
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 12:35:35 -0800 (PST)
In-Reply-To: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 13, 2018 at 8:29 AM, John Spray <jspray@redhat.com> wrote:
> Not sure if
> there is a sufficiently trusted third party Ubuntu repo to add to
> install_deps.sh.

Instead of adding another repository dependency, we could not build
the dashboard on Xenial, and target Ubuntu >= 18.04 for that.

https://packages.ubuntu.com/bionic/nodejs

- Ken
