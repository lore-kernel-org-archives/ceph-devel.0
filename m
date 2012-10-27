From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Using asphyxiate with Doxygen and Java?
Date: Fri, 26 Oct 2012 18:26:21 -0700
Message-ID: <CAPrxi59wA80DbvwekCDYP5+1jHsAp9=uCn5J0_Mqqx6rZ9MHeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58445 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932955Ab2J0B0W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 21:26:22 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so3683268vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 18:26:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Tommi Virtanen <tv@inktank.com>

I stumbled upon Breathe, and then asphyxiate. The doxygenfile
directive in the later doesn't seem to like what Doxygen produces from
parsing JavaDoc markup, although I've read that the Doxygen produced
should be compliant. Here is the error:

   AssertionError: cannot handle compounddef kind=class

Before going any further and I wanted to ping the list to see if
anyone thinks it would be a good/bad idea to look into this. It'd be
nice to have the Java documentation in Sphinx seamlessly. Any change
Breathe has gotten faster over time?

THanks,
Noah
