From: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Subject: Re: Can I limit buffering for each object in radosgw?
Date: Thu, 20 Nov 2014 23:56:46 +0300
Message-ID: <CAMWPydQLbjE6HFcyLw24D_fmE89YebCRMCGkUYANAKfyRuDhjg@mail.gmail.com>
References: <CAMWPydROJKB-HvATJmbB28L6QM9kXpYeRf5+myyX8AJ3OiaUSg@mail.gmail.com>
	<CABBk=J-zgjxRAy_fd9Be_j_FvTPtZ8nUc20eV3e3UcgVb3fo9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:58318 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756884AbaKTU4s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Nov 2014 15:56:48 -0500
Received: by mail-wg0-f49.google.com with SMTP id x12so4791853wgg.8
        for <ceph-devel@vger.kernel.org>; Thu, 20 Nov 2014 12:56:46 -0800 (PST)
In-Reply-To: <CABBk=J-zgjxRAy_fd9Be_j_FvTPtZ8nUc20eV3e3UcgVb3fo9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 20, 2014 at 8:03 PM, Yehuda Sadeh <yehuda@redhat.com> wrote:
> On Thu, Nov 20, 2014 at 1:03 AM, Mustafa Muhammad
> <mustafaa.alhamdaani@gmail.com> wrote:
>> I am using radosgw, I have a large number of connections with huge
>> files, the memory usage keeps getting higher until killed by the
>> kernel, I *think* because of buffering for each request.
>> Is the a way to limit the buffer size for each object (or for each
>> connection)? and What do you suggest?\\\
>
>
> These are main two factors that would affect your memory consumption
>  - number of threads (rgw thread pool size)
>  - window size (rgw_get_obj_window_size)

Thank you for replying, in the configuration reference:
http://ceph.com/docs/master/radosgw/config-ref/
rgw get obj window size is 16 << 20, in bytes

I couldn't understand this "16 << 20", could you please explain how to
read this in bytes?


>
> There's also the chunk size, but the window size should supersede it.

Also I couldn't find "chunk size" in the configuration reference.

Regards
Mustafa

>
> Yehuda
