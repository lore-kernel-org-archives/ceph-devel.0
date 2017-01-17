From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 0/4] ceph: endianness fixes and sparse warning fixes
Date: Tue, 17 Jan 2017 19:28:45 +0100
Message-ID: <CAOi1vP8dYx_m3CH+pTejGHETH_AB+edOo=WFuvXgeukAPN-BKA@mail.gmail.com>
References: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
 <alpine.DEB.2.11.1701121623290.5745@piezo.novalocal> <1484310965.2616.7.camel@redhat.com>
 <20170117192605.144022a7@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38911 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdAQS3b (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2017 13:29:31 -0500
Received: by mail-wm0-f50.google.com with SMTP id r144so236183127wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2017 10:28:47 -0800 (PST)
In-Reply-To: <20170117192605.144022a7@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Jeff Layton <jlayton@redhat.com>, Sage Weil <sweil@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jan 17, 2017 at 7:26 PM, David Disseldorp <ddiss@suse.de> wrote:
> On Fri, 13 Jan 2017 07:36:05 -0500, Jeff Layton wrote:
>
>> Thanks. Should we send this series to stable? I'm not sure how common
>> kcephfs mounts are on BE arches, but these bugs would likely prevent it
>> from working.
>
> Please do, Jeff. I hit the [PATCH 4/4] bug on first CephFS I/O with
> s390x (BE):
> [ 2691.805255] ceph: mds parse_reply err -5
> [ 2691.805256] ceph: mdsc_handle_reply got corrupt reply mds0(tid:5)

I'll pick these up.  Thanks for confirming,

                Ilya
