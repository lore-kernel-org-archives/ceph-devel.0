From: Sage Weil <sage@inktank.com>
Subject: Re: Review request : Erasure Code plugin loader implementation
Date: Sun, 18 Aug 2013 17:24:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308181719340.1479@cobra.newdream.net>
References: <5210F429.2020805@dachary.org> <alpine.DEB.2.00.1308181031580.1479@cobra.newdream.net> <521128ED.1080605@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40205 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab3HSAYm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Aug 2013 20:24:42 -0400
In-Reply-To: <521128ED.1080605@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

One other thought on http://tracker.ceph.com/issues/5878:

The user interface there would let you adjust various parameters of the 
pool's erasure coding scheme after the pool is created.  As a practical 
matter, I suspect that many/most of these fields will be specified exactly 
once (at pool creation time) and will be immutable properties of the pool 
after that.  The m/k at a minimum need to match up with what we are 
requesting out of crush.  And once there is data stored, I don't think it 
will make sense to be able to change the encoding scheme for new objects 
and still be able to deal with old objects.  (Or maybe it will be, if the 
code metadata is in the object_info_t.)

Even if we do support changing some of these on the fly, though, I suspect 
the most important interface, and the first we implement, will be 
something like

 ceph osd pool create <name> [key=value ...]

the various parameters listed, like EC algorithm, m, k, and pg_num.  We 
can probably generalize the mon command interface to have a key/value list 
type that will make this easy to plumb from the CLI (and trivial via 
ceph-rest-api).

sage
