From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Subject: Failure to run "rbd" commands
Date: Wed, 22 Feb 2012 14:18:46 +1000
Message-ID: <81C477727102DA4E9B2605AC748C495407E36DF80C@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mf4.mach.net.au ([74.55.157.90]:41130 "EHLO mf4.mach.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177Ab2BVEUf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 23:20:35 -0500
Received: from exch13.ad.mach.net.au (unknown [115.165.169.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mf4.mach.net.au (Postfix) with ESMTP id 5D92628028
	for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 14:20:26 +1000 (EST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

G'day all

Today's testing was on having a client (i.e. Ubuntu 12.04 server running KVM to be virtualisation host, named "server") connect to the 3x node v0.42 Ceph Cluster (names "ceph1, ceph2 & ceph3").

A very simple command "rbd ls" is failing per below:

root@server:/# rbd ls
terminate called after throwing an instance of 'ceph::buffer::error'
  what():  buffer::exception
*** Caught signal (Aborted) **
 in thread 7fe239f7d700
 ceph version 0.41 (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d)
 1: rbd() [0x459316]
 2: (()+0xfcb0) [0x7fe23c055cb0]
 3: (gsignal()+0x35) [0x7fe23a7b5475]
 4: (abort()+0x17b) [0x7fe23a7b8bdb]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fe23b10169d]
 6: (()+0xb5846) [0x7fe23b0ff846]
 7: (()+0xb5873) [0x7fe23b0ff873]
 8: (()+0xb596e) [0x7fe23b0ff96e]
 9: (pg_pool_t::decode(ceph::buffer::list::iterator&)+0x859) [0x7fe23c3d0e99]
 10: (void decode<long, pg_pool_t>(std::map<long, pg_pool_t, std::less<long>, std::allocator<std::pair<long const, pg_pool_t> > >&, ceph::buffer::list::iterator&)+0x91) [0x7fe23c3c8851]
 11: (OSDMap::decode(ceph::buffer::list&)+0x17d) [0x7fe23c3befcd]
 12: (Objecter::handle_osd_map(MOSDMap*)+0x1e9f) [0x7fe23c3033ff]
 13: (librados::RadosClient::_dispatch(Message*)+0x54) [0x7fe23c2e3e44]
 14: (librados::RadosClient::ms_dispatch(Message*)+0x33) [0x7fe23c2e3ef3]
 15: (SimpleMessenger::dispatch_entry()+0x76b) [0x47ea1b]
 16: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x46995c]
 17: (()+0x7e9a) [0x7fe23c04de9a]
 18: (clone()+0x6d) [0x7fe23a86f77d]
Aborted (core dumped)

However this command works on the same box:
root@server:/# echo "10.112.9.11,10.112.9.12,10.112.9.13 name=admin,secret=AQBBg0NPeFt9MRAAg8AWG108I8sje82hzdjkiw== rbd demo.rbd" > /sys/bus/rbd/add
root@server:/# ls -alh /dev/rbd*
brw-rw---- 1 root disk 251, 0 Feb 22 14:12 /dev/rbd0

/dev/rbd:
total 0
drwxr-xr-x  3 root root   60 Feb 22 14:12 .
drwxr-xr-x 16 root root 4.2K Feb 22 14:12 ..
drwxr-xr-x  2 root root   60 Feb 22 14:12 rbd


Confirming the below works as expected when run from any of the 3x servers within the Cluster:
root@ceph1:/etc/ceph# rbd ls
demo.rbd
root@ceph3:~# rbd -p rbd ls
demo.rbd

On the "client" KVM box, I have installed:
apt-get install ceph-common
modprobe rbd

Then created these two files:
;-------------------------------------------------------------------
/etc/ceph/ceph.conf
;-------------------------------------------------------------------
[global]
    ; enable secure authentication
    auth supported = cephx
    keyring = /etc/ceph/keyring.bin

[mon]
[mon.alpha]
        host = ceph1
        mon addr = 10.112.9.11:6789

[mon.bravo]
        host = ceph2
        mon addr = 10.112.9.12:6789

[mon.charlie]
        host = ceph3
        mon addr = 10.112.9.13:6789


;-------------------------------------------------------------------
/etc/ceph/keyring.bin
;-------------------------------------------------------------------
[client.admin]
        key = AQBBg0NPeFt9MRAAg8AWG108I8sje82hzdjkiw==





