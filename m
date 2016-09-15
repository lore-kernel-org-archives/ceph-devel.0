From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 0/2] rbd_img_obj_exists_submit() fixes
Date: Thu, 15 Sep 2016 07:25:00 -0500
Message-ID: <2d75d29b-5110-60b3-b6f8-8923a832fa8b@linaro.org>
References: <1472741959-1786-1-git-send-email-ddiss@suse.de>
 <20160915124805.20590455@echidna.suse.de>
 <CAOi1vP-XqpYFVsS26w_gm+vJygmiS848TjXEv79V80Ytjzdpig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:35032 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754450AbcIOMZh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2016 08:25:37 -0400
Received: by mail-it0-f47.google.com with SMTP id r192so91761234ita.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2016 05:25:03 -0700 (PDT)
In-Reply-To: <CAOi1vP-XqpYFVsS26w_gm+vJygmiS848TjXEv79V80Ytjzdpig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, David Disseldorp <ddiss@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 09/15/2016 06:53 AM, Ilya Dryomov wrote:
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

Yeah, it has been my intention to look at these, sorry I
haven't gotten to it yet.  I'll try to look today.  I can
comment on yours even knowing Ilya plans to send out a
different version.

					-Alex

> 
> For the invalid union field use issue, I think we can just skip calling
> rbd_osd_req_format_read() for !img_data requests, but I need to double
> check.
> 
> I'll put together a branch my version of these fixes and ping you.
> 
> Thanks,
> 
>                 Ilya
> 

