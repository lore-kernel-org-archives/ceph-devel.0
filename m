From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Use LIBEDIT_LIBS in Makefile.am
Date: Wed, 28 Sep 2011 10:50:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109281049500.13650@cobra.newdream.net>
References: <201109280847.p8S8lYS9003894@pentland.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49673 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab1I1Ru2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 13:50:28 -0400
In-Reply-To: <201109280847.p8S8lYS9003894@pentland.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: ceph-devel@vger.kernel.org

Hi Hannes!

Applied this, thanks.
sage


On Wed, 28 Sep 2011, Hannes Reinecke wrote:

> 
> The editline library might require some additional libs, so
> instead of hardcoding '-ledit' we should be using LIBEDIT_LIBS
> in Makefile.am
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  src/Makefile.am |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 704f1fa..b7ab7ae 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -49,7 +49,7 @@ ceph_SOURCES = \
>  	tools/ceph.cc \
>  	tools/common.cc \
>  	mon/PGMap.cc
> -ceph_LDADD = $(LIBGLOBAL_LDA) -ledit
> +ceph_LDADD = $(LIBGLOBAL_LDA) $(LIBEDIT_LIBS)
>  ceph_CXXFLAGS = ${AM_CXXFLAGS}
>  
>  if WITH_GTK2
> @@ -77,7 +77,7 @@ gceph_SOURCES = \
>  	mon/PGMap.cc \
>  	tools/gceph.cc \
>  	tools/gui.cc
> -gceph_LDADD = $(LIBGLOBAL_LDA) -ledit $(GTKMM_LIBS)
> +gceph_LDADD = $(LIBGLOBAL_LDA) $(LIBEDIT_LIBS) $(GTKMM_LIBS)
>  gceph_CXXFLAGS = ${AM_CXXFLAGS} $(GTKMM_CFLAGS) \
>  	-DCEPH_TOOL_GUIDIR="\"${ceph_tool_guidir}\""
>  bin_PROGRAMS += gceph
> @@ -955,7 +955,7 @@ libclient_la_SOURCES = \
>  	client/Inode.cc \
>  	client/MetaRequest.cc \
>  	client/Trace.cc
> -libclient_la_LIBADD = libcommon.la
> +libclient_la_LIBADD = libcommon.la $(LIBEDIT_LIBS)
>  noinst_LTLIBRARIES += libclient.la
>  
>  dist-hook:
> -- 
> 1.6.0.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
