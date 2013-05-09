From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: coverity scan - a plea for help!
Date: Thu, 9 May 2013 13:15:41 -0400
Message-ID: <CACkq2mpZLj-Ez6CshNDOE7KEnJcRGUmyCfxx2u2j+_vxj=bstw@mail.gmail.com>
References: <alpine.DEB.2.00.1305090922300.4023@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:51245 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab3EIRQE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 May 2013 13:16:04 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so1567356bkc.16
        for <ceph-devel@vger.kernel.org>; Thu, 09 May 2013 10:16:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1305090922300.4023@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

My C skills are a bit rusty, but this seems like a good way to revive
them.  Without making any hard commitments, I'm certainly interested.

 - Travis

On Thu, May 9, 2013 at 12:26 PM, Sage Weil <sage@inktank.com> wrote:
> We were added to coverity's awesome scan program a while back, which gives
> free access to their static analysis tool to open source projects.
>
> Currently it identifies 421 issues.  We've already taken care of the ones
> that are highest impact, but the usefulness of periodic scans is limited
> until we can eliminate the noise from the remaining issues and easily see
> when new problems come up.
>
> If anybody is interested in helping out in the cleanup effort, let me know
> and I'll share the login info.  This would provide significant value to
> our overall quality efforts and is a pretty easy way to make a meaningful
> contribution to the project without a huge investment in understanding the
> code and architecture!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
