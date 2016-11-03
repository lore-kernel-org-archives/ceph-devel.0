From: Samuel Just <sjust@redhat.com>
Subject: Re: requiring sortbitwise post-jewel
Date: Thu, 3 Nov 2016 15:32:25 -0700
Message-ID: <CAN=+7FVnSj6GhizAuf7CuCQzie6vb3sWy1taV52tw1e66TjE6A@mail.gmail.com>
References: <alpine.DEB.2.11.1611031728580.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36456 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbcKCWc1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2016 18:32:27 -0400
Received: by mail-qk0-f169.google.com with SMTP id o68so76485092qkf.3
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2016 15:32:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1611031728580.20331@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Seems like a good idea to me.
-Sam

On Thu, Nov 3, 2016 at 10:30 AM, Sage Weil <sweil@redhat.com> wrote:
> What do you think about requiring that the sortbitwise OSDMap flag be set
> before ceph-osd will start?  I think this would let us drop all the
> Sortbitwise comparator stuff immediately.  Jewel already issues a health
> warning if all OSDs are jewel and the flag isn't set.  We can make a note
> in the upgrade notes.
>
> ?
>
> sage
>
