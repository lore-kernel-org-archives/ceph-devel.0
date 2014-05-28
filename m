From: "Shu, Xinxin" <xinxin.shu@intel.com>
Subject: RE: [RFC] add rocksdb support
Date: Wed, 28 May 2014 10:05:10 +0000
Message-ID: <75674D092A819E4189E91166C74CB90D013C094D@shsmsx102.ccr.corp.intel.com>
References: <75674D092A819E4189E91166C74CB90D0131CB27@SHSMSX104.ccr.corp.intel.com>
 <alpine.DEB.2.00.1405201814330.1689@cobra.newdream.net>
 <75674D092A819E4189E91166C74CB90D013BEDED@shsmsx102.ccr.corp.intel.com>
 <537CA4BA.4000900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43210 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbaE1KFS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 May 2014 06:05:18 -0400
In-Reply-To: <537CA4BA.4000900@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Zhang, Jian" <jian.zhang@intel.com>

Hi sage ,  
I will add two configure options to --with-librocksdb-static and --with-librocksdb , with --with-librocksdb-static option , ceph will compile the code that get from ceph repository , with  --with-librocksdb option ,  in case of distro packages for rocksdb , ceph will not compile the rocksdb code , will use pre-installed library. is that ok for you ?

since current rocksdb does not support autoconf&automake , I will add autoconf&automake support for rocksdb , but before that , i think we should fork a stable branch (maybe 3.0) for ceph .

-----Original Message-----
From: Mark Nelson [mailto:mark.nelson@inktank.com] 
Sent: Wednesday, May 21, 2014 9:06 PM
To: Shu, Xinxin; Sage Weil
Cc: ceph-devel@vger.kernel.org; Zhang, Jian
Subject: Re: [RFC] add rocksdb support

On 05/21/2014 07:54 AM, Shu, Xinxin wrote:
> Hi, sage
>
> I will add rocksdb submodule into the makefile , currently we want to have fully performance tests on key-value db backend , both leveldb and rocksdb. Then optimize on rocksdb performance.

I'm definitely interested in any performance tests you do here.  Last winter I started doing some fairly high level tests on raw leveldb/hyperleveldb/raikleveldb.  I'm very interested in what you see with rocksdb as a backend.

>
> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com]
> Sent: Wednesday, May 21, 2014 9:19 AM
> To: Shu, Xinxin
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: [RFC] add rocksdb support
>
> Hi Xinxin,
>
> I've pushed an updated wip-rocksdb to github/liewegas/ceph.git that includes the latest set of patches with the groundwork and your rocksdb patch.  There is also a commit that adds rocksdb as a git submodule.  I'm thinking that, since there aren't any distro packages for rocksdb at this point, this is going to be the easiest way to make this usable for people.
>
> If you can wire the submodule into the makefile, we can merge this in so that rocksdb support is in the ceph.com packages on ceph.com.  I suspect that the distros will prefer to turns this off in favor of separate shared libs, but they can do this at their option if/when they include rocksdb in the distro. I think the key is just to have both --with-librockdb and --with-librocksdb-static (or similar) options so that you can either use the static or dynamically linked one.
>
> Has your group done further testing with rocksdb?  Anything interesting to share?
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>

