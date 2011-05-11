From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/2] adding libceph xattr support
Date: Wed, 11 May 2011 10:29:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105111029190.17222@cobra.newdream.net>
References: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41039 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab1EKR2z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 13:28:55 -0400
In-Reply-To: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org

Thanks Brian, applied these.  (Also broke out the namespace thing into a 
separate patch.)

sage

On Tue, 10 May 2011, Brian Chrisman wrote:

> Expands libceph to handle xattr calls including underlying Client methods.
> testceph is expanded to verify libceph xattr calls work.
> 
> Brian Chrisman (2):
>   support for xattrs in libceph
>   expand testceph to check xattrs
> 
>  src/client/Client.cc       |   67 +++++++++++++++++++++++++++++++++++++++-
>  src/client/Client.h        |   10 ++++++
>  src/client/testceph.cc     |   74 +++++++++++++++++++++++++++++++++++++++++++-
>  src/include/ceph/libceph.h |   15 +++++++++
>  src/libceph.cc             |   42 +++++++++++++++++++++++++
>  5 files changed, 206 insertions(+), 2 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
