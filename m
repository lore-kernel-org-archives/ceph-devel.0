From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Ceph_objectstore_bench crashed on keyvaluestore bench with ceph
 master branch
Date: Thu, 3 Dec 2015 13:49:21 +0800
Message-ID: <CACJqLybRecT1-g5_xV7MLfywyasy=SFjrTmcMvwT0h5N=wrJrw@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C05619A8E9@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33870 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbbLCFtW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 00:49:22 -0500
Received: by igvg19 with SMTP id g19so6073420igv.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Dec 2015 21:49:22 -0800 (PST)
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C05619A8E9@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

thanks! Fixed in https://github.com/ceph/ceph/pull/6783. plz review

On Thu, Dec 3, 2015 at 3:19 AM, James (Fei) Liu-SSI
<james.liu@ssi.samsung.com> wrote:
> Hi Haomai,
>    I happened to run ceph_objectstore_bench against key value store on master branch. It always crashed at finisher_thread_entry :  assert(!ls_rval.empty());
>
>    It looks like the completion not only has null entry in the finisher queue , but also has none entry in the finisher_queue_rval. I tired and it actually is.
>
>  Could you  mind telling us in which case the NULL entry in finisher queue also has not any entry in finisher_queue_rval?
>
>   Thanks,
>
>
>   Please refer to issue http://tracker.ceph.com/issues/13961
>
>
> Regards,
> James
>
> void *Finisher::finisher_thread_entry()
> {
>   finisher_lock.Lock();
>   ldout(cct, 10) << "finisher_thread start" << dendl;
>
>   utime_t start;
>   while (!finisher_stop) {
>     /// Every time we are woken up, we process the queue until it is empty.
>     while (!finisher_queue.empty()) {
>       if (logger)
>         start = ceph_clock_now(cct);
>       // To reduce lock contention, we swap out the queue to process.
>       // This way other threads can submit new contexts to complete while we are working.
>       vector<Context*> ls;
>       list<pair<Context*,int> > ls_rval;
>       ls.swap(finisher_queue);
>       ls_rval.swap(finisher_queue_rval);
>       finisher_running = true;
>       finisher_lock.Unlock();
>       ldout(cct, 10) << "finisher_thread doing " << ls << dendl;
>          // ldout(cct, 10) <<"...........Finisher thread is calling again over here........" << dendl;
>
>       // Now actually process the contexts.
>       for (vector<Context*>::iterator p = ls.begin();
>            p != ls.end();
>            ++p) {
>         if (*p) {
>           (*p)->complete(0);
>         } else {
>           // When an item is NULL in the finisher_queue, it means
>           // we should instead process an item from finisher_queue_rval,
>           // which has a parameter for complete() other than zero.
>           // This preserves the order while saving some storage.
>           assert(!ls_rval.empty());
>           Context *c = ls_rval.front().first;
>           c->complete(ls_rval.front().second);
>           ls_rval.pop_front();
>         }
>         if (logger) {
>           logger->dec(l_finisher_queue_len);
>           logger->tinc(l_finisher_complete_lat, ceph_clock_now(cct) - start);
>         }
>       }
>       ldout(cct, 10) << "finisher_thread done with " << ls << dendl;
>       ls.clear();
>
>       finisher_lock.Lock();
>       finisher_running = false;
>     }
>     ldout(cct, 10) << "finisher_thread empty" << dendl;
>     finisher_empty_cond.Signal();
>     if (finisher_stop)
>       break;
>
>     ldout(cct, 10) << "finisher_thread sleeping" << dendl;
>     finisher_cond.Wait(finisher_lock);
>   }
>   // If we are exiting, we signal the thread waiting in stop(),
>   // otherwise it would never unblock
>   finisher_empty_cond.Signal();
>
>   ldout(cct, 10) << "finisher_thread stop" << dendl;
>   finisher_stop = false;
>   finisher_lock.Unlock();
>   return 0;
> }
>



-- 
Best Regards,

Wheat
