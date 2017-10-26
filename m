From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: 12.2.2 status
Date: Thu, 26 Oct 2017 11:05:22 -0700
Message-ID: <CA+2bHPYXuma-e-4_XAdLp6rxcT7NBYL+xF4Rz0PAvptLoXvQdw@mail.gmail.com>
References: <87fua6c4xy.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:52867 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932331AbdJZSFx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 14:05:53 -0400
Received: by mail-qt0-f175.google.com with SMTP id 31so5406235qtz.9
        for <ceph-devel@vger.kernel.org>; Thu, 26 Oct 2017 11:05:53 -0700 (PDT)
In-Reply-To: <87fua6c4xy.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>

On Thu, Oct 26, 2017 at 8:19 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
> Also for the leads, Sage, Yehuda. Jason, Josh, Patrick are there any
> critical PRs that we need to have in 12.2.2 so that we can include
> them in the next round of testing before handing over to QE?

Please include:

https://github.com/ceph/ceph/pull/18019
https://github.com/ceph/ceph/pull/18008

Thanks,

-- 
Patrick Donnelly
