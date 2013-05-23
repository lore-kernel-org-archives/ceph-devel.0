From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: flush dcache after zeroing page data
Date: Thu, 23 May 2013 07:13:00 -0500
Message-ID: <519E07CC.6010208@inktank.com>
References: <519E0781.4000603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:56634 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758533Ab3EWMNB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 08:13:01 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so8414010iet.14
        for <ceph-devel@vger.kernel.org>; Thu, 23 May 2013 05:13:01 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xf4sm25507872igb.8.2013.05.23.05.12.59
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 05:13:00 -0700 (PDT)
In-Reply-To: <519E0781.4000603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 05/23/2013 07:11 AM, Alex Elder wrote:
> Neither zero_bio_chain() nor zero_pages() contains a call to flush
> caches after zeroing a portion of a page.  This can cause problems
> on architectures that have caches that allow virtual address
> aliasing.
> 
> This resolves:
>     http://tracker.ceph.com/issues/4777
> 
> Signed-off-by: Alex Elder <elder@inktank.com>

This patch and the other two I just posted are available in the
"review/wip-rbd" branch of the ceph-client git repository.

					-Alex
