From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: ceph watch/notify
Date: Wed, 26 Oct 2016 08:31:46 -0400
Message-ID: <CA+aFP1C3kVu4Dy0n5A_RbuwkeV5+uXacmgVACxt8K_cFRSgwyQ@mail.gmail.com>
References: <CAKZcxgdqeFzTFQmESLrvhoBXJFE4TWaaD10gc0qw923Xc1aTRg@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:37467 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967015AbcJZMjo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2016 08:39:44 -0400
Received: by mail-lf0-f49.google.com with SMTP id m193so5401930lfm.4
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2016 05:39:42 -0700 (PDT)
In-Reply-To: <CAKZcxgdqeFzTFQmESLrvhoBXJFE4TWaaD10gc0qw923Xc1aTRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Oct 26, 2016 at 6:34 AM, Jaze Lee <jazeltq@gmail.com> wrote:
> But here
> https://github.com/ceph/ceph/blob/master/src/librbd/ImageWatcher.cc#L819
> It is not estimate whether it is owner.  I do not why, can someone explain
> more about this? Thanks.

The "ExclusiveLock::accept_requests" method will return false with a
zeroed error code if it's not the exclusive lock owner, so it will
fall through the "if" and the "else if" statements and do nothing
accept acknowledge receipt of the notification.

-- 
Jason
