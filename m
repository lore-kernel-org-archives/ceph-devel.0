From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw/multisite: unlock failure problem
Date: Mon, 14 Nov 2016 13:26:49 -0800
Message-ID: <CADRKj5Rp-EB=nnxne55t4d+PWV5Uqpxx7LoGp4FYnnmhj6_6Nw@mail.gmail.com>
References: <CAEv+sP6p9sdMt61yucxy10azo5jwQf-e765YbcHvDYQcXrfWPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33668 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932809AbcKNV0u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2016 16:26:50 -0500
Received: by mail-vk0-f41.google.com with SMTP id 137so74304358vkl.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2016 13:26:50 -0800 (PST)
In-Reply-To: <CAEv+sP6p9sdMt61yucxy10azo5jwQf-e765YbcHvDYQcXrfWPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tianshan Qu <qutianshan@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Nov 13, 2016 at 10:40 PM, Tianshan Qu <qutianshan@gmail.com> wrote:
> Hi:
>
> There is a problem with unlock multiste sync log.
> The situation is set rgw_num_rados_handles > 1 and
> rgw_num_async_rados_threads default 32. since multisite use async
> thread pool, so lock and unlock operation may get different threads,
> which may direct to different rados handles, and lock operation use
> client.xxxx to identify owner, different rados handles means different
> client, leads to unlock fail, and next lock will return locked, rgw
> log will show many -16 error.
> Is there a good way to solve this?

Can you open a ceph tracker issue for that?

Thanks,
Yehuda
