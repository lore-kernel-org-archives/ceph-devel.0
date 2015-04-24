From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 0/3] rbd: header read/refresh improvements
Date: Fri, 24 Apr 2015 17:17:08 +0300
Message-ID: <CAOi1vP85mJS3_e1PS-2zNzT3BDVmwV75qquo_sRiUrK2Whw5kQ@mail.gmail.com>
References: <cover.1429814290.git.dfuller@redhat.com>
	<553A411A.8060902@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33382 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbbDXORJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Apr 2015 10:17:09 -0400
Received: by wgin8 with SMTP id n8so52276811wgi.0
        for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2015 07:17:08 -0700 (PDT)
In-Reply-To: <553A411A.8060902@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Douglas Fuller <dfuller@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Apr 24, 2015 at 4:11 PM, Alex Elder <elder@ieee.org> wrote:
> On 04/23/2015 02:06 PM, Douglas Fuller wrote:
>>
>> Support multiple class op calls in one ceph_msg and consolidate rbd header
>> read and refresh processes to use this feature to reduce the number of
>> ceph_msgs sent for that process. Refresh features on header refresh and
>> begin returning EIO if features have changed since mapping.
>>
>> Douglas Fuller (3):
>>    ceph: support multiple class method calls in one ceph_msg
>>    rbd: combine object method calls in header refresh using fewer
>>      ceph_msgs
>>    rbd: re-read features during header refresh and detect changes.
>>
>>   drivers/block/rbd.c             | 518
>> +++++++++++++++++++++++++++++-----------
>>   include/linux/ceph/osd_client.h |   3 +-
>>   net/ceph/messenger.c            |   4 +
>>   net/ceph/osd_client.c           |  92 ++++++-
>>   4 files changed, 470 insertions(+), 147 deletions(-)
>>
>
> In case Ilya or others don't get to it soon, I plan to review this
> series tomorrow.

I was planning take a look while I'm the road during the weekend.

Doug, from a quick look this revision still has a bunch of style
issues, most notably the alignment of function parameters and braces
around if / else.  See Documentation/CodingStyle in the kernel tree for
examples.

You might also want to run your patches through scripts/checkpatch.pl,
but take it with a grain of salt - it can be a bit too extreme at
times.  No need to post v3 with just style fixes, wait for more feedback.

Thanks,

                Ilya
