From: Sage Weil <sage@newdream.net>
Subject: rockddb prefix seek api
Date: Fri, 3 Jun 2016 14:23:49 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606031419400.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52122 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbcFCSX0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2016 14:23:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Jianjian Huo <jianjian.huo@samsung.com>, Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 1 Jun 2016, Haomai Wang wrote:
> From my current view, prefix could be more flexible. For example, each 
> rgw bucket index could use one prefix to make each bucket index object 
> seek separated. For CF, it would be too heavry.

It seems likeI the CF and prefix seek are solving different problems.  A 
new column family means we can have different compaction 
parameters/policies and cache sizes/policies for different types of data 
(onode vs omap, say).

The prefix seek thing just seems like a smart optimization for any 
non-Wholespace iterator... something we should just implement in the 
rocksdb KeyValueDB glue interface.  I did a quick grep on the code and it 
looks like there is only one (one!) caller to prev() on an iterator:

 int DBObjectMap::DBObjectMapIteratorImpl::in_complete_region(
	const string &to_test,
	string *begin,
	string *end);

in FileStore.  We could make a special iterator creation parameter to 
allow bidirectional iteration, since every other caller doesn't need it, 
and use the prefix thing for forward-only?  Or just drop prev() support 
completely from rocksdb (nobody should be using it with filestore on a 
production OSD since it's marked experimental) and be done with it...

sage

