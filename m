From: Wido den Hollander <wido@42on.com>
Subject: Re: rbd ThreadPool threads number
Date: Thu, 13 Oct 2016 10:19:21 +0200 (CEST)
Message-ID: <815131890.6020.1476346761763@ox.pcextreme.nl>
References: <CAKT23OLRRLsy=fFJOpC3vqKM1zy0dCLy1nm9zpLov2yqvqb=cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:60098 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbcJMIT1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 04:19:27 -0400
In-Reply-To: <CAKT23OLRRLsy=fFJOpC3vqKM1zy0dCLy1nm9zpLov2yqvqb=cA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tao changtao <changtao381@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>


> Op 13 oktober 2016 om 8:56 schreef tao changtao <changtao381@gmail.com>:
> 
> 
> Hi All，
> 
> why the rbd ThreadPool  threads number are set 1 by hard code ?
> 

See this PR: https://github.com/ceph/ceph/commit/6c0ab75bceeff3239959f55b070a44fcb8dd6e23

And this issue: http://tracker.ceph.com/issues/15034

Wido

> 
> class ThreadPoolSingleton : public ThreadPool {
> public:
>   explicit ThreadPoolSingleton(CephContext *cct)
>     : ThreadPool(cct, "librbd::thread_pool", "tp_librbd", 1,
>                  "rbd_op_threads") {
>     start();
>   }
>   virtual ~ThreadPoolSingleton() {
>     stop();
>   }
> };
> 
> ________________________________
> changtao381@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
