From: Rutger ter Borg <rutger@terborg.net>
Subject: Re: As with ceph database to store
Date: Wed, 13 Jul 2011 14:46:13 +0200
Message-ID: <ivk42l$6o2$1@dough.gmane.org>
References: <CACR322gm8Zz8ZNTN+ks5GYPod131MnygEzUQtEBJEhO2uxwVDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36997 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab1GMMqZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jul 2011 08:46:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Qgypc-0008Gn-Kf
	for ceph-devel@vger.kernel.org; Wed, 13 Jul 2011 14:46:24 +0200
Received: from 233-250-103-145.static.glaslokaal.nl ([145.103.250.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 14:46:24 +0200
Received: from rutger by 233-250-103-145.static.glaslokaal.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 14:46:24 +0200
In-Reply-To: <CACR322gm8Zz8ZNTN+ks5GYPod131MnygEzUQtEBJEhO2uxwVDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 07/13/2011 12:39 PM, biyan chen wrote:
> Hi everyone, I want to ask next ceph whether can be used as a mass
> sqlite small database of storage?
>
> Ceph direct sharing as the database of storage space is whether
> foreseeable problem?
>
> Thanks! I haven't made specific test!!!!! Was underway


As it happens to be, I have been investigating the same thing in the 
past few days. Sqlite and rados seems to be a very natural combination. 
Sqlite's and rados' architecture seem to provide hooks to make it 
possible. Things to consider / look into:

* where to put the "backend" split, i.e., at the btree or pager level, 
or just implement a rados-sqlite's vfs.
* increase the max #pages in a DB "file" to 48 or 64 bits (otherwise 
it's limited to "just" 140 TB)
* how to improve concurrency (distributed shared-memory, etc.)
* a distributed locking service (chubby-like)

Cheers,

Rutger


