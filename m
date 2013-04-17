From: Olivier Bonvalet <ceph.list-PaEMFeTk6C1QFI55V6+gNQ@public.gmane.org>
Subject: Re: Scrub shutdown the OSD process
Date: Wed, 17 Apr 2013 20:52:05 +0200
Message-ID: <1366224725.14655.30.camel@localhost>
References: <1366018923.3018.3.camel@localhost>
	<CAPYLRziFNxnUhyxHRUCzZBF6oQwrWt8YdxBtDrKzMMNuyuW=YQ@mail.gmail.com>
	<1366046351.26980.0.camel@localhost>
	<CAPYLRzjz3FVvm5OH-TBN3R8tmv8LREFYKTEX41Zk7DTLjoPXkA@mail.gmail.com>
	<1366095376.3018.28.camel@localhost>
	<1366192124.14655.20.camel@localhost>
Reply-To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1366192124.14655.20.camel@localhost>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Some additional infos :

today at 18:57:40, the PG 3.1 [19,5,28] was having a scrub date of
"2013-03-28 08:38:12.858041", and the OSD 28 was recovering.

Ten minutes later (@ 19:07:40), that PG 3.1 was having a scrub date of
today.

But at 19:41:04 I seen a error in syslog :
	osd.10 52042 heartbeat_check: no reply from osd.28 since 2013-04-17 19:40:43.565511

So, since 19:47:44, the PG 3.1 [19,5] is in "active+degraded" state, is
scrub date is returned to "2013-03-28 08:38:12.858041" ; and of course
the osd.28 is DOWN, the process abort :

     0> 2013-04-17 19:40:46.791010 7f6658f5a700 -1 *** Caught signal (Aborted) **
 in thread 7f6658f5a700

 ceph version 0.56.4-4-gd89ab0e (d89ab0ea6fa8d0961cad82f6a81eccbd3bbd3f55)
 1: /usr/bin/ceph-osd() [0x7a6289]
 2: (()+0xeff0) [0x7f666b488ff0]
 3: (gsignal()+0x35) [0x7f6669f121b5]
 4: (abort()+0x180) [0x7f6669f14fc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f666a7a6dc5]
 6: (()+0xcb166) [0x7f666a7a5166]
 7: (()+0xcb193) [0x7f666a7a5193]
 8: (()+0xcb28e) [0x7f666a7a528e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x7c9) [0x8f9549]
 10: (ReplicatedPG::_scrub(ScrubMap&)+0x1a78) [0x57a038]
 11: (PG::scrub_compare_maps()+0xeb8) [0x696c18]
 12: (PG::chunky_scrub()+0x2d9) [0x6c37f9]
 13: (PG::scrub()+0x145) [0x6c4e55]
 14: (OSD::ScrubWQ::_process(PG*)+0xc) [0x64048c]
 15: (ThreadPool::worker(ThreadPool::WorkThread*)+0x879) [0x815179]
 16: (ThreadPool::WorkThread::entry()+0x10) [0x817980]
 17: (()+0x68ca) [0x7f666b4808ca]
 18: (clone()+0x6d) [0x7f6669fafb6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.


What I didn't understand is why the OSD process crash, instead of
marking that PG "corrupted", and does that PG really "corrupted" are is
this just an OSD bug ?

Thanks,
Olivier
