From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 0/2] rbd_img_obj_exists_submit() fixes
Date: Thu, 15 Sep 2016 12:48:05 +0200
Message-ID: <20160915124805.20590455@echidna.suse.de>
References: <1472741959-1786-1-git-send-email-ddiss@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755225AbcIOKsH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Sep 2016 06:48:07 -0400
In-Reply-To: <1472741959-1786-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@linaro.org, Ilya Dryomov <idryomov@gmail.com>

On Thu,  1 Sep 2016 16:59:17 +0200, David Disseldorp wrote:

> Hi,
> 
> This patchset fixes a couple of bugs in the rbd_img_obj_exists_submit()
> code-path which appear to have been there since the function was first
> added.
> 
> Feedback appreciated.

Did anyone get a chance to look at these changes?

Cheers, David
