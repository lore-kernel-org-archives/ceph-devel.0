From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] mds: issue caps on file update finish if no client cap
 specified
Date: Wed, 11 May 2011 10:40:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105111033310.17222@cobra.newdream.net>
References: <1305110696-2688-1-git-send-email-henry.cy.chang@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60036 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab1EKRje (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 13:39:34 -0400
In-Reply-To: <1305110696-2688-1-git-send-email-henry.cy.chang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 11 May 2011, Henry C Chang wrote:

> Fix the following scenario that happens occasionally when running
> blogbench:
> 
> client released caps on one inode. Then, the inode's ifile was wrlocked
> during updating client range. Before the update had finished, client
> re-opened the file again for reading. Since ifile was wrlocked, the client
> was not given the Fr cap and was blocked on reading forever.

This one I'm not sure about.  Do you have an MDS log for this case?  I 
would expect the cap issue to happen when we drop_locks(mut) and the lock 
state changes.

sage


> 
> Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
> ---
>  src/mds/Locker.cc |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
> index 3c7c190..36da98e 100644
> --- a/src/mds/Locker.cc
> +++ b/src/mds/Locker.cc
> @@ -1242,7 +1242,7 @@ void Locker::file_update_finish(CInode *in, Mutation *mut, bool share, client_t
>      if (gather)
>        eval_cap_gather(in);
>    } else {
> -    if (cap && (cap->wanted() & ~cap->pending())) {
> +    if (!cap || (cap && (cap->wanted() & ~cap->pending()))) {
>        issue_caps(in, cap);
>      }
>    
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
