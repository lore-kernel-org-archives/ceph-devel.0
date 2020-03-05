From: Qiujun Huang <hqjagain@gmail.com>
Subject: Re: [PATCH] fs/ceph/export: remove unused variable 'err'
Date: Thu, 5 Mar 2020 08:45:01 +0800
Message-ID: <CAJRQjoeOPrJnXruVU-pTCCrkdQFLUF+ZSE1eBKteTpAve6AJBA@mail.gmail.com>
References: <1583252499-16078-1-git-send-email-hqjagain@gmail.com> <f09ffef023cfb8740f6a9a289215e53a16bebb2d.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-il1-f196.google.com ([209.85.166.196]:46820 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCEApN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2020 19:45:13 -0500
In-Reply-To: <f09ffef023cfb8740f6a9a289215e53a16bebb2d.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, Mar 5, 2020 at 4:36 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> I think we probably ought to just return ERR_PTR(err) in that case
> instead of discarding it. It looks like today we'll end up returning
> ENOENT when that errors out which doesn't seem right when there is a
> different issue.

I get that, thanks.

>
> --
> Jeff Layton <jlayton@kernel.org>
>
