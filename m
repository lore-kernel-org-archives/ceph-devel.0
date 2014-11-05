From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 0/3] __remove_osd() vs lingering requests
Date: Wed, 5 Nov 2014 22:42:10 +0400
Message-ID: <CALFYKtBkkoBtY2d+NhaTbbqonyam0aeG-kHEWrVJ7vU3472ZQQ@mail.gmail.com>
References: <1415208804-10163-1-git-send-email-idryomov@redhat.com>
	<545A6342.4000404@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:62870 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbaKESmL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 13:42:11 -0500
Received: by mail-qa0-f52.google.com with SMTP id u7so916975qaz.25
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 10:42:10 -0800 (PST)
In-Reply-To: <545A6342.4000404@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Nov 5, 2014 at 8:49 PM, Alex Elder <elder@ieee.org> wrote:
> On 11/05/2014 11:33 AM, Ilya Dryomov wrote:
>> Hello,
>>
>> These are fixes for the problem I found while trying to reproduce
>> recently reopened http://tracker.ceph.com/issues/5429.  I'm pretty sure
>> this is what was reported in http://tracker.ceph.com/issues/8568 too.
>> The exact BUG_ON() it points to is no longer there, but I checked with
>> an older kernel and the reproducer I have for this triggered it.
>>
>> Thanks,
>>
>>                 Ilya
>
> All three of these look good to me.  The interactions with
> these lists has always been a bit too tricky; you've done a
> lot to make sense of them.
>
> And I'm sure there are other BUG_ON() (or rbd_assert()) calls
> that can be tamed--either removed, changed to warnings, or
> changed to simply return errors where possible.
>
> Reviewed-by: Alex Elder <elder@linaro.org>

Thanks for the review, Alex!

                Ilya
