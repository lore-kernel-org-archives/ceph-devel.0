From: Sage Weil <sage@newdream.net>
Subject: Re: multi-mds crash on first file create (git/unstable)
Date: Thu, 30 Sep 2010 10:59:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009301059010.11268@cobra.newdream.net>
References: <i82id5$cuv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54694 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab0I3R5g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Sep 2010 13:57:36 -0400
In-Reply-To: <i82id5$cuv$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Thu, 30 Sep 2010, Thomas Mueller wrote:
> hi
> 
> now on git/unstable - no more git/master.
> 
> started with vstart.sh and
> 
> export CEPH_NUM_MON=1
> export CEPH_NUM_OSD=1
> export CEPH_NUM_MDS=3
> 
> 
> right after first file creation (mktemp 
> /<pathto>/testspace/ceph_basiccheck_testspace.XXXX) the mds0
> crashed and the kclient hangs now.
> 
> do i need the 2.6.36rc kclient to work with multi-mds testing?

No need.  It was a bad assert I introduced a few days ago.  Reverted for 
now, and will audit this code later.  The fix is pushed to unstable.

Thanks!
sage



> 
> rev: 7657a6d5b30dd181350acf19681847d9c8f5d694
> 
> - Thomas
> 
> 2010-09-30 19:37:44.538704 7f7802dea710 mds0.locker eval done
> 2010-09-30 19:37:44.538715 7f7802dea710 mds0.server dispatch_client_request client_request(client4106:27 create #1/ceph_basiccheck_testspace.VArD)
> 2010-09-30 19:37:44.538733 7f7802dea710 mds0.server open w/ O_CREAT on #1/ceph_basiccheck_testspace.VArD
> 2010-09-30 19:37:44.538746 7f7802dea710 mds0.server rdlock_path_xlock_dentry request(client4106:27 cr=0x29e7b40) #1/ceph_basiccheck_testspace.VArD
> 2010-09-30 19:37:44.538758 7f7802dea710 mds0.server traverse_to_auth_dir dirpath #1 dname ceph_basiccheck_testspace.VArD
> 2010-09-30 19:37:44.538769 7f7802dea710 mds0.cache traverse: opening base ino 1 snap head
> 2010-09-30 19:37:44.538781 7f7802dea710 mds0.cache path_traverse finish on snapid head
> 2010-09-30 19:37:44.538792 7f7802dea710 mds0.server traverse_to_auth_dir [dir 1 / [2,head] auth{1=2,2=1} v=1 cv=1/1 REP dir_auth=0 state=1073741826|complete f(v0 1=0+1) n(v0 1=0+1) hs=1+6,ss=0+0 | child subtree replicated 0x29fd000]
> 2010-09-30 19:37:44.538808 7f7802dea710 mds0.server rdlock_path_xlock_dentry dir [dir 1 / [2,head] auth{1=2,2=1} v=1 cv=1/1 REP dir_auth=0 state=1073741826|complete f(v0 1=0+1) n(v0 1=0+1) hs=1+6,ss=0+0 | child subtree replicated 0x29fd000]
> 2010-09-30 19:37:44.538823 7f7802dea710 mds0.server prepare_null_dentry ceph_basiccheck_testspace.VArD in [dir 1 / [2,head] auth{1=2,2=1} v=1 cv=1/1 REP dir_auth=0 state=1073741826|complete f(v0 1=0+1) n(v0 1=0+1) hs=1+6,ss=0+0 | child subtree replicated 0x29fd000]
> 2010-09-30 19:37:44.538839 7f7802dea710 mds0.cache.dir(1) lookup (head, 'ceph_basiccheck_testspace.VArD')
> 2010-09-30 19:37:44.538849 7f7802dea710 mds0.cache.dir(1)   hit -> (ceph_basiccheck_testspace.VArD,head)
> 2010-09-30 19:37:44.538862 7f7802dea710 mds0.locker acquire_locks request(client4106:27 cr=0x29e7b40)
> 2010-09-30 19:37:44.538873 7f7802dea710 mds0.locker  must xlock (dn sync) [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock) pv=0 v=1 inode=0 0x2a0ae80]
> 2010-09-30 19:37:44.538890 7f7802dea710 mds0.locker  must wrlock (ifile sync) [inode 1 [...2,head] / auth{1=2,2=1} v1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated 0x29e9000]
> 2010-09-30 19:37:44.538907 7f7802dea710 mds0.locker  must wrlock (inest sync) [inode 1 [...2,head] / auth{1=2,2=1} v1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated 0x29e9000]
> 2010-09-30 19:37:44.538926 7f7802dea710 mds0.locker  must wrlock (dversion lock) [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock) pv=0 v=1 inode=0 0x2a0ae80]
> 2010-09-30 19:37:44.538940 7f7802dea710 mds0.locker  must rdlock (iauth sync) [inode 1 [...2,head] / auth{1=2,2=1} v1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated 0x29e9000]
> 2010-09-30 19:37:44.538958 7f7802dea710 mds0.locker  must rdlock (isnap sync) [inode 1 [...2,head] / auth{1=2,2=1} v1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated 0x29e9000]
> 2010-09-30 19:37:44.538975 7f7802dea710 mds0.locker  must rdlock (dn sync) [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock) pv=0 v=1 inode=0 0x2a0ae80]
> 2010-09-30 19:37:44.538989 7f7802dea710 mds0.locker  must authpin [inode 1 [...2,head] / auth{1=2,2=1} v1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated 0x29e9000]
> 2010-09-30 19:37:44.539006 7f7802dea710 mds0.locker  must authpin [inode 1 [...2,head] / auth{1=2,2=1} v1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated 0x29e9000]
> 2010-09-30 19:37:44.539023 7f7802dea710 mds0.locker  must authpin [inode 1 [...2,head] / auth{1=2,2=1} v1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated 0x29e9000]
> 2010-09-30 19:37:44.539039 7f7802dea710 mds0.locker  must authpin [inode 1 [...2,head] / auth{1=2,2=1} v1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated 0x29e9000]
> 2010-09-30 19:37:44.539059 7f7802dea710 mds0.locker  must authpin [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock) pv=0 v=1 inode=0 0x2a0ae80]
> 2010-09-30 19:37:44.539073 7f7802dea710 mds0.locker  must authpin [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock) pv=0 v=1 inode=0 0x2a0ae80]
> 2010-09-30 19:37:44.539085 7f7802dea710 mds0.locker  auth_pinning [inode 1 [...2,head] / auth{1=2,2=1} v1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated 0x29e9000]
> 2010-09-30 19:37:44.539103 7f7802dea710 mds0.cache.ino(1) auth_pin by 0x2a1a000 on [inode 1 [...2,head] / auth{1=2,2=1} v1 ap=1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated authpin 0x29e9000] now 1+0
> 2010-09-30 19:37:44.539121 7f7802dea710 mds0.locker  already auth_pinned [inode 1 [...2,head] / auth{1=2,2=1} v1 ap=1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated authpin 0x29e9000]
> 2010-09-30 19:37:44.539138 7f7802dea710 mds0.locker  already auth_pinned [inode 1 [...2,head] / auth{1=2,2=1} v1 ap=1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated authpin 0x29e9000]
> 2010-09-30 19:37:44.539155 7f7802dea710 mds0.locker  already auth_pinned [inode 1 [...2,head] / auth{1=2,2=1} v1 ap=1 snaprealm=0x29e8480 f(v0 1=0+1) n(v0 1=0+1) (iversion lock) caps={4106=pAsLsXs/p@26} | dirfrag caps replicated authpin 0x29e9000]
> 2010-09-30 19:37:44.539172 7f7802dea710 mds0.locker  auth_pinning [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock) pv=0 v=1 inode=0 0x2a0ae80]
> 2010-09-30 19:37:44.539185 7f7802dea710 mds0.cache.den(1 ceph_basiccheck_testspace.VArD) auth_pin by 0x2a1a000 on [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock) pv=0 v=1 ap=1+0 inode=0 | authpin 0x2a0ae80] now 1+0
> 2010-09-30 19:37:44.539199 7f7802dea710 mds0.cache.dir(1) adjust_nested_auth_pins 1/1 on [dir 1 / [2,head] auth{1=2,2=1} v=1 cv=1/1 REP dir_auth=0 ap=0+1+1 state=1073741826|complete f(v0 1=0+1) n(v0 1=0+1) hs=1+6,ss=0+0 | child subtree replicated 0x29fd000] count now 0 + 1
> 2010-09-30 19:37:44.539216 7f7802dea710 mds0.locker  already auth_pinned [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock) pv=0 v=1 ap=1+0 inode=0 | authpin 0x2a0ae80]
> 2010-09-30 19:37:44.539231 7f7802dea710 mds0.locker local_wrlock_start  on (dversion lock) on [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock) pv=0 v=1 ap=1+0 inode=0 | authpin 0x2a0ae80]
> 2010-09-30 19:37:44.539246 7f7802dea710 mds0.locker  got wrlock on (dversion lock w=1 last_client=4106) [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock w=1 last_client=4106) pv=0 v=1 ap=1+0 inode=0 | lock authpin 0x2a0ae80]
> 2010-09-30 19:37:44.539262 7f7802dea710 mds0.locker xlock_start on (dn sync) on [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock w=1 last_client=4106) pv=0 v=1 ap=1+0 inode=0 | lock authpin 0x2a0ae80]
> 2010-09-30 19:37:44.539276 7f7802dea710 mds0.locker simple_lock on (dn sync) on [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dversion lock w=1 last_client=4106) pv=0 v=1 ap=1+0 inode=0 | lock authpin 0x2a0ae80]
> 2010-09-30 19:37:44.539293 7f7802dea710 mds0.locker simple_xlock on (dn lock) on [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dn lock) (dversion lock w=1 last_client=4106) pv=0 v=1 ap=1+0 inode=0 | lock authpin 0x2a0ae80]
> 2010-09-30 19:37:44.539308 7f7802dea710 mds0.cache.den(1 ceph_basiccheck_testspace.VArD) auth_pin by 0x2a0afc8 on [dentry #1/ceph_basiccheck_testspace.VArD [2,head] auth NULL (dn lock) (dversion lock w=1 last_client=4106) pv=0 v=1 ap=2+0 inode=0 | lock authpin 0x2a0ae80] now 2+0
> 2010-09-30 19:37:44.539323 7f7802dea710 mds0.cache.dir(1) adjust_nested_auth_pins 1/1 on [dir 1 / [2,head] auth{1=2,2=1} v=1 cv=1/1 REP dir_auth=0 ap=0+2+2 state=1073741826|complete f(v0 1=0+1) n(v0 1=0+1) hs=1+6,ss=0+0 | child subtree replicated 0x29fd000] count now 0 + 2
> mds/Locker.cc: In function 'void Locker::simple_xlock(SimpleLock*)':
> mds/Locker.cc:3138: FAILED assert("shouldn't be called if we are already xlockable" == 0)
>  ceph version 0.22~rc (7657a6d5b30dd181350acf19681847d9c8f5d694)
>  1: (Locker::xlock_start(SimpleLock*, MDRequest*)+0x2ab) [0x5811ab]
>  2: (Locker::acquire_locks(MDRequest*, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&)+0x1749) [0x586a99]
>  3: (Server::handle_client_openc(MDRequest*)+0x407) [0x4dd737]
>  4: (Server::handle_client_request(MClientRequest*)+0x340) [0x4e2990]
>  5: (MDS::_dispatch(Message*)+0x2598) [0x49e038]
>  6: (MDS::ms_dispatch(Message*)+0x5b) [0x49e1ab]
>  7: (SimpleMessenger::dispatch_entry()+0x67a) [0x483f9a]
>  8: (SimpleMessenger::DispatchThread::entry()+0x4d) [0x47a4ed]
>  9: (Thread::_entry_func(void*)+0x7) [0x48dd17]
>  10: (()+0x68ba) [0x7f780553b8ba]
>  11: (clone()+0x6d) [0x7f78044ef02d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
