From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph cluster is unreachable because of
 authentication failure
Date: Thu, 23 Jan 2014 06:32:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401230630150.18304@cobra.newdream.net>
References: <BLU0-SMTP1356EEDE6A8ACF94947F22ADFBF0@phx.gbl>
	<alpine.DEB.2.00.1401140654500.10628@cobra.newdream.net>
	<016D7F31-523E-4EC1-8222-7D4084BA400F@outlook.com>
	<BLU0-SMTP14487458FBE42B33537BD4EDFB90@phx.gbl>
	<alpine.DEB.2.00.1401160908170.3044@cobra.newdream.net>
	<BLU0-SMTP169D80D759610D226681DD3DFB80@phx.gbl>
	<alpine.DEB.2.00.1401170804180.304@cobra.newdream.net>
	<BLU0-SMTP65962E190D657BC79CFBB2DFBA0@phx.gbl>
	<alpine.DEB.2.00.1401200835050.2149@cobra.newdream.net>
	<BLU0-SMTP45470BC6BBFC330988AD1B9DFA70@phx.gbl>
	<52DFC439.5080506@inktank.com>
	<BLU0-SMTP3186ED17CE3EC156E4EA064DFA60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <BLU0-SMTP3186ED17CE3EC156E4EA064DFA60-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Guang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 23 Jan 2014, Guang wrote:
> Hi Joao,
> Thanks for your reply!
> 
> I captured the log after seeing the 'noin' keyword and the log is attached.
> 
> Meanwhile, while checking the monitor logs, I see it does election every few seconds and the election process could take several seconds, so that the cluster is doing election almost all the time (could that be the root cause that we see out of date cluster status and command failure?).
> 
> I captured one round of election logs and following is the log, please help to check. Thanks very much.

It looks like this election was triggered by a slow or misbehaving mon.1 
(10.193.207.131).  There isn't enough before or after to know what the 
pattern is (does it always ack the previous election but slowly?  maybe 
it's clock is off;  is its host overloaded or is it over a very slow 
link?).  I suspect, though, that you can get the cluster into quorum by 
just stopping the daemon.  Double-check the clock sync and then try to 
join it in.  Even with it down temporarily, though, the mons will become 
available.

sage

> 
> 2014-01-23 04:01:08.871622 7fa5fbe21700  5 mon.osd152@0(leader).elector(204008) handle_propose from mon.1
> 2014-01-23 04:01:08.871625 7fa5fbe21700  5 mon.osd152@0(leader).elector(204008)  got propose from old epoch, quorum is 0,2, mon.1 must have just started
> 2014-01-23 04:01:08.871627 7fa5fbe21700 10 mon.osd152@0(leader) e1 start_election
> 2014-01-23 04:01:08.871629 7fa5fbe21700 10 mon.osd152@0(electing) e1 _reset
> 2014-01-23 04:01:08.871635 7fa5fbe21700 10 mon.osd152@0(electing) e1 cancel_probe_timeout (none scheduled)
> 2014-01-23 04:01:08.871636 7fa5fbe21700 10 mon.osd152@0(electing) e1 timecheck_finish
> 2014-01-23 04:01:08.871640 7fa5fbe21700 10 mon.osd152@0(electing) e1 scrub_reset
> 2014-01-23 04:01:08.871642 7fa5fbe21700 10 mon.osd152@0(electing).paxos(paxos active c 4353345..4353903) restart -- canceling timeouts
> 2014-01-23 04:01:08.871646 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) restart
> 2014-01-23 04:01:08.871649 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart
> 2014-01-23 04:01:08.871651 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(osdmap 133136..134893) restart
> 2014-01-23 04:01:08.871653 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958) restart
> 2014-01-23 04:01:08.871654 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958)  canceling proposal_timer 0x47d3e40
> 2014-01-23 04:01:08.871657 7fa5fbe21700  7 mon.osd152@0(electing).log v1793958 _updated_log for mon.2 10.194.0.68:6789/0
> 2014-01-23 04:01:08.871663 7fa5fbe21700  1 -- 10.193.207.130:6789/0 --> 10.194.0.68:6789/0 -- route(log(last 39415) v1 tid 3682233) v2 -- ?+0 0x1236de80 con 0x301c8e0
> 2014-01-23 04:01:08.871677 7fa5fbe21700  7 mon.osd152@0(electing).log v1793958 _updated_log for mon.0 10.193.207.130:6789/0
> 2014-01-23 04:01:08.871681 7fa5fbe21700  1 -- 10.193.207.130:6789/0 --> 10.193.207.130:6789/0 -- log(last 192924) v1 -- ?+0 0x53ccec0 con 0x3018580
> 2014-01-23 04:01:08.871690 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(monmap 1..1) restart
> 2014-01-23 04:01:08.871693 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(auth 2010..2269) restart
> 2014-01-23 04:01:08.871696 7fa5fbe21700 10 mon.osd152@0(electing) e1 cancel_probe_timeout (none scheduled)
> 2014-01-23 04:01:08.871709 7fa5fbe21700  0 log [INF] : mon.osd152 calling new monitor election
> 2014-01-23 04:01:08.871732 7fa5fbe21700  1 -- 10.193.207.130:6789/0 --> mon.0 10.193.207.130:6789/0 -- log(2 entries) v1 -- ?+0 0x408b33c0
> 2014-01-23 04:01:08.871739 7fa5fbe21700  5 mon.osd152@0(electing).elector(204008) start -- can i be leader?
> 2014-01-23 04:01:08.871834 7fa5fbe21700  1 mon.osd152@0(electing).elector(204008) init, last seen epoch 204008
> 2014-01-23 04:01:08.871836 7fa5fbe21700 10 mon.osd152@0(electing).elector(204008) bump_epoch 204008 to 204009
> 2014-01-23 04:01:08.872379 7fa5fbe21700 10 mon.osd152@0(electing) e1 join_election
> 2014-01-23 04:01:08.872389 7fa5fbe21700 10 mon.osd152@0(electing) e1 _reset
> 2014-01-23 04:01:08.872391 7fa5fbe21700 10 mon.osd152@0(electing) e1 cancel_probe_timeout (none scheduled)
> 2014-01-23 04:01:08.872392 7fa5fbe21700 10 mon.osd152@0(electing) e1 timecheck_finish
> 2014-01-23 04:01:08.872394 7fa5fbe21700 10 mon.osd152@0(electing) e1 scrub_reset
> 2014-01-23 04:01:08.872396 7fa5fbe21700 10 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) restart -- canceling timeouts
> 2014-01-23 04:01:08.872399 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) restart
> 2014-01-23 04:01:08.872401 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart
> 2014-01-23 04:01:08.872403 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(osdmap 133136..134893) restart
> 2014-01-23 04:01:08.872404 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958) restart
> 2014-01-23 04:01:08.872406 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(monmap 1..1) restart
> 2014-01-23 04:01:08.872407 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(auth 2010..2269) restart
> 2014-01-23 04:01:08.872415 7fa5fbe21700  1 -- 10.193.207.130:6789/0 --> mon.1 10.193.207.131:6789/0 -- election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 -- ?+0 0x2d611d40
> 2014-01-23 04:01:08.872434 7fa5fbe21700  1 -- 10.193.207.130:6789/0 --> mon.2 10.194.0.68:6789/0 -- election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 -- ?+0 0x41505c40
> 2014-01-23 04:01:08.872456 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.2 10.194.0.68:6789/0 463485294 ==== election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 ==== 540+0+0 (3981094898 0 0) 0x2d610000 con 0x301c8e0
> 2014-01-23 04:01:08.872478 7fa5fbe21700  5 mon.osd152@0(electing).elector(204009) handle_propose from mon.2
> 2014-01-23 04:01:08.872485 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.0 10.193.207.130:6789/0 0 ==== log(2 entries) v1 ==== 0+0+0 (0 0 0) 0x1236e540 con 0x3018580
> 2014-01-23 04:01:08.872495 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958) dispatch log(2 entries) v1 from mon.0 10.193.207.130:6789/0
> 2014-01-23 04:01:08.872501 7fa5fbe21700  1 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) is_readable now=2014-01-23 04:01:08.872502 lease_expire=2014-01-23 04:01:13.871236 has v0 lc 4353903
> 2014-01-23 04:01:08.872509 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958)  waiting for paxos -> readable (v0)
> 2014-01-23 04:01:08.872511 7fa5fbe21700  1 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) is_readable now=2014-01-23 04:01:08.872512 lease_expire=2014-01-23 04:01:13.871236 has v0 lc 4353903
> 2014-01-23 04:01:08.872516 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.1 10.193.207.131:6789/0 398310803 ==== election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 ack 204007) v4 ==== 540+0+0 (382260333 0 0) 0x408b3600 con 0x301cba0
> 2014-01-23 04:01:08.872530 7fa5fbe21700  5 mon.osd152@0(electing).elector(204009) old epoch, dropping
> 2014-01-23 04:01:08.872534 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.0 10.193.207.130:6789/0 0 ==== log(2 entries) v1 ==== 0+0+0 (0 0 0) 0x41504c80 con 0x3018580
> 2014-01-23 04:01:08.872539 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958) dispatch log(2 entries) v1 from mon.0 10.193.207.130:6789/0
> 2014-01-23 04:01:08.872542 7fa5fbe21700  1 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) is_readable now=2014-01-23 04:01:08.872543 lease_expire=2014-01-23 04:01:13.871236 has v0 lc 4353903
> 2014-01-23 04:01:08.872547 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958)  waiting for paxos -> readable (v0)
> 2014-01-23 04:01:08.872548 7fa5fbe21700  1 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) is_readable now=2014-01-23 04:01:08.872549 lease_expire=2014-01-23 04:01:13.871236 has v0 lc 4353903
> 2014-01-23 04:01:08.872553 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.1 10.193.207.131:6789/0 398310804 ==== election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 ==== 540+0+0 (3981094898 0 0) 0x408b7740 con 0x301cba0
> 2014-01-23 04:01:08.872565 7fa5fbe21700  5 mon.osd152@0(electing).elector(204009) handle_propose from mon.1
> 2014-01-23 04:01:08.872568 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.0 10.193.207.130:6789/0 0 ==== log(last 192924) v1 ==== 0+0+0 (0 0 0) 0x53ccec0 con 0x3018580
> 2014-01-23 04:01:08.872824 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.0 10.193.207.130:6789/0 0 ==== log(2 entries) v1 ==== 0+0+0 (0 0 0) 0x408b33c0 con 0x3018580
> 2014-01-23 04:01:08.872830 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958) dispatch log(2 entries) v1 from mon.0 10.193.207.130:6789/0
> 2014-01-23 04:01:08.872834 7fa5fbe21700  1 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) is_readable now=2014-01-23 04:01:08.872835 lease_expire=2014-01-23 04:01:13.871236 has v0 lc 4353903
> 2014-01-23 04:01:08.872839 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958)  waiting for paxos -> readable (v0)
> 2014-01-23 04:01:08.872841 7fa5fbe21700  1 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) is_readable now=2014-01-23 04:01:08.872841 lease_expire=2014-01-23 04:01:13.871236 has v0 lc 4353903
> 2014-01-23 04:01:08.872846 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== osd.448 10.194.0.143:6816/357 1 ==== auth(proto 0 28 bytes epoch 1) v1 ==== 58+0+0 (1794778480 0 0) 0x25398fc0 con 0x25347640
> 2014-01-23 04:01:08.872854 7fa5fbe21700  5 mon.osd152@0(electing) e1 discarding message auth(proto 0 28 bytes epoch 1) v1 and sending client elsewhere
> 2014-01-23 04:01:08.872857 7fa5fbe21700  1 -- 10.193.207.130:6789/0 mark_down 0x25347640 -- 0x21ee4380
> 2014-01-23 04:01:08.874236 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.2 10.194.0.68:6789/0 463485295 ==== election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204011) v4 ==== 540+0+0 (229380923 0 0) 0x1236de80 con 0x301c8e0
> 2014-01-23 04:01:08.874266 7fa5fbe21700  5 mon.osd152@0(electing).elector(204009) handle_propose from mon.2
> 2014-01-23 04:01:08.874270 7fa5fbe21700 10 mon.osd152@0(electing).elector(204009) bump_epoch 204009 to 204011
> 2014-01-23 04:01:08.874755 7fa5fbe21700 10 mon.osd152@0(electing) e1 join_election
> 2014-01-23 04:01:08.874764 7fa5fbe21700 10 mon.osd152@0(electing) e1 _reset
> 2014-01-23 04:01:08.874767 7fa5fbe21700 10 mon.osd152@0(electing) e1 cancel_probe_timeout (none scheduled)
> 2014-01-23 04:01:08.874768 7fa5fbe21700 10 mon.osd152@0(electing) e1 timecheck_finish
> 2014-01-23 04:01:08.874770 7fa5fbe21700 10 mon.osd152@0(electing) e1 scrub_reset
> 2014-01-23 04:01:08.874771 7fa5fbe21700 10 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) restart -- canceling timeouts
> 2014-01-23 04:01:08.874775 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) restart
> 2014-01-23 04:01:08.874777 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart
> 2014-01-23 04:01:08.874779 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(osdmap 133136..134893) restart
> 2014-01-23 04:01:08.874780 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958) restart
> 2014-01-23 04:01:08.874782 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(monmap 1..1) restart
> 2014-01-23 04:01:08.874783 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(auth 2010..2269) restart
> 2014-01-23 04:01:08.874786 7fa5fbe21700 10 mon.osd152@0(electing) e1 start_election
> 2014-01-23 04:01:08.874787 7fa5fbe21700 10 mon.osd152@0(electing) e1 _reset
> 2014-01-23 04:01:08.874788 7fa5fbe21700 10 mon.osd152@0(electing) e1 cancel_probe_timeout (none scheduled)
> 2014-01-23 04:01:08.874790 7fa5fbe21700 10 mon.osd152@0(electing) e1 timecheck_finish
> 2014-01-23 04:01:08.874791 7fa5fbe21700 10 mon.osd152@0(electing) e1 scrub_reset
> 2014-01-23 04:01:08.874793 7fa5fbe21700 10 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) restart -- canceling timeouts
> 2014-01-23 04:01:08.874795 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) restart
> 2014-01-23 04:01:08.874797 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart
> 2014-01-23 04:01:08.874798 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(osdmap 133136..134893) restart
> 2014-01-23 04:01:08.874799 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958) restart
> 2014-01-23 04:01:08.874800 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(monmap 1..1) restart
> 2014-01-23 04:01:08.874801 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(auth 2010..2269) restart
> 2014-01-23 04:01:08.874803 7fa5fbe21700 10 mon.osd152@0(electing) e1 cancel_probe_timeout (none scheduled)
> 2014-01-23 04:01:08.874807 7fa5fbe21700  0 log [INF] : mon.osd152 calling new monitor election
> 2014-01-23 04:01:08.874824 7fa5fbe21700  1 -- 10.193.207.130:6789/0 --> mon.0 10.193.207.130:6789/0 -- log(2 entries) v1 -- ?+0 0x408b7740
> 2014-01-23 04:01:08.874831 7fa5fbe21700  5 mon.osd152@0(electing).elector(204011) start -- can i be leader?
> 2014-01-23 04:01:08.874867 7fa5fbe21700  1 mon.osd152@0(electing).elector(204011) init, last seen epoch 204011
> 2014-01-23 04:01:08.874873 7fa5fbe21700  1 -- 10.193.207.130:6789/0 --> mon.1 10.193.207.131:6789/0 -- election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204011) v4 -- ?+0 0x25398fc0
> 2014-01-23 04:01:08.874887 7fa5fbe21700  1 -- 10.193.207.130:6789/0 --> mon.2 10.194.0.68:6789/0 -- election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204011) v4 -- ?+0 0x408b4800
> 2014-01-23 04:01:08.874909 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.2 10.194.0.68:6789/0 463485296 ==== election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 ack 204011) v4 ==== 540+0+0 (1598534457 0 0) 0x2d6133c0 con 0x301c8e0
> 2014-01-23 04:01:08.874932 7fa5fbe21700  5 mon.osd152@0(electing).elector(204011) handle_ack from mon.2
> 2014-01-23 04:01:08.874936 7fa5fbe21700  5 mon.osd152@0(electing).elector(204011)  so far i have {0=34359738367,2=34359738367}
> 2014-01-23 04:01:08.874943 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.0 10.193.207.130:6789/0 0 ==== log(2 entries) v1 ==== 0+0+0 (0 0 0) 0x408b7740 con 0x3018580
> 2014-01-23 04:01:08.874959 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958) dispatch log(2 entries) v1 from mon.0 10.193.207.130:6789/0
> 2014-01-23 04:01:08.874963 7fa5fbe21700  1 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) is_readable now=2014-01-23 04:01:08.874964 lease_expire=2014-01-23 04:01:13.871236 has v0 lc 4353903
> 2014-01-23 04:01:08.874969 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958)  waiting for paxos -> readable (v0)
> 2014-01-23 04:01:08.874971 7fa5fbe21700  1 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) is_readable now=2014-01-23 04:01:08.874971 lease_expire=2014-01-23 04:01:13.871236 has v0 lc 4353903
> 2014-01-23 04:01:08.875528 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.2 10.194.0.68:6789/0 463485297 ==== election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 ack 204011) v4 ==== 540+0+0 (1598534457 0 0) 0x2d613600 con 0x301c8e0
> 2014-01-23 04:01:08.875553 7fa5fbe21700  5 mon.osd152@0(electing).elector(204011) handle_ack from mon.2
> 2014-01-23 04:01:08.875556 7fa5fbe21700  5 mon.osd152@0(electing).elector(204011)  so far i have {0=34359738367,2=34359738367}
> 2014-01-23 04:01:13.875028 7fa5fc822700  5 mon.osd152@0(electing).elector(204011) election timer expired
> 2014-01-23 04:01:13.875043 7fa5fc822700 10 mon.osd152@0(electing).elector(204011) bump_epoch 204011 to 204012
> 2014-01-23 04:01:13.875375 7fa5fc822700 10 mon.osd152@0(electing) e1 join_election
> 2014-01-23 04:01:13.875386 7fa5fc822700 10 mon.osd152@0(electing) e1 _reset
> 2014-01-23 04:01:13.875389 7fa5fc822700 10 mon.osd152@0(electing) e1 cancel_probe_timeout (none scheduled)
> 2014-01-23 04:01:13.875390 7fa5fc822700 10 mon.osd152@0(electing) e1 timecheck_finish
> 2014-01-23 04:01:13.875393 7fa5fc822700 10 mon.osd152@0(electing) e1 scrub_reset
> 2014-01-23 04:01:13.875395 7fa5fc822700 10 mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) restart -- canceling timeouts
> 2014-01-23 04:01:13.875401 7fa5fc822700 10 mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) restart
> 2014-01-23 04:01:13.875404 7fa5fc822700 10 mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart
> 2014-01-23 04:01:13.875407 7fa5fc822700 10 mon.osd152@0(electing).paxosservice(osdmap 133136..134893) restart
> 2014-01-23 04:01:13.875409 7fa5fc822700 10 mon.osd152@0(electing).paxosservice(logm 1793310..1793958) restart
> 2014-01-23 04:01:13.875411 7fa5fc822700 10 mon.osd152@0(electing).paxosservice(monmap 1..1) restart
> 2014-01-23 04:01:13.875413 7fa5fc822700 10 mon.osd152@0(electing).paxosservice(auth 2010..2269) restart
> 2014-01-23 04:01:13.875423 7fa5fc822700  1 -- 10.193.207.130:6789/0 --> mon.2 10.194.0.68:6789/0 -- election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 victory 204012) v4 -- ?+0 0x248bf980
> 2014-01-23 04:01:13.875445 7fa5fc822700 10 mon.osd152@0(electing) e1 win_election epoch 204012 quorum 0,2 features 34359738367
> 2014-01-23 04:01:13.875457 7fa5fc822700  0 log [INF] : mon.osd152@0 won leader election with quorum 0,2
> 2014-01-23 04:01:13.875481 7fa5fc822700  1 -- 10.193.207.130:6789/0 --> mon.0 10.193.207.130:6789/0 -- log(2 entries) v1 -- ?+0 0x248bc5c0
> 2014-01-23 04:01:13.875498 7fa5fc822700 10 mon.osd152@0(leader).paxos(paxos recovering c 4353345..4353903) leader_init -- starting paxos recovery
> 2014-01-23 04:01:13.875558 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <== mon.0 10.193.207.130:6789/0 0 ==== log(2 entries) v1 ==== 0+0+0 (0 0 0) 0x248bc5c0 con 0x3018580
> 2014-01-23 04:01:13.875690 7fa5fc822700 10 mon.osd152@0(leader).paxos(paxos recovering c 4353345..4353903) get_new_proposal_number = 9772500
> 2014-01-23 04:01:13.875703 7fa5fc822700 10 mon.osd152@0(leader).paxos(paxos recovering c 4353345..4353903) collect with pn 9772500
> 2014-01-23 04:01:13.875708 7fa5fc822700  1 -- 10.193.207.130:6789/0 --> mon.2 10.194.0.68:6789/0 -- paxos(collect lc 4353903 fc 4353345 pn 9772500 opn 0) v3 -- ?+0 0x167ceb80
> 2014-01-23 04:01:13.875725 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(pgmap 2388001..2388518) election_finished
> 2014-01-23 04:01:13.875729 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(pgmap 2388001..2388518) _active - not active
> 2014-01-23 04:01:13.875731 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(mdsmap 1..1) election_finished
> 2014-01-23 04:01:13.875733 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(mdsmap 1..1) _active - not active
> 2014-01-23 04:01:13.875735 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(osdmap 133136..134893) election_finished
> 2014-01-23 04:01:13.875737 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(osdmap 133136..134893) _active - not active
> 2014-01-23 04:01:13.875740 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(logm 1793310..1793958) election_finished
> 2014-01-23 04:01:13.875741 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(logm 1793310..1793958) _active - not active
> 2014-01-23 04:01:13.875743 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(monmap 1..1) election_finished
> 2014-01-23 04:01:13.875745 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(monmap 1..1) _active - not active
> 2014-01-23 04:01:13.875747 7fa5fc822700 10 mon.osd152@0(leader).paxosservice(auth 2010..2269) election_finished
> 
> 
