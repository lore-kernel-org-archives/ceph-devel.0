From: Sage Weil <sage@newdream.net>
Subject: Re: Store test BluestoreStatFSTest failure
Date: Fri, 2 Sep 2016 14:17:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609021417050.31624@piezo.us.to>
References: <CY1PR0201MB1820E737B99E2655DC28620085E50@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45739 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbcIBORz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Sep 2016 10:17:55 -0400
In-Reply-To: <CY1PR0201MB1820E737B99E2655DC28620085E50@CY1PR0201MB1820.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 2 Sep 2016, Ramesh Chander wrote:
> I am trying to run ceph_test_objectstore with my changes and I see this 
> intermittent failure.
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
> I traced call and looks like there is really a 1MB allocation from 
> BlueFS: _flush_range function.
> 
> Is it possible that when we write an object BlueFS also allocated 
> another 1MB block and causing this difference?
> 
> How to avoid this failure? Is it test case issue ?

We merged a PR a day or two ago that disabled the allocated checks in the 
unit test.  If you rebase on master this should go away!

sage
