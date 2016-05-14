From: Jimmy Devine <fxmulder@gmail.com>
Subject: Re: RADOS backend for Dovecot mail storage
Date: Sat, 14 May 2016 18:56:48 -0500
Message-ID: <CAPmoJaOZUSgft3HwUCzWg6gfAzSUYn5LRAXW+OQqd0VyrCe2+A@mail.gmail.com>
References: <551A8182.9020406@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34996 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbcENX4t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 May 2016 19:56:49 -0400
Received: by mail-oi0-f53.google.com with SMTP id x19so221744513oix.2
        for <ceph-devel@vger.kernel.org>; Sat, 14 May 2016 16:56:49 -0700 (PDT)
In-Reply-To: <551A8182.9020406@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I second this, I had looked for something that would allow dovecot to
work directly with ceph a few years back rather than using something
like mdbox on top of cephfs.  I saw a few people who had interest in
something like this, I'm surprised I haven't seen more about it, seems
like a very good coupling.  Hard to find the time to devote I guess.

On Tue, Mar 31, 2015 at 6:14 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> Recently Dovecot merged with OpenXchange as announced here:
> http://www.dovecot.fi/open-xchange-and-dovecot-announce-merger-to-create-worlds-leading-open-source-messaging-software-provider/
>
> In the past few years I've contacted Dovecot a couple of times because
> it would be very, very cool to have your e-mail stored via native RADOS.
>
> They thought it was a very cool idea, but since they had closed source
> Object Store plugins for Dovecot like Scality they couldn't allow RADOS
> to be implemented for Object Mail storage.
>
> My idea is basically: Dovecot -> libmailrados -> librados -> Ceph
>
> Now that OpenXchange acquired Dovecot it might be that this possibility
> opens up!
>
> Just wanted to get this out there. I currently won't be able to look
> into this, but it would be very cool if this happens.
>
> --
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
