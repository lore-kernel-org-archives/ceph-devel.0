From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: 0.94.8 QE validation - on-hold
Date: Tue, 16 Aug 2016 08:39:39 -0700
Message-ID: <CAMMFjmGc0sgP7Rv3569ds8M3tcVFGYOcqbimQMM4eELAF7+c3w@mail.gmail.com>
References: <CAMMFjmG7sa8zL7mSJzaLyivYv-j2GLx9rW-=XLT=Z8L_eG2hbQ@mail.gmail.com>
 <CAF-wwdGhNd9LpVp+8TJ4A+hwPkjowyRnec-yxtwfsBPG-wDnMg@mail.gmail.com>
 <20160816080138.GE5947@rskikr.localdomain> <82fc130c-c7ca-5ae2-3ccf-d41aeb207129@suse.cz>
 <CAMMFjmE-Oqg-a6MpK-9sA+V4yFPXeB+uT5LKK2L_uQr0hzQS_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36454 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbcHPPjp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2016 11:39:45 -0400
Received: by mail-wm0-f42.google.com with SMTP id q128so151464106wma.1
        for <ceph-devel@vger.kernel.org>; Tue, 16 Aug 2016 08:39:40 -0700 (PDT)
In-Reply-To: <CAMMFjmE-Oqg-a6MpK-9sA+V4yFPXeB+uT5LKK2L_uQr0hzQS_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Brad Hubbard <bhubbard@redhat.com>, "Weil, Sage" <sage@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>

Nathan

Should we backport https://github.com/ceph/teuthology/pull/933 to
hammer 0.94.8 ?

On Tue, Aug 16, 2016 at 8:07 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
> Thank you all.
>
> I will resume testing.
>
> On Tue, Aug 16, 2016 at 4:51 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>>> At this stage, after looking at this in great depth today we have decided
>>> this
>>> is a problem, most likely in libunwind, and should be able to be safely
>>> ignored. There are suppression files to be found for this issue, or very
>>> similar issues, such as
>>>
>>> https://github.com/hkimura/foedus_code/blob/master/foedus-core/tools/valgrind.supp
>>> and we already even have multiple valgrind suppressions for similar
>>> issues.
>>>
>>>
>>> https://github.com/ceph/teuthology/blob/master/teuthology/task/valgrind.supp#L38
>>>
>>> Thanks to Kefu for helping with this.
>>
>>
>> Thanks, guys. This showed up during integration testing and it was judged to
>> not be a blocker. We saw it on CentOS only.
>>
>> Nathan
