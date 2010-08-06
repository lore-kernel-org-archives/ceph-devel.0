From: Sage Weil <sage@newdream.net>
Subject: Re: rbd create command fails to create image
Date: Fri, 6 Aug 2010 09:44:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008060940300.26680@cobra.newdream.net>
References: <AANLkTim1YdtvJ4mnV2P8m3xyyPTdRvPDsQ8R1G3Xk6=x@mail.gmail.com>
 <AANLkTiksxkHQ-bJuKuE=sxGUpeBUcB16sjqmVRB4GkCU@mail.gmail.com>
 <AANLkTikyKWEObcbRJ1pTjMuEHOAXrRxiKO5ts+9m9cx0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34909 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933833Ab0HFQlY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Aug 2010 12:41:24 -0400
In-Reply-To: <AANLkTikyKWEObcbRJ1pTjMuEHOAXrRxiKO5ts+9m9cx0@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoguang Liu <syslxg@gmail.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

Hi Xiaoguang,

The problem is that /usr/lib/rados-classes/* shouldn't have symbols 
stripped.  I'm no rpmbuild expert, but a search for 'rpmbuild strip' 
turned up a few things.  Can you see if the below patch fixes the problem 
for you?

Thanks!
sage


diff --git a/ceph.spec.in b/ceph.spec.in
index 20e0251..f068edd 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -64,6 +64,7 @@ conjunction with any FastCGI capable web server.
 make -j$(getconf _NPROCESSORS_ONLN) CFLAGS="$RPM_OPT_FLAGS" CXXFLAGS="$RPM_OPT_FLAGS"
 
 %install
+export DONT_STRIP=1
 rm -rf $RPM_BUILD_ROOT
 make install DESTDIR=$RPM_BUILD_ROOT
 find $RPM_BUILD_ROOT -type f -name "*.la" -exec rm -f {} ';'
