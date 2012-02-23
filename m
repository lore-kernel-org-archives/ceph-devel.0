From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Subject: RE: Failure to run "rbd" commands
Date: Fri, 24 Feb 2012 09:38:17 +1000
Message-ID: <81C477727102DA4E9B2605AC748C495407EC3EAD1F@exch10>
References: <81C477727102DA4E9B2605AC748C495407E36DF80C@exch10>
 <Pine.LNX.4.64.1202212121490.9891@cobra.newdream.net>
 <Pine.LNX.4.64.1202231535310.22117@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mf4.mach.net.au ([74.55.157.90]:49800 "EHLO mf4.mach.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521Ab2BWXiW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 18:38:22 -0500
In-Reply-To: <Pine.LNX.4.64.1202231535310.22117@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Many thanks Sage - we will apply this 0.42.1 version and continue with the project
Paul

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net] 
Sent: Friday, 24 February 2012 9:36 AM
To: Paul Pettigrew
Cc: ceph-devel@vger.kernel.org
Subject: Re: Failure to run "rbd" commands

On Tue, 21 Feb 2012, Sage Weil wrote:
> On Wed, 22 Feb 2012, Paul Pettigrew wrote:
> > G'day all
> > 
> > Today's testing was on having a client (i.e. Ubuntu 12.04 server running KVM to be virtualisation host, named "server") connect to the 3x node v0.42 Ceph Cluster (names "ceph1, ceph2 & ceph3").
> > 
> > A very simple command "rbd ls" is failing per below:
> > 
> > root@server:/# rbd ls
> > terminate called after throwing an instance of 'ceph::buffer::error'
> >   what():  buffer::exception
> > *** Caught signal (Aborted) **
> >  in thread 7fe239f7d700
> >  ceph version 0.41 (commit:c1345f7136a0af55d88280ffe4b58339aaf28c9d)
> >  1: rbd() [0x459316]
> >  2: (()+0xfcb0) [0x7fe23c055cb0]
> >  3: (gsignal()+0x35) [0x7fe23a7b5475]
> >  4: (abort()+0x17b) [0x7fe23a7b8bdb]
> >  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) 
> > [0x7fe23b10169d]
> >  6: (()+0xb5846) [0x7fe23b0ff846]
> >  7: (()+0xb5873) [0x7fe23b0ff873]
> >  8: (()+0xb596e) [0x7fe23b0ff96e]
> >  9: (pg_pool_t::decode(ceph::buffer::list::iterator&)+0x859) 
> > [0x7fe23c3d0e99]
> >  10: (void decode<long, pg_pool_t>(std::map<long, pg_pool_t, 
> > std::less<long>, std::allocator<std::pair<long const, pg_pool_t> > 
> > >&, ceph::buffer::list::iterator&)+0x91) [0x7fe23c3c8851]
> >  11: (OSDMap::decode(ceph::buffer::list&)+0x17d) [0x7fe23c3befcd]
> >  12: (Objecter::handle_osd_map(MOSDMap*)+0x1e9f) [0x7fe23c3033ff]
> >  13: (librados::RadosClient::_dispatch(Message*)+0x54) 
> > [0x7fe23c2e3e44]
> >  14: (librados::RadosClient::ms_dispatch(Message*)+0x33) 
> > [0x7fe23c2e3ef3]
> >  15: (SimpleMessenger::dispatch_entry()+0x76b) [0x47ea1b]
> >  16: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x46995c]
> >  17: (()+0x7e9a) [0x7fe23c04de9a]
> >  18: (clone()+0x6d) [0x7fe23a86f77d] Aborted (core dumped)
> 
> ARgh... I screwed this up.  I didn't introduce a new feature bit to 
> control encoding between client and daemons because it would force an 
> upgrade, and I forgot that the OSDMap was affected.
> 
> The easy solution is to upgrade the clients (librados in this case).  
> 
> The harder solution would be introduce a feature bit for v0.42 (or
> v0.42.1) and upgrade the servers instead, along with conditional 
> encoding for pg_pool_t and anything else that's included in OSDMap.
> 
> Sorry!
> 
> In the meantime, anyone who can't upgrade their clients along with the 
> servers should hold off on v0.42 (and let us know about it) so we can 
> fix it for v0.43...

Okay, we've pushed a fix for this to the stable branch--it wasn't as painful as I initially thought.  I'll start building a v0.42.1 point release based on that now.

In the meantime, you (or anyone else upgrading to v0.42) should pull the latest stable code, which includes ddc99983228e761f754e0038aecbe341d7e2181f.

Thanks!
sage


> 
> sage
> 
> 
> > 
> > However this command works on the same box:
> > root@server:/# echo "10.112.9.11,10.112.9.12,10.112.9.13 
> > name=admin,secret=AQBBg0NPeFt9MRAAg8AWG108I8sje82hzdjkiw== rbd 
> > demo.rbd" > /sys/bus/rbd/add root@server:/# ls -alh /dev/rbd*
> > brw-rw---- 1 root disk 251, 0 Feb 22 14:12 /dev/rbd0
> > 
> > /dev/rbd:
> > total 0
> > drwxr-xr-x  3 root root   60 Feb 22 14:12 .
> > drwxr-xr-x 16 root root 4.2K Feb 22 14:12 ..
> > drwxr-xr-x  2 root root   60 Feb 22 14:12 rbd
> > 
> > 
> > Confirming the below works as expected when run from any of the 3x servers within the Cluster:
> > root@ceph1:/etc/ceph# rbd ls
> > demo.rbd
> > root@ceph3:~# rbd -p rbd ls
> > demo.rbd
> > 
> > On the "client" KVM box, I have installed:
> > apt-get install ceph-common
> > modprobe rbd
> > 
> > Then created these two files:
> > ;-------------------------------------------------------------------
> > /etc/ceph/ceph.conf
> > ;-------------------------------------------------------------------
> > [global]
> >     ; enable secure authentication
> >     auth supported = cephx
> >     keyring = /etc/ceph/keyring.bin
> > 
> > [mon]
> > [mon.alpha]
> >         host = ceph1
> >         mon addr = 10.112.9.11:6789
> > 
> > [mon.bravo]
> >         host = ceph2
> >         mon addr = 10.112.9.12:6789
> > 
> > [mon.charlie]
> >         host = ceph3
> >         mon addr = 10.112.9.13:6789
> > 
> > 
> > ;-------------------------------------------------------------------
> > /etc/ceph/keyring.bin
> > ;-------------------------------------------------------------------
> > [client.admin]
> >         key = AQBBg0NPeFt9MRAAg8AWG108I8sje82hzdjkiw==
> > 
> > 
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > ceph-devel" in the body of a message to majordomo@vger.kernel.org 
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
> 




