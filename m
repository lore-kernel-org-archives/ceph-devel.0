From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/4] ceph.spec.in: fixes and additions for the rpm spec
 file
Date: Fri, 9 Jul 2010 09:41:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007090939160.5826@cobra.newdream.net>
References: <20100709091116.GB29300@bambus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39098 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757754Ab0GIQjk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jul 2010 12:39:40 -0400
In-Reply-To: <20100709091116.GB29300@bambus>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 9 Jul 2010, Christian Brunner wrote:
> Hi,
> 
> in the following I'll send a few fixes and additions for the rpm spec file.
> Please commit the patches that you like to the repository.

Thanks, committing now.

There's one other pitfall I ran into with the debs... by default symbols 
are stripped from all binaries, but the libcls_rbd.so shared object needs 
to _not_ be stripped, or else the class loading doesn't work.  I have no 
idea where/when/if this is done during the rpmbuild.  The version in the 
built package should look like so:

$ nm .libs/libcls_rbd.so
000000000000797d T __cls_init
000000000020ce50 D __cls_name
000000000020ce7c B __cls_name__rbd
000000000020ce78 B __cls_ver__1_1
000000000020ce48 D __cls_ver_maj
000000000020ce4c D __cls_ver_min

Thanks-
sage
