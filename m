From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: 12.2.2 status
Date: Thu, 26 Oct 2017 09:50:09 -0700
Message-ID: <CADRKj5RuqjfQQoK+ri+WLqh07O9snWvsKSfr+83GmmRtBYiBHw@mail.gmail.com>
References: <87fua6c4xy.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:51677 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbdJZQuK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 12:50:10 -0400
Received: by mail-oi0-f51.google.com with SMTP id j126so6712115oib.8
        for <ceph-devel@vger.kernel.org>; Thu, 26 Oct 2017 09:50:10 -0700 (PDT)
In-Reply-To: <87fua6c4xy.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Matt Benjamin <mbenjamin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>

On Thu, Oct 26, 2017 at 8:19 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>
> A first round of PRs were tested on Luminous integration branch, results
> updated at http://tracker.ceph.com/issues/21830,
> RADOS suite was green, RBD, RGW & FS hit some known failures
>
> ceph-disk has hit a failure with dmcrypt, details at
> http://tracker.ceph.com/issues/21830#note-10 which doesn't seem to have
> occured in QE runs before but there is a bug report, is anyone aware of
> past issues with ceph-disk & dmcrypt?
>
> Also for the leads, Sage, Yehuda. Jason, Josh, Patrick are there any
> critical PRs that we need to have in 12.2.2 so that we can include
> them in the next round of testing before handing over to QE?
>

I'd be happy to see these fixed:
http://tracker.ceph.com/issues/21819
http://tracker.ceph.com/issues/21735

however, these are not in master yet, need validation.

This one is ready I think:
http://tracker.ceph.com/issues/21500

> Best,
> Abhishek & Karol
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
