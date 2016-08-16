From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: 0.94.8 QE validation - on-hold
Date: Tue, 16 Aug 2016 18:01:38 +1000
Message-ID: <20160816080138.GE5947@rskikr.localdomain>
References: <CAMMFjmG7sa8zL7mSJzaLyivYv-j2GLx9rW-=XLT=Z8L_eG2hbQ@mail.gmail.com>
 <CAF-wwdGhNd9LpVp+8TJ4A+hwPkjowyRnec-yxtwfsBPG-wDnMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32921 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbcHPIBr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2016 04:01:47 -0400
Received: by mail-pa0-f48.google.com with SMTP id ti13so24179924pac.0
        for <ceph-devel@vger.kernel.org>; Tue, 16 Aug 2016 01:01:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF-wwdGhNd9LpVp+8TJ4A+hwPkjowyRnec-yxtwfsBPG-wDnMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, "Weil, Sage" <sage@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>



On Tue, Aug 16, 2016 at 12:54 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
> On Tue, Aug 16, 2016 at 9:19 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Nathan,
>>
>> Based on a small subset of suites ran so far, one issue seems persisting -
>>
>> http://tracker.ceph.com/issues/17035
>> "saw valgrind issues" in hammer 0.94.8 release
>
> Pretty sure this is http://tracker.ceph.com/issues/15117
>
>>
>> I need your assessment if we need to fix this issue before continuing
>> QE validation of this point release.
>>
>> Holding on further validations till we make this decision.

At this stage, after looking at this in great depth today we have decided this
is a problem, most likely in libunwind, and should be able to be safely
ignored. There are suppression files to be found for this issue, or very
similar issues, such as
https://github.com/hkimura/foedus_code/blob/master/foedus-core/tools/valgrind.supp
and we already even have multiple valgrind suppressions for similar issues.

https://github.com/ceph/teuthology/blob/master/teuthology/task/valgrind.supp#L38

Thanks to Kefu for helping with this.

-- 
Cheers,
Brad
