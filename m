From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 1/4] ceph: fix endianness of getattr mask in
 ceph_d_revalidate
Date: Thu, 12 Jan 2017 12:16:32 -0500
Message-ID: <1484241392.8506.4.camel@redhat.com>
References: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
         <1484237565-27423-2-git-send-email-jlayton@redhat.com>
         <CAOi1vP8CMkXOj_wFekA-8Az_=boMg6Oz4-Fho6C9jt6XtrVKiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:32837 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdALRRX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 12:17:23 -0500
Received: by mail-qt0-f177.google.com with SMTP id v23so24243591qtb.0
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2017 09:16:36 -0800 (PST)
In-Reply-To: <CAOi1vP8CMkXOj_wFekA-8Az_=boMg6Oz4-Fho6C9jt6XtrVKiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 2017-01-12 at 17:43 +0100, Ilya Dryomov wrote:
> On Thu, Jan 12, 2017 at 5:12 PM, Jeff Layton <jlayton@redhat.com> wrote:
> >     fs/ceph/dir.c:1248:50: warning: incorrect type in assignment (different base types)
> >     fs/ceph/dir.c:1248:50:    expected restricted __le32 [usertype] mask
> >     fs/ceph/dir.c:1248:50:    got int [signed] [assigned] mask
> 
> This one is missing "sparse says" ;)
> 
> Thanks,

Oops! Fixed in my tree, which is here, btw:

    git://git.samba.org/jlayton/linux.git

...in my ceph-4.10 branch.
-- 
Jeff Layton <jlayton@redhat.com>
