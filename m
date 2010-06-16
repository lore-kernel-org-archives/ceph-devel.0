From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: simple performance tests
Date: Wed, 16 Jun 2010 12:35:16 +0200
Message-ID: <4C18A8E4.2070109@chaschperli.ch>
References: <hva4nu$2nr$1@dough.gmane.org> <1276681775.2492.3.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trillian.muellerit.ch ([83.169.22.129]:49359 "EHLO
	trillian.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab0FPKnh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jun 2010 06:43:37 -0400
In-Reply-To: <1276681775.2492.3.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@pcextreme.nl>
Cc: ceph-devel@vger.kernel.org

On 16.06.2010 11:49, Wido den Hollander wrote:
> Hi,
>
> You were running all the Ceph components on the same host? E.g, mon, mds
> and osd on the same machine?

yes, all on one.



>
> Imho that is not the way to test Ceph.

of course this is not the inteded use uf ceph. i wanted to know the 
performance penalty between local access and access with ceph. didn't 
expect it to be that large (it's also huge with samba - so not a ceph 
specific "problem").

i'll do more testing in the next weeks in a more ceph-apropriate 
envirnoment. maybe also comparing to glusterfs.

>
> I've done some benchmarking myself with 6 physical machines for OSD's
> (different hw in each machine) and i was seeing about 30 ~ 40MB/sec over
> a Gigabit network.

what was the workload involved with your benchmarking? if these are 
large writes or reads then 30-40mb/s are IMHO not what i would expect of 
6xGigE (6x80MB/s). I would expect the GigE port of the client to be the 
bottleneck.


> Try benchmarking Ceph against NFS and you will start seeing different
> results.
>

thats why i've included samba in the mix. i wanted nfs but it crashed 
the machine (heard about nfs problems in 2.6.32). samba wins all the 
"competitions" in samba vs. ceph.

- Thomas
