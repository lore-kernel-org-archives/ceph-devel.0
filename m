From: Derek Yarnell <derek-+0HnD9Kv66LFajBVf7NWsQ@public.gmane.org>
Subject: CephFS Segfault 12.2.0
Date: Mon, 18 Sep 2017 16:30:47 -0400
Message-ID: <5f43d77d-4684-1dfd-e597-6dd113004d6f@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

We have a recent cluster upgraded from Jewel to Luminous.  Today we had
a segmentation fault that led to file system degraded.  Systemd then
decided to restart the daemon over and over with a different stack trace
(can be seen after the 10k events in the log file[0]).

After trying to fail over to the standby which also kept failing.  After
shutting down both MDSs for some time we brought one back online and
what seemed to be the clients had been out long enough to be evicted.
We were able to then reboot clients (RHEL 7.4) and have them re-connect
to the file system.

2017-09-18 13:27:12.836699 7f9c0ca51700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f9c0ca51700 thread_name:fn_anonymous

 ceph version 12.2.0 (32ce2a3ae5239ee33d6150705cdb24d43bab910c) luminous
(rc)
 1: (()+0x590c21) [0x55a40867ac21]
 2: (()+0xf5e0) [0x7f9c17cb75e0]
 3:
(Server::handle_client_readdir(boost::intrusive_ptr<MDRequestImpl>&)+0xbb9)
[0x55a4083f74b9]
 4:
(Server::dispatch_client_request(boost::intrusive_ptr<MDRequestImpl>&)+0x9c1)
[0x55a408428591]
 5: (MDSInternalContextBase::complete(int)+0x1eb) [0x55a408605c0b]
 6: (void finish_contexts<MDSInternalContextBase>(CephContext*,
std::list<MDSInternalContextBase*,
std::allocator<MDSInternalContextBase*> >&, int)+0xac) [0x55a4083c69ac]
 7: (MDSCacheObject::finish_waiting(unsigned long, int)+0x46)
[0x55a40861d856]
 8: (Locker::eval_gather(SimpleLock*, bool, bool*,
std::list<MDSInternalContextBase*,
std::allocator<MDSInternalContextBase*> >*)+0x10df) [0x55a40851f93f]
 9: (Locker::wrlock_finish(SimpleLock*, MutationImpl*, bool*)+0x310)
[0x55a408521210]
 10: (Locker::_drop_non_rdlocks(MutationImpl*, std::set<CInode*,
std::less<CInode*>, std::allocator<CInode*> >*)+0x22c) [0x55a408524adc]
 11: (Locker::drop_non_rdlocks(MutationImpl*, std::set<CInode*,
std::less<CInode*>, std::allocator<CInode*> >*)+0x59) [0x55a4085253d9]
 12: (Server::reply_client_request(boost::intrusive_ptr<MDRequestImpl>&,
MClientReply*)+0x433) [0x55a4083f21a3]
 13: (Server::respond_to_request(boost::intrusive_ptr<MDRequestImpl>&,
int)+0x459) [0x55a4083f2dd9]
 14: (Server::_unlink_local_finish(boost::intrusive_ptr<MDRequestImpl>&,
CDentry*, CDentry*, unsigned long)+0x2ab) [0x55a4083fd7fb]
 15: (MDSIOContextBase::complete(int)+0xa4) [0x55a408605d44]
 16: (MDSLogContextBase::complete(int)+0x3c) [0x55a4086060fc]
 17: (Finisher::finisher_thread_entry()+0x198) [0x55a4086ba718]
 18: (()+0x7e25) [0x7f9c17cafe25]
 19: (clone()+0x6d) [0x7f9c16d9234dC


[0] -
https://obj.umiacs.umd.edu/derek_support/mds_20170918/ceph-mds.objmds01.log?Signature=VJB4qL34j5UKM%2BCxeiR8n0JA1gE%3D&Expires=1508357409&AWSAccessKeyId=936291C3OMB2LBD7FLK4

-- 
Derek T. Yarnell
Director of Computing Facilities
University of Maryland
Institute for Advanced Computer Studies
