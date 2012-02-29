From: Alex Elder <elder@dreamhost.com>
Subject: Fwd: Re: [PATCH] ceph: use a shared zero page rather than one per
 messenger
Date: Tue, 28 Feb 2012 21:04:55 -0800
Message-ID: <4F4DB1F7.7090709@dreamhost.com>
References: <4F4DB1C7.6050104@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60129 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab2B2FE6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 00:04:58 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id D126824318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 21:04:55 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id C442724314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 21:04:55 -0800 (PST)
In-Reply-To: <4F4DB1C7.6050104@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Neglected to copy the list on my response.	-Alex

-------- Original Message --------
Subject: Re: [PATCH] ceph: use a shared zero page rather than one per 
messenger
Date: Tue, 28 Feb 2012 21:04:07 -0800
From: Alex Elder <elder@dreamhost.com>
To: Christoph Hellwig <hch@infradead.org>

On 02/28/2012 08:18 PM, Christoph Hellwig wrote:
> On Tue, Feb 28, 2012 at 07:06:22PM -0800, Alex Elder wrote:
>> Each messenger allocates a page to be used when writing zeroes
>> out in the event of error or other abnormal condition.  Just
>> allocate one at initialization time and have them all share it.
>
> Any reason you don't simply use the kernel-wide ZERO_PAGE()?

No reason, I just didn't take the change to that logical
conclusion.  I'll update it to do that instead.

					-Alex

