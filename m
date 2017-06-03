From: Nathan Cutler <ncutler@suse.cz>
Subject: CentOS builds failing in Shaman since Friday evening
Date: Sat, 3 Jun 2017 14:52:22 +0200
Message-ID: <4a0aa923-028a-a9bf-d988-ead0f51fe831@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52107 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750775AbdFCMwZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 3 Jun 2017 08:52:25 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E744ABCA
        for <ceph-devel@vger.kernel.org>; Sat,  3 Jun 2017 12:52:24 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

CentOS builds in Shaman started failing with this error:

{standard input}: Assembler messages:
{standard input}:186778: Warning: end of file not at end of a line; 
newline inserted
{standard input}: Error: open CFI at the end of file; missing 
.cfi_endproc directive
c++: internal compiler error: Killed (program cc1plus)
Please submit a full bug report,
with preprocessed source if appropriate.
See <http://bugzilla.redhat.com/bugzilla> for instructions.

AFAICT the first occurrence was in [1] and the error has been haunting 
the build queue since then.

[1] 
https://shaman.ceph.com/builds/ceph/wip-sage-testing2/f93ad23a8fec219667a03695136842edb0cceace/default/45729/

Nathan
