From: Nathan Cutler <ncutler@suse.cz>
Subject: Duplicate issues?
Date: Fri, 10 Jul 2015 23:00:28 +0200
Message-ID: <55A0326C.2090303@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56141 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754603AbbGJVAb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jul 2015 17:00:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Loic:

Please look at the following two issues that are earmarked for backport 
to firefly:

http://tracker.ceph.com/issues/8674 osd: cache tier: avoid promotion on 
first read
http://tracker.ceph.com/issues/9064 RadosModel assertion failure

They both seem to be fixed by the same commit, namely:

https://github.com/ceph/ceph/commit/0ed3adc1e0a74bf9548d1d956aece11f019afee0

. . . which would mean that the corresponding backport tracker issues 
are duplicates?

Can you confirm/deny this?

Thanks,
Nathan
