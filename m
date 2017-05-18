From: Dan Mick <dmick@redhat.com>
Subject: Re: Is jenkins still building docs for branches in ceph.git?
Date: Thu, 18 May 2017 16:05:30 -0700
Message-ID: <6e5d9a7b-2f93-de08-65a5-7e39a328c1ec@redhat.com>
References: <9d38ef73-ca54-00c4-7c12-35ef75280279@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754392AbdERXFb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 May 2017 19:05:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0F3768A6
        for <ceph-devel@vger.kernel.org>; Thu, 18 May 2017 23:05:30 +0000 (UTC)
In-Reply-To: <9d38ef73-ca54-00c4-7c12-35ef75280279@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 05/18/2017 09:25 AM, Casey Bodley wrote:
> The last few times I pushed doc branches to ceph/ceph.git, I never saw
> previews built. For example, I pushed
> https://github.com/ceph/ceph/commits/wip-doc-rgw-remove-agent a couple
> days ago, and I'm still getting 404 errors for
> http://docs.ceph.com/docs/wip-doc-rgw-remove-agent/.
> 
> This used to work. Are there new rules about which branches get built?
> Does there have to be an open PR targetting the ceph/ceph.git branch?


http://tracker.ceph.com/issues/19976 is filed and I'm chewing on solutions.
