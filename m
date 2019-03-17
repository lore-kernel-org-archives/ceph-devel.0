From: Alex Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Constant Compaction on one mimic node
Date: Sun, 17 Mar 2019 04:11:47 -0500
Message-ID: <q6l30k$3l2i$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hello everyone,

I am getting a huge number of messages on one out of three nodes showing Manual compaction starting all the time.  I see no such of log entries on the other nodes in the cluster.

Mar 16 06:40:11 storage1n1-chi docker[24502]: debug 2019-03-16 06:40:11.441 7f6967af4700  4 rocksdb: 
[/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/13.2.2/rpm/el7/BUILD/ceph-13.2.2/src/rocksdb/db/db_impl_compaction_flush.cc:1024] 
[default] Manual compaction starting
Mar 16 06:40:11 storage1n1-chi docker[24502]: message repeated 4 times: [ debug 2019-03-16 06:40:11.441 7f6967af4700  4 rocksdb: 
[/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/13.2.2/rpm/el7/BUILD/ceph-13.2.2/src/rocksdb/db/db_impl_compaction_flush.cc:1024] 
[default] Manual compaction starting]
Mar 16 06:42:21 storage1n1-chi docker[24502]: debug 2019-03-16 06:42:21.466 7f6970305700  4 rocksdb: 
[/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/13.2.2/rpm/el7/BUILD/ceph-13.2.2/src/rocksdb/db/db_impl_compaction_flush.cc:77] 
[JOB 1021] Syncing log #194307

I am not sure what triggers those message on one node an not on the others.

Checking config on all mons

debug_leveldb             4/5                                          override
debug_memdb               4/5                                          override
debug_mgr                 0/5                                          override
debug_mgrc                0/5                                          override
debug_rocksdb             4/5                                          override

Documentation tells nothing about the compaction logs or at least I couldn't find anything specific to my issue.
