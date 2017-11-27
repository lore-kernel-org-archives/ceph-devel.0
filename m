From: Igor Fedotov <ifedotov@suse.de>
Subject: osd: fine-grained statistics for object space usage
Date: Tue, 28 Nov 2017 01:52:41 +0300
Message-ID: <dc13f045-6d0c-5c89-afad-0bccb21424da@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbdK0Wwp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 27 Nov 2017 17:52:45 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F35C4ACB2
        for <ceph-devel@vger.kernel.org>; Mon, 27 Nov 2017 22:52:43 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers,

a while ago Ceph got a PR#15199 
(https://github.com/ceph/ceph/pull/15199) that improved object space 
usage tracking.

It introduced 'dirty' extent map (in fact - interval set) in an attempt 
to track the real space used by the object considering overwrites, holes 
etc.

This extent map is kept at OSD level within object_info_t structure that 
in turn utilizes object attributes as a persistent storage.

This is a step forward comparing to the initial implementation relied on 
maximum object offset.

However IMO there is a couple of significant issues related to this patch:

1) Extent tracking might be pretty expensive. Each write operation 
triggers both extent map encoding and its update at object store level. 
It takes 16 bytes (offset+length) per single extent that easily results 
in submitting  several Kb of additional data per write for scattered 
objects. For BlueStore this additional data weigh on already  overburden 
KV store. Moreover this tracking mechanics totally duplicates existing 
stuff - at least for BlueStore which tracks 'dirty' extent map on its own.

2) The approach is still inaccurate. It tracks logical space not the 
actual physical allocation. E.g. single byte write might result in 4K 
physical space  allocation.

My suggestion is to refactor this mechanics and force Object Store to 
track and report back real object space usage. This looks easily doable 
and more accurate for BlueStore. And we can either rollback to the 
original implementation or migrate that new PR#15199  approach to FileStore.

What do you think?

Thanks,

Igor


