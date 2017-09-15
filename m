From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: Status of luminous v12.2.1 integration branch
Date: Fri, 15 Sep 2017 23:26:12 +0200
Message-ID: <CAEw75dMVtBnXy9wJAWV+HPCkOYHKXcZOz-wNx+pTW5jwonJKCw@mail.gmail.com>
References: <20890cf9-8e88-45b3-97d2-e6ad5d2ce583@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:44762 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdIOV0N (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 17:26:13 -0400
Received: by mail-it0-f48.google.com with SMTP id r131so2316894itc.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 14:26:13 -0700 (PDT)
In-Reply-To: <20890cf9-8e88-45b3-97d2-e6ad5d2ce583@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>, "Durgin, Josh" <jdurgin@redhat.com>

Yuri,
Sage also acked on IRC, lets start the QE round for 12.2.1 at the
current luminous branch

(sha1 ddf84249fa8a8ec3655c39bac5331ab81c0307b1)

Best,
Abhishek


On Fri, Sep 15, 2017 at 11:17 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> Good to go for rados!
>
>
> Sent from Nine
> ________________________________
> From: Abhishek L <abhishek.lekshmanan@gmail.com>
> Sent: Sep 15, 2017 1:50 PM
> To: Patrick Donnelly
> Cc: Abhishek Lekshmanan; Yuri Weinstein; Development, Ceph; Weil, Sage;
> Durgin, Josh; Sadeh-Weinraub, Yehuda; John Spray; gmeno@redhat.com
> Subject: Re: Status of luminous v12.2.1 integration branch
>
> Merged all the pending PRs that went through the run yesterday,
>
> Josh, Sage, Patrick, Yehuda are we good to go for the final QE?
>
> (We already had Jason's  approval, and #17764 & #17484 as Orit
> requested were already merged for RGW)
>
> On Fri, Sep 15, 2017 at 8:02 PM, Patrick Donnelly <pdonnell@redhat.com>
> wrote:
>> On Fri, Sep 15, 2017 at 1:54 AM, Abhishek Lekshmanan <abhishek@suse.com>
>> wrote:
>>> So had failures in many jobs of all the 3 suites due to an ansible
>>> failure, the fs suite, however, has a few failures in this test
>>> (tasks.cephfs.test_misc.TestMisc), is anyone aware of prior failures of
>>> this suite, can be seen in this run for eg.
>>>
>>>
>>> http://pulpito.ceph.com/abhi-2017-09-14_11:23:49-fs-wip-luminous-2017-09-14-distro-basic-smithi/1632469/
>>
>> That fs failure is known and can be ignored:
>> http://tracker.ceph.com/issues/21381
>>
>> --
>> Patrick Donnelly
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
