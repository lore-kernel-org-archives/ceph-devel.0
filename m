From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: Plugin for querying rgw metadata
Date: Wed, 2 Nov 2016 14:16:35 -0700
Message-ID: <CADRKj5RN4KWCHH9WhWYMRXsDi1L2x6ry6z_hHUcy426VbspQnQ@mail.gmail.com>
References: <8FC2060F93794D44942D588B8B547287121F993F@BPXM03GP.gisp.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:35168 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755978AbcKBVQh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Nov 2016 17:16:37 -0400
Received: by mail-ua0-f182.google.com with SMTP id 12so23695566uas.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Nov 2016 14:16:36 -0700 (PDT)
In-Reply-To: <8FC2060F93794D44942D588B8B547287121F993F@BPXM03GP.gisp.nec.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hidekazu Nakamura <hid-nakamura@vf.jp.nec.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Haruhiko Katou <har-katou@ts.jp.nec.com>

On Tue, Nov 1, 2016 at 9:08 PM, Hidekazu Nakamura
<hid-nakamura@vf.jp.nec.com> wrote:
> Hi ceph developers,
>
> I heard at OpenStack Summit Barcelona[*] that community will develop plugin
> which put metadata into elasticsearch for querying metadata.
> Could anyone teach me spec of it?

I sent an email to ceph-devel a while back describing it, here it is:

http://www.spinics.net/lists/ceph-devel/msg32219.html

>
> My concern is whether operator could know object sync status between zones.

'radosgw-admin sync status' can be used to query each zone about the
sync status, but it's not a per-object granularity.

Yehuda

>
> [*]https://www.openstack.org/videos/video/ceph-now-and-later-our-plan-for-open-unified-cloud-storage
>
> Thanks,
> Hidekazu Nakamura
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
