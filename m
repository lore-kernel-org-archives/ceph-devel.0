From: David Zafman <dzafman@redhat.com>
Subject: Re: new OSD re-using old OSD id fails to boot
Date: Tue, 8 Dec 2015 17:13:26 -0800
Message-ID: <56678036.5050909@redhat.com>
References: <5663158D.1010302@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56054 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbbLIBN3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Dec 2015 20:13:29 -0500
In-Reply-To: <5663158D.1010302@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


Remember I really think we want a disk replacement feature that would 
retain the OSD id so that it avoids unnecessary data movement.  See 
tracker http://tracker.ceph.com/issues/13732

David

On 12/5/15 8:49 AM, Loic Dachary wrote:
> Hi Sage,
>
> The problem described at "new OSD re-using old OSD id fails to boot" http://tracker.ceph.com/issues/13988 consistently fails the ceph-disk suite on master. I wonder if it could be a side effect of the recent optimizations introduced in the monitor ?
>
> Cheers
>

