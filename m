From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: [PATCH 2/2] configure: remove -m4_include(m4/acx_pthread.m4)
Date: Wed, 23 Jan 2013 16:43:07 -0800
Message-ID: <7D5E8091-F819-4BC6-8DBC-6D8A4175F652@inktank.com>
References: <1358963867-30235-1-git-send-email-danny.al-gaaf@bisect.de> <1358963867-30235-3-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:57686 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab3AXAnM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 19:43:12 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so5050159pbc.17
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 16:43:11 -0800 (PST)
In-Reply-To: <1358963867-30235-3-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Hi Danny -

These two patches are now in the wip-rpm-update-2 branch.  Will merge into master after build test.

Thanks,
Gary

On Jan 23, 2013, at 9:57 AM, Danny Al-Gaaf wrote:

> Since we use already AC_CONFIG_MACRO_DIR, no need to include m4/acx_pthread.m4
> extra.
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
> configure.ac | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index f87140f..ffbd150 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1,6 +1,5 @@
> #                                               -*- Autoconf -*-
> # Process this file with autoconf to produce a configure script.
> -m4_include(m4/acx_pthread.m4)
> 
> # Autoconf
> AC_PREREQ(2.59)
> -- 
> 1.8.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

