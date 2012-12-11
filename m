From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH] fix build of unittest_formatter
Date: Tue, 11 Dec 2012 13:08:26 +0100
Message-ID: <50C7223A.3000607@bisect.de>
References: <1354115148-5549-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:39920 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751418Ab2LKMIe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 07:08:34 -0500
In-Reply-To: <1354115148-5549-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Hi,

did you have a chance to take a look at this patch?

Danny

Am 28.11.2012 16:05, schrieb Danny Al-Gaaf:
> Add CRYPTO_CXXFLAGS to unittest_formatter_CXXFLAGS to find pk11pub.h to
> be included in src/common/ceph_crypto.h.
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  src/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/Makefile.am b/src/Makefile.am
> index be851d6..2f6f486 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -764,7 +764,7 @@ check_PROGRAMS += unittest_heartbeatmap
>  unittest_formatter_SOURCES = test/formatter.cc rgw/rgw_formats.cc
>  unittest_formatter_LDFLAGS = $(PTHREAD_CFLAGS) ${AM_LDFLAGS}
>  unittest_formatter_LDADD = ${UNITTEST_LDADD} $(LIBGLOBAL_LDA)
> -unittest_formatter_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +unittest_formatter_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
>  check_PROGRAMS += unittest_formatter
>  
>  unittest_libcephfs_config_SOURCES = test/libcephfs_config.cc
> 

