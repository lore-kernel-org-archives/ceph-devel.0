From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Store test BluestoreStatFSTest failure
Date: Fri, 2 Sep 2016 15:10:57 +0300
Message-ID: <418d7e7b-bc7a-d747-e255-21c7e53940c2@mirantis.com>
References: <CY1PR0201MB1820E737B99E2655DC28620085E50@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33998 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbcIBMLB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Sep 2016 08:11:01 -0400
Received: by mail-qk0-f178.google.com with SMTP id t7so115263096qkh.1
        for <ceph-devel@vger.kernel.org>; Fri, 02 Sep 2016 05:11:00 -0700 (PDT)
In-Reply-To: <CY1PR0201MB1820E737B99E2655DC28620085E50@CY1PR0201MB1820.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Ramesh,

this was fixed recently - please rebase to the latest master.


Thanks,

Igor


On 02.09.2016 14:42, Ramesh Chander wrote:
> I am trying to run ceph_test_objectstore with my changes and I see this intermittent failure.
>
>
> Store_test.cc At line 1187:
>
> 1174     ObjectStore::Transaction t;
> 1175     bufferlist bl;
> 1176     bl.append("abcde");
> 1177     t.write(cid, hoid, 0, 5, bl);
> 1178     cerr << "Append 5 bytes" << std::endl;
> 1179     r = apply_transaction(store, &osr, std::move(t));
> 1180     ASSERT_EQ(r, 0);
> 1181
> 1182     struct store_statfs_t statfs;
> 1183     int r = store->statfs(&statfs);
> 1184     ASSERT_EQ(r, 0);
> 1185     ASSERT_EQ(5, statfs.stored);
> 1186     ASSERT_EQ(0x10000, statfs.allocated);
> 1187     ASSERT_EQ(available0 - 0x10000, statfs.available);
>
> The total allocated are 1MB more than expected by this test.
>
> (gdb) p statfs
> $50 = {total = 10737418240, available = 10722672640, allocated = 65536, stored = 5, compressed = 0, compressed_allocated = 0, compressed_original = 0}
> (gdb) p available0
> $51 = 10723786752
> (gdb) p 10723786752-10722672640
> $52 = 1114112
> (gdb) p 1114112-65536
> $53 = 1048576
> (gdb) p $53 / 1024
> $54 = 1024
> (gdb) list
>
> I traced call and looks like there is really a 1MB allocation from BlueFS: _flush_range function.
>
> Is it possible that when we write an object BlueFS also allocated another 1MB block and causing this difference?
>
> How to avoid this failure? Is it test case issue ?
>
> -Ramesh
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

