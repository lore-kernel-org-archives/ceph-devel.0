From: Henrik Korkuc <lists@kirneh.eu>
Subject: Re: rbd-nbd 2T limit
Date: Thu, 9 Mar 2017 09:14:53 +0200
Message-ID: <975af97d-849e-6e65-d617-e0dc16672da4@kirneh.eu>
References: <CAJDfisnEsBkYUXkVMnGPy9vu6DWYC3PZHFW7jOYm5bc_Dv-56w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alpha.syseng.pro ([37.48.90.241]:35638 "EHLO alpha.syseng.pro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbdCIHPo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Mar 2017 02:15:44 -0500
In-Reply-To: <CAJDfisnEsBkYUXkVMnGPy9vu6DWYC3PZHFW7jOYm5bc_Dv-56w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Max Yehorov <myehorov@skytap.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 17-03-09 05:38, Max Yehorov wrote:
> I was reading through release notes for 10.2.6 and there was a ticket
>
> rbd: rbd-nbd: disallow mapping images >2TB in size (issue#17219,
> pr#11870, Mykola Golub)
>
> default nbd block size is 1k, valid values are from 512 to PAGE_SIZE
>
> rbd_nbd.cc sets blocksize to 512 here:
> https://github.com/ceph/ceph/blob/master/src/tools/rbd_nbd/rbd-nbd.cc#L635
>
> Why 512 was chosen for rbd_nbd?
> krbd also uses 512 sector size. Is there a reason to use 512 block
> size vs 4k AF?
I am also interested in >2TB NBD support and was disapointed when I 
couldn't mount 10TB images.

Based on issue in that commit for me it seems to be clear why it was 
done - some (most?) kernels in the wild do not support larger sizes. But 
it looks like support on unaffected kernels is already in master (not 
sure if it got backported to current releases). For reference:
http://tracker.ceph.com/issues/17219 -> 
https://github.com/ceph/ceph/pull/11741 -> 
http://tracker.ceph.com/issues/18335 -> 
https://github.com/ceph/ceph/pull/13229


