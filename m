From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: [Ceph-community] Getting WARN in __kick_osd_requests doing stress testing
Date: Fri, 18 Sep 2015 12:18:44 +0530
Message-ID: <CAEw75dM7D0kaBV9rt+wKvv3xqwT+KNDPRiu8rs_ZX8cd4KKRDg@mail.gmail.com>
References: <20150917153314.73c74430a203f93b40249fa0fa5c8853.dffc7cf164.wbe@email11.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38770 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbbIRGsp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Sep 2015 02:48:45 -0400
Received: by igxx6 with SMTP id x6so11332380igx.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Sep 2015 23:48:45 -0700 (PDT)
In-Reply-To: <20150917153314.73c74430a203f93b40249fa0fa5c8853.dffc7cf164.wbe@email11.secureserver.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bart.bartel@osnexus.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Redirecting to ceph-devel, where such a question might have a better
chance of a reply.

On Fri, Sep 18, 2015 at 4:03 AM,  <bart.bartel@osnexus.com> wrote:
> I'm running in a 3-node cluster and doing osd/rbd creation and deletion, and
> ran across this WARN
> Note, it only happened once (on one rbd add) after approximately 500 cycles
> of the test, but was wondering if
> someone can explain to me why this warning would be happening, and how I can
> prevent it.
>
> Here is what my test script is doing:
>
> while(1):
>     create 5 ceph pools   - sleep 2 between each pool create
>     sleep 5
>     create 5 ceph volumes - sleep 2 between each pool create
>     sleep 5
>     delete 5 ceph volumes - sleep 2 between each pool create
>     sleep 5
>     delete 5 ceph pools   - sleep 2 between each pool create
>     sleep 5
>
>
> 333940 Sep 17 00:31:54 10.0.41.9 [18372.272771] Call Trace:
> 333941 Sep 17 00:31:54 10.0.41.9 [18372.273489]  [<ffffffff817d8d3e>]
> dump_stack+0x45/0x57
> 333942 Sep 17 00:31:54 10.0.41.9 [18372.274226]  [<ffffffff81078067>]
> warn_slowpath_common+0x97/0xe0
> 333943 Sep 17 00:31:54 10.0.41.9 [18372.274923]  [<ffffffff810780ca>]
> warn_slowpath_null+0x1a/0x20
> 333944 Sep 17 00:31:54 10.0.41.9 [18372.275635]  [<ffffffffc0f60eec>]
> __kick_osd_requests+0x1dc/0x240 [libceph]
> 333945 Sep 17 00:31:54 10.0.41.9 [18372.276305]  [<ffffffffc0f60fa7>]
> osd_reset+0x57/0xa0 [libceph]
> 333946 Sep 17 00:31:54 10.0.41.9 [18372.276962]  [<ffffffffc0f59162>]
> con_work+0x112/0x290 [libceph]
> 333947 Sep 17 00:31:54 10.0.41.9 [18372.277608]  [<ffffffff810909c4>]
> process_one_work+0x144/0x470
> 333948 Sep 17 00:31:54 10.0.41.9 [18372.278247]  [<ffffffff8109140e>]
> worker_thread+0x11e/0x450
> 333949 Sep 17 00:31:54 10.0.41.9 [18372.278880]  [<ffffffff810912f0>] ?
> create_worker+0x1f0/0x1f0
> 333950 Sep 17 00:31:54 10.0.41.9 [18372.279543]  [<ffffffff81097179>]
> kthread+0xc9/0xe0
> 333951 Sep 17 00:31:54 10.0.41.9 [18372.280174]  [<ffffffff810970b0>] ?
> flush_kthread_worker+0x90/0x90
> 333952 Sep 17 00:31:54 10.0.41.9 [18372.280803]  [<ffffffff817e5998>]
> ret_from_fork+0x58/0x90
> 333953 Sep 17 00:31:54 10.0.41.9 [18372.281430]  [<ffffffff810970b0>] ?
> flush_kthread_worker+0x90/0x90
>
> static void __kick_osd_requests(struct ceph_osd_client *osdc,
>                                 struct ceph_osd *osd)
> {
>      :
>         list_for_each_entry_safe(req, nreq, &osd->o_linger_requests,
>                                  r_linger_osd_item) {
>                 WARN_ON(!list_empty(&req->r_req_lru_item));
>                 __kick_linger_request(req);
>         }
>     :
> }
>
> - Bart
>
>
> _______________________________________________
> Ceph-community mailing list
> Ceph-community@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-community-ceph.com
>
