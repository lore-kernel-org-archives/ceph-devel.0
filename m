From: "Stephen Perkins" <perkins@netmass.com>
Subject: Best insertion point for storage shim
Date: Fri, 24 Aug 2012 10:49:21 -0500
Message-ID: <00b201cd8210$077de070$1679a150$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 142.122.233.72.static.reverse.ltdomains.com ([72.233.122.142]:51555
	"EHLO stgateway01.netmass.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759674Ab2HXPtZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Aug 2012 11:49:25 -0400
Received: from stgateway01.netmass.com (localhost [127.0.0.1])
	by stgateway01.netmass.com (Postfix) with ESMTP id 2B10F422035
	for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 10:49:25 -0500 (CDT)
Received: from sidney (sidney.netmass.com [10.10.120.10])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by stgateway01.netmass.com (Postfix) with ESMTPS id 6A95442202D
	for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 10:49:20 -0500 (CDT)
Content-Language: en-us
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I'd like to get feedback from folks as to where the best place would be to
insert a "shim" into the RADOS object storage.

Currently, you can configure RADOS to use copy based storage to store
redundant copies of a file (I like 3 redundant copies so I will use that as
an example).  So... each file is stored in three locations on independent
hardware.   The redundancy has a cost of 3x the storage.

I would assume that it is "possible" to configure RADOS to store only 1 copy
of a file (bear with me here).

I'd like to see where it may be possible to insert a "shim" in the storage
such that I can take the file to be stored and apply some erasure coding to
it. Therefore, the file now becomes multiple files that are handed off to
RADOS.  

The shim would also have to take read file requests and read some small
portion of the fragments and recombine.

Basically... what I am asking is...  where would be the best place to start
looking at adding this:
	https://tahoe-lafs.org/trac/tahoe-lafs#
	
(just the erasure coded part).

Here is the real rationale.  Extreme availability at only 1.3 or 1.6 time
redundancy:

	http://www.zdnet.com/videos/whiteboard/dispersed-storage/156114

Thoughts appreciated,

- Steve

P.S. yes... I posted on this earlier.  Microsoft Azure storage takes this
approach by lazy erasure coding inactive files to significantly reduce
storage costs while increasing reliability.


