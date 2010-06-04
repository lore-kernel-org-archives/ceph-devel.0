From: Sage Weil <sage@newdream.net>
Subject: Re: cfuse fail on dbench (ceph.git testing)
Date: Fri, 4 Jun 2010 16:32:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006041631460.2384@cobra.newdream.net>
References: <huag5k$te4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33081 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209Ab0FDXcc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jun 2010 19:32:32 -0400
In-Reply-To: <huag5k$te4$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Fri, 4 Jun 2010, Thomas Mueller wrote:
> cfuse fails dbench with ceph.git testing. See logs:

Hi Thomas,

I've fixed this (and some related ObjectCacher bugs).  dbench exercised a 
bunch of cache code that previous tests apparently hadn't hit.  Pushed to 
the 'unstable' branch of ceph.git.

sage
