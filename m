From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Seeking approval for kraken 11.2.1 release - rados
Date: Tue, 1 Aug 2017 13:31:33 +0200
Message-ID: <7c51a718-0917-d8d9-cd81-fa9813c425c2@suse.cz>
References: <0bf84195-f820-9608-a1ce-b04688f0331b@suse.cz>
 <d6e573ab-4771-2f61-db69-1c53770afbd0@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46067 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751978AbdHALbi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 1 Aug 2017 07:31:38 -0400
In-Reply-To: <d6e573ab-4771-2f61-db69-1c53770afbd0@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Durgin, Josh" <jdurgin@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Also, in the spirit of full disclosure, please note that one of the 
outstanding rados PRs [1] looks like it might fix a problem in the 
upgrad/jewel-x suite [2] - however, I marked it DNM because it caused 
OSDs to assert [3]. If anyone thinks it's really important to have this 
fix in kraken, now would be a good time to debug that.

[1] https://github.com/ceph/ceph/pull/16082
[2] 
http://pulpito.ceph.com/smithfarm-2017-08-01_09:32:53-upgrade:jewel-x-wip-kraken-backports-distro-basic-smithi/1468986/
[3] http://tracker.ceph.com/issues/19009#note-62
