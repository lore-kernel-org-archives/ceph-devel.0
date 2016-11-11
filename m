From: Nathan Cutler <ncutler@suse.cz>
Subject: Tracker "Source" field default value changed from "other" to empty
Date: Fri, 11 Nov 2016 10:11:05 +0100
Message-ID: <939a67e9-160c-421b-eb60-87f054c53464@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965735AbcKKJLI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Nov 2016 04:11:08 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3BAE4ABFC
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 09:11:06 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The tracker has a custom field called "Source" which is supposed to 
indicate who found, or first reported, a given issue. In practice, the 
field is rarely used and it typically is left at its default value, 
which is "other". Over time, I have found this to be a low-grade 
annoyance, so today I changed the default value to empty (not filled out).

For me, this is a no-brainer :-) but if anyone has objections let's discuss!

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
