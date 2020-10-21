Return-Path: <SRS0=9r1d=D4=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4291C388F9
	for <ceph-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7E920BED
	for <ceph-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN+L7+J2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442040AbgJUNwC (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439686AbgJUNwB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Oct 2020 09:52:01 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E7AC0613CE
        for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2020 06:52:01 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so3239508ion.3
        for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2020 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2HwJcZHMLdOFK4urslYe32wYz6TMkEIxCs7Rwty4uM=;
        b=SN+L7+J2jh19j2uMofKQvhUPZfzeND6Iqn+1TAFUpswuwKKU9i36yTcb9mUsaNc+5W
         YjiPKQzGW+Ernw4dZb/2zeYuU/sZlfVRTO6lq7ZdYsQqnKRvVPP8GherlxWEpBJ986q6
         eTZqebJ6zNSQSkSJ0RW6szugcXj0BwphM5pBubxMoJgZHI8A6p+KqlCf4LWuhCGOYzFE
         04dyv1Rwmnqe+ZYMIW/7RoxwFU0xZL9a9NS30FykC4tDYPHjqQZwpD3CPIdk+kEBYS3F
         Qep7rknH34z4si80RyZxqmz34A29lasB9xgokTsMKtMR0C0yV7yQ4AoRbXYx69TaXYaI
         CCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2HwJcZHMLdOFK4urslYe32wYz6TMkEIxCs7Rwty4uM=;
        b=pKPn43/lu0B3Ns7WjEVUG4xNOK/H3cB7TS2A0kO0IlUBP0J0PlGg28fvFUZHZenKF+
         KLUTcetdPH6KjMVRYjzJ2sroERVSUAo0KNGAkwpq8xmbIfgh5MXtuTmIrBbjgoF0L1jp
         S1gbIhLzqbvqVzu9In2dNui2ks0V8hqRAkOBvmKv6ZuoiILGkZ8wWW43GimGGyBb6HY/
         QlQyYpPhUlIo5tdYQKAINBpeOGHrfecU9VzBkRldonOrTExflsYmwYq+I4xj/aaW7zCW
         c6XgTM4XgoYQG4uY7sRxxmyA/bxdxdUH9YLL5CZCHHdYyao3eOYXbsrYKnnBe+ix64zb
         H+Ww==
X-Gm-Message-State: AOAM533Fr/kLEo2+Rm+dJ257t2eCRdLnVBXvWnjYCJv7sOEbmXCCsqUF
        6deMcB9TuPNoKyQI120wNIy4SOmgpVblKE4oUQs=
X-Google-Smtp-Source: ABdhPJxWWc22Eoi6Ze/mgkW5IL3a8E1E7dXKjYhGAhzd0A6S+qwmNqVab5/tNsQ6RayXS9QohJ8t26W6ksgmj3puCYA=
X-Received: by 2002:a02:3849:: with SMTP id v9mr3028891jae.23.1603288320883;
 Wed, 21 Oct 2020 06:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201007121700.10489-1-jlayton@kernel.org>
In-Reply-To: <20201007121700.10489-1-jlayton@kernel.org>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Wed, 21 Oct 2020 21:51:49 +0800
Message-ID: <CAAM7YA=fQ36xGZApUErp-v_0mPCrK3we+FB-uL_3YpB=ZVAS2Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] ceph: fix spurious recover_session=clean errors
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel <ceph-devel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Wed, Oct 7, 2020 at 8:17 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> v4: test for CEPH_MOUNT_RECOVER in more places
> v3: add RECOVER mount_state and allow dumping pagecache when it's set
>     shrink size of mount_state field
> v2: fix handling of async requests in patch to queue requests
>
> This is the fourth revision of this patchset. The main difference from
> v3 is that this one converts more "==" tests for SHUTDOWN state into
> ">=", so that the RECOVER state is treated the same way.
>
> Original cover letter:
>
> Ilya noticed that he would get spurious EACCES errors on calls done just
> after blocklisting the client on mounts with recover_session=clean. The
> session would get marked as REJECTED and that caused in-flight calls to
> die with EACCES. This patchset seems to smooth over the problem, but I'm
> not fully convinced it's the right approach.
>
> The potential issue I see is that the client could take cap references to
> do a call on a session that has been blocklisted. We then queue the
> message and reestablish the session, but we may not have been granted
> the same caps by the MDS at that point.
>
> If this is a problem, then we probably need to rework it so that we
> return a distinct error code in this situation and have the upper layers
> issue a completely new mds request (with new cap refs, etc.)
>
> Obviously, that's a much more invasive approach though, so it would be
> nice to avoid that if this would suffice.
>
> Jeff Layton (5):
>   ceph: don't WARN when removing caps due to blocklisting
>   ceph: make fsc->mount_state an int
>   ceph: add new RECOVER mount_state when recovering session
>   ceph: remove timeout on allowing reconnect after blocklisting
>   ceph: queue MDS requests to REJECTED sessions when CLEANRECOVER is set
>

series
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>

>  fs/ceph/addr.c               |  4 ++--
>  fs/ceph/caps.c               |  4 ++--
>  fs/ceph/inode.c              |  2 +-
>  fs/ceph/mds_client.c         | 27 ++++++++++++++++-----------
>  fs/ceph/super.c              | 14 ++++++++++----
>  fs/ceph/super.h              |  3 +--
>  include/linux/ceph/libceph.h |  1 +
>  7 files changed, 33 insertions(+), 22 deletions(-)
>
> --
> 2.26.2
>
