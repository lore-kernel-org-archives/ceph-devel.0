From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: 0.94.8 QE validation status
Date: Tue, 23 Aug 2016 15:37:23 +0200
Message-ID: <CAOi1vP-jtkSeJSuMuSBMeg9bWtJycBcZyE7t1RhNOek0+z2h_A@mail.gmail.com>
References: <CAMMFjmFnSi68xJKh+WtpzHzoGu=w1QPnDjZefAuN-fSXtdWi7g@mail.gmail.com>
 <CA+aFP1AbTziD=e7pKdThChfq=4s3Y_F_9Fhb-vBt01A-d8YzNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:33454 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756739AbcHWNh5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 09:37:57 -0400
Received: by mail-ua0-f175.google.com with SMTP id 74so244622549uau.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 06:37:24 -0700 (PDT)
In-Reply-To: <CA+aFP1AbTziD=e7pKdThChfq=4s3Y_F_9Fhb-vBt01A-d8YzNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: "Weil, Sage" <sage@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Yuri Weinstein <yweinste@redhat.com>

On Tue, Aug 23, 2016 at 2:00 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> On Mon, Aug 22, 2016 at 5:04 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> krbd -  http://tracker.ceph.com/issues/17083 (Jason pls review/approve)
>
> Ilya, would you mind taking a look at this ticket?

Hmm, I can't tell what happened here.

It looks like stdout/stderr output is no longer streamed.  I've filed
http://tracker.ceph.com/issues/17102.

That said, xfstests failures are a known long-standing problem -
I guess I'll have to prioritize it after all.  Approved.

Thanks,

                Ilya
