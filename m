From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 1/8] rbd: change rbd_obj_request_submit() signature
Date: Mon, 26 Sep 2016 14:38:03 +0200
Message-ID: <20160926143803.5de08868@echidna.suse.de>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
        <1474304608-17958-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965304AbcIZMiF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Sep 2016 08:38:05 -0400
In-Reply-To: <1474304608-17958-2-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@linaro.org>

On Mon, 19 Sep 2016 19:03:21 +0200, Ilya Dryomov wrote:

> - osdc parameter is useless
> - starting with commit 5aea3dcd5021 ("libceph: a major OSD client
>   update"), ceph_osdc_start_request() always returns success
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.
Reviewed-by: David Disseldorp <ddiss@suse.de>
