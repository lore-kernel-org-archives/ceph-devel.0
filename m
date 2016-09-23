From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 2/8] rbd: clean up asserts in rbd_img_obj_request_submit() helpers
Date: Fri, 23 Sep 2016 18:07:27 +0200
Message-ID: <CAOi1vP_xaykygG+ekZa9TKZ8iCNjh_GCZQWS69nKysBgmyqR2w@mail.gmail.com>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-3-git-send-email-idryomov@gmail.com> <a04e660b-ae90-78ba-63d8-c388ad29be8e@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34783 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030326AbcIWQHd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2016 12:07:33 -0400
Received: by mail-ua0-f195.google.com with SMTP id 51so1864926uac.1
        for <ceph-devel@vger.kernel.org>; Fri, 23 Sep 2016 09:07:28 -0700 (PDT)
In-Reply-To: <a04e660b-ae90-78ba-63d8-c388ad29be8e@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@linaro.org>

On Fri, Sep 23, 2016 at 5:57 PM, Alex Elder <elder@ieee.org> wrote:
> On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
>> Assert once in rbd_img_obj_request_submit().
>
> Generally I prefer validating things as early as possible.
>
> But I also value the simplicity of doing it all in one place.
> These are assertions, so the conditions checked should never
> really happen anyway.  And...  now that we're well past doing
> huge and rapid changes, the code is showing its maturity, so
> the number of assertions is kind of excessive anyway.

For the record, with this patch we now assert earlier than we were ;)
Also, it doesn't weaken any of the asserts - just moves them to central
location.

Thanks,

                Ilya
