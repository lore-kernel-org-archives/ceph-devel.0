From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Luminous v12.2.3 approvals
Date: Wed, 7 Feb 2018 14:57:32 -0800
Message-ID: <CAMMFjmG2GGqy-K4dowBtcGETOGoWUZfuC_91U0C8FvrE+Azurg@mail.gmail.com>
References: <87vafa2frf.fsf@suse.com> <CA+2bHPbrdPrmFqbg_c_tUO-arf7fa91bpDCxtnw7y7D72CAMtA@mail.gmail.com>
 <CAMMFjmFAggpL+7XpOjSCJGzpzDo9KbADh_C8=emMVOEjTceMFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pl0-f50.google.com ([209.85.160.50]:42734 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeBGW5d (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Feb 2018 17:57:33 -0500
Received: by mail-pl0-f50.google.com with SMTP id 11-v6so977482plc.9
        for <ceph-devel@vger.kernel.org>; Wed, 07 Feb 2018 14:57:33 -0800 (PST)
In-Reply-To: <CAMMFjmFAggpL+7XpOjSCJGzpzDo9KbADh_C8=emMVOEjTceMFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, John Spray <jspray@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Sage Weil <sage@redhat.com>

OK I see no PRs in the queue left =>
https://github.com/ceph/ceph/labels/luminous-batch-1
(https://github.com/ceph/ceph/pull/20338 is waiting for approval/merge
by Yehuda)

Abhishek, waiting for dev leads final approval and confirmation that
no PRs left and "go ahead" from you to start formal QE validation.

Thx
YuriW

On Tue, Feb 6, 2018 at 12:31 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Patrick
>
> Ack testing those
>
> On Tue, Feb 6, 2018 at 10:10 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
>> On Tue, Feb 6, 2018 at 9:24 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>>> These are the current list of PRs currently undergoing/waiting QE for Luminous v12.2.3
>>> https://github.com/ceph/ceph/labels/luminous-batch-1
>>>
>>> Assuming teuthology is happy with these, leads, are we ready to cut
>>> 12.2.3 or are there more PRs that we need to wait for?
>>
>> For CephFS:
>>
>> https://github.com/ceph/ceph/pull/20339
>> https://github.com/ceph/ceph/pull/20340
>> https://github.com/ceph/ceph/pull/20341
>> https://github.com/ceph/ceph/pull/20342
>> https://github.com/ceph/ceph/pull/20300
>> https://github.com/ceph/ceph/pull/20249
>> https://github.com/ceph/ceph/pull/20256
>> https://github.com/ceph/ceph/pull/20299
>>
>> --
>> Patrick Donnelly
