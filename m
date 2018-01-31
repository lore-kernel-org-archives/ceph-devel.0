From: Alfredo Deza <adeza@redhat.com>
Subject: Better anticipation for minor releases
Date: Wed, 31 Jan 2018 12:46:40 -0500
Message-ID: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33533 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbeAaRql (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jan 2018 12:46:41 -0500
Received: by mail-qk0-f181.google.com with SMTP id i141so15812358qke.0
        for <ceph-devel@vger.kernel.org>; Wed, 31 Jan 2018 09:46:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Abhishek,

For almost every minor release we have, there is a cloud of
uncertainty where nobody really knows when the release will be cut.

Most of the time there is an email (or series of emails) that trigger
the conversation of "are we now ready to cut a release?", where leads
respond what backports are still pending, or if there are test suites
that aren't really in the clear.

For minor releases a mix of a time-based schedule with a set of each
lead's group of passing tests, would be a nice way to predict when we
can start having the conversation of cutting a release.

It isn't a one-shot fix, but would certainly improve everyone who
wants/needs a new release and can't get any clues as to what that may
be.

Something like:

* Minor releases every 6 weeks
* subset of test suites passing from each lead

Would be a good way to start. If we can get that initial release path,
it would be possible to start thinking about what "gating" really
means for our releases (since we don't really have any sort of gating
today)

What do you think?
