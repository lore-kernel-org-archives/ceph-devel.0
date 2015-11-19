From: Mark Nelson <mnelson@redhat.com>
Subject: Re: All-Flash Ceph cluster and journal
Date: Thu, 19 Nov 2015 08:34:11 -0600
Message-ID: <564DDDE3.9050409@redhat.com>
References: <564DB2A1.9080603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758502AbbKSOeN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Nov 2015 09:34:13 -0500
In-Reply-To: <564DB2A1.9080603@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Almateia <mike.almateia@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is actually the direction newstore is heading with the 
newstore_min_alloc_size so that you can configure when to write into the 
rocksdb WAL.  By default it's set to 512k, but for SSDs we will almost 
certainly want to go smaller.

On 11/19/2015 05:29 AM, Mike Almateia wrote:
> Hello.
>
> By now we have SSD disks with a great perfomance under O_DIRECT/O_SYNC
> flags (and we recomended to use they for journal).
>
> Why in a All-Flash type Ceph clusters we still use journal and them put
> a data into OSD?
> Why we can't just write a data into OSD with O_DIRECT/O_SYNC flags,
> without journal?
>
> Can we just switch off the journal functional for all-flash ceph clusters?
>
