From: Gregory Farnum <greg@inktank.com>
Subject: Re: [RESEND][PATCH 0/2] fix few root xattr bugs
Date: Thu, 18 Apr 2013 11:04:07 -0700
Message-ID: <CAPYLRzhuoNFbigcc6Bp2HkXabek-szD_NvY_JwiL9mOOK2sL8A@mail.gmail.com>
References: <1366267406-1449-1-git-send-email-big.chiu@bigtera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:63995 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab3DRSEI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 14:04:08 -0400
Received: by mail-qe0-f46.google.com with SMTP id nd7so1985317qeb.33
        for <ceph-devel@vger.kernel.org>; Thu, 18 Apr 2013 11:04:07 -0700 (PDT)
In-Reply-To: <1366267406-1449-1-git-send-email-big.chiu@bigtera.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kuan Kai Chiu <big.chiu@bigtera.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks! I merged these into "next" (going to be Cuttlefish) in commits
f379ce37bfdcb3670f52ef47c02787f82e50e612 and
87634d882fda80c4a2e3705c83a38bdfd613763f.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Wed, Apr 17, 2013 at 11:43 PM, Kuan Kai Chiu <big.chiu@bigtera.com> wrote:
> The first patch fixes a bug that causes MDS crash while setting or removing
> xattrs on root directory.
>
> The second patch fixes another bug that root xattrs not correctly logged
> in MDS journal.
>
> Kuan Kai Chiu (2):
>   mds: fix setting/removing xattrs on root
>   mds: journal the projected root xattrs in add_root()
>
>  src/mds/Server.cc          |    6 ++----
>  src/mds/events/EMetaBlob.h |    2 +-
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
