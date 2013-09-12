From: Liam Monahan <liam@umiacs.umd.edu>
Subject: Bucket ACL precedence over key ACLs in radosgw
Date: Thu, 12 Sep 2013 17:35:09 -0400
Message-ID: <0b1431c8eff488eefb27b014c87dd330@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pompom.umiacs.umd.edu ([128.8.120.254]:43650 "EHLO
	pompom.umiacs.umd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab3ILVur (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Sep 2013 17:50:47 -0400
Received: from mrouter6.umiacs.umd.edu (mrouter6.umiacs.umd.edu [128.8.120.13]) by pompom.umiacs.umd.edu with ESMTP id RqMhXvrSL2B6FxHd (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO) for <ceph-devel@vger.kernel.org>; Thu, 12 Sep 2013 17:35:09 -0400 (EDT)
Received: from webmail.umiacs.umd.edu (webmail01.umiacs.umd.edu [192.168.7.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mrouter6.umiacs.umd.edu (Postfix) with ESMTPSA id B81BCC0052
	for <ceph-devel@vger.kernel.org>; Thu, 12 Sep 2013 17:35:09 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

There's a limitation for my site's installation of Ceph, particularly 
the radosgw s3 API, that we've been trying to work around.  If a user is 
granted FULL_CONTROL over a bucket, they still can get 403s when trying 
to access/modify keys in that bucket.  Would it be appropriate to skip 
ACL checks for the key if the user has full control over the bucket or 
is there a good reason not to do so?

I wanted to gauge the likelihood of acceptance for such a patch before 
starting in on it.  Any suggestions would be helpful.  I was thinking 
that modifications would mainly be necessary in 
verify_object_permission() in src/rgw/rgw_common.cc.

Thanks,
Liam Monahan

University of Maryland
Institute for Advanced Computer Studies
http://www.umiacs.umd.edu/~liam
