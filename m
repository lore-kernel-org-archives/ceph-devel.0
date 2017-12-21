From: Jos Collin <jcollin@redhat.com>
Subject: Re: New Defects reported by Coverity Scan for ceph
Date: Thu, 21 Dec 2017 09:04:27 +0530
Message-ID: <81f1da2d-75b4-ab4a-2933-65e3794192a5@redhat.com>
References: <5a3b1452921a0_20dd327328244d2@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:42298 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756330AbdLUDeb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Dec 2017 22:34:31 -0500
Received: by mail-pf0-f171.google.com with SMTP id d23so13442787pfe.9
        for <ceph-devel@vger.kernel.org>; Wed, 20 Dec 2017 19:34:31 -0800 (PST)
Received: from [10.65.193.116] ([125.16.97.119])
        by smtp.gmail.com with ESMTPSA id c73sm37634769pfd.181.2017.12.20.19.34.28
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Dec 2017 19:34:29 -0800 (PST)
In-Reply-To: <5a3b1452921a0_20dd327328244d2@ss1435.mail>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>



On Thursday 21 December 2017 07:24 AM, scan-admin@coverity.com wrote:
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.
> 
> 3 new defect(s) introduced to ceph found with Coverity Scan.
> 11 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.
> 
> New defect(s) Reported-by: Coverity Scan
> Showing 3 of 3 defect(s)
> 
> 
> ** CID 1426746:  Null pointer dereferences  (REVERSE_INULL)
> /home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1270 in MDBalancer::dump_loads(ceph::Formatter *)()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 1426746:  Null pointer dereferences  (REVERSE_INULL)
> /home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1270 in MDBalancer::dump_loads(ceph::Formatter *)()
> 1264
> 1265       f->open_array_section("dirfrags");
> 1266       while (!dfs.empty()) {
> 1267         CDir *dir = dfs.front();
> 1268         dfs.pop_front();
> 1269
>>>>      CID 1426746:  Null pointer dereferences  (REVERSE_INULL)
>>>>      Null-checking "f" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
> 1270         if (f) {
> 1271           f->open_object_section("dir");
> 1272           dir->dump_load(f, now, decayrate);
> 1273           f->close_section();
> 1274         }
> 1275
> 
> ** CID 1426747:  Null pointer dereferences  (FORWARD_NULL)
> /home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1290 in MDBalancer::dump_loads(ceph::Formatter *)()

There is a possibility that `f` might be NULL. But it is not NULL.

Please see:
https://github.com/ceph/ceph/blob/f33ab7e03a13e18c8c883284033d511f1b43df12/src/mds/MDSDaemon.cc#L135

> 
> 
> ________________________________________________________________________________________________________
> *** CID 1426747:  Null pointer dereferences  (FORWARD_NULL)
> /home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1290 in MDBalancer::dump_loads(ceph::Formatter *)()
> 1284     	if (subdir->pop_nested.meta_load() < .001)
> 1285     	  continue;
> 1286     	dfs.push_back(subdir);
> 1287           }
> 1288         }
> 1289       }
>>>>      CID 1426747:  Null pointer dereferences  (FORWARD_NULL)
>>>>      Passing null pointer "f" to "close_section", which dereferences it. (The dereference happens because this is a virtual function call.)
> 1290       f->close_section();  // dirfrags array
> 1291
> 1292       f->open_object_section("mds_load");
> 1293       {
> 1294
> 1295         auto dump_mds_load = [this, f, now](mds_load_t& load) {
> 
> ** CID 1426748:  Uninitialized members  (UNINIT_CTOR)
> /home/brad/working/src/ceph/src/osd/ECBackend.h: 511 in ECBackend::Op::Op()()
