From: Florian Haas <florian@hastexo.com>
Subject: Re: [Openstack] Ceph/OpenStack integration on Ubuntu precise:
 horribly broken, or am I doing something wrong?
Date: Fri, 8 Jun 2012 18:11:09 +0200
Message-ID: <CAPUexz9WtA3K8SN=vau1q0BwLW3bP3qU-SMWQt2yktR6_aVSPg@mail.gmail.com>
References: <CAPUexz846keC+6KvFeethXV4xzpke3n_YKU0_oh-YfTCVR1ozw@mail.gmail.com>
	<4FD21ECC.7040906@inktank.com>
	<4FD2217F.8040804@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:39626 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761323Ab2FHQLK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 12:11:10 -0400
Received: by qabj40 with SMTP id j40so1284014qab.1
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 09:11:10 -0700 (PDT)
In-Reply-To: <4FD2217F.8040804@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>
Cc: openstack@lists.launchpad.net, ceph-devel@vger.kernel.org

On Fri, Jun 8, 2012 at 5:59 PM, James Page <james.page@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi Josh
>
> On 08/06/12 16:48, Josh Durgin wrote:
>> There's an Ubuntu bug already:
>>
>> https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/981130
>>
>> librgw was not complete, and wasn't actually used by radosgw, so it
>> was dropped. The Ubuntu package just needs to be updated to remove
>> the dependency and rgw.py, like upstream did.
>
> You can type faster than I can... I'm working on getting this resolved
> in the current dev release of Ubuntu in the next few days after which
> it will go through the normal SRU process for Ubuntu 12.04.

Sweet, thanks!

Cheers,
Florian
