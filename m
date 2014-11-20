From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: Can I limit buffering for each object in radosgw?
Date: Thu, 20 Nov 2014 09:03:20 -0800
Message-ID: <CABBk=J-zgjxRAy_fd9Be_j_FvTPtZ8nUc20eV3e3UcgVb3fo9w@mail.gmail.com>
References: <CAMWPydROJKB-HvATJmbB28L6QM9kXpYeRf5+myyX8AJ3OiaUSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44835 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757954AbaKTRDV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Nov 2014 12:03:21 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so3155462iec.29
        for <ceph-devel@vger.kernel.org>; Thu, 20 Nov 2014 09:03:21 -0800 (PST)
In-Reply-To: <CAMWPydROJKB-HvATJmbB28L6QM9kXpYeRf5+myyX8AJ3OiaUSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 20, 2014 at 1:03 AM, Mustafa Muhammad
<mustafaa.alhamdaani@gmail.com> wrote:
> I am using radosgw, I have a large number of connections with huge
> files, the memory usage keeps getting higher until killed by the
> kernel, I *think* because of buffering for each request.
> Is the a way to limit the buffer size for each object (or for each
> connection)? and What do you suggest?\\\


These are main two factors that would affect your memory consumption
 - number of threads (rgw thread pool size)
 - window size (rgw_get_obj_window_size)

There's also the chunk size, but the window size should supersede it.

Yehuda
