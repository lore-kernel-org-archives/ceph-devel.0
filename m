From: Owen Synge <osynge@suse.com>
Subject: Re: questions about erasure coded pool and rados
Date: Fri, 17 Oct 2014 12:16:13 +0200
Message-ID: <5440EC6D.9060501@suse.com>
References: <CAPaK2r_B8TjUo63P3d-XOOQzdvz_bUhpgPHw9TXLngms4=4c9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:59870 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbaJQKQy (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 17 Oct 2014 06:16:54 -0400
In-Reply-To: <CAPaK2r_B8TjUo63P3d-XOOQzdvz_bUhpgPHw9TXLngms4=4c9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yue longguang <yuelongguang@gmail.com>, ceph-devel@vger.kernel.org

An erasure encoded pool cannot be accessed directly using rbd. For this
reason we need a cache pool and an erasure pool. This not only allows
supporting rbd but increases performance.


http://karan-mj.blogspot.de/2014/04/erasure-coding-in-ceph.html
http://docs.ceph.com/docs/master/rados/operations/pools/
http://ceph.com/docs/master/rados/operations/cache-tiering/

Good luck

Owen

On 10/17/2014 12:13 PM, yue longguang wrote:
> 1. why erasure coded pool does not work with rbd?
> 2. i used rados command to put a file into erasue coded pool,then rm
> it. why the file remains on osd's backend fs all the time?
> 3. what is the best use case with erasure coded pool?
> 
> 4. command of 'rados ls' is to list objects, where are the object-name stored?
> 5.when a rbd file is put on erasure coded pool, where is the
> infomation(rbd name) of the rbd stored?
> 
> thanks
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
