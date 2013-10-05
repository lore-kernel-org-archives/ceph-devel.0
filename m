From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] v0.67.4 released
Date: Fri, 4 Oct 2013 22:06:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310042206160.12714@cobra.newdream.net>
References: <alpine.DEB.2.00.1310041650540.30223@cobra.newdream.net> <BBD59B71-7495-4018-99C1-7E0E597F9BD0@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34618 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3JEFGx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Oct 2013 01:06:53 -0400
In-Reply-To: <BBD59B71-7495-4018-99C1-7E0E597F9BD0@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Fixed!

(This was actually on master; not part of the dumpling point release.)

Thanks-
sage


On Fri, 4 Oct 2013, David Zafman wrote:

> 
> Unit tests on v0.67.4 not passing.  Could be a test case needs to be fixed.
> 
> $ test/encoding/check-generated.sh
> checking ceph-dencoder generated test instances...
> numgen type
> 3 ACLGrant
> ??.
> 4 ObjectStore::Transaction
> mon/PGMap.cc: In function 'void PGMap::apply_incremental(CephContext*, const PGMap::Incremental&)' thread 7fac10e81780 time 2013-10-04 18:08:59.019448
> mon/PGMap.cc: 226: FAILED assert(inc.get_osd_epochs().find(osd) != inc.get_osd_epochs().end())
>  ceph version 0.69-548-ge927941 (e927941fcadff56483137cffc0899b4ab9c6c297)
>  1: (PGMap::apply_incremental(CephContext*, PGMap::Incremental const&)+0x697) [0x948bc7]
>  2: (PGMap::generate_test_instances(std::list<PGMap*, std::allocator<PGMap*> >&)+0xc3) [0x949433]
>  3: (main()+0xce27) [0x5e48f7]
>  4: (__libc_start_main()+0xed) [0x7fac0ef3176d]
>  5: ./ceph-dencoder() [0x5eb749]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> Aborted
> 
> David Zafman
> Senior Developer
> http://www.inktank.com
> 
> 
> 
> 
> On Oct 4, 2013, at 4:55 PM, Sage Weil <sage@inktank.com> wrote:
> 
> > This point release fixes an important performance issue with radosgw, 
> > keystone authentication token caching, and CORS.  All users (especially 
> > those of rgw) are encouraged to upgrade.
> > 
> > Notable changes:
> > 
> > * crush: fix invalidation of cached names
> > * crushtool: do not crash on non-unique bucket ids
> > * mds: be more careful when decoding LogEvents
> > * mds: fix heap check debugging commands
> > * mon: avoid rebuilding old full osdmaps
> > * mon: fix 'ceph crush move ...'
> > * mon: fix 'ceph osd crush reweight ...'
> > * mon: fix writeout of full osdmaps during trim
> > * mon: limit size of transactions
> > * mon: prevent both unmanaged and pool snaps
> > * osd: disable xattr size limit (prevents upload of large rgw objects)
> > * osd: fix recovery op throttling
> > * osd: fix throttling of log messages for very slow requests
> > * rgw: drain pending requests before completing write
> > * rgw: fix CORS
> > * rgw: fix inefficient list::size() usage
> > * rgw: fix keystone token expiration
> > * rgw: fix minor memory leaks
> > * rgw: fix null termination of buffer
> > 
> > For more detail:
> > 
> > * http://ceph.com/docs/master/release-notes/#v0-67-4-dumpling
> > * http://ceph.com/docs/master/_downloads/v0.67.4.txt
> > 
> > You can get v0.67.4 from the usual locations:
> > 
> > * Git at git://github.com/ceph/ceph.git
> > * Tarball at http://ceph.com/download/ceph-0.67.4.tar.gz
> > * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
> > * For RPMs, see http://ceph.com/docs/master/install/rpm
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
