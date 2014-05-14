From: Gregory Farnum <greg@inktank.com>
Subject: Re: XioMessenger (RDMA) Status Update
Date: Tue, 13 May 2014 19:55:27 -0700
Message-ID: <CAPYLRzjFgJXWhVxXMPzPzx-fCxR9fMTrFoCJueQZssoZQGcWHw@mail.gmail.com>
References: <774348207.178.1400024312462.JavaMail.root@thunderbeast.private.linuxbox.com>
	<731499372.186.1400031039363.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:49559 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbaENCz2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 22:55:28 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so1852295qgd.15
        for <ceph-devel@vger.kernel.org>; Tue, 13 May 2014 19:55:27 -0700 (PDT)
In-Reply-To: <731499372.186.1400031039363.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Tue, May 13, 2014 at 6:30 PM, Matt W. Benjamin <matt@cohortfs.com> wrote:
> Hi Greg,
>
> 1. there isn't support for for mark_down() yet (!), but we're working
> on it.  I've had good discussions with the Accelio team regarding exposing
> explicit channel and flow control interfaces, which round out that topic
> as we were exploring it.
>
> 2. the big changes in this push are major cleanups and bug fixes, plus
> much wider integration with the user space code.  my #1 action item from
> our last convo was to first extend Xio coverage everywhere, and in particular,
> add support for intra-cluster messaging over Xio.
>
> 2.1 on the cleanups and bugs front, starting with biggest, I finished support
> for peer identification, using a small api change to Accelio (it's now on the
> official Accelio for_next branch).  a Connection refcnt underrun is fixed.  then
> I added a mechanism to bypass Accelio for intra-server messages, using a special
> singleton connection.  I cleaned up, but didn't deepen, feature support, as a
> temporary measure.  There's lot's of cleanup and various fixes in ceph_osd, too.
>
> 2.2 then, I did first cut integration with the MDS, and while at it, the Client
> module as well.  I've only started verifying, but so far it looks like the
> intra-cluster messaging paths work, and a client workload may work--more fixes
> likely forthcoming.
>
> I have a plan to get at least the starter policy interfaces like mark_down and
> mark_down_all shorty.

Cool. Let me know when those features are ready for a semantics review
or there's something else we need to talk about. :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
