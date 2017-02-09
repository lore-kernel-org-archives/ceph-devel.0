From: David Disseldorp <ddiss@suse.de>
Subject: GPG signing of upstream release tags
Date: Thu, 9 Feb 2017 16:03:45 +0100
Message-ID: <20170209160345.1cf38e78@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57871 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752323AbdBIPEf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 10:04:35 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8B368AC5B
        for <ceph-devel@vger.kernel.org>; Thu,  9 Feb 2017 15:03:45 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

TL;DR: release tags should be GPG signed, to allow for downstream source
       verification.

Upstream Ceph releases are currently tagged in Git by the Jenkins Build
Slave User following successful testing. Since v11.0.0/v10.0.5/v0.94.3,
these tags have not been GPG signed, so downstream consumers have no
reliable way of verifying that the source they have matches the reviewed
and tested upstream release source.

Release announcements also (AFAICT) make no mention of the tag's
corresponding SHA-1 commit hash.

IMO, failing to offer users/packagers a means of verification places too
much trust in Github[1], and could again lead to an incident similar in
severity to the previous ceph.com / download.inktank.com intrusion[2]
detected in 2015.

To address this, I propose that:
- *All* future upstream releases tags and tarballs are GPG signed by the
  release manager.
- The signing key used by the release manager is signed by Sage's GPG
  key, and / or keys of other Core Team members.
- The public key is available on Ceph.com.
- Downstream users / packagers are instructed to verify their sources.

Any thoughts?

Cheers, David

1. Github Security Vulnerability (2012)
   https://github.com/blog/1068-public-key-security-vulnerability-and-mitigation
2. ceph.com / download.inktank.com intrusion (2015)
   http://ceph.com/releases/important-security-notice-regarding-signing-key-and-binary-downloads-of-ceph/
