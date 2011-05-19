From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/2] Adding ceph_readdir to libceph
Date: Thu, 19 May 2011 15:05:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105191505270.9218@cobra.newdream.net>
References: <1305836553-393-1-git-send-email-brchrisman@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49447 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933084Ab1ESWE0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 18:04:26 -0400
In-Reply-To: <1305836553-393-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 19 May 2011, Brian Chrisman wrote:
> Some applications (Samba-VFS layer included) expect readdir() rather than readdir_r().
> Expanded Client & libceph to include readdir.
> Expanded testceph to cover additional basic functionality.
> 
> Brian Chrisman (2):
>   add ceph_readdir() to libceph
>   expanding testceph to test open/readdir/telldir

Applied, thanks!
sage



> 
>  src/client/Client.cc       |   35 ++++++++++++++++-
>  src/client/Client.h        |    1 +
>  src/client/testceph.cc     |   88 ++++++++++++++++++++++++++++++++++---------
>  src/include/ceph/libceph.h |    1 +
>  src/libceph.cc             |    5 ++
>  5 files changed, 109 insertions(+), 21 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
