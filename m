From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: use keepalive2 to verify the mon session is alive
Date: Tue, 1 Sep 2015 18:52:01 +0300
Message-ID: <CAOi1vP-uAWvwOZ70bGUtuZuf-yW83Bjxa9zh47yt6TM_-X37gQ@mail.gmail.com>
References: <1441117315-96386-1-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33348 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbbIAPwD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Sep 2015 11:52:03 -0400
Received: by lbcjc2 with SMTP id jc2so2285330lbc.0
        for <ceph-devel@vger.kernel.org>; Tue, 01 Sep 2015 08:52:01 -0700 (PDT)
In-Reply-To: <1441117315-96386-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 1, 2015 at 5:21 PM, Yan, Zheng <zyan@redhat.com> wrote:
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  include/linux/ceph/libceph.h   |  2 ++
>  include/linux/ceph/messenger.h |  4 +++
>  include/linux/ceph/msgr.h      |  4 ++-
>  net/ceph/ceph_common.c         | 18 ++++++++++++-
>  net/ceph/messenger.c           | 60 ++++++++++++++++++++++++++++++++++++++----
>  net/ceph/mon_client.c          | 38 ++++++++++++++++++++------
>  6 files changed, 111 insertions(+), 15 deletions(-)

Hi Zheng,

Just want to make sure you saw my "Re: " message - I had a few
suggestions.  This one looks like the one I commented on, straight from
the testing branch.

Thanks,

                Ilya
