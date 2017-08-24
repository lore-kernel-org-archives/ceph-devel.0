From: Nathan Cutler <ncutler@suse.cz>
Subject: docs build check - necessary for Jewel?
Date: Thu, 24 Aug 2017 09:59:49 +0200
Message-ID: <8fb1422b-b2b0-88d2-f6ff-849219d1ec46@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751183AbdHXH7v (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 24 Aug 2017 03:59:51 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01085ABE4
        for <ceph-devel@vger.kernel.org>; Thu, 24 Aug 2017 07:59:50 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, is the "docs build check" on GitHub necessary for jewel? If not, can 
it be disabled for jewel?

Given the instability of the checks themselves (false negatives are 
quite common), this new docs check - in addition to guarding against doc 
regressions - also serves to make it even more difficult to get a green 
check mark on a PR.

(I know the check is not "required" and PRs can be merged when it is 
failing. The problem arises when the failing docs check causes PRs to go 
from having a nice green checkmark in the list, to having a nasty red X 
- each red X has to be investigated and dealt with, generating 
additional work in an already labor-intensive process.)

Thanks!
Nathan
