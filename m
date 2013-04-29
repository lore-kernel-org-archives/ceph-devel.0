From: Anders Saaby <anders@saaby.com>
Subject: Re: placement group sizing
Date: Mon, 29 Apr 2013 09:17:58 +0200
Message-ID: <2A254E15-B87E-456F-B850-F0318349C883@saaby.com>
References: <02E999F2-8374-4D47-88DC-D8DC30547068@saaby.com> <517A718E.2000203@42on.com> <BE9322CA-90F7-4D71-9EB0-6FD7FA61E4AD@saaby.com> <517B57D7.8080306@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.saaby.com ([95.170.88.191]:48073 "EHLO mail.saaby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3D2HR7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 03:17:59 -0400
In-Reply-To: <517B57D7.8080306@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 27/04/2013, at 06.45, Xiaopong Tran <xiaopong.tran@gmail.com> wrote:
> On 04/27/2013 01:07 AM, Anders Saaby wrote:
>> 
>>> How many OSDs per machine do you have and how much memory do you have per machine?
>> 
>> 12 OSD's per machine. A bit over 1GB memory per OSD. (16GB per machine)
> 
> Try more. If you have a large-ish cluster, with many OSDs, and if you
> have large PGs, when one or more OSDs go down (for different reasons,
> a crash, a disk failure, etc), Ceph will start to remap and rebalance,
> memory usage per OSD can easily balloon to GBs per OSD.

I take it, you mean more memory?
Is there a way to calculate OSD memory requirements based on pg_num and/or number of OSDs?

> When this happens, and if you don't have enough memory, the
> OSD processes might get OOM-killed, and you'll get into a
> vicious cycle.


Right.


regards,
Anders

