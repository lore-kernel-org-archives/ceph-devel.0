From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: "Unix Domain socket path too long" failures in Jenkins make check
Date: Mon, 3 Jul 2017 12:35:54 -0700
Message-ID: <CA+2bHPb4Z4naH-uBf_AFdkUMse78cWEv+oVY9QQQJYZuvBFjYw@mail.gmail.com>
References: <bf9dcc9d-3c9e-03a5-1be2-f601bed3a18c@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36269 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbdGCTgZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jul 2017 15:36:25 -0400
Received: by mail-qt0-f169.google.com with SMTP id i2so150816602qta.3
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jul 2017 12:36:25 -0700 (PDT)
In-Reply-To: <bf9dcc9d-3c9e-03a5-1be2-f601bed3a18c@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jun 30, 2017 at 2:08 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Ceph!
>
> Now that 10.2.8 is finally in QE, I had planned to turn my attention to
> kraken 11.2.1. The first task is to get the backport PRs through "make
> check". This is proving more difficult than usual because most of the time
> the make check test fails due to the "Unix Domain socket path too long"
> error. This happens in jewel PRs, too, but the incidence in kraken PRs seems
> much higher.
>
> Does the CI team have statistics on how many make check jobs are failing due
> to this bug?
>
> Also, is my understanding correct that there is no way to get Jenkins to
> shorten the path?

I have a PR to fix short path restrictions on admin sockets once and for all:

https://github.com/ceph/ceph/pull/16087

-- 
Patrick Donnelly
