From: Jan Fajerski <jfajerski@suse.com>
Subject: cephfs quota support for the kernel client
Date: Mon, 10 Jul 2017 17:02:59 +0200
Message-ID: <20170710150259.kbtbpjn762xu5web@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:34594 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbdGJPDS (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 10 Jul 2017 11:03:18 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi list,
are there any plans/intentions for or reservations against adding quota support 
the cephfs kernel client?
From a superficial look into the quota implementation there doesn't seem to be 
technical reason for not adding this feature to the kernel.
From an engineering perspective there seem to be some objections against xattr 
based quota implementations in the wider kernel community.
https://patchwork.kernel.org/patch/8449721/
https://www.ietf.org/mail-archive/web/nfsv4/current/msg14063.html
https://www.spinics.net/lists/linux-fsdevel/msg113357.html

What does the Ceph community think?

-- 
Jan Fajerski
Engineer Enterprise Storage
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
