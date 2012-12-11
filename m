From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] fix build of unittest_formatter
Date: Tue, 11 Dec 2012 08:44:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212110844240.32154@cobra.newdream.net>
References: <1354115148-5549-1-git-send-email-danny.al-gaaf@bisect.de> <50C7223A.3000607@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48886 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab2LKQoz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 11:44:55 -0500
In-Reply-To: <50C7223A.3000607@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org

I missed it before; applied.

Thanks!
sage


On Tue, 11 Dec 2012, Danny Al-Gaaf wrote:

> Hi,
> 
> did you have a chance to take a look at this patch?
> 
> Danny
> 
> Am 28.11.2012 16:05, schrieb Danny Al-Gaaf:
> > Add CRYPTO_CXXFLAGS to unittest_formatter_CXXFLAGS to find pk11pub.h to
> > be included in src/common/ceph_crypto.h.
> > 
> > Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> > ---
> >  src/Makefile.am | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/src/Makefile.am b/src/Makefile.am
> > index be851d6..2f6f486 100644
> > --- a/src/Makefile.am
> > +++ b/src/Makefile.am
> > @@ -764,7 +764,7 @@ check_PROGRAMS += unittest_heartbeatmap
> >  unittest_formatter_SOURCES = test/formatter.cc rgw/rgw_formats.cc
> >  unittest_formatter_LDFLAGS = $(PTHREAD_CFLAGS) ${AM_LDFLAGS}
> >  unittest_formatter_LDADD = ${UNITTEST_LDADD} $(LIBGLOBAL_LDA)
> > -unittest_formatter_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> > +unittest_formatter_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> >  check_PROGRAMS += unittest_formatter
> >  
> >  unittest_libcephfs_config_SOURCES = test/libcephfs_config.cc
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
