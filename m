From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] improve qemu-img conversion performance
Date: Fri, 09 Sep 2011 10:18:35 +0200
Message-ID: <4E69CBDB.1000401@redhat.com>
References: <cover.1315436097.git.yehuda@hq.newdream.net> <4E68CD7E.2050704@redhat.com> <Pine.LNX.4.64.1109080933150.9266@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6625 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758478Ab1IIIPm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Sep 2011 04:15:42 -0400
In-Reply-To: <Pine.LNX.4.64.1109080933150.9266@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, yehudasa@gmail.com

Am 08.09.2011 18:36, schrieb Sage Weil:
> On Thu, 8 Sep 2011, Kevin Wolf wrote:
>> Am 08.09.2011 01:06, schrieb Yehuda Sadeh:
>>> The following set of patches improve the qemu-img conversion process
>>> performance. When using a higher latency backend, small writes have a
>>> severe impact on the time it takes to do image conversion. 
>>> We switch to using async writes, and we avoid splitting writes due to
>>> holes when the holes are small enough.
>>>
>>> Yehuda Sadeh (2):
>>>   qemu-img: async write to block device when converting image
>>>   qemu-img: don't skip writing small holes
>>>
>>>  qemu-img.c |   34 +++++++++++++++++++++++++++-------
>>>  1 files changed, 27 insertions(+), 7 deletions(-)
>>>
>>
>> This doesn't seem to be against git master or the block tree. Please rebase.
>>
>> I think that commit a22f123c may obsolete your patch 2/2.
> 
> With git.kernel.org down, where should I be looking for the latest 
> upstream?

qemu has never been on kernel.org. The interesting repositories for you are:

* Upstream: git://git.qemu.org/qemu.git master
* Block development branch: git://repo.or.cz/qemu/kevin.git block

Kevin
