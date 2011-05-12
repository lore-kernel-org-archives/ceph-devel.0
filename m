From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/2] Update Client to handle self directories
Date: Thu, 12 May 2011 08:32:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105120832001.19492@cobra.newdream.net>
References: <1305178007-2927-1-git-send-email-brchrisman@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40074 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208Ab1ELPbL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 11:31:11 -0400
In-Reply-To: <1305178007-2927-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

On Wed, 11 May 2011, Brian Chrisman wrote:

> libceph lookup of the self-referencing '.' directory fails.
> Patch makes Client class handle '.' specially like it does '..'.
> testceph updated to check the special cases of lstat(.) and lstat(/.).
> 
> Brian Chrisman (2):
>   Add analogous special case for "." directory alongside ".." in
>     _lookup
>   updated test to cover "." directory stat
> 
>  src/client/Client.cc   |    5 +++++
>  src/client/testceph.cc |   17 +++++++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
