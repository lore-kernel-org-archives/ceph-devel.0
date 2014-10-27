From: Janne Grunau <j@jannau.net>
Subject: Re: [PATCH 2/5] autotools: ARM/AArch64 NEON detection similar to x86
Date: Mon, 27 Oct 2014 19:49:38 +0100
Message-ID: <20141027184938.GB4489@jannau.net>
References: <1414434036-29313-1-git-send-email-j@jannau.net>
 <1414434036-29313-3-git-send-email-j@jannau.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:59408 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaJ0Stj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 14:49:39 -0400
Content-Disposition: inline
In-Reply-To: <1414434036-29313-3-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2014-10-27 19:20:33 +0100, Janne Grunau wrote:
> ---
>  configure.ac |  7 +++----
>  m4/ax_arm.m4 | 27 +++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 4 deletions(-)
>  create mode 100644 m4/ax_arm.m4
> 
> diff --git a/configure.ac b/configure.ac
> index d994712..feb85a1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -141,9 +141,6 @@ AC_DEFUN([AC_CHECK_CC_FLAG],
>  AC_CHECK_CC_FLAG([-Wtype-limits], [WARN_TYPE_LIMITS])
>  AC_CHECK_CC_FLAG([-Wignored-qualifiers], [WARN_IGNORED_QUALIFIERS])
>  
> -# Checks for architecture stuff
> -AM_CONDITIONAL([ENABLE_FPU_NEON], [case $target_cpu in arm*) true;; *) false;; esac])
> -

This conflicts with the wip-neon-crc32c branch. I removed it since 
ENABLE_FPU_NEON is currently unused. I think that branch should be 
updated to use the defines/flags in this patch since this is more in 
line with behaviour for x86.

Janne
