From: David Disseldorp <ddiss@suse.de>
Subject: memcpy() avoidance using decode(bufferlist)
Date: Fri, 22 Apr 2016 15:53:55 +0200
Message-ID: <20160422155355.06c5ef4c@echidna.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55677 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbcDVNx5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Apr 2016 09:53:57 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id D00DCABC7
	for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 13:53:53 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

A question regarding bufferlist usage:

I'm working on the cmpext librados C API, and want to decode the OSD
response directly into a (char *buf/size_t len) buffer provided by the
caller.

I figured this would be straightforward via:
  bl.push_back(buffer::create_static(buf, len));
  ...
  ::decode_nohead(iter.get_remaining(), bl, iter);

However, the decoded data doesn't make it into buf, unless an extra copy
occurs via:
  bl.copy(0, bl.length(), buf);

Any suggestions on a clean way to avoid the extra copy here?

Cheers, David
