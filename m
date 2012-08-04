From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: ceph-0.48: osd hits assertion with rbd benchmark: ENOSPC not
 handled
Date: Fri, 03 Aug 2012 18:14:12 -0700
Message-ID: <501C7764.1010600@inktank.com>
References: <501B79D2.3030106@itxperts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51928 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab2HDBOQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Aug 2012 21:14:16 -0400
Received: by pbbrp8 with SMTP id rp8so2181654pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Aug 2012 18:14:15 -0700 (PDT)
In-Reply-To: <501B79D2.3030106@itxperts.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 08/03/2012 12:12 AM, Andreas Bluemle wrote:
> Hi,
>
> running rados benchmark
>
>     rados -p rbd bench 120 write -t 8
>
> hits end-of-device and forces ceph-osd daemons to die.
>
> Log file output:
>
> 2012-08-02 17:24:42.388250 7f85bb94e700  0 filestore(/data/osd.2)
>   error (28) No space left on device not handled on operation 10
>   (6962.1.0, or op 0, counting from 0)
> 2012-08-02 17:24:42.388275 7f85bb94e700  0 filestore(/data/osd.2)
>   ENOSPC handling not implemented
>
> 2012-08-02 17:24:42.389481 7f85bb94e700 -1 os/FileStore.cc:
>   In function 'unsigned int
> FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t, int)'
>   thread 7f85bb94e700 time 2012-08-02 17:24:42.388353
>   os/FileStore.cc: 2955: FAILED assert(0 == "unexpected error")
>
>
> 2012-08-02 17:24:42.390885 7f85bc14f700  0  -9895> 2012-08-02
> 17:24:40.931547 7f
> 85ba94c700  5 filestore(/data/osd.2)  transaction dump:
> { "ops": [
>         { "op_num": 0,
>           "op_name": "write",
>           "collection": "2.8_head",
>           "oid": "77c18908\/CIBDB1_7638_object8048\/head\/\/2",
>           "length": 4194304,
>           "offset": 0,
>           "bufferlist length": 4194304},
>         { "op_num": 1,
>           "op_name": "setattr",
>           "collection": "2.8_head",
>           "oid": "77c18908\/CIBDB1_7638_object8048\/head\/\/2",
>           "name": "_",
>           "length": 221},
>         { "op_num": 2,
>           "op_name": "setattr",
>           "collection": "2.8_head",
>           "oid": "77c18908\/CIBDB1_7638_object8048\/head\/\/2",
>           "name": "snapset",
>           "length": 31}]}
> --OSD::tracker-- reqid: client.4102.0:7792, seq: 9858,
> time: 2012-08-02 17:24:40.931546, event: sub_op_applied, request:
> osd_sub_op(cli
> ent.4102.0:7792 2.3b 1d0d503b/CIBDB1_7638_object7791/head//2 [] v 6'27
> snapset=0
> =[]:[] snapc=0=[]) v7
>
>
> ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
> 1: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned long,
> int)+0
> x1f50) [0x6ca490]
> 2: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
> std::alloca
> tor<ObjectStore::Transaction*> >&, unsigned long)+0x86) [0x6d0836]
> 3: (FileStore::_do_op(FileStore::OpSequencer*)+0x1e9) [0x699fc9]
> 4: (ThreadPool::worker()+0x543) [0x814a33]
> 5: (ThreadPool::WorkThread::entry()+0xd) [0x60876d]
> 6: (()+0x7f05) [0x7f85c7215f05]
> 7: (clone()+0x6d) [0x7f85c59e810d]
> NOTE: a copy of the executable, or `objdump -rdS <executable>`
> is needed to interpret this.
>
>
> Is this a known issue?

Yes, if your storage is fast enough, you can bypass the thresholds
described here:

http://ceph.com/docs/master/ops/manage/failures/osd/#full-cluster

Usage information is reported by the osds to the monitors
asynchronously. If an osd fills up before the monitors notice
it's full and the new osdmap marking it full is distributed, the osd
will hit that assert.

You can adjust the thresholds with:
ceph pg set_full_ratio 0.95
ceph pg set_nearfull_ratio 0.85

You can force more frequent stats reporting by adjusting the osd config:
osd_mon_report_interval_min (default 5 seconds)
osd_mon_report_interval_max (default 120 seconds)

Josh

> Regards
>
> Andreas Bluemle
>
>
>

