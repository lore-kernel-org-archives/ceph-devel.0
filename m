From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 0/2] fs, ceph filesystem refcount conversions
Date: Fri, 3 Mar 2017 17:39:40 +0100
Message-ID: <CAOi1vP-wZL9yW=_MkhU0x6fGn=9=xEYP1T03ikL2p6g49Vandw@mail.gmail.com>
References: <1488532507-27863-1-git-send-email-elena.reshetova@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:33937 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdCCRjO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Mar 2017 12:39:14 -0500
In-Reply-To: <1488532507-27863-1-git-send-email-elena.reshetova@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, peterz@infradead.org, Greg KH <gregkh@linuxfoundation.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>

On Fri, Mar 3, 2017 at 10:15 AM, Elena Reshetova
<elena.reshetova@intel.com> wrote:
> Now when new refcount_t type and API are finally merged
> (see include/linux/refcount.h), the following
> patches convert various refcounters in the ceph filesystem from atomic_t
> to refcount_t. By doing this we prevent intentional or accidental
> underflows or overflows that can led to use-after-free vulnerabilities.
>
> The below patches are fully independent and can be cherry-picked separately.
> Since we convert all kernel subsystems in the same fashion, resulting
> in about 300 patches, we have to group them for sending at least in some
> fashion to be manageable. Please excuse the long cc list.
>
> Not runtime tested, since I am not sure how to do it for ceph.
> However changes are pretty trivial in this case.
>
> Elena Reshetova (2):
>   fs, ceph: convert ceph_mds_session.s_ref from atomic_t to refcount_t
>   fs, ceph: convert ceph_cap_snap.nref from atomic_t to refcount_t
>
>  fs/ceph/caps.c       |  4 ++--
>  fs/ceph/mds_client.c | 18 +++++++++---------
>  fs/ceph/mds_client.h |  5 +++--
>  fs/ceph/snap.c       |  2 +-
>  fs/ceph/super.h      |  5 +++--
>  5 files changed, 18 insertions(+), 16 deletions(-)

I'll pull these into testing.

Thanks,

                Ilya
