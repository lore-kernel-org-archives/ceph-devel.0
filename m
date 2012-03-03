From: Sage Weil <sage@newdream.net>
Subject: Re: leveldb configure errors
Date: Fri, 2 Mar 2012 16:14:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021614060.1674@cobra.newdream.net>
References: <50C10F7E-5438-463D-864D-8C9CF7AC8030@cs.ucsc.edu>
 <49D1C699-E24E-4A2B-B8BF-60B673552D4B@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45402 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965489Ab2CCAOS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 19:14:18 -0500
In-Reply-To: <49D1C699-E24E-4A2B-B8BF-60B673552D4B@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org

Alternatively,

 git submodule init
 git submodule update

sage

On Fri, 2 Mar 2012, Noah Watkins wrote:

> Solved:
> 
>   git clone --recursive
> 
> -Noah
> 
> On Mar 2, 2012, at 3:24 PM, Noah Watkins wrote:
> 
> > With the latest master the leveldb directory is showing up empty and causing some problems after the clone. Is there an additional step required to get that directory to be populated?
> > 
> > -Noah
> > 
> > $ ./configure
> > ...
> > config.status: executing libtool commands
> > === configuring in src/leveldb (/home/nwatkins/projects/ceph/clean/ceph/src/leveldb)
> > configure: WARNING: no configuration information is in src/leveldb
> > 
> > 
> > 
> > nwatkins@kyoto:~/projects/ceph/clean/ceph$ ls -l src/leveldb/
> > total 0
> > 
> > 
> > 
> > nwatkins@kyoto:~/projects/ceph/clean/ceph$ make
> > Making all in .
> > make[1]: Entering directory `/home/nwatkins/projects/ceph/clean/ceph'
> > make[1]: Nothing to be done for `all-am'.
> > make[1]: Leaving directory `/home/nwatkins/projects/ceph/clean/ceph'
> > Making all in src
> > make[1]: Entering directory `/home/nwatkins/projects/ceph/clean/ceph/src'
> > rm -f init-ceph init-ceph.tmp
> > sed -e 's|@bindir[@]|/usr/local/bin|g' -e 's|@libdir[@]|/usr/local/lib|g' -e 's|@sysconfdir[@]|/usr/local/etc|g' -e 's|@datadir[@]|/usr/local/share/ceph|g' -e 's|@prefix[@]|/usr/local|g' -e 's|@@GCOV_PREFIX_STRIP[@][@]|7|g' './init-ceph.in' >init-ceph.tmp
> > chmod +x init-ceph.tmp
> > chmod a-w init-ceph.tmp
> > mv init-ceph.tmp init-ceph
> > make  all-recursive
> > make[2]: Entering directory `/home/nwatkins/projects/ceph/clean/ceph/src'
> > Making all in ocf
> > make[3]: Entering directory `/home/nwatkins/projects/ceph/clean/ceph/src/ocf'
> > make[3]: Nothing to be done for `all'.
> > make[3]: Leaving directory `/home/nwatkins/projects/ceph/clean/ceph/src/ocf'
> > Making all in leveldb
> > make[3]: Entering directory `/home/nwatkins/projects/ceph/clean/ceph/src/leveldb'
> > make[3]: *** No rule to make target `all'.  Stop.
> > make[3]: Leaving directory `/home/nwatkins/projects/ceph/clean/ceph/src/leveldb'
> > make[2]: *** [all-recursive] Error 1
> > make[2]: Leaving directory `/home/nwatkins/projects/ceph/clean/ceph/src'
> > make[1]: *** [all] Error 2
> > make[1]: Leaving directory `/home/nwatkins/projects/ceph/clean/ceph/src'
> > make: *** [all-recursive] Error 1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
