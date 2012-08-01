From: <Eric_YH_Chen@wiwynn.com>
Subject: RE: cannot startup one of the osd
Date: Wed, 1 Aug 2012 08:11:28 +0000
Message-ID: <60E83269D669544E8069A09CB69135EA01245B@GDC-CLDMBX-P02.whq.wistron>
References: <60E83269D669544E8069A09CB69135EA011DB4@GDC-CLDMBX-P02.whq.wistron>
 <CA+4uBUZgZXJ8TZz4T3OFeVYmNgvwXg0Ye6jwjrwXpPKbXufXbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw3.wistron.com ([220.128.89.23]:65040 "EHLO
	TWNHUMSW3.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab2HAILa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 04:11:30 -0400
Content-Language: zh-TW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com, sam.just@inktank.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

Hi, Samuel:

And the ceph cluster stays at a not healthy status. How could we fix it? 
There are 230 object unfound and we cannot access some rbd devices now.
It would hang at "rbd info <image_name>".

root@ubuntu:~$ ceph -s
   health HEALTH_WARN 96 pgs backfill; 96 pgs degraded; 96 pgs recovering; 96 pgs stuck unclean; recovery 4978/138644 de
graded (3.590%); 230/69322 unfound (0.332%)
   monmap e1: 3 mons at {006=192.168.200.84:6789/0,008=192.168.200.86:6789/0,009=192.168.200.87:6789/0}, election epoch
6, quorum 0,1,2 006,008,009
   osdmap e2944: 24 osds: 23 up, 23 in
    pgmap v297084: 4608 pgs: 4512 active+clean, 50 active+recovering+degraded+remapped+backfill, 46 active+recovering+de
graded+backfill; 257 GB data, 952 GB used, 19367 GB / 21390 GB avail; 4978/138644 degraded (3.590%); 230/69322 unfound (
0.332%)
   mdsmap e1: 0/0/1 up


-----Original Message-----
From: Eric YH Chen/WYHQ/Wiwynn 
Sent: Wednesday, August 01, 2012 9:01 AM
To: 'Samuel Just'
Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WYHQ/Wiwynn; Victor CY Chang/WYHQ/Wiwynn
Subject: RE: cannot startup one of the osd

Hi, Samuel:

It happens every startup, I cannot fix it now.

-----Original Message-----
From: Samuel Just [mailto:sam.just@inktank.com]
Sent: Wednesday, August 01, 2012 1:36 AM
To: Eric YH Chen/WYHQ/Wiwynn
Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WYHQ/Wiwynn; Victor CY Chang/WYHQ/Wiwynn
Subject: Re: cannot startup one of the osd

This crash happens on each startup?
-Sam

On Tue, Jul 31, 2012 at 2:32 AM,  <Eric_YH_Chen@wiwynn.com> wrote:
> Hi, all:
>
> My Environment:  two servers, and 12 hard-disk on each server.
>                  Version: Ceph 0.48, Kernel: 3.2.0-27
>
> We create a ceph cluster with 24 osd, 3 monitors
> Osd.0 ~ osd.11 is on server1
> Osd.12 ~ osd.23 is on server2
> Mon.0 is on server1
> Mon.1 is on server2
> Mon.2 is on server3 which has no osd
>
> root@ubuntu:~$ ceph -s
>    health HEALTH_WARN 227 pgs degraded; 93 pgs down; 93 pgs peering; 85 pgs recovering; 82 pgs stuck inactive; 255 pgs stuck unclean; recovery 4808/138644 degraded (3.468%); 202/69322 unfound (0.291%); 1/24 in osds are down
>    monmap e1: 3 mons at {006=192.168.200.84:6789/0,008=192.168.200.86:6789/0,009=192.168.200.87:6789/0}, election epoch 564, quorum 0,1,2 006,008,009
>    osdmap e1911: 24 osds: 23 up, 24 in
>     pgmap v292031: 4608 pgs: 4251 active+clean, 85 active+recovering+degraded, 37 active+remapped, 58 down+peering, 142 active+degraded, 35 down+replay+peering; 257 GB data, 948 GB used, 19370 GB / 21390 GB avail; 4808/138644 degraded (3.468%); 202/69322 unfound (0.291%)
>    mdsmap e1: 0/0/1 up
>
> I find one of the osd cannot startup anymore. Before that, I am testing HA of Ceph cluster.
>
> Step1:  shutdown server1, wait 5 min
> Step2:  bootup server1, wait 5 min until ceph enter health status
> Step3:  shutdown server2, wait 5 min
> Step4:  bootup server2, wait 5 min until ceph enter health status 
> Repeat Step1~ Step4 several times, then I met this problem.
>
>
> Log of ceph-osd.22.log
> 2012-07-31 17:18:15.120678 7f9375300780  0 filestore(/srv/disk10/data) 
> mount found snaps <>
> 2012-07-31 17:18:15.122081 7f9375300780  0 filestore(/srv/disk10/data)
> mount: enabling WRITEAHEAD journal mode: btrfs not detected
> 2012-07-31 17:18:15.128544 7f9375300780  1 journal _open 
> /srv/disk10/journal fd 23: 6442450944 bytes, block size 4096 bytes, 
> directio = 1, aio = 0
> 2012-07-31 17:18:15.257302 7f9375300780  1 journal _open 
> /srv/disk10/journal fd 23: 6442450944 bytes, block size 4096 bytes, 
> directio = 1, aio = 0
> 2012-07-31 17:18:15.273163 7f9375300780  1 journal close 
> /srv/disk10/journal
> 2012-07-31 17:18:15.274395 7f9375300780 -1 filestore(/srv/disk10/data) 
> limited size xattrs -- filestore_xattr_use_omap enabled
> 2012-07-31 17:18:15.275169 7f9375300780  0 filestore(/srv/disk10/data) 
> mount FIEMAP ioctl is supported and appears to work
> 2012-07-31 17:18:15.275180 7f9375300780  0 filestore(/srv/disk10/data) 
> mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
> 2012-07-31 17:18:15.275312 7f9375300780  0 filestore(/srv/disk10/data) 
> mount did NOT detect btrfs
> 2012-07-31 17:18:15.276060 7f9375300780  0 filestore(/srv/disk10/data) 
> mount syncfs(2) syscall fully supported (by glib and kernel)
> 2012-07-31 17:18:15.276154 7f9375300780  0 filestore(/srv/disk10/data) 
> mount found snaps <>
> 2012-07-31 17:18:15.277031 7f9375300780  0 filestore(/srv/disk10/data)
> mount: enabling WRITEAHEAD journal mode: btrfs not detected
> 2012-07-31 17:18:15.280906 7f9375300780  1 journal _open 
> /srv/disk10/journal fd 32: 6442450944 bytes, block size 4096 bytes, 
> directio = 1, aio = 0
> 2012-07-31 17:18:15.307761 7f9375300780  1 journal _open 
> /srv/disk10/journal fd 32: 6442450944 bytes, block size 4096 bytes, 
> directio = 1, aio = 0
> 2012-07-31 17:18:19.466921 7f9360a97700  0 --
> 192.168.200.82:6830/18744 >> 192.168.200.83:0/3485583732
> pipe(0x45bd000 sd=34 pgs=0 cs=0 l=0).accept peer addr is really
> 192.168.200.83:0/3485583732 (socket is 192.168.200.83:45653/0)
> 2012-07-31 17:18:19.671681 7f9363a9d700 -1 os/DBObjectMap.cc: In 
> function 'virtual bool DBObjectMap::DBObjectMapIteratorImpl::valid()'
> thread 7f9363a9d700 time 2012-07-31 17:18:19.670082
> os/DBObjectMap.cc: 396: FAILED assert(!valid || cur_iter->valid())
>
> ceph version 0.48argonaut
> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>  1: /usr/bin/ceph-osd() [0x6a3123]
>  2: (ReplicatedPG::send_push(int, ObjectRecoveryInfo, 
> ObjectRecoveryProgress, ObjectRecoveryProgress*)+0x684) [0x53f314]
>  3: (ReplicatedPG::push_start(ReplicatedPG::ObjectContext*, hobject_t 
> const&, int, eversion_t, interval_set<unsigned long>&, 
> std::map<hobject_t, interval_set<unsigned long>, std::less<hobject_t>, 
> std::allocator<std::pair<hobject_t const, interval_set<unsigned long>
> > > >&)+0x333) [0x54c873]
>  4: (ReplicatedPG::push_to_replica(ReplicatedPG::ObjectContext*,
> hobject_t const&, int)+0x343) [0x54cdc3]
>  5: (ReplicatedPG::recover_object_replicas(hobject_t const&,
> eversion_t)+0x35f) [0x5527bf]
>  6: (ReplicatedPG::wait_for_degraded_object(hobject_t const&,
> std::tr1::shared_ptr<OpRequest>)+0x17b) [0x55406b]
>  7: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x9de)
> [0x56305e]
>  8: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x199) [0x5fda89]
>  9: (OSD::dequeue_op(PG*)+0x238) [0x5bf668]
>  10: (ThreadPool::worker()+0x605) [0x796d55]
>  11: (ThreadPool::WorkThread::entry()+0xd) [0x5d5d0d]
>  12: (()+0x7e9a) [0x7f9374794e9a]
>  13: (clone()+0x6d) [0x7f93734344bd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
> --- begin dump of recent events ---
>    -21> 2012-07-31 17:18:15.114905 7f9375300780  0 ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030), process ceph-osd, pid 18744
>    -20> 2012-07-31 17:18:15.118038 7f9375300780 -1 filestore(/srv/disk10/data) limited size xattrs -- filestore_xattr_use_omap enabled
>    -19> 2012-07-31 17:18:15.119172 7f9375300780  0 filestore(/srv/disk10/data) mount FIEMAP ioctl is supported and appears to work
>    -18> 2012-07-31 17:18:15.119185 7f9375300780  0 filestore(/srv/disk10/data) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
>    -17> 2012-07-31 17:18:15.119339 7f9375300780  0 filestore(/srv/disk10/data) mount did NOT detect btrfs
>    -16> 2012-07-31 17:18:15.120567 7f9375300780  0 filestore(/srv/disk10/data) mount syncfs(2) syscall fully supported (by glibc and kernel)
>    -15> 2012-07-31 17:18:15.120678 7f9375300780  0 filestore(/srv/disk10/data) mount found snaps <>
>    -14> 2012-07-31 17:18:15.122081 7f9375300780  0 filestore(/srv/disk10/data) mount: enabling WRITEAHEAD journal mode:btrfs not detected
>    -13> 2012-07-31 17:18:15.128544 7f9375300780  1 journal _open /srv/disk10/journal fd 23: 6442450944 bytes, block size 4096 bytes, directio = 1, aio = 0
>    -12> 2012-07-31 17:18:15.257302 7f9375300780  1 journal _open /srv/disk10/journal fd 23: 6442450944 bytes, block size 4096 bytes, directio = 1, aio = 0
>    -11> 2012-07-31 17:18:15.273163 7f9375300780  1 journal close /srv/disk10/journal
>    -10> 2012-07-31 17:18:15.274395 7f9375300780 -1 filestore(/srv/disk10/data) limited size xattrs -- filestore_xattr_use_omap enabled
>     -9> 2012-07-31 17:18:15.275169 7f9375300780  0 filestore(/srv/disk10/data) mount FIEMAP ioctl is supported and appea
>     -8> 2012-07-31 17:18:15.275180 7f9375300780  0 filestore(/srv/disk10/data) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
>     -7> 2012-07-31 17:18:15.275312 7f9375300780  0 filestore(/srv/disk10/data) mount did NOT detect btrfs
>     -6> 2012-07-31 17:18:15.276060 7f9375300780  0 filestore(/srv/disk10/data) mount syncfs(2) syscall fully supported (by glibc and kernel)
>     -5> 2012-07-31 17:18:15.276154 7f9375300780  0 filestore(/srv/disk10/data) mount found snaps <>
>     -4> 2012-07-31 17:18:15.277031 7f9375300780  0 filestore(/srv/disk10/data) mount: enabling WRITEAHEAD journal mode: btrfs not detected
>     -3> 2012-07-31 17:18:15.280906 7f9375300780  1 journal _open /srv/disk10/journal fd 32: 6442450944 bytes, block size 4096 bytes, directio = 1, aio = 0
>     -2> 2012-07-31 17:18:15.307761 7f9375300780  1 journal _open /srv/disk10/journal fd 32: 6442450944 bytes, block size 4096 bytes, directio = 1, aio = 0
>     -1> 2012-07-31 17:18:19.466921 7f9360a97700  0 -- 192.168.200.82:6830/18744 >> 192.168.200.83:0/3485583732 pipe(0x45bd000 sd=34 pgs=0 cs=0 l=0).accept peer addr is really 192.168.200.83:0/3485583732 (socket is 192.168.200.83:45653/0)
>      0> 2012-07-31 17:18:19.671681 7f9363a9d700 -1 os/DBObjectMap.cc: 
> In function 'virtual bool
> DBObjectMap::DBObjectMapIteratorImpl::valid()' thread 7f9363a9d700 
> time 2012-07-31 17:18:19.670082
> os/DBObjectMap.cc: 396: FAILED assert(!valid || cur_iter->valid())
>
>
>  ceph version 0.48argonaut
> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>  1: /usr/bin/ceph-osd() [0x6a3123]
>  2: (ReplicatedPG::send_push(int, ObjectRecoveryInfo, 
> ObjectRecoveryProgress, ObjectRecoveryProgress*)+0x684) [0x53f314]
>  3: (ReplicatedPG::push_start(ReplicatedPG::ObjectContext*, hobject_t 
> const&, int, eversion_t, interval_set<unsigned long>&, 
> std::map<hobject_t, interval_set<unsigned long>, std::less<hobject_t>, 
> std::allocator<std::pair<hobject_t const, interval_set<unsigned long>
> > > >&)+0x333) [0x54c873]
>  4: (ReplicatedPG::push_to_replica(ReplicatedPG::ObjectContext*,
> hobject_t const&, int)+0x343) [0x54cdc3]
>  5: (ReplicatedPG::recover_object_replicas(hobject_t const&,
> eversion_t)+0x35f) [0x5527bf]
>  6: (ReplicatedPG::wait_for_degraded_object(hobject_t const&,
> std::tr1::shared_ptr<OpRequest>)+0x17b) [0x55406b]
>  7: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x9de)
> [0x56305e]
>  8: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x199) [0x5fda89]
>  9: (OSD::dequeue_op(PG*)+0x238) [0x5bf668]
>  10: (ThreadPool::worker()+0x605) [0x796d55]
>  11: (ThreadPool::WorkThread::entry()+0xd) [0x5d5d0d]
>  12: (()+0x7e9a) [0x7f9374794e9a]
>  13: (clone()+0x6d) [0x7f93734344bd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
> --- end dump of recent events ---
> 2012-07-31 17:18:19.673801 7f9363a9d700 -1 *** Caught signal (Aborted)
> **  in thread 7f9363a9d700
>
>  ceph version 0.48argonaut
> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>  1: /usr/bin/ceph-osd() [0x6e900a]
>  2: (()+0xfcb0) [0x7f937479ccb0]
>  3: (gsignal()+0x35) [0x7f9373378445]
>  4: (abort()+0x17b) [0x7f937337bbab]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f9373cc669d]
>  6: (()+0xb5846) [0x7f9373cc4846]
>  7: (()+0xb5873) [0x7f9373cc4873]
>  8: (()+0xb596e) [0x7f9373cc496e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x282) [0x79f662]
>  10: /usr/bin/ceph-osd() [0x6a3123]
>  11: (ReplicatedPG::send_push(int, ObjectRecoveryInfo, 
> ObjectRecoveryProgress, ObjectRecoveryProgress*)+0x684) [0x53f314 ]
>  12: (ReplicatedPG::push_start(ReplicatedPG::ObjectContext*, hobject_t 
> const&, int, eversion_t, interval_set<unsigned lo
> ng>&, std::map<hobject_t, interval_set<unsigned long>, 
> ng>std::less<hobject_t>, std::allocator<std::pair<hobject_t const, i
> nterval_set<unsigned long> > > >&)+0x333) [0x54c873]
>  13: (ReplicatedPG::push_to_replica(ReplicatedPG::ObjectContext*,
> hobject_t const&, int)+0x343) [0x54cdc3]
>  14: (ReplicatedPG::recover_object_replicas(hobject_t const&,
> eversion_t)+0x35f) [0x5527bf]
>  15: (ReplicatedPG::wait_for_degraded_object(hobject_t const&,
> std::tr1::shared_ptr<OpRequest>)+0x17b) [0x55406b]
>  16: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x9de)
> [0x56305e]
>  17: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x199)
> [0x5fda89]
>  18: (OSD::dequeue_op(PG*)+0x238) [0x5bf668]
>  19: (ThreadPool::worker()+0x605) [0x796d55]
>  20: (ThreadPool::WorkThread::entry()+0xd) [0x5d5d0d]
>  21: (()+0x7e9a) [0x7f9374794e9a]
>  22: (clone()+0x6d) [0x7f93734344bd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> --- begin dump of recent events ---
>      0> 2012-07-31 17:18:19.673801 7f9363a9d700 -1 *** Caught signal
> (Aborted) **  in thread 7f9363a9d700
>
>  ceph version 0.48argonaut
> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>  1: /usr/bin/ceph-osd() [0x6e900a]
>  2: (()+0xfcb0) [0x7f937479ccb0]
>  3: (gsignal()+0x35) [0x7f9373378445]
>  4: (abort()+0x17b) [0x7f937337bbab]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f9373cc669d]
>  6: (()+0xb5846) [0x7f9373cc4846]
>  7: (()+0xb5873) [0x7f9373cc4873]
>  8: (()+0xb596e) [0x7f9373cc496e]
>  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x282) [0x79f662]
>  10: /usr/bin/ceph-osd() [0x6a3123]
>  11: (ReplicatedPG::send_push(int, ObjectRecoveryInfo, 
> ObjectRecoveryProgress, ObjectRecoveryProgress*)+0x684) [0x53f314]
>  12: (ReplicatedPG::push_start(ReplicatedPG::ObjectContext*, hobject_t 
> const&, int, eversion_t, interval_set<unsigned long>&, 
> std::map<hobject_t, interval_set<unsigned long>, std::less<hobject_t>, 
> std::allocator<std::pair<hobject_t const, interval_set<unsigned long>
> > > >&)+0x333) [0x54c873]
>  13: (ReplicatedPG::push_to_replica(ReplicatedPG::ObjectContext*,
> hobject_t const&, int)+0x343) [0x54cdc3]
>  14: (ReplicatedPG::recover_object_replicas(hobject_t const&,
> eversion_t)+0x35f) [0x5527bf]
>  15: (ReplicatedPG::wait_for_degraded_object(hobject_t const&,
> std::tr1::shared_ptr<OpRequest>)+0x17b) [0x55406b]
>  16: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>)+0x9de)
> [0x56305e]
>  17: (PG::do_request(std::tr1::shared_ptr<OpRequest>)+0x199)
> [0x5fda89]
>  18: (OSD::dequeue_op(PG*)+0x238) [0x5bf668]
>  19: (ThreadPool::worker()+0x605) [0x796d55]
>  20: (ThreadPool::WorkThread::entry()+0xd) [0x5d5d0d]
>  21: (()+0x7e9a) [0x7f9374794e9a]
>  22: (clone()+0x6d) [0x7f93734344bd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
> --- end dump of recent events ---
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
