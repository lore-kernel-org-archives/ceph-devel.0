From: Guang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph cluster is unreachable because of
	authentication failure
Date: Fri, 24 Jan 2014 19:41:08 +0800
Message-ID: <BLU0-SMTP461882F11F7B298D3D58ED9DFA10@phx.gbl>
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
	<alpine.DEB.2.00.1401230630150.18304@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/mixed; boundary="===============1014171793=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1401230630150.18304-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1014171793==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_2727DA0F-6F43-48D0-BC2D-5C7EBB03BAB2"

--Apple-Mail=_2727DA0F-6F43-48D0-BC2D-5C7EBB03BAB2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Thanks Sage.

Even after I stopped mon.1 (19.193.207.131), the problem still =
persisted, those two left mons kept electing.

I checked the network, clock and they are all good.=20

One problem I noticed is the %CPU of the monitor being elected as =
leader, it is always around 100%, no matter we have 3 monitors in or 2 =
monitors in, the other monitor's %CPU are less than 10%.

I used *pstack* checking the busy one and have the following result, =
looks like thread #25 make it busy.

Meanwhile, I kept seeing the logs like '2014-01-24 11:03:18.959087 =
7f87eff4b700  0 mon.osd153@1(leader) e1 handle_command =
mon_command({"prefix": "osd crush create-or-move", "args": =
["root=3Ddefault", "host=3Dosd84"], "id": 725, "weight": =
3.6299999999999999} v 0) v1' from within the leader's log, though all =
OSDs were stopped at the time, is it like event replay?

bash-4.1$ sudo pstack 1159
Thread 30 (Thread 0x7f87f7619700 (LWP 1160)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007b7acb in ceph::log::Log::entry() ()
#2  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#3  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 29 (Thread 0x7f87f64bd700 (LWP 1161)):
#0  0x00000037a980d811 in sem_timedwait () from /lib64/libpthread.so.0
#1  0x000000000070de60 in CephContextServiceThread::entry() ()
#2  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#3  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 28 (Thread 0x7f87f5abc700 (LWP 1162)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x0000000000705d5a in AdminSocket::entry() ()
#2  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#3  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 27 (Thread 0x7f87f134d700 (LWP 1163)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x0000000000731d31 in SimpleMessenger::reaper_entry() ()
#2  0x000000000073475d in SimpleMessenger::ReaperThread::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 26 (Thread 0x7f87f094c700 (LWP 1164)):
#0  0x00000037a980e054 in __lll_lock_wait () from /lib64/libpthread.so.0
#1  0x00000037a9810e1d in _L_cond_lock_886 () from =
/lib64/libpthread.so.0
#2  0x00000037a9810cf7 in __pthread_mutex_cond_lock () from =
/lib64/libpthread.so.0
#3  0x00000037a980b875 in pthread_cond_timedwait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#4  0x000000000072715e in SafeTimer::timer_thread() ()
#5  0x0000000000728fbd in SafeTimerThread::entry() ()
#6  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#7  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 25 (Thread 0x7f87eff4b700 (LWP 1165)):
#0  0x0000000000707e8e in crush_hash32_3 ()
#1  0x0000000000734c14 in crush_choose ()
#2  0x000000000073518f in crush_do_rule ()
#3  0x000000000068a8a3 in CrushWrapper::do_rule(int, int, =
std::vector<int, std::allocator<int> >&, int, std::vector<unsigned int, =
std::allocator<unsigned int> > const&) const ()
#4  0x0000000000720dff in OSDMap::_pg_to_osds(pg_pool_t const&, pg_t, =
std::vector<int, std::allocator<int> >&) const ()
#5  0x0000000000720ff1 in OSDMap::pg_to_raw_up(pg_t, std::vector<int, =
std::allocator<int> >&) const ()
#6  0x0000000000590ee6 in OSDMonitor::remove_redundant_pg_temp() ()
#7  0x00000000005adfb5 in OSDMonitor::create_pending() ()
#8  0x000000000058cca9 in PaxosService::_active() ()
#9  0x000000000056063a in Context::complete(int) ()
#10 0x000000000056424d in finish_contexts(CephContext*, =
std::list<Context*, std::allocator<Context*> >&, int) ()
#11 0x000000000058461e in Paxos::handle_last(MMonPaxos*) ()
#12 0x000000000058579b in Paxos::dispatch(PaxosServiceMessage*) ()
#13 0x000000000055c9ca in Monitor::_ms_dispatch(Message*) ()
#14 0x0000000000578502 in Monitor::ms_dispatch(Message*) ()
#15 0x00000000007bc552 in DispatchQueue::entry() ()
#16 0x000000000073268d in DispatchQueue::DispatchThread::entry() ()
#17 0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#18 0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 24 (Thread 0x7f87ef54a700 (LWP 1166)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007db3f9 in Accepter::entry() ()
#2  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#3  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 23 (Thread 0x7f87eea48700 (LWP 1168)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007ccc89 in Pipe::writer() ()
#2  0x00000000007da52d in Pipe::Writer::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 22 (Thread 0x7f87ee947700 (LWP 1169)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x0000000000646726 in SignalHandler::entry() ()
#2  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#3  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 21 (Thread 0x7f87eeb49700 (LWP 1173)):
#0  0x00000037a980b7bb in pthread_cond_timedwait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007c7147 in Pipe::fault(bool) ()
#2  0x00000000007c97a2 in Pipe::connect() ()
#3  0x00000000007ccf63 in Pipe::writer() ()
#4  0x00000000007da52d in Pipe::Writer::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 20 (Thread 0x7f87edc33700 (LWP 1195)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007c08f9 in Pipe::tcp_read_wait() ()
#2  0x00000000007c8755 in Pipe::tcp_read(char*, int) ()
#3  0x00000000007d757f in Pipe::reader() ()
#4  0x00000000007da54d in Pipe::Reader::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 19 (Thread 0x7f87edb32700 (LWP 1196)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007ccc89 in Pipe::writer() ()
#2  0x00000000007da52d in Pipe::Writer::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 18 (Thread 0x7f87eda31700 (LWP 1197)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007c08f9 in Pipe::tcp_read_wait() ()
#2  0x00000000007c8755 in Pipe::tcp_read(char*, int) ()
#3  0x00000000007d757f in Pipe::reader() ()
#4  0x00000000007da54d in Pipe::Reader::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 17 (Thread 0x7f87ed930700 (LWP 1198)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007ccc89 in Pipe::writer() ()
#2  0x00000000007da52d in Pipe::Writer::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 16 (Thread 0x7f87edd34700 (LWP 1205)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007c08f9 in Pipe::tcp_read_wait() ()
#2  0x00000000007c8755 in Pipe::tcp_read(char*, int) ()
#3  0x00000000007d757f in Pipe::reader() ()
#4  0x00000000007da54d in Pipe::Reader::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 15 (Thread 0x7f87ede35700 (LWP 1211)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007c08f9 in Pipe::tcp_read_wait() ()
#2  0x00000000007c8755 in Pipe::tcp_read(char*, int) ()
#3  0x00000000007d757f in Pipe::reader() ()
#4  0x00000000007da54d in Pipe::Reader::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 14 (Thread 0x7f87ed82f700 (LWP 1212)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007ccc89 in Pipe::writer() ()
#2  0x00000000007da52d in Pipe::Writer::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 13 (Thread 0x7f87ed72e700 (LWP 1213)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007c08f9 in Pipe::tcp_read_wait() ()
#2  0x00000000007c8755 in Pipe::tcp_read(char*, int) ()
#3  0x00000000007d757f in Pipe::reader() ()
#4  0x00000000007da54d in Pipe::Reader::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 12 (Thread 0x7f87ed62d700 (LWP 1214)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007ccc89 in Pipe::writer() ()
#2  0x00000000007da52d in Pipe::Writer::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7f87ed52c700 (LWP 1215)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007c08f9 in Pipe::tcp_read_wait() ()
#2  0x00000000007c8755 in Pipe::tcp_read(char*, int) ()
#3  0x00000000007d757f in Pipe::reader() ()
#4  0x00000000007da54d in Pipe::Reader::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7f87ed42b700 (LWP 1216)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007ccc89 in Pipe::writer() ()
#2  0x00000000007da52d in Pipe::Writer::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7f87ed32a700 (LWP 1217)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007c08f9 in Pipe::tcp_read_wait() ()
#2  0x00000000007c8755 in Pipe::tcp_read(char*, int) ()
#3  0x00000000007d757f in Pipe::reader() ()
#4  0x00000000007da54d in Pipe::Reader::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7f87ed229700 (LWP 1218)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007ccc89 in Pipe::writer() ()
#2  0x00000000007da52d in Pipe::Writer::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 7 (Thread 0x7f87ecf26700 (LWP 1221)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007c08f9 in Pipe::tcp_read_wait() ()
#2  0x00000000007c8755 in Pipe::tcp_read(char*, int) ()
#3  0x00000000007d757f in Pipe::reader() ()
#4  0x00000000007da54d in Pipe::Reader::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 6 (Thread 0x7f87ece25700 (LWP 1222)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007ccc89 in Pipe::writer() ()
#2  0x00000000007da52d in Pipe::Writer::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7f87ecd24700 (LWP 1223)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007c08f9 in Pipe::tcp_read_wait() ()
#2  0x00000000007c8755 in Pipe::tcp_read(char*, int) ()
#3  0x00000000007d757f in Pipe::reader() ()
#4  0x00000000007da54d in Pipe::Reader::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7f87ecc23700 (LWP 1224)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007ccc89 in Pipe::writer() ()
#2  0x00000000007da52d in Pipe::Writer::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7f87ecb22700 (LWP 1225)):
#0  0x00000037a94df253 in poll () from /lib64/libc.so.6
#1  0x00000000007c08f9 in Pipe::tcp_read_wait() ()
#2  0x00000000007c8755 in Pipe::tcp_read(char*, int) ()
#3  0x00000000007d757f in Pipe::reader() ()
#4  0x00000000007da54d in Pipe::Reader::entry() ()
#5  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#6  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7f87eca21700 (LWP 1226)):
#0  0x00000037a980b43c in pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0
#1  0x00000000007ccc89 in Pipe::writer() ()
#2  0x00000000007da52d in Pipe::Writer::entry() ()
#3  0x00000037a9807851 in start_thread () from /lib64/libpthread.so.0
#4  0x00000037a94e890d in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7f87f761a7a0 (LWP 1159)):
#0  0x00000037a98080ad in pthread_join () from /lib64/libpthread.so.0
#1  0x0000000000735352 in Thread::join(void**) ()
#2  0x000000000072f8ba in SimpleMessenger::wait() ()
#3  0x00000000005202fa in main ()


On Jan 23, 2014, at 10:32 PM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Thu, 23 Jan 2014, Guang wrote:
>> Hi Joao,
>> Thanks for your reply!
>>=20
>> I captured the log after seeing the 'noin' keyword and the log is =
attached.
>>=20
>> Meanwhile, while checking the monitor logs, I see it does election =
every few seconds and the election process could take several seconds, =
so that the cluster is doing election almost all the time (could that be =
the root cause that we see out of date cluster status and command =
failure?).
>>=20
>> I captured one round of election logs and following is the log, =
please help to check. Thanks very much.
>=20
> It looks like this election was triggered by a slow or misbehaving =
mon.1=20
> (10.193.207.131).  There isn't enough before or after to know what the=20=

> pattern is (does it always ack the previous election but slowly?  =
maybe=20
> it's clock is off;  is its host overloaded or is it over a very slow=20=

> link?).  I suspect, though, that you can get the cluster into quorum =
by=20
> just stopping the daemon.  Double-check the clock sync and then try to=20=

> join it in.  Even with it down temporarily, though, the mons will =
become=20
> available.
>=20
> sage
>=20
>>=20
>> 2014-01-23 04:01:08.871622 7fa5fbe21700  5 =
mon.osd152@0(leader).elector(204008) handle_propose from mon.1
>> 2014-01-23 04:01:08.871625 7fa5fbe21700  5 =
mon.osd152@0(leader).elector(204008)  got propose from old epoch, quorum =
is 0,2, mon.1 must have just started
>> 2014-01-23 04:01:08.871627 7fa5fbe21700 10 mon.osd152@0(leader) e1 =
start_election
>> 2014-01-23 04:01:08.871629 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
_reset
>> 2014-01-23 04:01:08.871635 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)
>> 2014-01-23 04:01:08.871636 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
timecheck_finish
>> 2014-01-23 04:01:08.871640 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
scrub_reset
>> 2014-01-23 04:01:08.871642 7fa5fbe21700 10 =
mon.osd152@0(electing).paxos(paxos active c 4353345..4353903) restart -- =
canceling timeouts
>> 2014-01-23 04:01:08.871646 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) restart
>> 2014-01-23 04:01:08.871649 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart
>> 2014-01-23 04:01:08.871651 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) restart
>> 2014-01-23 04:01:08.871653 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) restart
>> 2014-01-23 04:01:08.871654 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958)  canceling =
proposal_timer 0x47d3e40
>> 2014-01-23 04:01:08.871657 7fa5fbe21700  7 mon.osd152@0(electing).log =
v1793958 _updated_log for mon.2 10.194.0.68:6789/0
>> 2014-01-23 04:01:08.871663 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
--> 10.194.0.68:6789/0 -- route(log(last 39415) v1 tid 3682233) v2 -- =
?+0 0x1236de80 con 0x301c8e0
>> 2014-01-23 04:01:08.871677 7fa5fbe21700  7 mon.osd152@0(electing).log =
v1793958 _updated_log for mon.0 10.193.207.130:6789/0
>> 2014-01-23 04:01:08.871681 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
--> 10.193.207.130:6789/0 -- log(last 192924) v1 -- ?+0 0x53ccec0 con =
0x3018580
>> 2014-01-23 04:01:08.871690 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(monmap 1..1) restart
>> 2014-01-23 04:01:08.871693 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(auth 2010..2269) restart
>> 2014-01-23 04:01:08.871696 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)
>> 2014-01-23 04:01:08.871709 7fa5fbe21700  0 log [INF] : mon.osd152 =
calling new monitor election
>> 2014-01-23 04:01:08.871732 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
--> mon.0 10.193.207.130:6789/0 -- log(2 entries) v1 -- ?+0 0x408b33c0
>> 2014-01-23 04:01:08.871739 7fa5fbe21700  5 =
mon.osd152@0(electing).elector(204008) start -- can i be leader?
>> 2014-01-23 04:01:08.871834 7fa5fbe21700  1 =
mon.osd152@0(electing).elector(204008) init, last seen epoch 204008
>> 2014-01-23 04:01:08.871836 7fa5fbe21700 10 =
mon.osd152@0(electing).elector(204008) bump_epoch 204008 to 204009
>> 2014-01-23 04:01:08.872379 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
join_election
>> 2014-01-23 04:01:08.872389 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
_reset
>> 2014-01-23 04:01:08.872391 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)
>> 2014-01-23 04:01:08.872392 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
timecheck_finish
>> 2014-01-23 04:01:08.872394 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
scrub_reset
>> 2014-01-23 04:01:08.872396 7fa5fbe21700 10 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
restart -- canceling timeouts
>> 2014-01-23 04:01:08.872399 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) restart
>> 2014-01-23 04:01:08.872401 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart
>> 2014-01-23 04:01:08.872403 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) restart
>> 2014-01-23 04:01:08.872404 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) restart
>> 2014-01-23 04:01:08.872406 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(monmap 1..1) restart
>> 2014-01-23 04:01:08.872407 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(auth 2010..2269) restart
>> 2014-01-23 04:01:08.872415 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
--> mon.1 10.193.207.131:6789/0 -- =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 -- ?+0 =
0x2d611d40
>> 2014-01-23 04:01:08.872434 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
--> mon.2 10.194.0.68:6789/0 -- =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 -- ?+0 =
0x41505c40
>> 2014-01-23 04:01:08.872456 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.2 10.194.0.68:6789/0 463485294 =3D=3D=3D=3D =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 =3D=3D=3D=
=3D 540+0+0 (3981094898 0 0) 0x2d610000 con 0x301c8e0
>> 2014-01-23 04:01:08.872478 7fa5fbe21700  5 =
mon.osd152@0(electing).elector(204009) handle_propose from mon.2
>> 2014-01-23 04:01:08.872485 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.0 10.193.207.130:6789/0 0 =3D=3D=3D=3D log(2 entries) v1 =
=3D=3D=3D=3D 0+0+0 (0 0 0) 0x1236e540 con 0x3018580
>> 2014-01-23 04:01:08.872495 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) dispatch =
log(2 entries) v1 from mon.0 10.193.207.130:6789/0
>> 2014-01-23 04:01:08.872501 7fa5fbe21700  1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.872502 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903
>> 2014-01-23 04:01:08.872509 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958)  waiting for =
paxos -> readable (v0)
>> 2014-01-23 04:01:08.872511 7fa5fbe21700  1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.872512 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903
>> 2014-01-23 04:01:08.872516 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.1 10.193.207.131:6789/0 398310803 =3D=3D=3D=3D =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 ack 204007) v4 =3D=3D=3D=3D =
540+0+0 (382260333 0 0) 0x408b3600 con 0x301cba0
>> 2014-01-23 04:01:08.872530 7fa5fbe21700  5 =
mon.osd152@0(electing).elector(204009) old epoch, dropping
>> 2014-01-23 04:01:08.872534 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.0 10.193.207.130:6789/0 0 =3D=3D=3D=3D log(2 entries) v1 =
=3D=3D=3D=3D 0+0+0 (0 0 0) 0x41504c80 con 0x3018580
>> 2014-01-23 04:01:08.872539 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) dispatch =
log(2 entries) v1 from mon.0 10.193.207.130:6789/0
>> 2014-01-23 04:01:08.872542 7fa5fbe21700  1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.872543 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903
>> 2014-01-23 04:01:08.872547 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958)  waiting for =
paxos -> readable (v0)
>> 2014-01-23 04:01:08.872548 7fa5fbe21700  1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.872549 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903
>> 2014-01-23 04:01:08.872553 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.1 10.193.207.131:6789/0 398310804 =3D=3D=3D=3D =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 =3D=3D=3D=
=3D 540+0+0 (3981094898 0 0) 0x408b7740 con 0x301cba0
>> 2014-01-23 04:01:08.872565 7fa5fbe21700  5 =
mon.osd152@0(electing).elector(204009) handle_propose from mon.1
>> 2014-01-23 04:01:08.872568 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.0 10.193.207.130:6789/0 0 =3D=3D=3D=3D log(last 192924) v1 =
=3D=3D=3D=3D 0+0+0 (0 0 0) 0x53ccec0 con 0x3018580
>> 2014-01-23 04:01:08.872824 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.0 10.193.207.130:6789/0 0 =3D=3D=3D=3D log(2 entries) v1 =
=3D=3D=3D=3D 0+0+0 (0 0 0) 0x408b33c0 con 0x3018580
>> 2014-01-23 04:01:08.872830 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) dispatch =
log(2 entries) v1 from mon.0 10.193.207.130:6789/0
>> 2014-01-23 04:01:08.872834 7fa5fbe21700  1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.872835 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903
>> 2014-01-23 04:01:08.872839 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958)  waiting for =
paxos -> readable (v0)
>> 2014-01-23 04:01:08.872841 7fa5fbe21700  1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.872841 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903
>> 2014-01-23 04:01:08.872846 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D osd.448 10.194.0.143:6816/357 1 =3D=3D=3D=3D auth(proto 0 28 =
bytes epoch 1) v1 =3D=3D=3D=3D 58+0+0 (1794778480 0 0) 0x25398fc0 con =
0x25347640
>> 2014-01-23 04:01:08.872854 7fa5fbe21700  5 mon.osd152@0(electing) e1 =
discarding message auth(proto 0 28 bytes epoch 1) v1 and sending client =
elsewhere
>> 2014-01-23 04:01:08.872857 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
mark_down 0x25347640 -- 0x21ee4380
>> 2014-01-23 04:01:08.874236 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.2 10.194.0.68:6789/0 463485295 =3D=3D=3D=3D =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204011) v4 =3D=3D=3D=
=3D 540+0+0 (229380923 0 0) 0x1236de80 con 0x301c8e0
>> 2014-01-23 04:01:08.874266 7fa5fbe21700  5 =
mon.osd152@0(electing).elector(204009) handle_propose from mon.2
>> 2014-01-23 04:01:08.874270 7fa5fbe21700 10 =
mon.osd152@0(electing).elector(204009) bump_epoch 204009 to 204011
>> 2014-01-23 04:01:08.874755 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
join_election
>> 2014-01-23 04:01:08.874764 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
_reset
>> 2014-01-23 04:01:08.874767 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)
>> 2014-01-23 04:01:08.874768 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
timecheck_finish
>> 2014-01-23 04:01:08.874770 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
scrub_reset
>> 2014-01-23 04:01:08.874771 7fa5fbe21700 10 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
restart -- canceling timeouts
>> 2014-01-23 04:01:08.874775 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) restart
>> 2014-01-23 04:01:08.874777 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart
>> 2014-01-23 04:01:08.874779 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) restart
>> 2014-01-23 04:01:08.874780 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) restart
>> 2014-01-23 04:01:08.874782 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(monmap 1..1) restart
>> 2014-01-23 04:01:08.874783 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(auth 2010..2269) restart
>> 2014-01-23 04:01:08.874786 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
start_election
>> 2014-01-23 04:01:08.874787 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
_reset
>> 2014-01-23 04:01:08.874788 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)
>> 2014-01-23 04:01:08.874790 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
timecheck_finish
>> 2014-01-23 04:01:08.874791 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
scrub_reset
>> 2014-01-23 04:01:08.874793 7fa5fbe21700 10 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
restart -- canceling timeouts
>> 2014-01-23 04:01:08.874795 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) restart
>> 2014-01-23 04:01:08.874797 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart
>> 2014-01-23 04:01:08.874798 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) restart
>> 2014-01-23 04:01:08.874799 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) restart
>> 2014-01-23 04:01:08.874800 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(monmap 1..1) restart
>> 2014-01-23 04:01:08.874801 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(auth 2010..2269) restart
>> 2014-01-23 04:01:08.874803 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)
>> 2014-01-23 04:01:08.874807 7fa5fbe21700  0 log [INF] : mon.osd152 =
calling new monitor election
>> 2014-01-23 04:01:08.874824 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
--> mon.0 10.193.207.130:6789/0 -- log(2 entries) v1 -- ?+0 0x408b7740
>> 2014-01-23 04:01:08.874831 7fa5fbe21700  5 =
mon.osd152@0(electing).elector(204011) start -- can i be leader?
>> 2014-01-23 04:01:08.874867 7fa5fbe21700  1 =
mon.osd152@0(electing).elector(204011) init, last seen epoch 204011
>> 2014-01-23 04:01:08.874873 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
--> mon.1 10.193.207.131:6789/0 -- =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204011) v4 -- ?+0 =
0x25398fc0
>> 2014-01-23 04:01:08.874887 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
--> mon.2 10.194.0.68:6789/0 -- =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204011) v4 -- ?+0 =
0x408b4800
>> 2014-01-23 04:01:08.874909 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.2 10.194.0.68:6789/0 463485296 =3D=3D=3D=3D =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 ack 204011) v4 =3D=3D=3D=3D =
540+0+0 (1598534457 0 0) 0x2d6133c0 con 0x301c8e0
>> 2014-01-23 04:01:08.874932 7fa5fbe21700  5 =
mon.osd152@0(electing).elector(204011) handle_ack from mon.2
>> 2014-01-23 04:01:08.874936 7fa5fbe21700  5 =
mon.osd152@0(electing).elector(204011)  so far i have =
{0=3D34359738367,2=3D34359738367}
>> 2014-01-23 04:01:08.874943 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.0 10.193.207.130:6789/0 0 =3D=3D=3D=3D log(2 entries) v1 =
=3D=3D=3D=3D 0+0+0 (0 0 0) 0x408b7740 con 0x3018580
>> 2014-01-23 04:01:08.874959 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) dispatch =
log(2 entries) v1 from mon.0 10.193.207.130:6789/0
>> 2014-01-23 04:01:08.874963 7fa5fbe21700  1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.874964 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903
>> 2014-01-23 04:01:08.874969 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958)  waiting for =
paxos -> readable (v0)
>> 2014-01-23 04:01:08.874971 7fa5fbe21700  1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.874971 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903
>> 2014-01-23 04:01:08.875528 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.2 10.194.0.68:6789/0 463485297 =3D=3D=3D=3D =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 ack 204011) v4 =3D=3D=3D=3D =
540+0+0 (1598534457 0 0) 0x2d613600 con 0x301c8e0
>> 2014-01-23 04:01:08.875553 7fa5fbe21700  5 =
mon.osd152@0(electing).elector(204011) handle_ack from mon.2
>> 2014-01-23 04:01:08.875556 7fa5fbe21700  5 =
mon.osd152@0(electing).elector(204011)  so far i have =
{0=3D34359738367,2=3D34359738367}
>> 2014-01-23 04:01:13.875028 7fa5fc822700  5 =
mon.osd152@0(electing).elector(204011) election timer expired
>> 2014-01-23 04:01:13.875043 7fa5fc822700 10 =
mon.osd152@0(electing).elector(204011) bump_epoch 204011 to 204012
>> 2014-01-23 04:01:13.875375 7fa5fc822700 10 mon.osd152@0(electing) e1 =
join_election
>> 2014-01-23 04:01:13.875386 7fa5fc822700 10 mon.osd152@0(electing) e1 =
_reset
>> 2014-01-23 04:01:13.875389 7fa5fc822700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)
>> 2014-01-23 04:01:13.875390 7fa5fc822700 10 mon.osd152@0(electing) e1 =
timecheck_finish
>> 2014-01-23 04:01:13.875393 7fa5fc822700 10 mon.osd152@0(electing) e1 =
scrub_reset
>> 2014-01-23 04:01:13.875395 7fa5fc822700 10 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
restart -- canceling timeouts
>> 2014-01-23 04:01:13.875401 7fa5fc822700 10 =
mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) restart
>> 2014-01-23 04:01:13.875404 7fa5fc822700 10 =
mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart
>> 2014-01-23 04:01:13.875407 7fa5fc822700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) restart
>> 2014-01-23 04:01:13.875409 7fa5fc822700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) restart
>> 2014-01-23 04:01:13.875411 7fa5fc822700 10 =
mon.osd152@0(electing).paxosservice(monmap 1..1) restart
>> 2014-01-23 04:01:13.875413 7fa5fc822700 10 =
mon.osd152@0(electing).paxosservice(auth 2010..2269) restart
>> 2014-01-23 04:01:13.875423 7fa5fc822700  1 -- 10.193.207.130:6789/0 =
--> mon.2 10.194.0.68:6789/0 -- =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 victory 204012) v4 -- ?+0 =
0x248bf980
>> 2014-01-23 04:01:13.875445 7fa5fc822700 10 mon.osd152@0(electing) e1 =
win_election epoch 204012 quorum 0,2 features 34359738367
>> 2014-01-23 04:01:13.875457 7fa5fc822700  0 log [INF] : mon.osd152@0 =
won leader election with quorum 0,2
>> 2014-01-23 04:01:13.875481 7fa5fc822700  1 -- 10.193.207.130:6789/0 =
--> mon.0 10.193.207.130:6789/0 -- log(2 entries) v1 -- ?+0 0x248bc5c0
>> 2014-01-23 04:01:13.875498 7fa5fc822700 10 =
mon.osd152@0(leader).paxos(paxos recovering c 4353345..4353903) =
leader_init -- starting paxos recovery
>> 2014-01-23 04:01:13.875558 7fa5fbe21700  1 -- 10.193.207.130:6789/0 =
<=3D=3D mon.0 10.193.207.130:6789/0 0 =3D=3D=3D=3D log(2 entries) v1 =
=3D=3D=3D=3D 0+0+0 (0 0 0) 0x248bc5c0 con 0x3018580
>> 2014-01-23 04:01:13.875690 7fa5fc822700 10 =
mon.osd152@0(leader).paxos(paxos recovering c 4353345..4353903) =
get_new_proposal_number =3D 9772500
>> 2014-01-23 04:01:13.875703 7fa5fc822700 10 =
mon.osd152@0(leader).paxos(paxos recovering c 4353345..4353903) collect =
with pn 9772500
>> 2014-01-23 04:01:13.875708 7fa5fc822700  1 -- 10.193.207.130:6789/0 =
--> mon.2 10.194.0.68:6789/0 -- paxos(collect lc 4353903 fc 4353345 pn =
9772500 opn 0) v3 -- ?+0 0x167ceb80
>> 2014-01-23 04:01:13.875725 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(pgmap 2388001..2388518) =
election_finished
>> 2014-01-23 04:01:13.875729 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(pgmap 2388001..2388518) _active - not =
active
>> 2014-01-23 04:01:13.875731 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(mdsmap 1..1) election_finished
>> 2014-01-23 04:01:13.875733 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(mdsmap 1..1) _active - not active
>> 2014-01-23 04:01:13.875735 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) =
election_finished
>> 2014-01-23 04:01:13.875737 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) _active - not =
active
>> 2014-01-23 04:01:13.875740 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(logm 1793310..1793958) =
election_finished
>> 2014-01-23 04:01:13.875741 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(logm 1793310..1793958) _active - not =
active
>> 2014-01-23 04:01:13.875743 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(monmap 1..1) election_finished
>> 2014-01-23 04:01:13.875745 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(monmap 1..1) _active - not active
>> 2014-01-23 04:01:13.875747 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(auth 2010..2269) election_finished
>>=20
>>=20
>=20


--Apple-Mail=_2727DA0F-6F43-48D0-BC2D-5C7EBB03BAB2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="us-ascii"

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
">Thanks Sage.<div><br></div><div>Even after I stopped mon.1 =
(19.193.207.131), the problem still persisted, those two left mons kept =
electing.</div><div><br></div><div>I checked the network, clock and they =
are all good.&nbsp;</div><div><br></div><div>One problem I noticed is =
the %CPU of the monitor being elected as leader, it is always around =
100%, no matter we have 3 monitors in or 2 monitors in, the other =
monitor's %CPU are less than 10%.</div><div><br></div><div>I used =
*pstack* checking the busy one and have the following result, looks like =
thread #25 make it busy.</div><div><br></div><div>Meanwhile, I kept =
seeing the logs like '2014-01-24 11:03:18.959087 7f87eff4b700 &nbsp;0 =
mon.osd153@1(leader) e1 handle_command mon_command({"prefix": "osd crush =
create-or-move", "args": ["root=3Ddefault", "host=3Dosd84"], "id": 725, =
"weight": 3.6299999999999999} v 0) v1' from within the leader's log, =
though all OSDs were stopped at the time, is it like event =
replay?</div><div><br></div><div><div>bash-4.1$ sudo pstack =
1159</div><div>Thread 30 (Thread 0x7f87f7619700 (LWP =
1160)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007b7acb in =
ceph::log::Log::entry() ()</div><div>#2 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#3 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 29 (Thread 0x7f87f64bd700 (LWP =
1161)):</div><div>#0 &nbsp;0x00000037a980d811 in sem_timedwait () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x000000000070de60 in =
CephContextServiceThread::entry() ()</div><div>#2 =
&nbsp;0x00000037a9807851 in start_thread () from =
/lib64/libpthread.so.0</div><div>#3 &nbsp;0x00000037a94e890d in clone () =
from /lib64/libc.so.6</div><div>Thread 28 (Thread 0x7f87f5abc700 (LWP =
1162)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x0000000000705d5a in =
AdminSocket::entry() ()</div><div>#2 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#3 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 27 (Thread 0x7f87f134d700 (LWP =
1163)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x0000000000731d31 in =
SimpleMessenger::reaper_entry() ()</div><div>#2 &nbsp;0x000000000073475d =
in SimpleMessenger::ReaperThread::entry() ()</div><div>#3 =
&nbsp;0x00000037a9807851 in start_thread () from =
/lib64/libpthread.so.0</div><div>#4 &nbsp;0x00000037a94e890d in clone () =
from /lib64/libc.so.6</div><div>Thread 26 (Thread 0x7f87f094c700 (LWP =
1164)):</div><div>#0 &nbsp;0x00000037a980e054 in __lll_lock_wait () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000037a9810e1d in =
_L_cond_lock_886 () from /lib64/libpthread.so.0</div><div>#2 =
&nbsp;0x00000037a9810cf7 in __pthread_mutex_cond_lock () from =
/lib64/libpthread.so.0</div><div>#3 &nbsp;0x00000037a980b875 in =
pthread_cond_timedwait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#4 &nbsp;0x000000000072715e in =
SafeTimer::timer_thread() ()</div><div>#5 &nbsp;0x0000000000728fbd in =
SafeTimerThread::entry() ()</div><div>#6 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#7 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div><b>Thread 25 (Thread 0x7f87eff4b700 (LWP =
1165)):</b></div><div><b>#0 &nbsp;0x0000000000707e8e in crush_hash32_3 =
()</b></div><div><b>#1 &nbsp;0x0000000000734c14 in crush_choose =
()</b></div><div><b>#2 &nbsp;0x000000000073518f in crush_do_rule =
()</b></div><div><b>#3 &nbsp;0x000000000068a8a3 in =
CrushWrapper::do_rule(int, int, std::vector&lt;int, =
std::allocator&lt;int&gt; &gt;&amp;, int, std::vector&lt;unsigned int, =
std::allocator&lt;unsigned int&gt; &gt; const&amp;) const =
()</b></div><div><b>#4 &nbsp;0x0000000000720dff in =
OSDMap::_pg_to_osds(pg_pool_t const&amp;, pg_t, std::vector&lt;int, =
std::allocator&lt;int&gt; &gt;&amp;) const ()</b></div><div><b>#5 =
&nbsp;0x0000000000720ff1 in OSDMap::pg_to_raw_up(pg_t, =
std::vector&lt;int, std::allocator&lt;int&gt; &gt;&amp;) const =
()</b></div><div><b>#6 &nbsp;0x0000000000590ee6 in =
OSDMonitor::remove_redundant_pg_temp() ()</b></div><div><b>#7 =
&nbsp;0x00000000005adfb5 in OSDMonitor::create_pending() =
()</b></div><div><b>#8 &nbsp;0x000000000058cca9 in =
PaxosService::_active() ()</b></div><div><b>#9 &nbsp;0x000000000056063a =
in Context::complete(int) ()</b></div><div><b>#10 0x000000000056424d in =
finish_contexts(CephContext*, std::list&lt;Context*, =
std::allocator&lt;Context*&gt; &gt;&amp;, int) ()</b></div><div><b>#11 =
0x000000000058461e in Paxos::handle_last(MMonPaxos*) =
()</b></div><div><b>#12 0x000000000058579b in =
Paxos::dispatch(PaxosServiceMessage*) ()</b></div><div><b>#13 =
0x000000000055c9ca in Monitor::_ms_dispatch(Message*) =
()</b></div><div><b>#14 0x0000000000578502 in =
Monitor::ms_dispatch(Message*) ()</b></div><div><b>#15 =
0x00000000007bc552 in DispatchQueue::entry() ()</b></div><div><b>#16 =
0x000000000073268d in DispatchQueue::DispatchThread::entry() =
()</b></div><div><b>#17 0x00000037a9807851 in start_thread () from =
/lib64/libpthread.so.0</b></div><div><b>#18 0x00000037a94e890d in clone =
() from /lib64/libc.so.6</b></div><div>Thread 24 (Thread 0x7f87ef54a700 =
(LWP 1166)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007db3f9 in =
Accepter::entry() ()</div><div>#2 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#3 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 23 (Thread 0x7f87eea48700 (LWP =
1168)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007ccc89 in =
Pipe::writer() ()</div><div>#2 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#3 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#4 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 22 (Thread 0x7f87ee947700 (LWP =
1169)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x0000000000646726 in =
SignalHandler::entry() ()</div><div>#2 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#3 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 21 (Thread 0x7f87eeb49700 (LWP =
1173)):</div><div>#0 &nbsp;0x00000037a980b7bb in =
pthread_cond_timedwait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007c7147 in =
Pipe::fault(bool) ()</div><div>#2 &nbsp;0x00000000007c97a2 in =
Pipe::connect() ()</div><div>#3 &nbsp;0x00000000007ccf63 in =
Pipe::writer() ()</div><div>#4 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 20 (Thread 0x7f87edc33700 (LWP =
1195)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007c08f9 in =
Pipe::tcp_read_wait() ()</div><div>#2 &nbsp;0x00000000007c8755 in =
Pipe::tcp_read(char*, int) ()</div><div>#3 &nbsp;0x00000000007d757f in =
Pipe::reader() ()</div><div>#4 &nbsp;0x00000000007da54d in =
Pipe::Reader::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 19 (Thread 0x7f87edb32700 (LWP =
1196)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007ccc89 in =
Pipe::writer() ()</div><div>#2 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#3 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#4 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 18 (Thread 0x7f87eda31700 (LWP =
1197)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007c08f9 in =
Pipe::tcp_read_wait() ()</div><div>#2 &nbsp;0x00000000007c8755 in =
Pipe::tcp_read(char*, int) ()</div><div>#3 &nbsp;0x00000000007d757f in =
Pipe::reader() ()</div><div>#4 &nbsp;0x00000000007da54d in =
Pipe::Reader::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 17 (Thread 0x7f87ed930700 (LWP =
1198)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007ccc89 in =
Pipe::writer() ()</div><div>#2 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#3 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#4 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 16 (Thread 0x7f87edd34700 (LWP =
1205)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007c08f9 in =
Pipe::tcp_read_wait() ()</div><div>#2 &nbsp;0x00000000007c8755 in =
Pipe::tcp_read(char*, int) ()</div><div>#3 &nbsp;0x00000000007d757f in =
Pipe::reader() ()</div><div>#4 &nbsp;0x00000000007da54d in =
Pipe::Reader::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 15 (Thread 0x7f87ede35700 (LWP =
1211)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007c08f9 in =
Pipe::tcp_read_wait() ()</div><div>#2 &nbsp;0x00000000007c8755 in =
Pipe::tcp_read(char*, int) ()</div><div>#3 &nbsp;0x00000000007d757f in =
Pipe::reader() ()</div><div>#4 &nbsp;0x00000000007da54d in =
Pipe::Reader::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 14 (Thread 0x7f87ed82f700 (LWP =
1212)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007ccc89 in =
Pipe::writer() ()</div><div>#2 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#3 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#4 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 13 (Thread 0x7f87ed72e700 (LWP =
1213)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007c08f9 in =
Pipe::tcp_read_wait() ()</div><div>#2 &nbsp;0x00000000007c8755 in =
Pipe::tcp_read(char*, int) ()</div><div>#3 &nbsp;0x00000000007d757f in =
Pipe::reader() ()</div><div>#4 &nbsp;0x00000000007da54d in =
Pipe::Reader::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 12 (Thread 0x7f87ed62d700 (LWP =
1214)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007ccc89 in =
Pipe::writer() ()</div><div>#2 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#3 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#4 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 11 (Thread 0x7f87ed52c700 (LWP =
1215)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007c08f9 in =
Pipe::tcp_read_wait() ()</div><div>#2 &nbsp;0x00000000007c8755 in =
Pipe::tcp_read(char*, int) ()</div><div>#3 &nbsp;0x00000000007d757f in =
Pipe::reader() ()</div><div>#4 &nbsp;0x00000000007da54d in =
Pipe::Reader::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 10 (Thread 0x7f87ed42b700 (LWP =
1216)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007ccc89 in =
Pipe::writer() ()</div><div>#2 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#3 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#4 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 9 (Thread 0x7f87ed32a700 (LWP =
1217)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007c08f9 in =
Pipe::tcp_read_wait() ()</div><div>#2 &nbsp;0x00000000007c8755 in =
Pipe::tcp_read(char*, int) ()</div><div>#3 &nbsp;0x00000000007d757f in =
Pipe::reader() ()</div><div>#4 &nbsp;0x00000000007da54d in =
Pipe::Reader::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 8 (Thread 0x7f87ed229700 (LWP =
1218)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007ccc89 in =
Pipe::writer() ()</div><div>#2 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#3 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#4 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 7 (Thread 0x7f87ecf26700 (LWP =
1221)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007c08f9 in =
Pipe::tcp_read_wait() ()</div><div>#2 &nbsp;0x00000000007c8755 in =
Pipe::tcp_read(char*, int) ()</div><div>#3 &nbsp;0x00000000007d757f in =
Pipe::reader() ()</div><div>#4 &nbsp;0x00000000007da54d in =
Pipe::Reader::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 6 (Thread 0x7f87ece25700 (LWP =
1222)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007ccc89 in =
Pipe::writer() ()</div><div>#2 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#3 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#4 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 5 (Thread 0x7f87ecd24700 (LWP =
1223)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007c08f9 in =
Pipe::tcp_read_wait() ()</div><div>#2 &nbsp;0x00000000007c8755 in =
Pipe::tcp_read(char*, int) ()</div><div>#3 &nbsp;0x00000000007d757f in =
Pipe::reader() ()</div><div>#4 &nbsp;0x00000000007da54d in =
Pipe::Reader::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 4 (Thread 0x7f87ecc23700 (LWP =
1224)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007ccc89 in =
Pipe::writer() ()</div><div>#2 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#3 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#4 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 3 (Thread 0x7f87ecb22700 (LWP =
1225)):</div><div>#0 &nbsp;0x00000037a94df253 in poll () from =
/lib64/libc.so.6</div><div>#1 &nbsp;0x00000000007c08f9 in =
Pipe::tcp_read_wait() ()</div><div>#2 &nbsp;0x00000000007c8755 in =
Pipe::tcp_read(char*, int) ()</div><div>#3 &nbsp;0x00000000007d757f in =
Pipe::reader() ()</div><div>#4 &nbsp;0x00000000007da54d in =
Pipe::Reader::entry() ()</div><div>#5 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#6 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 2 (Thread 0x7f87eca21700 (LWP =
1226)):</div><div>#0 &nbsp;0x00000037a980b43c in =
pthread_cond_wait@@GLIBC_2.3.2 () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x00000000007ccc89 in =
Pipe::writer() ()</div><div>#2 &nbsp;0x00000000007da52d in =
Pipe::Writer::entry() ()</div><div>#3 &nbsp;0x00000037a9807851 in =
start_thread () from /lib64/libpthread.so.0</div><div>#4 =
&nbsp;0x00000037a94e890d in clone () from =
/lib64/libc.so.6</div><div>Thread 1 (Thread 0x7f87f761a7a0 (LWP =
1159)):</div><div>#0 &nbsp;0x00000037a98080ad in pthread_join () from =
/lib64/libpthread.so.0</div><div>#1 &nbsp;0x0000000000735352 in =
Thread::join(void**) ()</div><div>#2 &nbsp;0x000000000072f8ba in =
SimpleMessenger::wait() ()</div><div>#3 &nbsp;0x00000000005202fa in main =
()</div></div><div><br></div><div><br><div><div>On Jan 23, 2014, at =
10:32 PM, Sage Weil &lt;<a =
href=3D"mailto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite">On Thu, 23 Jan 2014, Guang wrote:<br><blockquote =
type=3D"cite">Hi Joao,<br>Thanks for your reply!<br><br>I captured the =
log after seeing the 'noin' keyword and the log is =
attached.<br><br>Meanwhile, while checking the monitor logs, I see it =
does election every few seconds and the election process could take =
several seconds, so that the cluster is doing election almost all the =
time (could that be the root cause that we see out of date cluster =
status and command failure?).<br><br>I captured one round of election =
logs and following is the log, please help to check. Thanks very =
much.<br></blockquote><br>It looks like this election was triggered by a =
slow or misbehaving mon.1 <br>(10.193.207.131). &nbsp;There isn't enough =
before or after to know what the <br>pattern is (does it always ack the =
previous election but slowly? &nbsp;maybe <br>it's clock is off; =
&nbsp;is its host overloaded or is it over a very slow <br>link?). =
&nbsp;I suspect, though, that you can get the cluster into quorum by =
<br>just stopping the daemon. &nbsp;Double-check the clock sync and then =
try to <br>join it in. &nbsp;Even with it down temporarily, though, the =
mons will become <br>available.<br><br>sage<br><br><blockquote =
type=3D"cite"><br>2014-01-23 04:01:08.871622 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(leader).elector(204008) handle_propose from =
mon.1<br>2014-01-23 04:01:08.871625 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(leader).elector(204008) &nbsp;got propose from old epoch, =
quorum is 0,2, mon.1 must have just started<br>2014-01-23 =
04:01:08.871627 7fa5fbe21700 10 mon.osd152@0(leader) e1 =
start_election<br>2014-01-23 04:01:08.871629 7fa5fbe21700 10 =
mon.osd152@0(electing) e1 _reset<br>2014-01-23 04:01:08.871635 =
7fa5fbe21700 10 mon.osd152@0(electing) e1 cancel_probe_timeout (none =
scheduled)<br>2014-01-23 04:01:08.871636 7fa5fbe21700 10 =
mon.osd152@0(electing) e1 timecheck_finish<br>2014-01-23 04:01:08.871640 =
7fa5fbe21700 10 mon.osd152@0(electing) e1 scrub_reset<br>2014-01-23 =
04:01:08.871642 7fa5fbe21700 10 mon.osd152@0(electing).paxos(paxos =
active c 4353345..4353903) restart -- canceling timeouts<br>2014-01-23 =
04:01:08.871646 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) =
restart<br>2014-01-23 04:01:08.871649 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart<br>2014-01-23 =
04:01:08.871651 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) =
restart<br>2014-01-23 04:01:08.871653 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) =
restart<br>2014-01-23 04:01:08.871654 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) =
&nbsp;canceling proposal_timer 0x47d3e40<br>2014-01-23 04:01:08.871657 =
7fa5fbe21700 &nbsp;7 mon.osd152@0(electing).log v1793958 _updated_log =
for mon.2 10.194.0.68:6789/0<br>2014-01-23 04:01:08.871663 7fa5fbe21700 =
&nbsp;1 -- 10.193.207.130:6789/0 --&gt; 10.194.0.68:6789/0 -- =
route(log(last 39415) v1 tid 3682233) v2 -- ?+0 0x1236de80 con =
0x301c8e0<br>2014-01-23 04:01:08.871677 7fa5fbe21700 &nbsp;7 =
mon.osd152@0(electing).log v1793958 _updated_log for mon.0 =
10.193.207.130:6789/0<br>2014-01-23 04:01:08.871681 7fa5fbe21700 &nbsp;1 =
-- 10.193.207.130:6789/0 --&gt; 10.193.207.130:6789/0 -- log(last =
192924) v1 -- ?+0 0x53ccec0 con 0x3018580<br>2014-01-23 04:01:08.871690 =
7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(monmap 1..1) =
restart<br>2014-01-23 04:01:08.871693 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(auth 2010..2269) =
restart<br>2014-01-23 04:01:08.871696 7fa5fbe21700 10 =
mon.osd152@0(electing) e1 cancel_probe_timeout (none =
scheduled)<br>2014-01-23 04:01:08.871709 7fa5fbe21700 &nbsp;0 log [INF] =
: mon.osd152 calling new monitor election<br>2014-01-23 04:01:08.871732 =
7fa5fbe21700 &nbsp;1 -- 10.193.207.130:6789/0 --&gt; mon.0 =
10.193.207.130:6789/0 -- log(2 entries) v1 -- ?+0 =
0x408b33c0<br>2014-01-23 04:01:08.871739 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(electing).elector(204008) start -- can i be =
leader?<br>2014-01-23 04:01:08.871834 7fa5fbe21700 &nbsp;1 =
mon.osd152@0(electing).elector(204008) init, last seen epoch =
204008<br>2014-01-23 04:01:08.871836 7fa5fbe21700 10 =
mon.osd152@0(electing).elector(204008) bump_epoch 204008 to =
204009<br>2014-01-23 04:01:08.872379 7fa5fbe21700 10 =
mon.osd152@0(electing) e1 join_election<br>2014-01-23 04:01:08.872389 =
7fa5fbe21700 10 mon.osd152@0(electing) e1 _reset<br>2014-01-23 =
04:01:08.872391 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)<br>2014-01-23 04:01:08.872392 =
7fa5fbe21700 10 mon.osd152@0(electing) e1 timecheck_finish<br>2014-01-23 =
04:01:08.872394 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
scrub_reset<br>2014-01-23 04:01:08.872396 7fa5fbe21700 10 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
restart -- canceling timeouts<br>2014-01-23 04:01:08.872399 7fa5fbe21700 =
10 mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) =
restart<br>2014-01-23 04:01:08.872401 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart<br>2014-01-23 =
04:01:08.872403 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) =
restart<br>2014-01-23 04:01:08.872404 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) =
restart<br>2014-01-23 04:01:08.872406 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(monmap 1..1) restart<br>2014-01-23 =
04:01:08.872407 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(auth =
2010..2269) restart<br>2014-01-23 04:01:08.872415 7fa5fbe21700 &nbsp;1 =
-- 10.193.207.130:6789/0 --&gt; mon.1 10.193.207.131:6789/0 -- =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 -- ?+0 =
0x2d611d40<br>2014-01-23 04:01:08.872434 7fa5fbe21700 &nbsp;1 -- =
10.193.207.130:6789/0 --&gt; mon.2 10.194.0.68:6789/0 -- =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 -- ?+0 =
0x41505c40<br>2014-01-23 04:01:08.872456 7fa5fbe21700 &nbsp;1 -- =
10.193.207.130:6789/0 &lt;=3D=3D mon.2 10.194.0.68:6789/0 463485294 =3D=3D=
=3D=3D election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 =
=3D=3D=3D=3D 540+0+0 (3981094898 0 0) 0x2d610000 con =
0x301c8e0<br>2014-01-23 04:01:08.872478 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(electing).elector(204009) handle_propose from =
mon.2<br>2014-01-23 04:01:08.872485 7fa5fbe21700 &nbsp;1 -- =
10.193.207.130:6789/0 &lt;=3D=3D mon.0 10.193.207.130:6789/0 0 =3D=3D=3D=3D=
 log(2 entries) v1 =3D=3D=3D=3D 0+0+0 (0 0 0) 0x1236e540 con =
0x3018580<br>2014-01-23 04:01:08.872495 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) dispatch =
log(2 entries) v1 from mon.0 10.193.207.130:6789/0<br>2014-01-23 =
04:01:08.872501 7fa5fbe21700 &nbsp;1 mon.osd152@0(electing).paxos(paxos =
recovering c 4353345..4353903) is_readable now=3D2014-01-23 =
04:01:08.872502 lease_expire=3D2014-01-23 04:01:13.871236 has v0 lc =
4353903<br>2014-01-23 04:01:08.872509 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) &nbsp;waiting =
for paxos -&gt; readable (v0)<br>2014-01-23 04:01:08.872511 7fa5fbe21700 =
&nbsp;1 mon.osd152@0(electing).paxos(paxos recovering c =
4353345..4353903) is_readable now=3D2014-01-23 04:01:08.872512 =
lease_expire=3D2014-01-23 04:01:13.871236 has v0 lc =
4353903<br>2014-01-23 04:01:08.872516 7fa5fbe21700 &nbsp;1 -- =
10.193.207.130:6789/0 &lt;=3D=3D mon.1 10.193.207.131:6789/0 398310803 =
=3D=3D=3D=3D election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 ack 204007) =
v4 =3D=3D=3D=3D 540+0+0 (382260333 0 0) 0x408b3600 con =
0x301cba0<br>2014-01-23 04:01:08.872530 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(electing).elector(204009) old epoch, dropping<br>2014-01-23 =
04:01:08.872534 7fa5fbe21700 &nbsp;1 -- 10.193.207.130:6789/0 &lt;=3D=3D =
mon.0 10.193.207.130:6789/0 0 =3D=3D=3D=3D log(2 entries) v1 =3D=3D=3D=3D =
0+0+0 (0 0 0) 0x41504c80 con 0x3018580<br>2014-01-23 04:01:08.872539 =
7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm =
1793310..1793958) dispatch log(2 entries) v1 from mon.0 =
10.193.207.130:6789/0<br>2014-01-23 04:01:08.872542 7fa5fbe21700 &nbsp;1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.872543 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903<br>2014-01-23 04:01:08.872547 =
7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm =
1793310..1793958) &nbsp;waiting for paxos -&gt; readable =
(v0)<br>2014-01-23 04:01:08.872548 7fa5fbe21700 &nbsp;1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.872549 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903<br>2014-01-23 04:01:08.872553 =
7fa5fbe21700 &nbsp;1 -- 10.193.207.130:6789/0 &lt;=3D=3D mon.1 =
10.193.207.131:6789/0 398310804 =3D=3D=3D=3D =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204009) v4 =3D=3D=3D=
=3D 540+0+0 (3981094898 0 0) 0x408b7740 con 0x301cba0<br>2014-01-23 =
04:01:08.872565 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(electing).elector(204009) handle_propose from =
mon.1<br>2014-01-23 04:01:08.872568 7fa5fbe21700 &nbsp;1 -- =
10.193.207.130:6789/0 &lt;=3D=3D mon.0 10.193.207.130:6789/0 0 =3D=3D=3D=3D=
 log(last 192924) v1 =3D=3D=3D=3D 0+0+0 (0 0 0) 0x53ccec0 con =
0x3018580<br>2014-01-23 04:01:08.872824 7fa5fbe21700 &nbsp;1 -- =
10.193.207.130:6789/0 &lt;=3D=3D mon.0 10.193.207.130:6789/0 0 =3D=3D=3D=3D=
 log(2 entries) v1 =3D=3D=3D=3D 0+0+0 (0 0 0) 0x408b33c0 con =
0x3018580<br>2014-01-23 04:01:08.872830 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) dispatch =
log(2 entries) v1 from mon.0 10.193.207.130:6789/0<br>2014-01-23 =
04:01:08.872834 7fa5fbe21700 &nbsp;1 mon.osd152@0(electing).paxos(paxos =
recovering c 4353345..4353903) is_readable now=3D2014-01-23 =
04:01:08.872835 lease_expire=3D2014-01-23 04:01:13.871236 has v0 lc =
4353903<br>2014-01-23 04:01:08.872839 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) &nbsp;waiting =
for paxos -&gt; readable (v0)<br>2014-01-23 04:01:08.872841 7fa5fbe21700 =
&nbsp;1 mon.osd152@0(electing).paxos(paxos recovering c =
4353345..4353903) is_readable now=3D2014-01-23 04:01:08.872841 =
lease_expire=3D2014-01-23 04:01:13.871236 has v0 lc =
4353903<br>2014-01-23 04:01:08.872846 7fa5fbe21700 &nbsp;1 -- =
10.193.207.130:6789/0 &lt;=3D=3D osd.448 10.194.0.143:6816/357 1 =3D=3D=3D=
=3D auth(proto 0 28 bytes epoch 1) v1 =3D=3D=3D=3D 58+0+0 (1794778480 0 =
0) 0x25398fc0 con 0x25347640<br>2014-01-23 04:01:08.872854 7fa5fbe21700 =
&nbsp;5 mon.osd152@0(electing) e1 discarding message auth(proto 0 28 =
bytes epoch 1) v1 and sending client elsewhere<br>2014-01-23 =
04:01:08.872857 7fa5fbe21700 &nbsp;1 -- 10.193.207.130:6789/0 mark_down =
0x25347640 -- 0x21ee4380<br>2014-01-23 04:01:08.874236 7fa5fbe21700 =
&nbsp;1 -- 10.193.207.130:6789/0 &lt;=3D=3D mon.2 10.194.0.68:6789/0 =
463485295 =3D=3D=3D=3D election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 =
propose 204011) v4 =3D=3D=3D=3D 540+0+0 (229380923 0 0) 0x1236de80 con =
0x301c8e0<br>2014-01-23 04:01:08.874266 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(electing).elector(204009) handle_propose from =
mon.2<br>2014-01-23 04:01:08.874270 7fa5fbe21700 10 =
mon.osd152@0(electing).elector(204009) bump_epoch 204009 to =
204011<br>2014-01-23 04:01:08.874755 7fa5fbe21700 10 =
mon.osd152@0(electing) e1 join_election<br>2014-01-23 04:01:08.874764 =
7fa5fbe21700 10 mon.osd152@0(electing) e1 _reset<br>2014-01-23 =
04:01:08.874767 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)<br>2014-01-23 04:01:08.874768 =
7fa5fbe21700 10 mon.osd152@0(electing) e1 timecheck_finish<br>2014-01-23 =
04:01:08.874770 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
scrub_reset<br>2014-01-23 04:01:08.874771 7fa5fbe21700 10 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
restart -- canceling timeouts<br>2014-01-23 04:01:08.874775 7fa5fbe21700 =
10 mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) =
restart<br>2014-01-23 04:01:08.874777 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart<br>2014-01-23 =
04:01:08.874779 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) =
restart<br>2014-01-23 04:01:08.874780 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) =
restart<br>2014-01-23 04:01:08.874782 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(monmap 1..1) restart<br>2014-01-23 =
04:01:08.874783 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(auth =
2010..2269) restart<br>2014-01-23 04:01:08.874786 7fa5fbe21700 10 =
mon.osd152@0(electing) e1 start_election<br>2014-01-23 04:01:08.874787 =
7fa5fbe21700 10 mon.osd152@0(electing) e1 _reset<br>2014-01-23 =
04:01:08.874788 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)<br>2014-01-23 04:01:08.874790 =
7fa5fbe21700 10 mon.osd152@0(electing) e1 timecheck_finish<br>2014-01-23 =
04:01:08.874791 7fa5fbe21700 10 mon.osd152@0(electing) e1 =
scrub_reset<br>2014-01-23 04:01:08.874793 7fa5fbe21700 10 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
restart -- canceling timeouts<br>2014-01-23 04:01:08.874795 7fa5fbe21700 =
10 mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) =
restart<br>2014-01-23 04:01:08.874797 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart<br>2014-01-23 =
04:01:08.874798 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) =
restart<br>2014-01-23 04:01:08.874799 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) =
restart<br>2014-01-23 04:01:08.874800 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(monmap 1..1) restart<br>2014-01-23 =
04:01:08.874801 7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(auth =
2010..2269) restart<br>2014-01-23 04:01:08.874803 7fa5fbe21700 10 =
mon.osd152@0(electing) e1 cancel_probe_timeout (none =
scheduled)<br>2014-01-23 04:01:08.874807 7fa5fbe21700 &nbsp;0 log [INF] =
: mon.osd152 calling new monitor election<br>2014-01-23 04:01:08.874824 =
7fa5fbe21700 &nbsp;1 -- 10.193.207.130:6789/0 --&gt; mon.0 =
10.193.207.130:6789/0 -- log(2 entries) v1 -- ?+0 =
0x408b7740<br>2014-01-23 04:01:08.874831 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(electing).elector(204011) start -- can i be =
leader?<br>2014-01-23 04:01:08.874867 7fa5fbe21700 &nbsp;1 =
mon.osd152@0(electing).elector(204011) init, last seen epoch =
204011<br>2014-01-23 04:01:08.874873 7fa5fbe21700 &nbsp;1 -- =
10.193.207.130:6789/0 --&gt; mon.1 10.193.207.131:6789/0 -- =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204011) v4 -- ?+0 =
0x25398fc0<br>2014-01-23 04:01:08.874887 7fa5fbe21700 &nbsp;1 -- =
10.193.207.130:6789/0 --&gt; mon.2 10.194.0.68:6789/0 -- =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 propose 204011) v4 -- ?+0 =
0x408b4800<br>2014-01-23 04:01:08.874909 7fa5fbe21700 &nbsp;1 -- =
10.193.207.130:6789/0 &lt;=3D=3D mon.2 10.194.0.68:6789/0 463485296 =3D=3D=
=3D=3D election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 ack 204011) v4 =3D=3D=
=3D=3D 540+0+0 (1598534457 0 0) 0x2d6133c0 con 0x301c8e0<br>2014-01-23 =
04:01:08.874932 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(electing).elector(204011) handle_ack from =
mon.2<br>2014-01-23 04:01:08.874936 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(electing).elector(204011) &nbsp;so far i have =
{0=3D34359738367,2=3D34359738367}<br>2014-01-23 04:01:08.874943 =
7fa5fbe21700 &nbsp;1 -- 10.193.207.130:6789/0 &lt;=3D=3D mon.0 =
10.193.207.130:6789/0 0 =3D=3D=3D=3D log(2 entries) v1 =3D=3D=3D=3D =
0+0+0 (0 0 0) 0x408b7740 con 0x3018580<br>2014-01-23 04:01:08.874959 =
7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm =
1793310..1793958) dispatch log(2 entries) v1 from mon.0 =
10.193.207.130:6789/0<br>2014-01-23 04:01:08.874963 7fa5fbe21700 &nbsp;1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.874964 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903<br>2014-01-23 04:01:08.874969 =
7fa5fbe21700 10 mon.osd152@0(electing).paxosservice(logm =
1793310..1793958) &nbsp;waiting for paxos -&gt; readable =
(v0)<br>2014-01-23 04:01:08.874971 7fa5fbe21700 &nbsp;1 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
is_readable now=3D2014-01-23 04:01:08.874971 lease_expire=3D2014-01-23 =
04:01:13.871236 has v0 lc 4353903<br>2014-01-23 04:01:08.875528 =
7fa5fbe21700 &nbsp;1 -- 10.193.207.130:6789/0 &lt;=3D=3D mon.2 =
10.194.0.68:6789/0 463485297 =3D=3D=3D=3D =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 ack 204011) v4 =3D=3D=3D=3D =
540+0+0 (1598534457 0 0) 0x2d613600 con 0x301c8e0<br>2014-01-23 =
04:01:08.875553 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(electing).elector(204011) handle_ack from =
mon.2<br>2014-01-23 04:01:08.875556 7fa5fbe21700 &nbsp;5 =
mon.osd152@0(electing).elector(204011) &nbsp;so far i have =
{0=3D34359738367,2=3D34359738367}<br>2014-01-23 04:01:13.875028 =
7fa5fc822700 &nbsp;5 mon.osd152@0(electing).elector(204011) election =
timer expired<br>2014-01-23 04:01:13.875043 7fa5fc822700 10 =
mon.osd152@0(electing).elector(204011) bump_epoch 204011 to =
204012<br>2014-01-23 04:01:13.875375 7fa5fc822700 10 =
mon.osd152@0(electing) e1 join_election<br>2014-01-23 04:01:13.875386 =
7fa5fc822700 10 mon.osd152@0(electing) e1 _reset<br>2014-01-23 =
04:01:13.875389 7fa5fc822700 10 mon.osd152@0(electing) e1 =
cancel_probe_timeout (none scheduled)<br>2014-01-23 04:01:13.875390 =
7fa5fc822700 10 mon.osd152@0(electing) e1 timecheck_finish<br>2014-01-23 =
04:01:13.875393 7fa5fc822700 10 mon.osd152@0(electing) e1 =
scrub_reset<br>2014-01-23 04:01:13.875395 7fa5fc822700 10 =
mon.osd152@0(electing).paxos(paxos recovering c 4353345..4353903) =
restart -- canceling timeouts<br>2014-01-23 04:01:13.875401 7fa5fc822700 =
10 mon.osd152@0(electing).paxosservice(pgmap 2388001..2388518) =
restart<br>2014-01-23 04:01:13.875404 7fa5fc822700 10 =
mon.osd152@0(electing).paxosservice(mdsmap 1..1) restart<br>2014-01-23 =
04:01:13.875407 7fa5fc822700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) =
restart<br>2014-01-23 04:01:13.875409 7fa5fc822700 10 =
mon.osd152@0(electing).paxosservice(logm 1793310..1793958) =
restart<br>2014-01-23 04:01:13.875411 7fa5fc822700 10 =
mon.osd152@0(electing).paxosservice(monmap 1..1) restart<br>2014-01-23 =
04:01:13.875413 7fa5fc822700 10 mon.osd152@0(electing).paxosservice(auth =
2010..2269) restart<br>2014-01-23 04:01:13.875423 7fa5fc822700 &nbsp;1 =
-- 10.193.207.130:6789/0 --&gt; mon.2 10.194.0.68:6789/0 -- =
election(b9cb3ea9-e1de-48b4-9e86-6921e2c537d2 victory 204012) v4 -- ?+0 =
0x248bf980<br>2014-01-23 04:01:13.875445 7fa5fc822700 10 =
mon.osd152@0(electing) e1 win_election epoch 204012 quorum 0,2 features =
34359738367<br>2014-01-23 04:01:13.875457 7fa5fc822700 &nbsp;0 log [INF] =
: mon.osd152@0 won leader election with quorum 0,2<br>2014-01-23 =
04:01:13.875481 7fa5fc822700 &nbsp;1 -- 10.193.207.130:6789/0 --&gt; =
mon.0 10.193.207.130:6789/0 -- log(2 entries) v1 -- ?+0 =
0x248bc5c0<br>2014-01-23 04:01:13.875498 7fa5fc822700 10 =
mon.osd152@0(leader).paxos(paxos recovering c 4353345..4353903) =
leader_init -- starting paxos recovery<br>2014-01-23 04:01:13.875558 =
7fa5fbe21700 &nbsp;1 -- 10.193.207.130:6789/0 &lt;=3D=3D mon.0 =
10.193.207.130:6789/0 0 =3D=3D=3D=3D log(2 entries) v1 =3D=3D=3D=3D =
0+0+0 (0 0 0) 0x248bc5c0 con 0x3018580<br>2014-01-23 04:01:13.875690 =
7fa5fc822700 10 mon.osd152@0(leader).paxos(paxos recovering c =
4353345..4353903) get_new_proposal_number =3D 9772500<br>2014-01-23 =
04:01:13.875703 7fa5fc822700 10 mon.osd152@0(leader).paxos(paxos =
recovering c 4353345..4353903) collect with pn 9772500<br>2014-01-23 =
04:01:13.875708 7fa5fc822700 &nbsp;1 -- 10.193.207.130:6789/0 --&gt; =
mon.2 10.194.0.68:6789/0 -- paxos(collect lc 4353903 fc 4353345 pn =
9772500 opn 0) v3 -- ?+0 0x167ceb80<br>2014-01-23 04:01:13.875725 =
7fa5fc822700 10 mon.osd152@0(leader).paxosservice(pgmap =
2388001..2388518) election_finished<br>2014-01-23 04:01:13.875729 =
7fa5fc822700 10 mon.osd152@0(leader).paxosservice(pgmap =
2388001..2388518) _active - not active<br>2014-01-23 04:01:13.875731 =
7fa5fc822700 10 mon.osd152@0(leader).paxosservice(mdsmap 1..1) =
election_finished<br>2014-01-23 04:01:13.875733 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(mdsmap 1..1) _active - not =
active<br>2014-01-23 04:01:13.875735 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) =
election_finished<br>2014-01-23 04:01:13.875737 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) _active - not =
active<br>2014-01-23 04:01:13.875740 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(logm 1793310..1793958) =
election_finished<br>2014-01-23 04:01:13.875741 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(logm 1793310..1793958) _active - not =
active<br>2014-01-23 04:01:13.875743 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(monmap 1..1) =
election_finished<br>2014-01-23 04:01:13.875745 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(monmap 1..1) _active - not =
active<br>2014-01-23 04:01:13.875747 7fa5fc822700 10 =
mon.osd152@0(leader).paxosservice(auth 2010..2269) =
election_finished<br><br><br></blockquote><br></blockquote></div><br></div=
></body></html>=

--Apple-Mail=_2727DA0F-6F43-48D0-BC2D-5C7EBB03BAB2--

--===============1014171793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1014171793==--
