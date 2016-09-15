From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 0/2] rbd_img_obj_exists_submit() fixes
Date: Thu, 15 Sep 2016 13:53:59 +0200
Message-ID: <CAOi1vP-XqpYFVsS26w_gm+vJygmiS848TjXEv79V80Ytjzdpig@mail.gmail.com>
References: <1472741959-1786-1-git-send-email-ddiss@suse.de> <20160915124805.20590455@echidna.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35829 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbcIOLyA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2016 07:54:00 -0400
Received: by mail-vk0-f53.google.com with SMTP id h134so22057213vkd.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2016 04:54:00 -0700 (PDT)
In-Reply-To: <20160915124805.20590455@echidna.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@linaro.org>

On Thu, Sep 15, 2016 at 12:48 PM, David Disseldorp <ddiss@suse.de> wrote:
> On Thu,  1 Sep 2016 16:59:17 +0200, David Disseldorp wrote:
>
>> Hi,
>>
>> This patchset fixes a couple of bugs in the rbd_img_obj_exists_submit()
>> code-path which appear to have been there since the function was first
>> added.
>>
>> Feedback appreciated.
>
> Did anyone get a chance to look at these changes?

Hi David,

I was waiting for Alex to take a look, but then realized that there is
more to fix: img_request is also getting leaked and we can ignore
ceph_osdc_start_request return value, simplifying things.

For the invalid union field use issue, I think we can just skip calling
rbd_osd_req_format_read() for !img_data requests, but I need to double
check.

I'll put together a branch my version of these fixes and ping you.

Thanks,

                Ilya
