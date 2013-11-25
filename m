From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/2] Fix resource leak
Date: Mon, 25 Nov 2013 14:02:31 -0800
Message-ID: <5293C8F7.8070108@inktank.com>
References: <cover.1384760071.git.liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:54420 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab3KYWCg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Nov 2013 17:02:36 -0500
Received: by mail-yh0-f54.google.com with SMTP id z12so3341253yhz.13
        for <ceph-devel@vger.kernel.org>; Mon, 25 Nov 2013 14:02:35 -0800 (PST)
In-Reply-To: <cover.1384760071.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>, ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

On 11/17/2013 11:40 PM, Li Wang wrote:
> Fix two coverity issues.
>
> Li Wang (2):
>    rbd: Release resource before return
>    mds: Release resource before return
>
>   src/mds/MDCache.cc |    2 +-
>   src/rbd.cc         |    6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)

Applied both, thanks!

Josh

