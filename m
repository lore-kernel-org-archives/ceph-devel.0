From: huang jun <hjwsm1989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bug maybe: osdmap failed undecoded
Date: Thu, 23 Feb 2017 22:37:34 +0800
Message-ID: <CABAwU-Yiyr5TDcZTSUrOVWM+XyFcPdEx4CvDPj50vZZJvn8moA@mail.gmail.com>
References: <CAKT23OLXnsikbXHRiffX43kWEOeMb327QbAnmt0uZV4LXLm9gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAKT23OLXnsikbXHRiffX43kWEOeMb327QbAnmt0uZV4LXLm9gg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: tao chang <changtao381-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

you can copy the corrupt osdmap file from osd.1 and then restart osd,
we met this before, and that works for us.

2017-02-23 22:33 GMT+08:00 tao chang <changtao381-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> HI,
>
> I have a ceph cluster  (ceph 10.2.5) witch 3 node, each has two osds.
>
> It was a power outage last night  and all the server are restarted
> this morning again.
> All osds are work well except the osd.0.
>
> ID WEIGHT  TYPE NAME        UP/DOWN REWEIGHT PRIMARY-AFFINITY
> -1 0.04500 root volumes
> -2 0.01500     host zk25-02
>  0 0.01500         osd.0       down        0          1.00000
>  1 0.01500         osd.1         up  1.00000          1.00000
> -3 0.01500     host zk25-03
>  2 0.01500         osd.2         up  1.00000          1.00000
>  3 0.01500         osd.3         up  1.00000          1.00000
> -4 0.01500     host zk25-01
>  4 0.01500         osd.4         up  1.00000          1.00000
>  5 0.01500         osd.5         up  1.00000          1.00000
>
> I tried to run it again with gdb, it turned it like this:
>
> (gdb) bt
> #0  0x00007ffff4cfd5f7 in raise () from /lib64/libc.so.6
> #1  0x00007ffff4cfece8 in abort () from /lib64/libc.so.6
> #2  0x00007ffff56019d5 in __gnu_cxx::__verbose_terminate_handler() ()
> from /lib64/libstdc++.so.6
> #3  0x00007ffff55ff946 in ?? () from /lib64/libstdc++.so.6
> #4  0x00007ffff55ff973 in std::terminate() () from /lib64/libstdc++.so.6
> #5  0x00007ffff55ffb93 in __cxa_throw () from /lib64/libstdc++.so.6
> #6  0x0000555555b93b7f in pg_pool_t::decode (this=<optimized out>,
> bl=...) at osd/osd_types.cc:1569
> #7  0x0000555555f3a53f in decode (p=..., c=...) at osd/osd_types.h:1487
> #8  decode<long, pg_pool_t> (m=Python Exception <type
> 'exceptions.IndexError'> list index out of range:
> std::map with 1 elements, p=...) at include/encoding.h:648
> #9  0x0000555555f2fa8d in OSDMap::decode_classic
> (this=this@entry=0x55555fdf6480, p=...) at osd/OSDMap.cc:2026
> #10 0x0000555555f2fe8c in OSDMap::decode
> (this=this@entry=0x55555fdf6480, bl=...) at osd/OSDMap.cc:2116
> #11 0x0000555555f3116e in OSDMap::decode (this=0x55555fdf6480, bl=...)
> at osd/OSDMap.cc:1985
> #12 0x00005555558e51fc in OSDService::try_get_map
> (this=0x55555ff51860, epoch=76) at osd/OSD.cc:1340
> #13 0x0000555555947ece in OSDService::get_map (this=<optimized out>,
> e=<optimized out>, this=<optimized out>) at osd/OSD.h:884
> #14 0x00005555558fb0f2 in OSD::init (this=0x55555ff50000) at osd/OSD.h:1917
> #15 0x000055555585eea5 in main (argc=<optimized out>, argv=<optimized
> out>) at ceph_osd.cc:605
>
> it was caused by failed undecoded of osdmap structure from osdmap
> file(/var/lib/ceph/osd/ceph-0/current/meta/osdmap.76__0_64173F9C__none)
> .
> And by comparing the same file on osd.1, It make sure the osdmap file
> has been corrupted.
>
>
> Any one know how to fix it ? Thanks for advance !
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thank you!
HuangJun
