From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/8] rbd: clean up asserts in rbd_img_obj_request_submit()
 helpers
Date: Fri, 23 Sep 2016 11:41:03 -0500
Message-ID: <bb6592bd-bbef-4a4c-42ad-7932997c5a97@ieee.org>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-3-git-send-email-idryomov@gmail.com>
 <a04e660b-ae90-78ba-63d8-c388ad29be8e@ieee.org>
 <CAOi1vP_xaykygG+ekZa9TKZ8iCNjh_GCZQWS69nKysBgmyqR2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:38279 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757951AbcIWQlF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2016 12:41:05 -0400
Received: by mail-it0-f48.google.com with SMTP id n143so20712709ita.1
        for <ceph-devel@vger.kernel.org>; Fri, 23 Sep 2016 09:41:05 -0700 (PDT)
In-Reply-To: <CAOi1vP_xaykygG+ekZa9TKZ8iCNjh_GCZQWS69nKysBgmyqR2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@linaro.org>

On 09/23/2016 11:07 AM, Ilya Dryomov wrote:
>> > Generally I prefer validating things as early as possible.
>> >
>> > But I also value the simplicity of doing it all in one place.
>> > These are assertions, so the conditions checked should never
>> > really happen anyway.  And...  now that we're well past doing
>> > huge and rapid changes, the code is showing its maturity, so
>> > the number of assertions is kind of excessive anyway.
> For the record, with this patch we now assert earlier than we were ;)
> Also, it doesn't weaken any of the asserts - just moves them to central
> location.

Yes, you're right, it's even better than I thought.	-Alex

