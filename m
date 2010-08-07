From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: rbd create command fails to create image
Date: Sat, 7 Aug 2010 11:38:41 +0000 (UTC)
Message-ID: <i3jgk1$iog$1@dough.gmane.org>
References: <AANLkTim1YdtvJ4mnV2P8m3xyyPTdRvPDsQ8R1G3Xk6=x@mail.gmail.com>
	<AANLkTiksxkHQ-bJuKuE=sxGUpeBUcB16sjqmVRB4GkCU@mail.gmail.com>
	<AANLkTikyKWEObcbRJ1pTjMuEHOAXrRxiKO5ts+9m9cx0@mail.gmail.com>
	<Pine.LNX.4.64.1008060940300.26680@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40020 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908Ab0HGMUn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 7 Aug 2010 08:20:43 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OhiO8-0001R5-1y
	for ceph-devel@vger.kernel.org; Sat, 07 Aug 2010 14:20:32 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 07 Aug 2010 14:20:32 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 07 Aug 2010 14:20:32 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Fri, 06 Aug 2010 09:44:16 -0700 schrieb Sage Weil:

> Hi Xiaoguang,
> 
> The problem is that /usr/lib/rados-classes/* shouldn't have symbols
> stripped.  I'm no rpmbuild expert, but a search for 'rpmbuild strip'
> turned up a few things.  Can you see if the below patch fixes the
> problem for you?
> 
> Thanks!
> sage
> 
> 
> diff --git a/ceph.spec.in b/ceph.spec.in index 20e0251..f068edd 100644
> --- a/ceph.spec.in
> +++ b/ceph.spec.in
> @@ -64,6 +64,7 @@ conjunction with any FastCGI capable web server.
>  make -j$(getconf _NPROCESSORS_ONLN) CFLAGS="$RPM_OPT_FLAGS"
>  CXXFLAGS="$RPM_OPT_FLAGS"
>  
>  %install
> +export DONT_STRIP=1
>  rm -rf $RPM_BUILD_ROOT
>  make install DESTDIR=$RPM_BUILD_ROOT
>  find $RPM_BUILD_ROOT -type f -name "*.la" -exec rm -f {} ';'

I'm not a rpm expert either. :) but grepping /usr/lib/rpm did not reveal 
any DONT_STRIP information. 

the strip'ing is done by "%__os_install_post" macro:

%__os_install_post        \
      /usr/lib/rpm/brp-compress \
      /usr/lib/rpm/brp-strip \
      /usr/lib/rpm/brp-strip-comment-note \

maybe redefining it in spec like this:

%define __os_install_post /usr/lib/rpm/brp-compress

may help?

either way, it disables strip'ing for all the files. Is this good? :)

- Thomas


