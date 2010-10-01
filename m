From: Sage Weil <sage@newdream.net>
Subject: Re: multi-mds crash: In function 'void MDCache::adjust_subtree_auth(CDir*,
 std::pair<int, int>, bool)
Date: Fri, 1 Oct 2010 12:56:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010011255370.25313@cobra.newdream.net>
References: <i82me6$4a8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57352 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0JATyV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Oct 2010 15:54:21 -0400
In-Reply-To: <i82me6$4a8$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

On Thu, 30 Sep 2010, Thomas Mueller wrote:

> hi 
> 
> updated to new git/unstable. mds0 crashed on bonnie++.
> 
> rev: 0e67718a365b42969e785f544ea3b4258bb2407f

Pushed a fix for this.  The cross-mds rename code didn't updated to match 
some other changes made in the spring.  Fixed in
commit:e87f751b3dc703f13e7580a24df49fbff1359536

Thanks!
sage


> 
> - Thomas
> 
> 
> 2010-09-30 20:50:37.349983 7f7ac0f83710 mds0.server  dest #1/pdj-fstest/fstest_dee6a1bf32b15e529c858789b95da80d/fstest_39eb4dd94c47707f5e10d6fcce034889/fstest_f0b645c62a70749289ae2636d07bbe50
> 2010-09-30 20:50:37.349999 7f7ac0f83710 mds0.cache traverse: opening base ino 1 snap head
> 2010-09-30 20:50:37.350011 7f7ac0f83710 mds0.cache traverse: path seg depth 0 'pdj-fstest' snapid head
> 2010-09-30 20:50:37.350022 7f7ac0f83710 mds0.cache.dir(1) lookup (head, 'pdj-fstest')
> 2010-09-30 20:50:37.350034 7f7ac0f83710 mds0.cache.dir(1)   hit -> (pdj-fstest,head)
> 2010-09-30 20:50:37.350045 7f7ac0f83710 mds0.cache traverse: path seg depth 1 'fstest_dee6a1bf32b15e529c858789b95da80d' snapid head
> 2010-09-30 20:50:37.350057 7f7ac0f83710 mds0.cache.dir(10000004007) lookup (head, 'fstest_dee6a1bf32b15e529c858789b95da80d')
> 2010-09-30 20:50:37.350068 7f7ac0f83710 mds0.cache.dir(10000004007)   hit -> (fstest_dee6a1bf32b15e529c858789b95da80d,head)
> 2010-09-30 20:50:37.350079 7f7ac0f83710 mds0.cache traverse: path seg depth 2 'fstest_39eb4dd94c47707f5e10d6fcce034889' snapid head
> 2010-09-30 20:50:37.350090 7f7ac0f83710 mds0.cache.dir(10000004197) lookup (head, 'fstest_39eb4dd94c47707f5e10d6fcce034889')
> 2010-09-30 20:50:37.350101 7f7ac0f83710 mds0.cache.dir(10000004197)   hit -> (fstest_39eb4dd94c47707f5e10d6fcce034889,head)
> 2010-09-30 20:50:37.350112 7f7ac0f83710 mds0.cache traverse: path seg depth 3 'fstest_f0b645c62a70749289ae2636d07bbe50' snapid head
> 2010-09-30 20:50:37.350124 7f7ac0f83710 mds0.cache.dir(10000004198) lookup (head, 'fstest_f0b645c62a70749289ae2636d07bbe50')
> 2010-09-30 20:50:37.350134 7f7ac0f83710 mds0.cache.dir(10000004198)   hit -> (fstest_f0b645c62a70749289ae2636d07bbe50,head)
> 2010-09-30 20:50:37.350146 7f7ac0f83710 mds0.cache path_traverse finish on snapid head
> 2010-09-30 20:50:37.350158 7f7ac0f83710 mds0.server  destdn [dentry #1/pdj-fstest/fstest_dee6a1bf32b15e529c858789b95da80d/fstest_39eb4dd94c47707f5e10d6fcce034889/fstest_f0b645c62a70749289ae2636d07bbe50 [2,head] rep@2,-2.1 (dn lock) (dversion lock) v=85 inode=0x2637ae0 0x71cc2d0]
> 2010-09-30 20:50:37.350176 7f7ac0f83710 mds0.server  src #1/pdj-fstest/fstest_dee6a1bf32b15e529c858789b95da80d/fstest_0f57639c4e31382d35f7d80cbf5c01e6/fstest_3ba1f332cdbc0043df8a732dca0de7bd
> 2010-09-30 20:50:37.350188 7f7ac0f83710 mds0.cache traverse: opening base ino 1 snap head
> 2010-09-30 20:50:37.350198 7f7ac0f83710 mds0.cache traverse: path seg depth 0 'pdj-fstest' snapid head
> 2010-09-30 20:50:37.350209 7f7ac0f83710 mds0.cache.dir(1) lookup (head, 'pdj-fstest')
> 2010-09-30 20:50:37.350220 7f7ac0f83710 mds0.cache.dir(1)   hit -> (pdj-fstest,head)
> 2010-09-30 20:50:37.350231 7f7ac0f83710 mds0.cache traverse: path seg depth 1 'fstest_dee6a1bf32b15e529c858789b95da80d' snapid head
> 2010-09-30 20:50:37.350241 7f7ac0f83710 mds0.cache.dir(10000004007) lookup (head, 'fstest_dee6a1bf32b15e529c858789b95da80d')
> 2010-09-30 20:50:37.350253 7f7ac0f83710 mds0.cache.dir(10000004007)   hit -> (fstest_dee6a1bf32b15e529c858789b95da80d,head)
> 2010-09-30 20:50:37.350263 7f7ac0f83710 mds0.cache traverse: path seg depth 2 'fstest_0f57639c4e31382d35f7d80cbf5c01e6' snapid head
> 2010-09-30 20:50:37.350274 7f7ac0f83710 mds0.cache.dir(10000004197) lookup (head, 'fstest_0f57639c4e31382d35f7d80cbf5c01e6')
> 2010-09-30 20:50:37.350285 7f7ac0f83710 mds0.cache.dir(10000004197)   hit -> (fstest_0f57639c4e31382d35f7d80cbf5c01e6,head)
> 2010-09-30 20:50:37.350296 7f7ac0f83710 mds0.cache traverse: path seg depth 3 'fstest_3ba1f332cdbc0043df8a732dca0de7bd' snapid head
> 2010-09-30 20:50:37.350306 7f7ac0f83710 mds0.cache.dir(10000004199) lookup (head, 'fstest_3ba1f332cdbc0043df8a732dca0de7bd')
> 2010-09-30 20:50:37.350317 7f7ac0f83710 mds0.cache.dir(10000004199)   hit -> (fstest_3ba1f332cdbc0043df8a732dca0de7bd,head)
> 2010-09-30 20:50:37.350329 7f7ac0f83710 mds0.cache path_traverse finish on snapid head
> 2010-09-30 20:50:37.350340 7f7ac0f83710 mds0.server  srcdn [dentry #1/pdj-fstest/fstest_dee6a1bf32b15e529c858789b95da80d/fstest_0f57639c4e31382d35f7d80cbf5c01e6/fstest_3ba1f332cdbc0043df8a732dca0de7bd [2,head] rep@2,-2.1 (dn lock) (dversion lock) v=89 inode=0x26560a0 0x71c3910]
> 2010-09-30 20:50:37.350371 7f7ac0f83710 mds0.cache add_replica_inode added [inode 602 [...2,head] #602/ rep@-2.1 v1 f() n() (inest lock) (ifile lock) (iversion lock) 0x2636a20]
> 2010-09-30 20:50:37.350389 7f7ac0f83710 mds0.cache strayin [inode 602 [...2,head] #602/ rep@-2.1 v1 f() n() (inest lock) (ifile lock) (iversion lock) 0x2636a20]
> 2010-09-30 20:50:37.350438 7f7ac0f83710 mds0.cache adjust_subtree_auth -1,-2 -> 2,-2 on [dir 602 #602/ [2,head] rep@-2.1 state=0 f() n() hs=0+0,ss=0+0 0x9fff0d0]
> 2010-09-30 20:50:37.350454 7f7ac0f83710 mds0.cache show_subtrees
> 2010-09-30 20:50:37.350471 7f7ac0f83710 mds0.cache |_.__ 0    auth [dir 1 / [2,head] auth{1=2,2=2} v=4521 cv=653/653 REP dir_auth=0 state=1610612738|complete f(v0 m2010-09-30 20:48:31.288385 3=0+3) n(v538 rc2010-09-30 20:50:36.629117 15478=15471+7) hs=3+8,ss=0+0 dirty=3 | child subtree replicated dirty 0x1ef5000]
> 2010-09-30 20:50:37.350493 7f7ac0f83710 mds0.cache | |__ 2     rep [dir 10000004007 /pdj-fstest/ [2,head] rep@2.1 dir_auth=2 state=0 f(v0 m2010-09-30 20:50:34.678949 1=0+1) n(v22 rc2010-09-30 20:50:36.659797 5=2+3)/n(v22 rc2010-09-30 20:50:36.629117 4=1+3) hs=1+5,ss=0+0 | child subtree 0x1ef8080]
> 2010-09-30 20:50:37.350514 7f7ac0f83710 mds0.cache | |__ 1     rep [dir 10000000002 /bonnie-1/ [2,head] rep@1.1 dir_auth=1 state=0 f(v0 m2010-09-30 20:19:32.173041 1=0+1) n(v333 rc2010-09-30 20:48:35.281655 15471=15470+1) hs=1+0,ss=0+0 | child subtree 0x1ef6840]
> 2010-09-30 20:50:37.350534 7f7ac0f83710 mds0.cache |____ 0    auth [dir 100 ~mds0/ [2,head] auth v=2490 cv=14/14 dir_auth=0 state=1610612738|complete f(v0 2=1+1) n(v30 rc2010-09-30 20:50:36.608644 b317719418 1028=773+255) hs=2+0,ss=0+0 dirty=1 | child subtree dirty 0x1ef5c20]
> 2010-09-30 20:50:37.350553 7f7ac0f83710 mds0.cache |____ 1     rep [dir 101 ~mds1/ [2,head] rep@1.303 dir_auth=1 state=0 f(v0 2=1+1) n(v301 rc2010-09-30 20:48:35.281655 305=304+1)/n(v301 rc2010-09-30 20:48:30.292270 304=303+1) hs=1+0,ss=0+0 | child subtree 0x1ef7460]
> mds/MDCache.cc: In function 'void MDCache::adjust_subtree_auth(CDir*, std::pair<int, int>, bool)':
> mds/MDCache.cc:644: FAILED assert(root)
>  ceph version 0.22~rc (0e67718a365b42969e785f544ea3b4258bb2407f)
>  1: (MDCache::add_replica_dir(ceph::buffer::list::iterator&, CInode*, int, std::list<Context*, std::allocator<Context*> >&)+0x1c1) [0x536a91]
>  2: (MDCache::add_replica_stray(ceph::buffer::list&, int)+0xdb) [0x536fab]
>  3: (Server::handle_slave_rename_prep(MDRequest*)+0x1113) [0x4d5c33]
>  4: (Server::dispatch_slave_request(MDRequest*)+0x21b) [0x4de80b]
>  5: (Server::handle_slave_request(MMDSSlaveRequest*)+0x145) [0x4e1955]
>  6: (MDS::_dispatch(Message*)+0x2598) [0x49e038]
>  7: (MDS::ms_dispatch(Message*)+0x5b) [0x49e1ab]
>  8: (SimpleMessenger::dispatch_entry()+0x67a) [0x483f9a]
>  9: (SimpleMessenger::DispatchThread::entry()+0x4d) [0x47a4ed]
>  10: (Thread::_entry_func(void*)+0x7) [0x48dd17]
>  11: (()+0x68ba) [0x7f7ac36d48ba]
>  12: (clone()+0x6d) [0x7f7ac268802d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
