From: kefu chai <tchaikov@gmail.com>
Subject: Re: needs-backport label on github/ceph/ceph
Date: Wed, 23 Aug 2017 11:35:17 +0800
Message-ID: <CAJE9aOM=312hvBs9LjZXSBj9YgwaYbZ3F+RWoQTbFrpTGTm97Q@mail.gmail.com>
References: <CAJE9aONVUvVCuKEdrLxNf8Z1YEard8ZoT9wy+tdzgCn9UTQb-Q@mail.gmail.com>
 <CALe9h7cvEeD27eyL8rMTsbfwzXvX20RebMSDkBm+=F0kKzVBMA@mail.gmail.com> <7f97669a-f05d-328b-a854-25f749742ccb@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35910 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbdHWDfS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Aug 2017 23:35:18 -0400
Received: by mail-oi0-f47.google.com with SMTP id g131so5444471oic.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Aug 2017 20:35:18 -0700 (PDT)
In-Reply-To: <7f97669a-f05d-328b-a854-25f749742ccb@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 23, 2017 at 12:00 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> On 08/22/2017 05:12 PM, John Spray wrote:
>>
>> On Tue, Aug 22, 2017 at 4:09 PM, kefu chai <tchaikov@gmail.com> wrote:
>>>
>>> i noticed that we have a new label named "needs-backport" [0]? could
>>> you shed some light on how we are supposed to use it? i thought we
>>> were going to cherry-pick all PRs with this label merged after the
>>> luminous was forked. but seems we are still marking PRs should be
>>> included by luminous with the "luminous" milestone. so i have no clues
>>> now =(
>>
>>
>> I'm curious too -- I believe the authoriative way to mark something
>> for backport is in a tracker ticket, so a separate label probably
>> isn't needed?
>
>
> Maybe it was added to accommodate/facilitate a "fast-track" backporting
> process for the early stages of the luminous release cycle?
>
> ISTR that jewel v10.2.1 went very quickly and some of the backports did not
> "cross all the t's and dot all the i's" wrt the sanctioned backporting
> process. Maybe something like that is a possibility for luminous as well? (I
> would welcome it.)
>
> It could work like this: if a PR is marked "needs-backport", the developer
> who merges the PR would be responsible for ensuring that the commits are
> cherry-picked to luminous and marking the tracker, if any, "Resolved" with a
> note that the backport is already done.

thank you, Nathan! that makes sense.

-- 
Regards
Kefu Chai
