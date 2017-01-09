From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Objecter command resend http://tracker.ceph.com/issues/18358
Date: Mon, 9 Jan 2017 14:29:13 -0800
Message-ID: <CAJ4mKGZJpOaX8iY9vAiPud6onkg1PWVmqC8GTUK0-uri=L3cxw@mail.gmail.com>
References: <CAN=+7FXMsvrkUPNRhVkuv6pTHgZy6r6WBjpKoxyxPMZna63RxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37954 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933433AbdAIW3O (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 17:29:14 -0500
Received: by mail-it0-f51.google.com with SMTP id x2so74719757itf.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2017 14:29:14 -0800 (PST)
In-Reply-To: <CAN=+7FXMsvrkUPNRhVkuv6pTHgZy6r6WBjpKoxyxPMZna63RxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "Weil, Sage" <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 9, 2017 at 12:50 PM, Samuel Just <sjust@redhat.com> wrote:
> It seems like the Objecter doesn't resend commands if the primary
> doesn't change.  As far as I can tell, mark_unfound_lost is the only
> command which doesn't complete syncronously (since the cleanup
> pre-jewel) since it waits for the Repop to commit.  On interval
> change, it doesn't really make sense to requeue the Command message
> since it didn't go through the normal op queue.  So should we:
> 1) Change lost_unfound to just return success immediately
> 2) Update the objecter to unconditionally resend Commands on interval change

I think Commands have enough of the normal op detection system that
this will work properly, right? In which case this seems like the
obvious choice to me — commands like this don't have a really obvious
need for speed and having them marked divergent would really confuse
any likely repair system or human being...
-Greg

> 3) Just return success on interval change, though it's possible that
> the update will end up divergent
> -Sam
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
