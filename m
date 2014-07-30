From: Sage Weil <sweil@redhat.com>
Subject: KeyValueDB instantiation
Date: Tue, 29 Jul 2014 21:47:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407292146440.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55905 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbaG3Eri (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 00:47:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com, haomaiwang@gmail.com
Cc: ceph-devel@vger.kernel.org

Hey,

https://github.com/ceph/ceph/pull/2163

cleans up the KeyValueDB instantiation and sets things up for rocksdb.  
Can you take a look?

Thanks!
sage

