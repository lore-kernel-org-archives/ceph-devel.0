From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] rbd: wire up snapshot removal and rollback
 functionality
Date: Thu, 12 Jan 2012 10:51:21 +0100
Message-ID: <4F0EAD19.2050704@redhat.com>
References: <CAF3hT9CSKMepR_rfbKsWUQrbYDJUyYpzsX5FpHXH30E8jBJYLQ@mail.gmail.com> <CAJSP0QU=gfCB2nvmMPNWhOOSxPkNMUB71fOeKnM5P=Qy4EVB8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36885 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab2ALJsB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 Jan 2012 04:48:01 -0500
In-Reply-To: <CAJSP0QU=gfCB2nvmMPNWhOOSxPkNMUB71fOeKnM5P=Qy4EVB8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

Am 12.01.2012 10:40, schrieb Stefan Hajnoczi:
> On Wed, Jan 11, 2012 at 7:53 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> Signed-off-by: Greg Farnum <gregory.farnum@dreamhost.com>
>> ---
>> Remove redundant warnings and add Kevin to the CC.
>>
>>  block/rbd.c |   22 ++++++++++++++++++++++
>>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

Thanks, applied to the block branch.

Kevin
