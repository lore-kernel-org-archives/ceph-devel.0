From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Hadoop release jars
Date: Fri, 22 Feb 2013 17:34:50 -0800
Message-ID: <B589CD93-0327-4300-937E-4BF714158657@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:47148 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758757Ab3BWBew convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 20:34:52 -0500
Received: by mail-pb0-f41.google.com with SMTP id um15so707339pbc.28
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 17:34:51 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Joe Buck <jbbuck@gmail.com>

Hi all,

I've pushed up some changes that let us build stand-alone jar files for the Hadoop CephFS bindings.

  github.com/ceph/hadoop-common.git cephfs/branch-1.0-build-jar

Running "ant cephfs" will produce "build/hadoop-cephfs.jar".

I've tested it locally and things work well, so hopefully this means we can continue to develop in the hadoop-common tree and produce jar releases for whatever version combinations we care about.

Is this something that should be easy to integrate into gitbuilder so we can link off the documentation page to the release jars?

-Noah

