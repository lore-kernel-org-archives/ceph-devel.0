From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: Re: placement group sizing
Date: Sat, 27 Apr 2013 12:45:11 +0800
Message-ID: <517B57D7.8080306@gmail.com>
References: <02E999F2-8374-4D47-88DC-D8DC30547068@saaby.com> <517A718E.2000203@42on.com> <BE9322CA-90F7-4D71-9EB0-6FD7FA61E4AD@saaby.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:60331 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab3D0EpH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 00:45:07 -0400
Received: by mail-da0-f46.google.com with SMTP id x4so1654585daj.33
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 21:45:06 -0700 (PDT)
In-Reply-To: <BE9322CA-90F7-4D71-9EB0-6FD7FA61E4AD@saaby.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anders Saaby <anders@saaby.com>
Cc: Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/27/2013 01:07 AM, Anders Saaby wrote:
>
>> How many OSDs per machine do you have and how much memory do you have per machine?
>
> 12 OSD's per machine. A bit over 1GB memory per OSD. (16GB per machine)
>

Try more. If you have a large-ish cluster, with many OSDs, and if you
have large PGs, when one or more OSDs go down (for different reasons,
a crash, a disk failure, etc), Ceph will start to remap and rebalance,
memory usage per OSD can easily balloon to GBs per OSD.

When this happens, and if you don't have enough memory, the
OSD processes might get OOM-killed, and you'll get into a
vicious cycle.

>> The more PGs you have, the more peering PGs you will have when an OSD boots again, so that could be heavy for the CPU in the machines.
>
> Right.
>

