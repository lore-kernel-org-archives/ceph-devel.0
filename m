From: Nathan Cutler <ncutler@suse.cz>
Subject: powercycle suite with -k testing
Date: Tue, 22 Nov 2016 07:10:16 +0100
Message-ID: <93d7f6cb-5640-98fc-29ce-fed3f19ab5cb@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbcKVGKS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Nov 2016 01:10:18 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 618FFAAC8
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 06:10:17 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Greetings:

During hammer integration testing, I ran some powercycle suites with "-k 
testing" and found that I could reproduce 
http://tracker.ceph.com/issues/17984 not only on the hammer-backports 
branch, but in hammer and jewel as well. But it only fails with "-k 
testing" (i.e. the "testing" kernel).

Can anyone shed light on this?

(I seem to remember that there is some kind of problem with "-k 
testing", perhaps that it uses whichever kernel happens to be installed 
on the test node from the last run?)

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
