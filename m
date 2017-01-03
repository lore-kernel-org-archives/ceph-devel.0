From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: ceph-ci.git and pull requests
Date: Tue, 3 Jan 2017 12:00:07 -0700
Message-ID: <CALqRxCznKbjq8x38NGO3=HQCR17a59iXvcq8HPvprNAJ_XyxHw@mail.gmail.com>
References: <7ca73dab-23d4-6725-79d4-c3bac274dc3b@redhat.com> <CAN=+7FX9jb712_ddmx4GgPKQW47R-QhB4fqfZ6gmCWuU-EiW2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:33601 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760564AbdACTAn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 14:00:43 -0500
Received: by mail-ua0-f177.google.com with SMTP id i68so226334537uad.0
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 11:00:08 -0800 (PST)
In-Reply-To: <CAN=+7FX9jb712_ddmx4GgPKQW47R-QhB4fqfZ6gmCWuU-EiW2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Casey Bodley <cbodley@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Right, I don't think GitHub allows an "upstream" repo and a "fork"
repo to exist within the same org (github.com/ceph). I do the same
thing Sam suggests.

- Ken

On Tue, Jan 3, 2017 at 10:40 AM, Samuel Just <sjust@redhat.com> wrote:
> Hmm, I always push branches like that to my own github account
> ceph.git as well and do the PR from there.
> -Sam
>
> On Tue, Jan 3, 2017 at 9:23 AM, Casey Bodley <cbodley@redhat.com> wrote:
>> Hi,
>>
>> I had pushed a branch to ceph/ceph-ci.git for testing, but was unable to
>> open a pull request for it against ceph/ceph.git. The github ui wouldn't let
>> me target branches in ceph-ci.git, presumably because it doesn't recognize
>> it as a fork if ceph.git.
>>
>> Has anyone else been able to figure this out?
>>
>> Thanks,
>> Casey
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
