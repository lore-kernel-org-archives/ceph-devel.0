From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Seeking approval for kraken 11.2.1 release - rados
Date: Tue, 1 Aug 2017 14:21:42 -0700
Message-ID: <0cc23f43-359e-b822-ec85-41d787f6659f@redhat.com>
References: <0bf84195-f820-9608-a1ce-b04688f0331b@suse.cz>
 <d6e573ab-4771-2f61-db69-1c53770afbd0@suse.cz>
 <7c51a718-0917-d8d9-cd81-fa9813c425c2@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbdHAVVn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 1 Aug 2017 17:21:43 -0400
In-Reply-To: <7c51a718-0917-d8d9-cd81-fa9813c425c2@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/01/2017 04:31 AM, Nathan Cutler wrote:
> Also, in the spirit of full disclosure, please note that one of the 
> outstanding rados PRs [1] looks like it might fix a problem in the 
> upgrad/jewel-x suite [2] - however, I marked it DNM because it caused 
> OSDs to assert [3]. If anyone thinks it's really important to have this 
> fix in kraken, now would be a good time to debug that.

Thanks for pointing that out. I don't think it's urgent to fix in kraken 
since it requires using snapshots for an EC pool, which is not a common 
configuration, and the consequence is minor and a workaround possible.

The existing backports to kraken look good to me - and I see no urgent
ones outstanding - so going ahead with 11.2.1 sounds good.

Thanks!
Josh
