From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: watch/notify changes
Date: Thu, 21 Aug 2014 16:02:54 -0700
Message-ID: <CABBk=J-9m-7Aan96NiYYPbOMCyV8HnB1endduQhJir9XHvOGMg@mail.gmail.com>
References: <alpine.DEB.2.00.1408211517320.31172@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:56031 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbaHUXCz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 19:02:55 -0400
Received: by mail-ig0-f170.google.com with SMTP id h3so360708igd.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 Aug 2014 16:02:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408211517320.31172@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 21, 2014 at 3:34 PM, Sage Weil <sweil@redhat.com> wrote:
> Sam and Josh and I discussed the state of watch/notify a couple weeks
> back.  Here are our notes:
>
>         http://pad.ceph.com/p/watch-notify
>
> I've mapped most of these to tickets or bugs and noted them in the pad.
>
> Ignore the fact that these are in the v0.86 sprint currently; it's just
> easier to enter them that way.
>
> If there are other issues we're missing here, let's address them now.  The
> API changes so far can be seen at
>
>         https://github.com/ceph/ceph/commit/7ba30230505c6eede06cb2e2cb64210fdd4025a8
>         https://github.com/ceph/ceph/commit/d179dd970e52db8b0c07b20f69c9e3be6bc43f09
>

There's a case where the notifier is also the sole watcher. In that
case, currently, we'll send a notification to the notifier. Don't see
whether it's going to change, but we may want to add an optional
optimization where the osd doesn't send anything and acks the notify
immediately. This could have significant performance improvement in a
single rgw installation with certain operations (bucket creation,
metadata modifications).

Yehuda
