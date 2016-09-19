From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 0/2] rbd_img_obj_exists_submit() fixes
Date: Mon, 19 Sep 2016 19:06:45 +0200
Message-ID: <CAOi1vP9G4zxaoNo-yyD8fEgM7RxLmMds4AeoPqtS3dwoMPV2sw@mail.gmail.com>
References: <1472741959-1786-1-git-send-email-ddiss@suse.de>
 <20160915124805.20590455@echidna.suse.de> <CAOi1vP-XqpYFVsS26w_gm+vJygmiS848TjXEv79V80Ytjzdpig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33204 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbcISRGr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 13:06:47 -0400
Received: by mail-vk0-f41.google.com with SMTP id u196so458209vkd.0
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 10:06:46 -0700 (PDT)
In-Reply-To: <CAOi1vP-XqpYFVsS26w_gm+vJygmiS848TjXEv79V80Ytjzdpig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@linaro.org>

On Thu, Sep 15, 2016 at 1:53 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Thu, Sep 15, 2016 at 12:48 PM, David Disseldorp <ddiss@suse.de> wrote:
>> On Thu,  1 Sep 2016 16:59:17 +0200, David Disseldorp wrote:
>>
>>> Hi,
>>>
>>> This patchset fixes a couple of bugs in the rbd_img_obj_exists_submit()
>>> code-path which appear to have been there since the function was first
>>> added.
>>>
>>> Feedback appreciated.
>>
>> Did anyone get a chance to look at these changes?
>
> Hi David,
>
> I was waiting for Alex to take a look, but then realized that there is
> more to fix: img_request is also getting leaked and we can ignore
> ceph_osdc_start_request return value, simplifying things.
>
> For the invalid union field use issue, I think we can just skip calling
> rbd_osd_req_format_read() for !img_data requests, but I need to double
> check.
>
> I'll put together a branch my version of these fixes and ping you.

Hi David,

I've pushed to testing @ ceph-client.git and posted to the list.
See patches 6 and 7.

Thanks,

                Ilya
