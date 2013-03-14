From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: CephFS locality API RFC
Date: Thu, 14 Mar 2013 11:14:55 -0700
Message-ID: <2A330211-CC95-42FB-967C-6FAD4E1895DC@cs.ucsc.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:49335 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932740Ab3CNSO5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 14:14:57 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so2610183pbc.30
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 11:14:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The current CephFS API is used to extract locality information as follows:

First we get a list of OSD IDs:

  ceph_get_file_extent_osds(offset) -> [OSD ID]*

Using the OSD IDs we can then query for the CRUSH bucket hierarchy:

  ceph_get_osd_crush_location(osd_id) -> path

The path includes hostname information, but we'd still like to get the IP. The current API for doing this is:

  ceph_get_file_stripe_address(offset) -> [sockaddr]*

that returns an IP for each OSD holds replicas. The order of the output list should be the same as the the OSD list, but It'd be nice to have a consistent API that deals with OSD id, making the correspondence explicit. For instance:

  ceph_get_file_stripe_address(osd_id) -> sockaddr

Another option is to have `ceph_get_osd_crush_location` return both the path and a sockaddr.

Thoughts?

Thanks,
Noah