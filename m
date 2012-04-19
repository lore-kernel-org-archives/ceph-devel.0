From: Martin Mailand <martin@tuxadero.com>
Subject: Re: rbd snapshot in qemu and libvirt
Date: Thu, 19 Apr 2012 14:42:10 +0200
Message-ID: <4F900822.50707@tuxadero.com>
References: <4F8EBCB9.3030803@tuxadero.com> <4F8EBD4E.1050606@widodh.nl> <4F8EC028.40601@tuxadero.com> <CABYiri-7DYgFsSBYSbWVzXxuA_NgzaAN9s9hQ_JXuuZhxzLSaw@mail.gmail.com> <4F8ED5CA.7040006@tuxadero.com> <CABYiri_GOHwpOZ2ZOUU4xTtHDmJFC01f07c2nQZ3yxT9j7m1Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:60246 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab2DSMmU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 08:42:20 -0400
Received: from [172.30.1.184] ([192.166.201.59])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3JCgAMJ013893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 14:42:18 +0200
In-Reply-To: <CABYiri_GOHwpOZ2ZOUU4xTtHDmJFC01f07c2nQZ3yxT9j7m1Rg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,

is it possible to quiesce the disk before a snapshot? Or does it make no 
sense with rbd?
How about the new rbd_cache, does it get flushed before the snapshot?

I would like to use it like this.

virsh snapshot-create --quiesce $DOMAIN

-martin
