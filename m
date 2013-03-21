From: Joao Eduardo Luis <joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Unable to start ceph monitor in V0.59
Date: Thu, 21 Mar 2013 11:39:56 +0000
Message-ID: <514AF18C.4010602@inktank.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC62079F@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC62079F-0J0gbvR4kTiiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "Chen, Xiaoxi" <xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org' (ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org)" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 03/21/2013 11:23 AM, Chen, Xiaoxi wrote:
> Hi List,
>
>           I cannot start my monitor when I update my cluster to v0.59,
> pls note that I am not trying to upgrade,but by reinstall the ceph
> software stack and rerunning mkcephfs.  I have seen that the monitor
> change a lot after 0.58, is the mkcephfs still have bugs ?

It's the first time I'm seeing this error, and it appears to be on the 
auth subsystem instead of the monitor, but it can be related to the 
monitor nonetheless.

Any chance you can run the monitor with 'debug mon 20' and 'debug auth 
20' and point me to the resulting log (assuming this happens all the time)?

   -Joao


>
> Below is the log:
>
> 2013-03-21 08:17:41.127576 7f71c3610780  0 ceph version 0.59
> (cbae6a435c62899f857775f66659de052fb0e759), process ceph-mon, pid 1550
>
> 2013-03-21 08:17:41.131271 7f71c3610780  1 unable to open monitor store
> at /data/mon.ceph1
>
> 2013-03-21 08:17:41.131281 7f71c3610780  1 check for old monitor store
> format
>
> 2013-03-21 08:17:41.131409 7f71c3610780  1 store(/data/mon.ceph1) mount
>
> 2013-03-21 08:17:41.131430 7f71c3610780  1 store(/data/mon.ceph1) mount
>
> 2013-03-21 08:17:41.131659 7f71c3610780  1 found old GV monitor store
> format -- should convert!
>
> 2013-03-21 08:17:41.136476 7f71c3610780  1 store(/data/mon.ceph1) mount
>
> 2013-03-21 08:17:46.098118 7f71c3610780  1 _convert_paxos first gv 2
> last gv 475156
>
> 2013-03-21 08:17:47.131667 7f71c3610780  0 convert finished conversion
>
> 2013-03-21 08:17:47.185261 7f71c3610780  1 mon.ceph1@-1(probing) e1
> preinit fsid 6d4e68d7-8959-4e8e-90c9-7e43f508f16a
>
> 2013-03-21 08:17:47.220874 7f71c3610780  0 mon.ceph1@-1(probing) e1  my
> rank is now 0 (was -1)
>
> 2013-03-21 08:17:47.220905 7f71c3610780  1 mon.ceph1@0(probing) e1
> win_standalone_election
>
> 2013-03-21 08:17:47.221808 7f71c3610780  0 log [INF] : mon.ceph1@0 won
> leader election with quorum 0
>
> 2013-03-21 08:17:47.238542 7f71c3610780  0 log [INF] : pgmap v217425:
> 10368 pgs: 140 active+clean, 3 stale+active+recovering, 2 stal
>
> e, 67 stale+active, 2 active+recovery_wait, 99 stale+active+clean, 819
> peering, 5 stale+active+degraded+wait_backfill, 3 stale+activ
>
> e+recovery_wait, 3760 down+peering, 12 stale+active+recovering+degraded,
> 305 stale+peering, 3977 stale+down+peering, 1135 stale+acti
>
> ve+degraded, 2 stale+active+degraded+backfilling, 4
> stale+active+degraded+remapped+wait_backfill, 6 incomplete, 1
> stale+remapped+pee
>
> ring, 17 stale+incomplete, 1 stale+active+degraded+remapped, 8
> active+recovering; 2717 GB data, 2015 GB used, 15441 GB / 17457 GB av
>
> ail; 90413/1391836 degraded (6.496%); 250/695918 unfound (0.036%)
>
> 2013-03-21 08:17:47.239560 7f71c3610780  0 log [INF] : mdsmap e1: 0/0/1 up
>
> 2013-03-21 08:17:47.240448 7f71c3610780  0 log [INF] : osdmap e5056: 80
> osds: 25 up, 25 in
>
> 2013-03-21 08:17:47.241019 7f71c3610780  0 log [INF] : monmap e1: 1 mons
> at {ceph1=192.168.10.11:6789/0}
>
> 2013-03-21 08:17:47.441000 7f71bc1d1700 -1
> auth/none/AuthNoneServiceHandler.h: In function 'virtual int
> AuthNoneServiceHandler::hand
>
> le_request(ceph::buffer::list::iterator&, ceph::bufferlist&, uint64_t&,
> AuthCapsInfo&, uint64_t*)' thread 7f71bc1d1700 time 2013-03-
>
> 21 08:17:47.440030
>
> auth/none/AuthNoneServiceHandler.h: 35: FAILED assert(0)
>
> ceph version 0.59 (cbae6a435c62899f857775f66659de052fb0e759)
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
