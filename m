From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 07/16] libceph: rename ceph_client_id() -> ceph_client_gid()
Date: Wed, 24 Aug 2016 22:56:56 +0200
Message-ID: <CAOi1vP8xvuDhbZzxvYRiZ7HDNVE0FjNWUu3xMoxGNFkUFxhOSg@mail.gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
 <1472044720-29116-8-git-send-email-idryomov@gmail.com> <028df11c-08d0-5972-7f44-e2064696092d@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33693 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756330AbcHXU46 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 16:56:58 -0400
Received: by mail-ua0-f182.google.com with SMTP id 74so50672833uau.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 13:56:57 -0700 (PDT)
In-Reply-To: <028df11c-08d0-5972-7f44-e2064696092d@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 24, 2016 at 10:00 PM, Alex Elder <elder@ieee.org> wrote:
>
> Why?  There must be at least a one-line explanation.

It's gid / global_id in other places and one of the next commits
introduces a struct rbd_client_id.  I'll update the commit message.

Thanks,

                Ilya
