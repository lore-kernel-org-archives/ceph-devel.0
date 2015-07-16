From: Nathan Cutler <ncutler@suse.cz>
Subject: Firefly 0.80.11 integration testing summary
Date: Thu, 16 Jul 2015 13:55:22 +0200
Message-ID: <55A79BAA.3000803@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33619 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293AbbGPLzZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Jul 2015 07:55:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic:

Current status of integration testing for the upcoming firefly 0.80.11 
release is as follows:

* rados: all green
* rgw: currently re-running 11 tests (known bug that has since been fixed)
* fs: currently re-running 4 tests that failed (probably 
environment-related)
* rbd: encountered test failures that I was unable to debug -- opened 
http://tracker.ceph.com/issues/12336
* powercycle: all green
* upgrade: encountered similar-looking test failures as in rbd

For details, see http://tracker.ceph.com/issues/11644

Regards

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
