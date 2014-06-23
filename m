From: "Shu, Xinxin" <xinxin.shu@intel.com>
Subject: RE: [RFC] add rocksdb support
Date: Mon, 23 Jun 2014 01:18:24 +0000
Message-ID: <75674D092A819E4189E91166C74CB90D013D657C@shsmsx102.ccr.corp.intel.com>
References: <75674D092A819E4189E91166C74CB90D0131CB27@SHSMSX104.ccr.corp.intel.com>
 <alpine.DEB.2.00.1405201814330.1689@cobra.newdream.net>
 <75674D092A819E4189E91166C74CB90D013BEDED@shsmsx102.ccr.corp.intel.com>
 <537CA4BA.4000900@inktank.com>
 <75674D092A819E4189E91166C74CB90D013C094D@shsmsx102.ccr.corp.intel.com>
 <5395EAD1.9000501@inktank.com>
 <75674D092A819E4189E91166C74CB90D013C3C13@shsmsx102.ccr.corp.intel.com>
 <B9FF37F8E2D7894A9493A5314D0816FC22609DCA@SACMBXIP01.sdcorp.global.sandisk.com>
 <75674D092A819E4189E91166C74CB90D013D3C3F@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33693 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbaFWBS2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Jun 2014 21:18:28 -0400
In-Reply-To: <75674D092A819E4189E91166C74CB90D013D3C3F@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Sushma Gurram' <Sushma.Gurram@sandisk.com>, 'Mark Nelson' <mark.nelson@inktank.com>, 'Sage Weil' <sage@inktank.com>
Cc: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>, "Zhang, Jian" <jian.zhang@intel.com>


Hi all,

 We enabled rocksdb as data store in our test setup (10 osds on two servers, each server has 5 HDDs as osd , 2 ssds as journal , Intel(R) Xeon(R) CPU E31280)  and have performance tests for xfs, leveldb and rocksdb (use rados bench as our test tool),  the following chart shows details, for write ,  with small number threads , leveldb performance is lower than the other two backends , from 16 threads point ,  rocksdb perform a little better than xfs and leveldb , leveldb and rocksdb perform much better than xfs with higher thread number.

	                                          xfs		  leveldb		rocksdb	
	                  throughtput	latency	    throughtput	latency	   throughtput	latency
1 thread write	     84.029	  0.048	            52.430	   0.076	      71.920	0.056
2 threads write	     166.417	  0.048	            97.917	   0.082	     155.148	0.052
4 threads write	      304.099	  0.052	            156.094	    0.102	     270.461	0.059
8 threads write	      323.047	  0.099	            221.370	    0.144	     339.455	0.094
16 threads write     295.040	  0.216	            272.032	    0.235       348.849	0.183
32 threads write     324.467	  0.394	            290.072	     0.441	     338.103	0.378
64 threads write     313.713	  0.812	            293.261	     0.871     324.603	0.787
1 thread read	      75.687	  0.053	             71.629	     0.056      72.526	0.055
2 threads read	      182.329	  0.044	            151.683	      0.053     153.125	0.052
4 threads read	      320.785	  0.050	            307.180	      0.052      312.016	0.051
8 threads read	       504.880	  0.063	            512.295	      0.062      519.683	0.062
16 threads read       477.706	  0.134	            643.385	      0.099      654.149	0.098
32 threads read       517.670	  0.247	             666.696          0.192      678.480	0.189
64 threads read       516.599	  0.495	             668.360	       0.383      680.673	0.376

-----Original Message-----
From: Shu, Xinxin 
Sent: Saturday, June 14, 2014 11:50 AM
To: Sushma Gurram; Mark Nelson; Sage Weil
Cc: ceph-devel@vger.kernel.org; Zhang, Jian
Subject: RE: [RFC] add rocksdb support

Currently ceph will get stable rocksdb from branch 3.0.fb of  ceph/rocksdb  , since PR https://github.com/ceph/rocksdb/pull/2 has not been merged ,  so if you use 'git submodule update --init' to get rocksdb submodule , It did not support autoconf/automake .  

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sushma Gurram
Sent: Saturday, June 14, 2014 2:52 AM
To: Shu, Xinxin; Mark Nelson; Sage Weil
Cc: ceph-devel@vger.kernel.org; Zhang, Jian
Subject: RE: [RFC] add rocksdb support

Hi Xinxin,

I tried to compile the wip-rocksdb branch, but the src/rocksdb directory seems to be empty. Do I need toput autoconf/automake in this directory?
It doesn't seem to have any other source files and compilation fails:
os/RocksDBStore.cc:10:24: fatal error: rocksdb/db.h: No such file or directory compilation terminated.

Thanks,
Sushma

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Shu, Xinxin
Sent: Monday, June 09, 2014 10:00 PM
To: Mark Nelson; Sage Weil
Cc: ceph-devel@vger.kernel.org; Zhang, Jian
Subject: RE: [RFC] add rocksdb support

Hi mark

I have finished development of support of rocksdb submodule,  a pull request for support of autoconf/automake for rocksdb has been created , you can find https://github.com/ceph/rocksdb/pull/2 , if this patch is ok ,  I will create a pull request for rocksdb submodule support , currently this patch can be found https://github.com/xinxinsh/ceph/tree/wip-rocksdb .

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
Sent: Tuesday, June 10, 2014 1:12 AM
To: Shu, Xinxin; Sage Weil
Cc: ceph-devel@vger.kernel.org; Zhang, Jian
Subject: Re: [RFC] add rocksdb support

Hi Xinxin,

On 05/28/2014 05:05 AM, Shu, Xinxin wrote:
> Hi sage ,
> I will add two configure options to --with-librocksdb-static and --with-librocksdb , with --with-librocksdb-static option , ceph will compile the code that get from ceph repository , with  --with-librocksdb option ,  in case of distro packages for rocksdb , ceph will not compile the rocksdb code , will use pre-installed library. is that ok for you ?
>
> since current rocksdb does not support autoconf&automake , I will add autoconf&automake support for rocksdb , but before that , i think we should fork a stable branch (maybe 3.0) for ceph .

I'm looking at testing out the rocksdb support as well, both for the OSD and for the monitor based on some issues we've been seeing lately.  Any news on the 3.0 fork and autoconf/automake support in rocksdb?

Thanks,
Mark

>
> -----Original Message-----
> From: Mark Nelson [mailto:mark.nelson@inktank.com]
> Sent: Wednesday, May 21, 2014 9:06 PM
> To: Shu, Xinxin; Sage Weil
> Cc: ceph-devel@vger.kernel.org; Zhang, Jian
> Subject: Re: [RFC] add rocksdb support
>
> On 05/21/2014 07:54 AM, Shu, Xinxin wrote:
>> Hi, sage
>>
>> I will add rocksdb submodule into the makefile , currently we want to have fully performance tests on key-value db backend , both leveldb and rocksdb. Then optimize on rocksdb performance.
>
> I'm definitely interested in any performance tests you do here.  Last winter I started doing some fairly high level tests on raw leveldb/hyperleveldb/raikleveldb.  I'm very interested in what you see with rocksdb as a backend.
>
>>
>> -----Original Message-----
>> From: Sage Weil [mailto:sage@inktank.com]
>> Sent: Wednesday, May 21, 2014 9:19 AM
>> To: Shu, Xinxin
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: [RFC] add rocksdb support
>>
>> Hi Xinxin,
>>
>> I've pushed an updated wip-rocksdb to github/liewegas/ceph.git that includes the latest set of patches with the groundwork and your rocksdb patch.  There is also a commit that adds rocksdb as a git submodule.  I'm thinking that, since there aren't any distro packages for rocksdb at this point, this is going to be the easiest way to make this usable for people.
>>
>> If you can wire the submodule into the makefile, we can merge this in so that rocksdb support is in the ceph.com packages on ceph.com.  I suspect that the distros will prefer to turns this off in favor of separate shared libs, but they can do this at their option if/when they include rocksdb in the distro. I think the key is just to have both --with-librockdb and --with-librocksdb-static (or similar) options so that you can either use the static or dynamically linked one.
>>
>> Has your group done further testing with rocksdb?  Anything interesting to share?
>>
>> Thanks!
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
