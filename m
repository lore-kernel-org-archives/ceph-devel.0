From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Status of luminous v12.2.1 QE validation
Date: Tue, 19 Sep 2017 13:35:28 -0700
Message-ID: <CAMMFjmE=yH7MyztEHKV1wNbtC4Xx4qs5RDk9gPKMom2VBDS_Tw@mail.gmail.com>
References: <CAMMFjmF5OczC9Yg1F2S3EvPAZO4ZBefpuxNm-f70XG-dr6-31g@mail.gmail.com>
 <fdf4aac4-d207-9a1f-bf3b-0e1579277759@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:45560 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdISUf3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Sep 2017 16:35:29 -0400
Received: by mail-io0-f182.google.com with SMTP id g32so2031416ioj.2
        for <ceph-devel@vger.kernel.org>; Tue, 19 Sep 2017 13:35:29 -0700 (PDT)
In-Reply-To: <fdf4aac4-d207-9a1f-bf3b-0e1579277759@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>, "Durgin, Josh" <jdurgin@redhat.com>, Zheng Yan <zyan@redhat.com>, Vasu Kulkarni <vakulkar@redhat.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Ilya Dryomov <idryomov@redhat.com>

Sure does, thx Nathan :)

On Tue, Sep 19, 2017 at 1:19 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Yuri:
>
>> RHEL 7.4 related PRs need to backported:
>> https://github.com/ceph/ceph/pull/17776
>
>
> Luminous backport PR is open: https://github.com/ceph/ceph/pull/17779
>
>> https://github.com/ceph/ceph/pull/17796
>
>
> The PR you mentioned (17796) is the luminous backport PR for
> https://github.com/ceph/ceph/pull/17795 (the latter will presumably be
> merged into master in short order).
>
>> https://github.com/ceph/ceph/pull/17777
>
>
> Luminous backport PR is open: https://github.com/ceph/ceph/pull/17816
>
> Hope this helps.
>
> Nathan
