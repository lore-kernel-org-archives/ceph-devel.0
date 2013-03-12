From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: Comments on Ceph.com's blog article 'Ceph's New Monitor Changes'
Date: Tue, 12 Mar 2013 10:54:05 -0700
Message-ID: <513F6BBD.9060309@inktank.com>
References: <513DC833.9090806@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:56654 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235Ab3CLRyI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 13:54:08 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so104975pbc.17
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 10:54:08 -0700 (PDT)
In-Reply-To: <513DC833.9090806@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It seems to me that the surviving OSDs still remember all of
the osdmap and pgmap history back to "last epoch started"
for all of their PGs.  Isn't this enough to enable reconstruction
of all of the pgmaps and osdmaps required to find any copy of
currently stored object?

My history has given me biases, but I prefer reconstruction over
snapshots because:

  (a) it enables recovery from more catastrophic incidents
      (e.g. a bug has corrupted all of the monitor stores
      or a fire has reduced all monitor nodes to slag)

  (b) it is less likely to result in inconsistencies involving
      object updates after the last snapshot

  (c) the ability to reconstruct is a superset of the ability
      to audit, so we get consistency audits for free


>> It tends to be a common source of discomfort among potential Ceph
>> users that if their mons ever become unrecoverable, it's almost
>> impossible to recover your data (compare to GlusterFS, where you can
>> always pull data out of Gluster bricks unharmed, at least as long as
>> you don't use striping volumes). With a file backed mon store, I had
>> hoped that eventually this might tie into btrfs snapshots such that
>> you would have been able to roll back to a known good configuration
>> in an emergency. With the switch to leveldb, I no longer foresee that
>> ever happening. Mind sharing your thoughts on that?
