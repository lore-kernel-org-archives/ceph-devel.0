From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] rbd: use writefull op for object size writes
Date: Wed, 7 Oct 2015 18:13:22 +0200
Message-ID: <CAOi1vP9XVRWm26=DiWTiymJ3Vmvd226PM5Nk6jNmLr=EMbAr2g@mail.gmail.com>
References: <1444237333-9677-1-git-send-email-idryomov@gmail.com>
	<56153BF3.5050403@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38479 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbbJGQNZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Oct 2015 12:13:25 -0400
Received: by wiclk2 with SMTP id lk2so36201479wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 07 Oct 2015 09:13:22 -0700 (PDT)
In-Reply-To: <56153BF3.5050403@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Oct 7, 2015 at 5:36 PM, Alex Elder <elder@ieee.org> wrote:
> On 10/07/2015 12:02 PM, Ilya Dryomov wrote:
>> This covers only the simplest case - an object size sized write, but
>> it's still useful in tiering setups when EC is used for the base tier
>> as writefull op can be proxied, saving an object promotion.
>>
>> Even though updating ceph_osdc_new_request() to allow writefull should
>> just be a matter of fixing an assert, I didn't do it because its only
>> user is cephfs.  All other sites were updated.
>>
>> Reflects ceph.git commit 7bfb7f9025a8ee0d2305f49bf0336d2424da5b5b.
>
> I haven't looked at this at all.  But can you give me a
> short explanation of what "writefull" is?
>
> Full object write?

Well, in a way.  It replaces previous data, you can think of it as an
atomic truncate to 0 + write from offset 0.  So it always writes
(replaces) entire objects.

Thanks,

                Ilya
