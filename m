From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 1/4] ceph: fix endianness of getattr mask in ceph_d_revalidate
Date: Thu, 12 Jan 2017 17:43:37 +0100
Message-ID: <CAOi1vP8CMkXOj_wFekA-8Az_=boMg6Oz4-Fho6C9jt6XtrVKiw@mail.gmail.com>
References: <1484237565-27423-1-git-send-email-jlayton@redhat.com> <1484237565-27423-2-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34908 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdALQod (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 11:44:33 -0500
Received: by mail-wm0-f66.google.com with SMTP id l2so4949544wml.2
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2017 08:43:38 -0800 (PST)
In-Reply-To: <1484237565-27423-2-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jan 12, 2017 at 5:12 PM, Jeff Layton <jlayton@redhat.com> wrote:
>     fs/ceph/dir.c:1248:50: warning: incorrect type in assignment (different base types)
>     fs/ceph/dir.c:1248:50:    expected restricted __le32 [usertype] mask
>     fs/ceph/dir.c:1248:50:    got int [signed] [assigned] mask

This one is missing "sparse says" ;)

Thanks,

                Ilya
