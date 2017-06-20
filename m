From: Andrew Schoen <aschoen@redhat.com>
Subject: Re: Fwd: EXT: [ceph-users] ceph-lvm - a tool to deploy OSDs from LVM volumes
Date: Tue, 20 Jun 2017 09:43:02 -0500
Message-ID: <CAEPMp+41hTKanCsxJ7r-YA7k11QFQczGPXaiwmYptW9viFAEAQ@mail.gmail.com>
References: <A5E80C1D-74F4-455B-8257-5B9E2FF6AB39@walmart.com>
 <CAC-Np1yqCZO7CzEjTV+hrNve857BtM_rZ+LxAi6Vf9UJkPM04g@mail.gmail.com>
 <CALe9h7cV6U3A_OT9R8tv_yPoGG9zFaWF3qXV5cwYK0KM-NDu4g@mail.gmail.com>
 <CAC-Np1yiRgkmhZCOij9qSBmqUo-YYtErWXk2gevYuvWKrYFyeg@mail.gmail.com>
 <CALe9h7cT54esfoT=eOgZq=ZbYAp1pjH_CeLiz-kFO61jABasrA@mail.gmail.com>
 <CAC-Np1zwnzcwFBn4kqAzuhwmk9vZv1ZiUdd7owQZkA76k=QYuA@mail.gmail.com>
 <CALe9h7cxPioPHLw48Gj02bEkD-HC49yHT8kG62AyLm_V9KnOZQ@mail.gmail.com> <09d01c0c-b5f0-519e-0687-c8117e1fc2ce@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35386 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdFTOnn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jun 2017 10:43:43 -0400
Received: by mail-qt0-f180.google.com with SMTP id w1so134504781qtg.2
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 07:43:43 -0700 (PDT)
In-Reply-To: <09d01c0c-b5f0-519e-0687-c8117e1fc2ce@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jun 20, 2017 at 2:12 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> On 06/19/2017 10:24 PM, John Spray wrote:
>>
>> Testing: being separate is only easier if you're only doing python
>> unit testing.
>
>
> Hear hear! I do a lot of functional/integration/regression testing and can
> confirm that it became a whole lot easier when ceph-qa-suite was moved
> in-tree.

Comparing ceph-qa-suite to a contained python module isn't quite a
fair comparison though. For upstream testing of ceph-volume (if it
existed outside ceph.git) you'd simply install it with pip. A jenkins
job that built every branch of ceph-volume.git and pushed them to
shaman would be easy enough as well if that's what's preferred.

Honestly, I think all manner of testing (including functional) becomes
easier with this out of ceph.git. Especially when it comes to testing
something inside of a container.

Best,
Andrew
