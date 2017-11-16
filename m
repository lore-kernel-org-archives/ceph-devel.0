From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: 12.2.2 Luminous validation status
Date: Thu, 16 Nov 2017 14:06:05 -0800
Message-ID: <CAMMFjmG_6UrMOEWmanz76GyGsJioFLt-ZAYRaYzQJ72LH2pRqA@mail.gmail.com>
References: <CAMMFjmH0-XbJ1P431bErnMS1BEaU3Ln9XhVMPbEte3ixm+YSzQ@mail.gmail.com>
 <9162c114-44ea-3153-fc3f-76fbd20e06b4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35361 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964784AbdKPWGG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Nov 2017 17:06:06 -0500
Received: by mail-oi0-f47.google.com with SMTP id e142so387957oih.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Nov 2017 14:06:06 -0800 (PST)
In-Reply-To: <9162c114-44ea-3153-fc3f-76fbd20e06b4@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Josh's fixed merged and tested, so rados is good.

Ilya's kernel fix helped sort out knfs and kcepfs failures, however
some jobs still failed (see details/bugs in the ticket) and need
Patrick, Ilya review.

Please review the tests results and either approve or comment.

Thx
YuriW

On Wed, Nov 15, 2017 at 6:07 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 11/15/2017 02:00 PM, Yuri Weinstein wrote:
>>
>> Details of this release summarized here
>> http://tracker.ceph.com/issues/21830#note-26
>
>
> The rados failures are due to a bug in the test fixed by:
>
> https://github.com/ceph/ceph/pull/18808
>
