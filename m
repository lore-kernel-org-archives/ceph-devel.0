From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: stuff for v0.56.4
Date: Thu, 7 Mar 2013 10:24:50 -0800
Message-ID: <CAC-hyiEUUxCB4i7Tkfz-nf1eO1WohLs+4tn9aPfPvtV7jEzETA@mail.gmail.com>
References: <alpine.DEB.2.00.1303051503480.1162@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:35053 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243Ab3CGSYv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 13:24:51 -0500
Received: by mail-ia0-f181.google.com with SMTP id w33so679587iag.40
        for <ceph-devel@vger.kernel.org>; Thu, 07 Mar 2013 10:24:50 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1303051503480.1162@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Mar 5, 2013 at 3:10 PM, Sage Weil <sage@inktank.com> wrote:
> There have been a few important bug fixes that people are hitting or
> want:
>
> - the journal replay bug (5d54ab154ca790688a6a1a2ad5f869c17a23980a)
> - the - _ pool name vs cap parsing thing that is biting openstack users
> - ceph-disk-* changes to support latest ceph-deploy
>
> If there are other things that we want to include in 0.56.4, lets get them
> into the bobtial branch sooner rather than later.
>
> Possible items:
>
> - pg log trimming (probably a conservative subset) to avoid memory bloat
> - omap scrub?
> - pg temp collection removal?
> - buffer::cmp fix from loic?
>
> Are there other items that we are missing?
>

wip-4247-bobtail (pending review)

Yehuda
