From: Xavier Roche <roche+kml2@exalead.com>
Subject: flock() on libcephfs ?
Date: Fri, 06 Feb 2015 11:39:17 +0100
Message-ID: <54D499D5.3060505@exalead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mhx-mail-gw.exalead.com ([178.255.215.32]:49255 "EHLO
	exalead.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752099AbbBFK7f (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Feb 2015 05:59:35 -0500
Received: from [192.168.204.216] (lenov011cem.paris.exalead.com [192.168.204.216])
	by exalead.com (8.14.4/8.14.4) with ESMTP id t16AdHN8045113
	for <ceph-devel@vger.kernel.org>; Fri, 6 Feb 2015 11:39:18 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks!

I'm not sure this is the right place to post, so do not hesitate to redirect me to a more appropriate list if necessary!

New to ceph, I naively attempted to add a flock (int ceph_flock(struct ceph_mount_info *cmount, int fd, int operation)) function in libcephfs, but I could not find the proper way to figure out what was the owner identifier used by Client::ll_flock() (an uint64_t integer) - this is not the pid, I presume ?

(In a similar way, the opaque void* fuse_req pointer passed appears to be optional, but I was not able to figure out what it was either, even if it is obviously FUSE-related)

Thanks in advance for any hints! By the way - would this new feature (flock()) make sense ?


Regards,
Xavier
