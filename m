From: Janne Grunau <j@jannau.net>
Subject: Re: [PATCH 1/5] erasure-code: conditionally build jerasure sse3/sse4
 plugins
Date: Mon, 27 Oct 2014 19:44:49 +0100
Message-ID: <20141027184449.GA4489@jannau.net>
References: <1414434036-29313-1-git-send-email-j@jannau.net>
 <1414434036-29313-2-git-send-email-j@jannau.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:59397 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbaJ0Soz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 14:44:55 -0400
Content-Disposition: inline
In-Reply-To: <1414434036-29313-2-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2014-10-27 19:20:32 +0100, Janne Grunau wrote:
> ---
>  configure.ac                          | 2 ++
>  src/erasure-code/jerasure/Makefile.am | 4 ++++
>  src/test/erasure-code/Makefile.am     | 4 ++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 7a0691d..d994712 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -539,6 +539,8 @@ AC_LANG_POP([C++])
>  
>  # Find supported SIMD / SSE extensions supported by the compiler
>  AX_INTEL_FEATURES()
> +AM_CONDITIONAL(HAVE_SSSE3, [ test "x$ax_cv_support_ssse3_ext" = "xyes"])
> +AM_CONDITIONAL(HAVE_SSE4_PCLMUL, [ test "x$ax_cv_support_pclmuldq_ext" = "xyes"])
>  
>  # kinetic osd backend?
>  AC_ARG_WITH([kinetic],
> diff --git a/src/erasure-code/jerasure/Makefile.am b/src/erasure-code/jerasure/Makefile.am
> index 86763af..142c612 100644
> --- a/src/erasure-code/jerasure/Makefile.am
> +++ b/src/erasure-code/jerasure/Makefile.am
> @@ -71,7 +71,9 @@ if LINUX
>  libec_jerasure_sse3_la_LDFLAGS += -export-symbols-regex '.*__erasure_code_.*'
>  endif
>  
> +if HAVE_SSSE3
>  erasure_codelib_LTLIBRARIES += libec_jerasure_sse3.la
> +endif

I just realised that this is not exactly safe. While libec_jerasure_sse3 
won't have useful code if HAVE_SSSE3 is not defined, the runtime 
detection in ErasureCodePluginSelectJerasure.cc can still return "sse3".  
That would fail since the sse3 libec_jerasure plugin is not built.

I'll send an updated patch which avoids this problem later.

Janne
