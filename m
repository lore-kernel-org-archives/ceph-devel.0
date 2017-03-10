From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: rbd-nbd 2T limit
Date: Fri, 10 Mar 2017 09:53:59 +0200
Message-ID: <20170310075358.GB24654@gmail.com>
References: <CAJDfisnEsBkYUXkVMnGPy9vu6DWYC3PZHFW7jOYm5bc_Dv-56w@mail.gmail.com>
 <975af97d-849e-6e65-d617-e0dc16672da4@kirneh.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35262 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755062AbdCJHyI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Mar 2017 02:54:08 -0500
Received: by mail-lf0-f67.google.com with SMTP id v2so6247625lfi.2
        for <ceph-devel@vger.kernel.org>; Thu, 09 Mar 2017 23:54:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <975af97d-849e-6e65-d617-e0dc16672da4@kirneh.eu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henrik Korkuc <lists@kirneh.eu>
Cc: Max Yehorov <myehorov@skytap.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 09, 2017 at 09:14:53AM +0200, Henrik Korkuc wrote:
> On 17-03-09 05:38, Max Yehorov wrote:
> >I was reading through release notes for 10.2.6 and there was a ticket
> >
> >rbd: rbd-nbd: disallow mapping images >2TB in size (issue#17219,
> >pr#11870, Mykola Golub)
> >
> >default nbd block size is 1k, valid values are from 512 to PAGE_SIZE
> >
> >rbd_nbd.cc sets blocksize to 512 here:
> >https://github.com/ceph/ceph/blob/master/src/tools/rbd_nbd/rbd-nbd.cc#L635
> >
> >Why 512 was chosen for rbd_nbd?
> >krbd also uses 512 sector size. Is there a reason to use 512 block
> >size vs 4k AF?
> I am also interested in >2TB NBD support and was disapointed when I couldn't
> mount 10TB images.
> 
> Based on issue in that commit for me it seems to be clear why it was done -
> some (most?) kernels in the wild do not support larger sizes. But it looks
> like support on unaffected kernels is already in master (not sure if it got
> backported to current releases). For reference:
> http://tracker.ceph.com/issues/17219 ->
> https://github.com/ceph/ceph/pull/11741 ->
> http://tracker.ceph.com/issues/18335 ->
> https://github.com/ceph/ceph/pull/13229

Yes, it removes the restriction for working kernels. It is going to be
backported to kraken and jewel:

http://tracker.ceph.com/issues/18910
http://tracker.ceph.com/issues/18911

-- 
Mykola Golub
