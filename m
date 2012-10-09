From: Gregory Farnum <greg@inktank.com>
Subject: Re: chaos monkeys
Date: Tue, 9 Oct 2012 11:40:29 -0700
Message-ID: <CAPYLRzg3=v4B6RqXr4GcOd5LSdUwumaNTk7FcmknXS1eY-5pGQ@mail.gmail.com>
References: <5074541B.4000504@inktank.com>
	<CAPYLRzhqfbWcP0_oXDQmoGSmzPOEGO9DutPSRBS32kzPjuLoZw@mail.gmail.com>
	<507457EB.4000802@inktank.com>
	<CAPYLRzi5PWbPoq8L9DSiMq9wkgeLEER_ZFDg_b28sUbt20=3oA@mail.gmail.com>
	<50746DC2.90609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:35702 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab2JISka convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 14:40:30 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3278082lag.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 11:40:29 -0700 (PDT)
In-Reply-To: <50746DC2.90609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 9, 2012 at 11:32 AM, Sam Lang <sam.lang@inktank.com> wrote:
> Putting a delay on the sender would avoid the reordering of messages =
that
> have semantic meaning but allow delay-caused reordering to occur for =
those
> that have no semantic dependency.
>
> You're right that reordering at the receiver won't work, but it would=
 be
> nice to have more concrete examples.  The only example I can come up =
with is
> the unsafe/safe messages from mds to client.  Even in that case it lo=
oks
> like we handle it by throwing away the unsafe message.  What other ex=
amples
> exist?  Caps issue/revoke?

in the OSDs then requests to the same object are all strictly ordered,
and responses need to be ordered in the same way =97 everybody through
the whole chain asserts out if that's not the case.

I haven't thought it through on the MDS, but yeah, caps messages on
the same inode (or inodes in a hierarchical relationship) all need to
be ordered. Most of the rest of its messages I can come up with aren't
going to have semantic meanings without the client already waiting, so
it's got fewer problems than the OSDs do.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
