From: Irek Fasikhov <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: strange benchmark problem : restarting osd daemon
 improve performance from 100k iops to 300k iops
Date: Fri, 24 Apr 2015 14:37:52 +0300
Message-ID: <CAF-rypyB=CjjJQs_+3Q=ELCVwpg9nyWKdBu8gVyuDQa49=GHtw@mail.gmail.com>
References: <1232683114.515741917.1429692005478.JavaMail.zimbra@oxygem.tv>
	<886679306.527978224.1429710961512.JavaMail.zimbra@oxygem.tv>
	<5537A9A8.10200@redhat.com>
	<59E25171A319194CB0889178D3F1E09A0B8916A0@SACMBXIP01.sdcorp.global.sandisk.com>
	<336199846.535234014.1429720226874.JavaMail.zimbra@oxygem.tv>
	<1806383776.554938002.1429776034371.JavaMail.zimbra@oxygem.tv>
	<1112295705.562655711.1429786696959.JavaMail.zimbra@oxygem.tv>
	<5538D86C.1090506@redhat.com>
	<1903663405.564474385.1429790186021.JavaMail.zimbra@oxygem.tv>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD806BE@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2050199614=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD806BE-cXZ6iGhjG0il5HHZYNR2WTJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Milosz Tanski <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2050199614==
Content-Type: multipart/alternative; boundary=001a11c3db82dc51e6051476d4eb

--001a11c3db82dc51e6051476d4eb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,Alexandre!
Do not try to change the parameter vm.min_free_kbytes?

2015-04-23 19:24 GMT+03:00 Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>:

> Alexandre,
> You can configure with --with-jemalloc or ./do_autogen -J to build ceph
> with jemalloc.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of
> Alexandre DERUMIER
> Sent: Thursday, April 23, 2015 4:56 AM
> To: Mark Nelson
> Cc: ceph-users; ceph-devel; Milosz Tanski
> Subject: Re: [ceph-users] strange benchmark problem : restarting osd
> daemon improve performance from 100k iops to 300k iops
>
> >>If you have the means to compile the same version of ceph with
> >>jemalloc, I would be very interested to see how it does.
>
> Yes, sure. (I have around 3-4 weeks to do all the benchs)
>
> But I don't know how to do it ?
> I'm running the cluster on centos7.1, maybe it can be easy to patch the
> srpms to rebuild the package with jemalloc.
>
>
>
> ----- Mail original -----
> De: "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> =C3=80: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>, "Srinivasula Maram" <
> Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
> Cc: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <
> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Milosz Tanski" <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
> Envoy=C3=A9: Jeudi 23 Avril 2015 13:33:00
> Objet: Re: [ceph-users] strange benchmark problem : restarting osd daemon
> improve performance from 100k iops to 300k iops
>
> Thanks for the testing Alexandre!
>
> If you have the means to compile the same version of ceph with jemalloc, =
I
> would be very interested to see how it does.
>
> In some ways I'm glad it turned out not to be NUMA. I still suspect we
> will have to deal with it at some point, but perhaps not today. ;)
>
> Mark
>
> On 04/23/2015 05:58 AM, Alexandre DERUMIER wrote:
> > Maybe it's tcmalloc related
> > I thinked to have patched it correctly, but perf show a lot of
> > tcmalloc::ThreadCache::ReleaseToCentralCache
> >
> > before osd restart (100k)
> > ------------------
> > 11.66% ceph-osd libtcmalloc.so.4.1.2 [.]
> > tcmalloc::ThreadCache::ReleaseToCentralCache
> > 8.51% ceph-osd libtcmalloc.so.4.1.2 [.]
> > tcmalloc::CentralFreeList::FetchFromSpans
> > 3.04% ceph-osd libtcmalloc.so.4.1.2 [.]
> > tcmalloc::CentralFreeList::ReleaseToSpans
> > 2.04% ceph-osd libtcmalloc.so.4.1.2 [.] operator new 1.63% swapper
> > [kernel.kallsyms] [k] intel_idle 1.35% ceph-osd libtcmalloc.so.4.1.2
> > [.] tcmalloc::CentralFreeList::ReleaseListToSpans
> > 1.33% ceph-osd libtcmalloc.so.4.1.2 [.] operator delete 1.07% ceph-osd
> > libstdc++.so.6.0.19 [.] std::basic_string<char,
> > std::char_traits<char>, std::allocator<char> >::basic_string 0.91%
> > ceph-osd libpthread-2.17.so [.] pthread_mutex_trylock 0.88% ceph-osd
> > libc-2.17.so [.] __memcpy_ssse3_back 0.81% ceph-osd ceph-osd [.]
> > Mutex::Lock 0.79% ceph-osd [kernel.kallsyms] [k]
> > copy_user_enhanced_fast_string 0.74% ceph-osd libpthread-2.17.so [.]
> > pthread_mutex_unlock 0.67% ceph-osd [kernel.kallsyms] [k]
> > _raw_spin_lock 0.63% swapper [kernel.kallsyms] [k]
> > native_write_msr_safe 0.62% ceph-osd [kernel.kallsyms] [k]
> > avc_has_perm_noaudit 0.58% ceph-osd ceph-osd [.] operator< 0.57%
> > ceph-osd [kernel.kallsyms] [k] __schedule 0.57% ceph-osd
> > [kernel.kallsyms] [k] __d_lookup_rcu 0.54% swapper [kernel.kallsyms]
> > [k] __schedule
> >
> >
> > after osd restart (300k iops)
> > ------------------------------
> > 3.47% ceph-osd libtcmalloc.so.4.1.2 [.] operator new 1.92% ceph-osd
> > libtcmalloc.so.4.1.2 [.] operator delete 1.86% swapper
> > [kernel.kallsyms] [k] intel_idle 1.52% ceph-osd libstdc++.so.6.0.19
> > [.] std::basic_string<char, std::char_traits<char>,
> > std::allocator<char> >::basic_string 1.34% ceph-osd
> > libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseToCentralCache
> > 1.24% ceph-osd libc-2.17.so [.] __memcpy_ssse3_back 1.23% ceph-osd
> > ceph-osd [.] Mutex::Lock 1.21% ceph-osd libpthread-2.17.so [.]
> > pthread_mutex_trylock 1.11% ceph-osd [kernel.kallsyms] [k]
> > copy_user_enhanced_fast_string 0.95% ceph-osd libpthread-2.17.so [.]
> > pthread_mutex_unlock 0.94% ceph-osd [kernel.kallsyms] [k]
> > _raw_spin_lock 0.78% ceph-osd [kernel.kallsyms] [k] __d_lookup_rcu
> > 0.70% ceph-osd [kernel.kallsyms] [k] tcp_sendmsg 0.70% ceph-osd
> > ceph-osd [.] Message::Message 0.68% ceph-osd [kernel.kallsyms] [k]
> > __schedule 0.66% ceph-osd [kernel.kallsyms] [k] idle_cpu 0.65%
> > ceph-osd libtcmalloc.so.4.1.2 [.]
> > tcmalloc::CentralFreeList::FetchFromSpans
> > 0.64% swapper [kernel.kallsyms] [k] native_write_msr_safe 0.61%
> > ceph-osd ceph-osd [.]
> > std::tr1::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>::_M_release
> > 0.60% swapper [kernel.kallsyms] [k] __schedule 0.60% ceph-osd
> > libstdc++.so.6.0.19 [.] 0x00000000000bdd2b 0.57% ceph-osd ceph-osd [.]
> > operator< 0.57% ceph-osd ceph-osd [.] crc32_iscsi_00 0.56% ceph-osd
> > libstdc++.so.6.0.19 [.] std::string::_Rep::_M_dispose 0.55% ceph-osd
> > [kernel.kallsyms] [k] __switch_to 0.54% ceph-osd libc-2.17.so [.]
> > vfprintf 0.52% ceph-osd [kernel.kallsyms] [k] fget_light
> >
> > ----- Mail original -----
> > De: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> > =C3=80: "Srinivasula Maram" <Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
> > Cc: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel"
> > <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Milosz Tanski" <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
> > Envoy=C3=A9: Jeudi 23 Avril 2015 10:00:34
> > Objet: Re: [ceph-users] strange benchmark problem : restarting osd
> > daemon improve performance from 100k iops to 300k iops
> >
> > Hi,
> > I'm hitting this bug again today.
> >
> > So don't seem to be numa related (I have try to flush linux buffer to b=
e
> sure).
> >
> > and tcmalloc is patched (I don't known how to verify that it's ok).
> >
> > I don't have restarted osd yet.
> >
> > Maybe some perf trace could be usefulll ?
> >
> >
> > ----- Mail original -----
> > De: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> > =C3=80: "Srinivasula Maram" <Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
> > Cc: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel"
> > <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Milosz Tanski" <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
> > Envoy=C3=A9: Mercredi 22 Avril 2015 18:30:26
> > Objet: Re: [ceph-users] strange benchmark problem : restarting osd
> > daemon improve performance from 100k iops to 300k iops
> >
> > Hi,
> >
> >>> I feel it is due to tcmalloc issue
> >
> > Indeed, I had patched one of my node, but not the other.
> > So maybe I have hit this bug. (but I can't confirm, I don't have traces=
).
> >
> > But numa interleaving seem to help in my case (maybe not from 100->300k=
,
> but 250k->300k).
> >
> > I need to do more long tests to confirm that.
> >
> >
> > ----- Mail original -----
> > De: "Srinivasula Maram" <Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
> > =C3=80: "Mark Nelson" <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "aderumier"
> > <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>, "Milosz Tanski" <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
> > Cc: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users"
> > <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> > Envoy=C3=A9: Mercredi 22 Avril 2015 16:34:33
> > Objet: RE: [ceph-users] strange benchmark problem : restarting osd
> > daemon improve performance from 100k iops to 300k iops
> >
> > I feel it is due to tcmalloc issue
> >
> > I have seen similar issue in my setup after 20 days.
> >
> > Thanks,
> > Srinivas
> >
> >
> >
> > -----Original Message-----
> > From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf
> > Of Mark Nelson
> > Sent: Wednesday, April 22, 2015 7:31 PM
> > To: Alexandre DERUMIER; Milosz Tanski
> > Cc: ceph-devel; ceph-users
> > Subject: Re: [ceph-users] strange benchmark problem : restarting osd
> > daemon improve performance from 100k iops to 300k iops
> >
> > Hi Alexandre,
> >
> > We should discuss this at the perf meeting today. We knew NUMA node
> affinity issues were going to crop up sooner or later (and indeed already
> have in some cases), but this is pretty major. It's probably time to real=
ly
> dig in and figure out how to deal with this.
> >
> > Note: this is one of the reasons I like small nodes with single sockets
> and fewer OSDs.
> >
> > Mark
> >
> > On 04/22/2015 08:56 AM, Alexandre DERUMIER wrote:
> >> Hi,
> >>
> >> I have done a lot of test today, and it seem indeed numa related.
> >>
> >> My numastat was
> >>
> >> # numastat
> >> node0 node1
> >> numa_hit 99075422 153976877
> >> numa_miss 167490965 1493663
> >> numa_foreign 1493663 167491417
> >> interleave_hit 157745 167015
> >> local_node 99049179 153830554
> >> other_node 167517697 1639986
> >>
> >> So, a lot of miss.
> >>
> >> In this case , I can reproduce ios going from 85k to 300k iops, up and
> down.
> >>
> >> now setting
> >> echo 0 > /proc/sys/kernel/numa_balancing
> >>
> >> and starting osd daemons with
> >>
> >> numactl --interleave=3Dall /usr/bin/ceph-osd
> >>
> >>
> >> I have a constant 300k iops !
> >>
> >>
> >> I wonder if it could be improve by binding osd daemons to specific num=
a
> node.
> >> I have 2 numanode of 10 cores with 6 osd, but I think it also require
> ceph.conf osd threads tunning.
> >>
> >>
> >>
> >> ----- Mail original -----
> >> De: "Milosz Tanski" <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
> >> =C3=80: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> >> Cc: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users"
> >> <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> >> Envoy=C3=A9: Mercredi 22 Avril 2015 12:54:23
> >> Objet: Re: [ceph-users] strange benchmark problem : restarting osd
> >> daemon improve performance from 100k iops to 300k iops
> >>
> >>
> >>
> >> On Wed, Apr 22, 2015 at 5:01 AM, Alexandre DERUMIER <
> aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org > wrote:
> >>
> >>
> >> I wonder if it could be numa related,
> >>
> >> I'm using centos 7.1,
> >> and auto numa balacning is enabled
> >>
> >> cat /proc/sys/kernel/numa_balancing =3D 1
> >>
> >> Maybe osd daemon access to buffer on wrong numa node.
> >>
> >> I'll try to reproduce the problem
> >>
> >>
> >>
> >> Can you force the degenerate case using numactl? To either affirm or
> deny your suspicion.
> >>
> >>
> >>
> >>
> >> ----- Mail original -----
> >> De: "aderumier" < aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org >
> >> =C3=80: "ceph-devel" < ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >, "ceph-users" <
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org >
> >> Envoy=C3=A9: Mercredi 22 Avril 2015 10:40:05
> >> Objet: [ceph-users] strange benchmark problem : restarting osd daemon
> >> improve performance from 100k iops to 300k iops
> >>
> >> Hi,
> >>
> >> I was doing some benchmarks,
> >> I have found an strange behaviour.
> >>
> >> Using fio with rbd engine, I was able to reach around 100k iops.
> >> (osd datas in linux buffer, iostat show 0% disk access)
> >>
> >> then after restarting all osd daemons,
> >>
> >> the same fio benchmark show now around 300k iops.
> >> (osd datas in linux buffer, iostat show 0% disk access)
> >>
> >>
> >> any ideas?
> >>
> >>
> >>
> >>
> >> before restarting osd
> >> ---------------------
> >> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> >> ioengine=3Drbd, iodepth=3D32 ...
> >> fio-2.2.7-10-g51e9
> >> Starting 10 processes
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> ^Cbs: 10 (f=3D10): [r(10)] [2.9% done] [376.1MB/0KB/0KB /s] [96.6K/0/0
> >> iops] [eta 14m:45s]
> >> fio: terminating on signal 2
> >>
> >> rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D17075: W=
ed Apr
> >> 22 10:00:04 2015 read : io=3D11558MB, bw=3D451487KB/s, iops=3D112871, =
runt=3D
> >> 26215msec slat (usec): min=3D5, max=3D3685, avg=3D16.89, stdev=3D17.38=
 clat
> >> (usec): min=3D5, max=3D62584, avg=3D2695.80, stdev=3D5351.23 lat (usec=
):
> >> min=3D109, max=3D62598, avg=3D2712.68, stdev=3D5350.42 clat percentile=
s
> >> (usec):
> >> | 1.00th=3D[ 155], 5.00th=3D[ 183], 10.00th=3D[ 205], 20.00th=3D[ 247]=
,
> >> | 30.00th=3D[ 294], 40.00th=3D[ 354], 50.00th=3D[ 446], 60.00th=3D[ 66=
0],
> >> | 70.00th=3D[ 1176], 80.00th=3D[ 3152], 90.00th=3D[ 9024], 95.00th=3D[=
14656],
> >> | 99.00th=3D[25984], 99.50th=3D[30336], 99.90th=3D[38656], 99.95th=3D[=
41728],
> >> | 99.99th=3D[47360]
> >> bw (KB /s): min=3D23928, max=3D154416, per=3D10.07%, avg=3D45462.82,
> >> stdev=3D28809.95 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=
=3D0.01%,
> >> 250=3D20.79% lat (usec) : 500=3D32.74%, 750=3D8.99%, 1000=3D5.03% lat =
(msec) :
> >> 2=3D8.37%, 4=3D6.21%, 10=3D8.90%, 20=3D6.60%, 50=3D2.37% lat (msec) : =
100=3D0.01%
> >> cpu : usr=3D15.90%, sys=3D3.01%, ctx=3D765446, majf=3D0, minf=3D8710 I=
O depths :
> >> 1=3D0.4%, 2=3D0.9%, 4=3D2.3%, 8=3D7.4%, 16=3D75.5%, 32=3D13.6%, >=3D64=
=3D0.0% submit :
> >> 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D6=
4=3D0.0%
> >> complete : 0=3D0.0%, 4=3D93.6%, 8=3D2.8%, 16=3D2.4%, 32=3D1.2%, 64=3D0=
.0%,
> >>> =3D64=3D0.0% issued : total=3Dr=3D2958935/w=3D0/d=3D0, short=3Dr=3D0/=
w=3D0/d=3D0,
> >> drop=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, percentile=
=3D100.00%,
> >> depth=3D32
> >>
> >> Run status group 0 (all jobs):
> >> READ: io=3D11558MB, aggrb=3D451487KB/s, minb=3D451487KB/s, maxb=3D4514=
87KB/s,
> >> mint=3D26215msec, maxt=3D26215msec
> >>
> >> Disk stats (read/write):
> >> sdg: ios=3D0/29, merge=3D0/16, ticks=3D0/3, in_queue=3D3, util=3D0.01%
> >> [root@ceph1-3 fiorbd]# ./fio fiorbd
> >> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> >> ioengine=3Drbd, iodepth=3D32
> >>
> >>
> >>
> >>
> >> AFTER RESTARTING OSDS
> >> ----------------------
> >> [root@ceph1-3 fiorbd]# ./fio fiorbd
> >> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> >> ioengine=3Drbd, iodepth=3D32 ...
> >> fio-2.2.7-10-g51e9
> >> Starting 10 processes
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> rbd engine: RBD version: 0.1.9
> >> ^Cbs: 10 (f=3D10): [r(10)] [0.2% done] [1155MB/0KB/0KB /s] [296K/0/0
> >> iops] [eta 01h:09m:27s]
> >> fio: terminating on signal 2
> >>
> >> rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D18252: W=
ed Apr
> >> 22 10:02:28 2015 read : io=3D7655.7MB, bw=3D1036.8MB/s, iops=3D265218,
> >> runt=3D 7389msec slat (usec): min=3D5, max=3D3406, avg=3D26.59, stdev=
=3D40.35
> >> clat
> >> (usec): min=3D8, max=3D684328, avg=3D930.43, stdev=3D6419.12 lat (usec=
):
> >> min=3D154, max=3D684342, avg=3D957.02, stdev=3D6419.28 clat percentile=
s
> >> (usec):
> >> | 1.00th=3D[ 243], 5.00th=3D[ 314], 10.00th=3D[ 366], 20.00th=3D[ 450]=
,
> >> | 30.00th=3D[ 524], 40.00th=3D[ 604], 50.00th=3D[ 692], 60.00th=3D[ 79=
6],
> >> | 70.00th=3D[ 924], 80.00th=3D[ 1096], 90.00th=3D[ 1400], 95.00th=3D[ =
1720],
> >> | 99.00th=3D[ 2672], 99.50th=3D[ 3248], 99.90th=3D[ 5920], 99.95th=3D[=
 9792],
> >> | 99.99th=3D[436224]
> >> bw (KB /s): min=3D32614, max=3D143160, per=3D10.19%, avg=3D108076.46,
> >> stdev=3D28263.82 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=
=3D0.01%,
> >> 250=3D1.23% lat (usec) : 500=3D25.64%, 750=3D29.15%, 1000=3D18.84% lat=
 (msec)
> >> : 2=3D22.19%, 4=3D2.69%, 10=3D0.21%, 20=3D0.02%, 50=3D0.01% lat (msec)=
 :
> >> 250=3D0.01%, 500=3D0.02%, 750=3D0.01% cpu : usr=3D44.06%, sys=3D11.26%=
,
> >> ctx=3D642620, majf=3D0, minf=3D6832 IO depths : 1=3D0.1%, 2=3D0.5%, 4=
=3D2.0%,
> >> 8=3D11.5%, 16=3D77.8%, 32=3D8.1%, >=3D64=3D0.0% submit : 0=3D0.0%, 4=
=3D100.0%,
> >> 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0% complete : 0=
=3D0.0%,
> >> 4=3D94.1%, 8=3D1.3%, 16=3D2.3%, 32=3D2.3%, 64=3D0.0%, >=3D64=3D0.0% is=
sued :
> >> total=3Dr=3D1959697/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, drop=3Dr=
=3D0/w=3D0/d=3D0 latency :
> >> target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
> >>
> >> Run status group 0 (all jobs):
> >> READ: io=3D7655.7MB, aggrb=3D1036.8MB/s, minb=3D1036.8MB/s,
> >> maxb=3D1036.8MB/s, mint=3D7389msec, maxt=3D7389msec
> >>
> >> Disk stats (read/write):
> >> sdg: ios=3D0/21, merge=3D0/10, ticks=3D0/2, in_queue=3D2, util=3D0.03%
> >>
> >>
> >>
> >>
> >> CEPH LOG
> >> --------
> >>
> >> before restarting osd
> >> ----------------------
> >>
> >> 2015-04-22 09:53:17.568095 mon.0 10.7.0.152:6789/0 2144 : cluster
> >> [INF] pgmap v11330: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 298 MB/s rd, 76465 op/s
> >> 2015-04-22 09:53:18.574524 mon.0 10.7.0.152:6789/0 2145 : cluster
> >> [INF] pgmap v11331: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 333 MB/s rd, 85355 op/s
> >> 2015-04-22 09:53:19.579351 mon.0 10.7.0.152:6789/0 2146 : cluster
> >> [INF] pgmap v11332: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 343 MB/s rd, 87932 op/s
> >> 2015-04-22 09:53:20.591586 mon.0 10.7.0.152:6789/0 2147 : cluster
> >> [INF] pgmap v11333: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 328 MB/s rd, 84151 op/s
> >> 2015-04-22 09:53:21.600650 mon.0 10.7.0.152:6789/0 2148 : cluster
> >> [INF] pgmap v11334: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 237 MB/s rd, 60855 op/s
> >> 2015-04-22 09:53:22.607966 mon.0 10.7.0.152:6789/0 2149 : cluster
> >> [INF] pgmap v11335: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 144 MB/s rd, 36935 op/s
> >> 2015-04-22 09:53:23.617780 mon.0 10.7.0.152:6789/0 2150 : cluster
> >> [INF] pgmap v11336: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 321 MB/s rd, 82334 op/s
> >> 2015-04-22 09:53:24.622341 mon.0 10.7.0.152:6789/0 2151 : cluster
> >> [INF] pgmap v11337: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 368 MB/s rd, 94211 op/s
> >> 2015-04-22 09:53:25.628432 mon.0 10.7.0.152:6789/0 2152 : cluster
> >> [INF] pgmap v11338: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 244 MB/s rd, 62644 op/s
> >> 2015-04-22 09:53:26.632855 mon.0 10.7.0.152:6789/0 2153 : cluster
> >> [INF] pgmap v11339: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 175 MB/s rd, 44997 op/s
> >> 2015-04-22 09:53:27.636573 mon.0 10.7.0.152:6789/0 2154 : cluster
> >> [INF] pgmap v11340: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 122 MB/s rd, 31259 op/s
> >> 2015-04-22 09:53:28.645784 mon.0 10.7.0.152:6789/0 2155 : cluster
> >> [INF] pgmap v11341: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 229 MB/s rd, 58674 op/s
> >> 2015-04-22 09:53:29.657128 mon.0 10.7.0.152:6789/0 2156 : cluster
> >> [INF] pgmap v11342: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 271 MB/s rd, 69501 op/s
> >> 2015-04-22 09:53:30.662796 mon.0 10.7.0.152:6789/0 2157 : cluster
> >> [INF] pgmap v11343: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 211 MB/s rd, 54020 op/s
> >> 2015-04-22 09:53:31.666421 mon.0 10.7.0.152:6789/0 2158 : cluster
> >> [INF] pgmap v11344: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 164 MB/s rd, 42001 op/s
> >> 2015-04-22 09:53:32.670842 mon.0 10.7.0.152:6789/0 2159 : cluster
> >> [INF] pgmap v11345: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 134 MB/s rd, 34380 op/s
> >> 2015-04-22 09:53:33.681357 mon.0 10.7.0.152:6789/0 2160 : cluster
> >> [INF] pgmap v11346: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 293 MB/s rd, 75213 op/s
> >> 2015-04-22 09:53:34.692177 mon.0 10.7.0.152:6789/0 2161 : cluster
> >> [INF] pgmap v11347: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 337 MB/s rd, 86353 op/s
> >> 2015-04-22 09:53:35.697401 mon.0 10.7.0.152:6789/0 2162 : cluster
> >> [INF] pgmap v11348: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 229 MB/s rd, 58839 op/s
> >> 2015-04-22 09:53:36.699309 mon.0 10.7.0.152:6789/0 2163 : cluster
> >> [INF] pgmap v11349: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 GB /
> >> 1295 GB avail; 152 MB/s rd, 39117 op/s
> >>
> >>
> >> restarting osd
> >> ---------------
> >>
> >> 2015-04-22 10:00:09.766906 mon.0 10.7.0.152:6789/0 2255 : cluster
> >> [INF] osd.0 marked itself down
> >> 2015-04-22 10:00:09.790212 mon.0 10.7.0.152:6789/0 2256 : cluster
> >> [INF] osdmap e849: 9 osds: 8 up, 9 in
> >> 2015-04-22 10:00:09.793050 mon.0 10.7.0.152:6789/0 2257 : cluster
> >> [INF] pgmap v11439: 964 pgs: 2 active+undersized+degraded, 8
> >> stale+active+remapped, 106 stale+active+clean, 54 active+remapped,
> >> stale+active+794
> >> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail; 516
> >> kB/s rd, 130 op/s
> >> 2015-04-22 10:00:10.795966 mon.0 10.7.0.152:6789/0 2258 : cluster
> >> [INF] osdmap e850: 9 osds: 8 up, 9 in
> >> 2015-04-22 10:00:10.796675 mon.0 10.7.0.152:6789/0 2259 : cluster
> >> [INF] pgmap v11440: 964 pgs: 2 active+undersized+degraded, 8
> >> stale+active+remapped, 106 stale+active+clean, 54 active+remapped,
> >> stale+active+794
> >> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:11.798257 mon.0 10.7.0.152:6789/0 2260 : cluster
> >> [INF] pgmap v11441: 964 pgs: 2 active+undersized+degraded, 8
> >> stale+active+remapped, 106 stale+active+clean, 54 active+remapped,
> >> stale+active+794
> >> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:12.339696 mon.0 10.7.0.152:6789/0 2262 : cluster
> >> [INF] osd.1 marked itself down
> >> 2015-04-22 10:00:12.800168 mon.0 10.7.0.152:6789/0 2263 : cluster
> >> [INF] osdmap e851: 9 osds: 7 up, 9 in
> >> 2015-04-22 10:00:12.806498 mon.0 10.7.0.152:6789/0 2264 : cluster
> >> [INF] pgmap v11443: 964 pgs: 1 active+undersized+degraded, 13
> >> stale+active+remapped, 216 stale+active+clean, 49 active+remapped,
> >> stale+active+684
> >> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB
> >> used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:13.804186 mon.0 10.7.0.152:6789/0 2265 : cluster
> >> [INF] osdmap e852: 9 osds: 7 up, 9 in
> >> 2015-04-22 10:00:13.805216 mon.0 10.7.0.152:6789/0 2266 : cluster
> >> [INF] pgmap v11444: 964 pgs: 1 active+undersized+degraded, 13
> >> stale+active+remapped, 216 stale+active+clean, 49 active+remapped,
> >> stale+active+684
> >> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB
> >> used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:14.781785 mon.0 10.7.0.152:6789/0 2268 : cluster
> >> [INF] osd.2 marked itself down
> >> 2015-04-22 10:00:14.810571 mon.0 10.7.0.152:6789/0 2269 : cluster
> >> [INF] osdmap e853: 9 osds: 6 up, 9 in
> >> 2015-04-22 10:00:14.813871 mon.0 10.7.0.152:6789/0 2270 : cluster
> >> [INF] pgmap v11445: 964 pgs: 1 active+undersized+degraded, 22
> >> stale+active+remapped, 300 stale+active+clean, 40 active+remapped,
> >> stale+active+600
> >> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB
> >> used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:15.810333 mon.0 10.7.0.152:6789/0 2271 : cluster
> >> [INF] osdmap e854: 9 osds: 6 up, 9 in
> >> 2015-04-22 10:00:15.811425 mon.0 10.7.0.152:6789/0 2272 : cluster
> >> [INF] pgmap v11446: 964 pgs: 1 active+undersized+degraded, 22
> >> stale+active+remapped, 300 stale+active+clean, 40 active+remapped,
> >> stale+active+600
> >> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB
> >> used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:16.395105 mon.0 10.7.0.152:6789/0 2273 : cluster
> >> [INF] HEALTH_WARN; 2 pgs degraded; 323 pgs stale; 2 pgs stuck
> >> degraded; 64 pgs stuck unclean; 2 pgs stuck undersized; 2 pgs
> >> undersized; 3/9 in osds are down; clock skew detected on mon.ceph1-2
> >> 2015-04-22 10:00:16.814432 mon.0 10.7.0.152:6789/0 2274 : cluster
> >> [INF] osd.1 10.7.0.152:6800/14848 boot
> >> 2015-04-22 10:00:16.814938 mon.0 10.7.0.152:6789/0 2275 : cluster
> >> [INF] osdmap e855: 9 osds: 7 up, 9 in
> >> 2015-04-22 10:00:16.815942 mon.0 10.7.0.152:6789/0 2276 : cluster
> >> [INF] pgmap v11447: 964 pgs: 1 active+undersized+degraded, 22
> >> stale+active+remapped, 300 stale+active+clean, 40 active+remapped,
> >> stale+active+600
> >> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB
> >> used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:17.222281 mon.0 10.7.0.152:6789/0 2278 : cluster
> >> [INF] osd.3 marked itself down
> >> 2015-04-22 10:00:17.819371 mon.0 10.7.0.152:6789/0 2279 : cluster
> >> [INF] osdmap e856: 9 osds: 6 up, 9 in
> >> 2015-04-22 10:00:17.822041 mon.0 10.7.0.152:6789/0 2280 : cluster
> >> [INF] pgmap v11448: 964 pgs: 1 active+undersized+degraded, 25
> >> stale+active+remapped, 394 stale+active+clean, 37 active+remapped,
> >> stale+active+506
> >> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB
> >> used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:18.551068 mon.0 10.7.0.152:6789/0 2282 : cluster
> >> [INF] osd.6 marked itself down
> >> 2015-04-22 10:00:18.819387 mon.0 10.7.0.152:6789/0 2283 : cluster
> >> [INF] osd.2 10.7.0.152:6812/15410 boot
> >> 2015-04-22 10:00:18.821134 mon.0 10.7.0.152:6789/0 2284 : cluster
> >> [INF] osdmap e857: 9 osds: 6 up, 9 in
> >> 2015-04-22 10:00:18.824440 mon.0 10.7.0.152:6789/0 2285 : cluster
> >> [INF] pgmap v11449: 964 pgs: 1 active+undersized+degraded, 30
> >> stale+active+remapped, 502 stale+active+clean, 32 active+remapped,
> >> stale+active+398
> >> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB
> >> used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:19.820947 mon.0 10.7.0.152:6789/0 2287 : cluster
> >> [INF] osdmap e858: 9 osds: 6 up, 9 in
> >> 2015-04-22 10:00:19.821853 mon.0 10.7.0.152:6789/0 2288 : cluster
> >> [INF] pgmap v11450: 964 pgs: 1 active+undersized+degraded, 30
> >> stale+active+remapped, 502 stale+active+clean, 32 active+remapped,
> >> stale+active+398
> >> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB
> >> used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:20.828047 mon.0 10.7.0.152:6789/0 2290 : cluster
> >> [INF] osd.3 10.7.0.152:6816/15971 boot
> >> 2015-04-22 10:00:20.828431 mon.0 10.7.0.152:6789/0 2291 : cluster
> >> [INF] osdmap e859: 9 osds: 7 up, 9 in
> >> 2015-04-22 10:00:20.829126 mon.0 10.7.0.152:6789/0 2292 : cluster
> >> [INF] pgmap v11451: 964 pgs: 1 active+undersized+degraded, 30
> >> stale+active+remapped, 502 stale+active+clean, 32 active+remapped,
> >> stale+active+398
> >> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB
> >> used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:20.991343 mon.0 10.7.0.152:6789/0 2294 : cluster
> >> [INF] osd.7 marked itself down
> >> 2015-04-22 10:00:21.830389 mon.0 10.7.0.152:6789/0 2295 : cluster
> >> [INF] osd.0 10.7.0.152:6804/14481 boot
> >> 2015-04-22 10:00:21.832518 mon.0 10.7.0.152:6789/0 2296 : cluster
> >> [INF] osdmap e860: 9 osds: 7 up, 9 in
> >> 2015-04-22 10:00:21.836129 mon.0 10.7.0.152:6789/0 2297 : cluster
> >> [INF] pgmap v11452: 964 pgs: 1 active+undersized+degraded, 35
> >> stale+active+remapped, 608 stale+active+clean, 27 active+remapped,
> >> stale+active+292
> >> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB
> >> used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:22.830456 mon.0 10.7.0.152:6789/0 2298 : cluster
> >> [INF] osd.6 10.7.0.153:6808/21955 boot
> >> 2015-04-22 10:00:22.832171 mon.0 10.7.0.152:6789/0 2299 : cluster
> >> [INF] osdmap e861: 9 osds: 8 up, 9 in
> >> 2015-04-22 10:00:22.836272 mon.0 10.7.0.152:6789/0 2300 : cluster
> >> [INF] pgmap v11453: 964 pgs: 3 active+undersized+degraded, 27
> >> stale+active+remapped, 498 stale+active+clean, 2 peering, 28
> >> active+remapped, 402 active+clean, 4 remapped+peering; 419 GB data,
> >> 420 GB used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:23.420309 mon.0 10.7.0.152:6789/0 2302 : cluster
> >> [INF] osd.8 marked itself down
> >> 2015-04-22 10:00:23.833708 mon.0 10.7.0.152:6789/0 2303 : cluster
> >> [INF] osdmap e862: 9 osds: 7 up, 9 in
> >> 2015-04-22 10:00:23.836459 mon.0 10.7.0.152:6789/0 2304 : cluster
> >> [INF] pgmap v11454: 964 pgs: 3 active+undersized+degraded, 44
> >> stale+active+remapped, 587 stale+active+clean, 2 peering, 11
> >> active+remapped, 313 active+clean, 4 remapped+peering; 419 GB data,
> >> 420 GB used, 874 GB / 1295 GB avail
> >> 2015-04-22 10:00:24.832905 mon.0 10.7.0.152:6789/0 2305 : cluster
> >> [INF] osd.7 10.7.0.153:6804/22536 boot
> >> 2015-04-22 10:00:24.834381 mon.0 10.7.0.152:6789/0 2306 : cluster
> >> [INF] osdmap e863: 9 osds: 8 up, 9 in
> >> 2015-04-22 10:00:24.836977 mon.0 10.7.0.152:6789/0 2307 : cluster
> >> [INF] pgmap v11455: 964 pgs: 3 active+undersized+degraded, 31
> >> stale+active+remapped, 503 stale+active+clean, 4
> >> active+undersized+degraded+remapped, 5 peering, 13 active+remapped,
> >> 397 active+clean, 8 remapped+peering; 419 GB data, 420 GB used, 874
> >> GB / 1295 GB avail
> >> 2015-04-22 10:00:25.834459 mon.0 10.7.0.152:6789/0 2309 : cluster
> >> [INF] osdmap e864: 9 osds: 8 up, 9 in
> >> 2015-04-22 10:00:25.835727 mon.0 10.7.0.152:6789/0 2310 : cluster
> >> [INF] pgmap v11456: 964 pgs: 3 active+undersized+degraded, 31
> >> stale+active+remapped, 503 stale+active+clean, 4
> >> active+undersized+degraded+remapped, 5 peering, 13 active
> >>
> >>
> >> AFTER OSD RESTART
> >> ------------------
> >>
> >>
> >> 2015-04-22 10:09:27.609052 mon.0 10.7.0.152:6789/0 2339 : cluster
> >> [INF] pgmap v11478: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 786 MB/s rd, 196 kop/s
> >> 2015-04-22 10:09:28.618082 mon.0 10.7.0.152:6789/0 2340 : cluster
> >> [INF] pgmap v11479: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 1578 MB/s rd, 394 kop/s
> >> 2015-04-22 10:09:30.629067 mon.0 10.7.0.152:6789/0 2341 : cluster
> >> [INF] pgmap v11480: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 932 MB/s rd, 233 kop/s
> >> 2015-04-22 10:09:32.645890 mon.0 10.7.0.152:6789/0 2342 : cluster
> >> [INF] pgmap v11481: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 627 MB/s rd, 156 kop/s
> >> 2015-04-22 10:09:33.652634 mon.0 10.7.0.152:6789/0 2343 : cluster
> >> [INF] pgmap v11482: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 1034 MB/s rd, 258 kop/s
> >> 2015-04-22 10:09:35.655657 mon.0 10.7.0.152:6789/0 2344 : cluster
> >> [INF] pgmap v11483: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 529 MB/s rd, 132 kop/s
> >> 2015-04-22 10:09:37.674332 mon.0 10.7.0.152:6789/0 2345 : cluster
> >> [INF] pgmap v11484: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 770 MB/s rd, 192 kop/s
> >> 2015-04-22 10:09:38.679445 mon.0 10.7.0.152:6789/0 2346 : cluster
> >> [INF] pgmap v11485: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 1358 MB/s rd, 339 kop/s
> >> 2015-04-22 10:09:40.690037 mon.0 10.7.0.152:6789/0 2347 : cluster
> >> [INF] pgmap v11486: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 649 MB/s rd, 162 kop/s
> >> 2015-04-22 10:09:42.707164 mon.0 10.7.0.152:6789/0 2348 : cluster
> >> [INF] pgmap v11487: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 580 MB/s rd, 145 kop/s
> >> 2015-04-22 10:09:43.713736 mon.0 10.7.0.152:6789/0 2349 : cluster
> >> [INF] pgmap v11488: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 962 MB/s rd, 240 kop/s
> >> 2015-04-22 10:09:45.718658 mon.0 10.7.0.152:6789/0 2350 : cluster
> >> [INF] pgmap v11489: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 506 MB/s rd, 126 kop/s
> >> 2015-04-22 10:09:47.737358 mon.0 10.7.0.152:6789/0 2351 : cluster
> >> [INF] pgmap v11490: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 774 MB/s rd, 193 kop/s
> >> 2015-04-22 10:09:48.743338 mon.0 10.7.0.152:6789/0 2352 : cluster
> >> [INF] pgmap v11491: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 1363 MB/s rd, 340 kop/s
> >> 2015-04-22 10:09:50.746685 mon.0 10.7.0.152:6789/0 2353 : cluster
> >> [INF] pgmap v11492: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 662 MB/s rd, 165 kop/s
> >> 2015-04-22 10:09:52.762461 mon.0 10.7.0.152:6789/0 2354 : cluster
> >> [INF] pgmap v11493: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 593 MB/s rd, 148 kop/s
> >> 2015-04-22 10:09:53.767729 mon.0 10.7.0.152:6789/0 2355 : cluster
> >> [INF] pgmap v11494: 964 pgs: 2 active+undersized+degraded, 62
> >> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 GB /
> >> 1295 GB avail; 938 MB/s rd, 234 kop/s
> >>
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> > ________________________________
> >
> > PLEASE NOTE: The information contained in this electronic mail message
> is intended only for the use of the designated recipient(s) named above. =
If
> the reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any review=
,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please noti=
fy
> the sender by telephone or e-mail (as shown above) immediately and destro=
y
> any and all copies of this message in your possession (whether hard copie=
s
> or electronically stored copies).
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=
=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=
=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87
=D0=9C=D0=BE=D0=B1.: +79229045757

--001a11c3db82dc51e6051476d4eb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,Alexandre!<div>Do not try to change the parameter vm.mi=
n_free_kbytes?</div></div><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">2015-04-23 19:24 GMT+03:00 Somnath Roy <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">Somnath.Roy@sandisk=
.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Alexandre,<br>
You can configure with --with-jemalloc or ./do_autogen -J to build ceph wit=
h jemalloc.<br>
<br>
Thanks &amp; Regards<br>
Somnath<br>
<div><div class=3D"h5"><br>
-----Original Message-----<br>
From: ceph-users [mailto:<a href=3D"mailto:ceph-users-bounces-idqoXFIVOFLNfb0M+mGrxg@public.gmane.org=
m">ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>] On Behalf Of Alexandre DERUMIER<b=
r>
Sent: Thursday, April 23, 2015 4:56 AM<br>
To: Mark Nelson<br>
Cc: ceph-users; ceph-devel; Milosz Tanski<br>
Subject: Re: [ceph-users] strange benchmark problem : restarting osd daemon=
 improve performance from 100k iops to 300k iops<br>
<br>
&gt;&gt;If you have the means to compile the same version of ceph with<br>
&gt;&gt;jemalloc, I would be very interested to see how it does.<br>
<br>
Yes, sure. (I have around 3-4 weeks to do all the benchs)<br>
<br>
But I don&#39;t know how to do it ?<br>
I&#39;m running the cluster on centos7.1, maybe it can be easy to patch the=
 srpms to rebuild the package with jemalloc.<br>
<br>
<br>
<br>
----- Mail original -----<br>
De: &quot;Mark Nelson&quot; &lt;<a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">mnels=
on-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
=C3=80: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">ad=
erumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;, &quot;Srinivasula Maram&quot; &lt;<a href=3D"mai=
lto:Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a>&gt;<br=
>
Cc: &quot;ceph-users&quot; &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org"=
>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;, &quot;ceph-devel&quot; &lt;<a href=3D"m=
ailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot=
;Milosz Tanski&quot; &lt;<a href=3D"mailto:milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org">milosz@adfin.c=
om</a>&gt;<br>
Envoy=C3=A9: Jeudi 23 Avril 2015 13:33:00<br>
Objet: Re: [ceph-users] strange benchmark problem : restarting osd daemon i=
mprove performance from 100k iops to 300k iops<br>
<br>
Thanks for the testing Alexandre!<br>
<br>
If you have the means to compile the same version of ceph with jemalloc, I =
would be very interested to see how it does.<br>
<br>
In some ways I&#39;m glad it turned out not to be NUMA. I still suspect we =
will have to deal with it at some point, but perhaps not today. ;)<br>
<br>
Mark<br>
<br>
On 04/23/2015 05:58 AM, Alexandre DERUMIER wrote:<br>
&gt; Maybe it&#39;s tcmalloc related<br>
&gt; I thinked to have patched it correctly, but perf show a lot of<br>
&gt; tcmalloc::ThreadCache::ReleaseToCentralCache<br>
&gt;<br>
&gt; before osd restart (100k)<br>
&gt; ------------------<br>
&gt; 11.66% ceph-osd libtcmalloc.so.4.1.2 [.]<br>
&gt; tcmalloc::ThreadCache::ReleaseToCentralCache<br>
&gt; 8.51% ceph-osd libtcmalloc.so.4.1.2 [.]<br>
&gt; tcmalloc::CentralFreeList::FetchFromSpans<br>
&gt; 3.04% ceph-osd libtcmalloc.so.4.1.2 [.]<br>
&gt; tcmalloc::CentralFreeList::ReleaseToSpans<br>
&gt; 2.04% ceph-osd libtcmalloc.so.4.1.2 [.] operator new 1.63% swapper<br>
&gt; [kernel.kallsyms] [k] intel_idle 1.35% ceph-osd libtcmalloc.so.4.1.2<b=
r>
&gt; [.] tcmalloc::CentralFreeList::ReleaseListToSpans<br>
&gt; 1.33% ceph-osd libtcmalloc.so.4.1.2 [.] operator delete 1.07% ceph-osd=
<br>
&gt; libstdc++.so.6.0.19 [.] std::basic_string&lt;char,<br>
&gt; std::char_traits&lt;char&gt;, std::allocator&lt;char&gt; &gt;::basic_s=
tring 0.91%<br>
&gt; ceph-osd <a href=3D"http://libpthread-2.17.so" target=3D"_blank">libpt=
hread-2.17.so</a> [.] pthread_mutex_trylock 0.88% ceph-osd<br>
&gt; <a href=3D"http://libc-2.17.so" target=3D"_blank">libc-2.17.so</a> [.]=
 __memcpy_ssse3_back 0.81% ceph-osd ceph-osd [.]<br>
&gt; Mutex::Lock 0.79% ceph-osd [kernel.kallsyms] [k]<br>
&gt; copy_user_enhanced_fast_string 0.74% ceph-osd <a href=3D"http://libpth=
read-2.17.so" target=3D"_blank">libpthread-2.17.so</a> [.]<br>
&gt; pthread_mutex_unlock 0.67% ceph-osd [kernel.kallsyms] [k]<br>
&gt; _raw_spin_lock 0.63% swapper [kernel.kallsyms] [k]<br>
&gt; native_write_msr_safe 0.62% ceph-osd [kernel.kallsyms] [k]<br>
&gt; avc_has_perm_noaudit 0.58% ceph-osd ceph-osd [.] operator&lt; 0.57%<br=
>
&gt; ceph-osd [kernel.kallsyms] [k] __schedule 0.57% ceph-osd<br>
&gt; [kernel.kallsyms] [k] __d_lookup_rcu 0.54% swapper [kernel.kallsyms]<b=
r>
&gt; [k] __schedule<br>
&gt;<br>
&gt;<br>
&gt; after osd restart (300k iops)<br>
&gt; ------------------------------<br>
&gt; 3.47% ceph-osd libtcmalloc.so.4.1.2 [.] operator new 1.92% ceph-osd<br=
>
&gt; libtcmalloc.so.4.1.2 [.] operator delete 1.86% swapper<br>
&gt; [kernel.kallsyms] [k] intel_idle 1.52% ceph-osd libstdc++.so.6.0.19<br=
>
&gt; [.] std::basic_string&lt;char, std::char_traits&lt;char&gt;,<br>
&gt; std::allocator&lt;char&gt; &gt;::basic_string 1.34% ceph-osd<br>
&gt; libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseToCentralCache<=
br>
&gt; 1.24% ceph-osd <a href=3D"http://libc-2.17.so" target=3D"_blank">libc-=
2.17.so</a> [.] __memcpy_ssse3_back 1.23% ceph-osd<br>
&gt; ceph-osd [.] Mutex::Lock 1.21% ceph-osd <a href=3D"http://libpthread-2=
.17.so" target=3D"_blank">libpthread-2.17.so</a> [.]<br>
&gt; pthread_mutex_trylock 1.11% ceph-osd [kernel.kallsyms] [k]<br>
&gt; copy_user_enhanced_fast_string 0.95% ceph-osd <a href=3D"http://libpth=
read-2.17.so" target=3D"_blank">libpthread-2.17.so</a> [.]<br>
&gt; pthread_mutex_unlock 0.94% ceph-osd [kernel.kallsyms] [k]<br>
&gt; _raw_spin_lock 0.78% ceph-osd [kernel.kallsyms] [k] __d_lookup_rcu<br>
&gt; 0.70% ceph-osd [kernel.kallsyms] [k] tcp_sendmsg 0.70% ceph-osd<br>
&gt; ceph-osd [.] Message::Message 0.68% ceph-osd [kernel.kallsyms] [k]<br>
&gt; __schedule 0.66% ceph-osd [kernel.kallsyms] [k] idle_cpu 0.65%<br>
&gt; ceph-osd libtcmalloc.so.4.1.2 [.]<br>
&gt; tcmalloc::CentralFreeList::FetchFromSpans<br>
&gt; 0.64% swapper [kernel.kallsyms] [k] native_write_msr_safe 0.61%<br>
&gt; ceph-osd ceph-osd [.]<br>
&gt; std::tr1::_Sp_counted_base&lt;(__gnu_cxx::_Lock_policy)2&gt;::_M_relea=
se<br>
&gt; 0.60% swapper [kernel.kallsyms] [k] __schedule 0.60% ceph-osd<br>
&gt; libstdc++.so.6.0.19 [.] 0x00000000000bdd2b 0.57% ceph-osd ceph-osd [.]=
<br>
&gt; operator&lt; 0.57% ceph-osd ceph-osd [.] crc32_iscsi_00 0.56% ceph-osd=
<br>
&gt; libstdc++.so.6.0.19 [.] std::string::_Rep::_M_dispose 0.55% ceph-osd<b=
r>
&gt; [kernel.kallsyms] [k] __switch_to 0.54% ceph-osd <a href=3D"http://lib=
c-2.17.so" target=3D"_blank">libc-2.17.so</a> [.]<br>
&gt; vfprintf 0.52% ceph-osd [kernel.kallsyms] [k] fget_light<br>
&gt;<br>
&gt; ----- Mail original -----<br>
&gt; De: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">a=
derumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; =C3=80: &quot;Srinivasula Maram&quot; &lt;<a href=3D"mailto:Srinivasul=
a.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
&gt; Cc: &quot;ceph-users&quot; &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;, &quot;ceph-devel&quot;<br>
&gt; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29Tb/PtFMR13I2A@public.gmane.org=
el.org</a>&gt;, &quot;Milosz Tanski&quot; &lt;<a href=3D"mailto:milosz@adfi=
n.com">milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; Envoy=C3=A9: Jeudi 23 Avril 2015 10:00:34<br>
&gt; Objet: Re: [ceph-users] strange benchmark problem : restarting osd<br>
&gt; daemon improve performance from 100k iops to 300k iops<br>
&gt;<br>
&gt; Hi,<br>
&gt; I&#39;m hitting this bug again today.<br>
&gt;<br>
&gt; So don&#39;t seem to be numa related (I have try to flush linux buffer=
 to be sure).<br>
&gt;<br>
&gt; and tcmalloc is patched (I don&#39;t known how to verify that it&#39;s=
 ok).<br>
&gt;<br>
&gt; I don&#39;t have restarted osd yet.<br>
&gt;<br>
&gt; Maybe some perf trace could be usefulll ?<br>
&gt;<br>
&gt;<br>
&gt; ----- Mail original -----<br>
&gt; De: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">a=
derumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; =C3=80: &quot;Srinivasula Maram&quot; &lt;<a href=3D"mailto:Srinivasul=
a.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
&gt; Cc: &quot;ceph-users&quot; &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;, &quot;ceph-devel&quot;<br>
&gt; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29Tb/PtFMR13I2A@public.gmane.org=
el.org</a>&gt;, &quot;Milosz Tanski&quot; &lt;<a href=3D"mailto:milosz@adfi=
n.com">milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; Envoy=C3=A9: Mercredi 22 Avril 2015 18:30:26<br>
&gt; Objet: Re: [ceph-users] strange benchmark problem : restarting osd<br>
&gt; daemon improve performance from 100k iops to 300k iops<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt;&gt;&gt; I feel it is due to tcmalloc issue<br>
&gt;<br>
&gt; Indeed, I had patched one of my node, but not the other.<br>
&gt; So maybe I have hit this bug. (but I can&#39;t confirm, I don&#39;t ha=
ve traces).<br>
&gt;<br>
&gt; But numa interleaving seem to help in my case (maybe not from 100-&gt;=
300k, but 250k-&gt;300k).<br>
&gt;<br>
&gt; I need to do more long tests to confirm that.<br>
&gt;<br>
&gt;<br>
&gt; ----- Mail original -----<br>
&gt; De: &quot;Srinivasula Maram&quot; &lt;<a href=3D"mailto:Srinivasula.Ma=
ram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org">Srinivasula.Maram-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
&gt; =C3=80: &quot;Mark Nelson&quot; &lt;<a href=3D"mailto:mnelson@redhat.c=
om">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;, &quot;aderumier&quot;<br>
&gt; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;=
, &quot;Milosz Tanski&quot; &lt;<a href=3D"mailto:milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org">milosz@=
adfin.com</a>&gt;<br>
&gt; Cc: &quot;ceph-devel&quot; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TZNg+MwTxZMZA@public.gmane.org=
l.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;ceph-users&quot;<br>
&gt; &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com</a>&gt;<br>
&gt; Envoy=C3=A9: Mercredi 22 Avril 2015 16:34:33<br>
&gt; Objet: RE: [ceph-users] strange benchmark problem : restarting osd<br>
&gt; daemon improve performance from 100k iops to 300k iops<br>
&gt;<br>
&gt; I feel it is due to tcmalloc issue<br>
&gt;<br>
&gt; I have seen similar issue in my setup after 20 days.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Srinivas<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: ceph-users [mailto:<a href=3D"mailto:ceph-users-bounces-idqoXFIVOFI@public.gmane.org=
ph.com">ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>] On Behalf<br>
&gt; Of Mark Nelson<br>
&gt; Sent: Wednesday, April 22, 2015 7:31 PM<br>
&gt; To: Alexandre DERUMIER; Milosz Tanski<br>
&gt; Cc: ceph-devel; ceph-users<br>
&gt; Subject: Re: [ceph-users] strange benchmark problem : restarting osd<b=
r>
&gt; daemon improve performance from 100k iops to 300k iops<br>
&gt;<br>
&gt; Hi Alexandre,<br>
&gt;<br>
&gt; We should discuss this at the perf meeting today. We knew NUMA node af=
finity issues were going to crop up sooner or later (and indeed already hav=
e in some cases), but this is pretty major. It&#39;s probably time to reall=
y dig in and figure out how to deal with this.<br>
&gt;<br>
&gt; Note: this is one of the reasons I like small nodes with single socket=
s and fewer OSDs.<br>
&gt;<br>
&gt; Mark<br>
&gt;<br>
&gt; On 04/22/2015 08:56 AM, Alexandre DERUMIER wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; I have done a lot of test today, and it seem indeed numa related.<=
br>
&gt;&gt;<br>
&gt;&gt; My numastat was<br>
&gt;&gt;<br>
&gt;&gt; # numastat<br>
&gt;&gt; node0 node1<br>
&gt;&gt; numa_hit 99075422 153976877<br>
&gt;&gt; numa_miss 167490965 1493663<br>
&gt;&gt; numa_foreign 1493663 167491417<br>
&gt;&gt; interleave_hit 157745 167015<br>
&gt;&gt; local_node 99049179 153830554<br>
&gt;&gt; other_node 167517697 1639986<br>
&gt;&gt;<br>
&gt;&gt; So, a lot of miss.<br>
&gt;&gt;<br>
&gt;&gt; In this case , I can reproduce ios going from 85k to 300k iops, up=
 and down.<br>
&gt;&gt;<br>
&gt;&gt; now setting<br>
&gt;&gt; echo 0 &gt; /proc/sys/kernel/numa_balancing<br>
&gt;&gt;<br>
&gt;&gt; and starting osd daemons with<br>
&gt;&gt;<br>
&gt;&gt; numactl --interleave=3Dall /usr/bin/ceph-osd<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I have a constant 300k iops !<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I wonder if it could be improve by binding osd daemons to specific=
 numa node.<br>
&gt;&gt; I have 2 numanode of 10 cores with 6 osd, but I think it also requ=
ire ceph.conf osd threads tunning.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ----- Mail original -----<br>
&gt;&gt; De: &quot;Milosz Tanski&quot; &lt;<a href=3D"mailto:milosz@adfin.c=
om">milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; =C3=80: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier@odis=
o.com">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; Cc: &quot;ceph-devel&quot; &lt;<a href=3D"mailto:ceph-devel@vger.k=
ernel.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;ceph-users&quot;<br>
&gt;&gt; &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@lists.=
ceph.com</a>&gt;<br>
&gt;&gt; Envoy=C3=A9: Mercredi 22 Avril 2015 12:54:23<br>
&gt;&gt; Objet: Re: [ceph-users] strange benchmark problem : restarting osd=
<br>
&gt;&gt; daemon improve performance from 100k iops to 300k iops<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Apr 22, 2015 at 5:01 AM, Alexandre DERUMIER &lt; <a href=
=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I wonder if it could be numa related,<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m using centos 7.1,<br>
&gt;&gt; and auto numa balacning is enabled<br>
&gt;&gt;<br>
&gt;&gt; cat /proc/sys/kernel/numa_balancing =3D 1<br>
&gt;&gt;<br>
&gt;&gt; Maybe osd daemon access to buffer on wrong numa node.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ll try to reproduce the problem<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Can you force the degenerate case using numactl? To either affirm =
or deny your suspicion.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ----- Mail original -----<br>
&gt;&gt; De: &quot;aderumier&quot; &lt; <a href=3D"mailto:aderumier@odiso.c=
om">aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a> &gt;<br>
&gt;&gt; =C3=80: &quot;ceph-devel&quot; &lt; <a href=3D"mailto:ceph-devel@v=
ger.kernel.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &gt;, &quot;ceph-users&quot;=
 &lt;<br>
&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com</a> &gt;<br>
&gt;&gt; Envoy=C3=A9: Mercredi 22 Avril 2015 10:40:05<br>
&gt;&gt; Objet: [ceph-users] strange benchmark problem : restarting osd dae=
mon<br>
&gt;&gt; improve performance from 100k iops to 300k iops<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; I was doing some benchmarks,<br>
&gt;&gt; I have found an strange behaviour.<br>
&gt;&gt;<br>
&gt;&gt; Using fio with rbd engine, I was able to reach around 100k iops.<b=
r>
&gt;&gt; (osd datas in linux buffer, iostat show 0% disk access)<br>
&gt;&gt;<br>
&gt;&gt; then after restarting all osd daemons,<br>
&gt;&gt;<br>
&gt;&gt; the same fio benchmark show now around 300k iops.<br>
&gt;&gt; (osd datas in linux buffer, iostat show 0% disk access)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; any ideas?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; before restarting osd<br>
&gt;&gt; ---------------------<br>
&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K=
,<br>
&gt;&gt; ioengine=3Drbd, iodepth=3D32 ...<br>
&gt;&gt; fio-2.2.7-10-g51e9<br>
&gt;&gt; Starting 10 processes<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; ^Cbs: 10 (f=3D10): [r(10)] [2.9% done] [376.1MB/0KB/0KB /s] [96.6K=
/0/0<br>
&gt;&gt; iops] [eta 14m:45s]<br>
&gt;&gt; fio: terminating on signal 2<br>
&gt;&gt;<br>
&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D1707=
5: Wed Apr<br>
&gt;&gt; 22 10:00:04 2015 read : io=3D11558MB, bw=3D451487KB/s, iops=3D1128=
71, runt=3D<br>
&gt;&gt; 26215msec slat (usec): min=3D5, max=3D3685, avg=3D16.89, stdev=3D1=
7.38 clat<br>
&gt;&gt; (usec): min=3D5, max=3D62584, avg=3D2695.80, stdev=3D5351.23 lat (=
usec):<br>
&gt;&gt; min=3D109, max=3D62598, avg=3D2712.68, stdev=3D5350.42 clat percen=
tiles<br>
&gt;&gt; (usec):<br>
&gt;&gt; | 1.00th=3D[ 155], 5.00th=3D[ 183], 10.00th=3D[ 205], 20.00th=3D[ =
247],<br>
&gt;&gt; | 30.00th=3D[ 294], 40.00th=3D[ 354], 50.00th=3D[ 446], 60.00th=3D=
[ 660],<br>
&gt;&gt; | 70.00th=3D[ 1176], 80.00th=3D[ 3152], 90.00th=3D[ 9024], 95.00th=
=3D[14656],<br>
&gt;&gt; | 99.00th=3D[25984], 99.50th=3D[30336], 99.90th=3D[38656], 99.95th=
=3D[41728],<br>
&gt;&gt; | 99.99th=3D[47360]<br>
&gt;&gt; bw (KB /s): min=3D23928, max=3D154416, per=3D10.07%, avg=3D45462.8=
2,<br>
&gt;&gt; stdev=3D28809.95 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, =
100=3D0.01%,<br>
&gt;&gt; 250=3D20.79% lat (usec) : 500=3D32.74%, 750=3D8.99%, 1000=3D5.03% =
lat (msec) :<br>
&gt;&gt; 2=3D8.37%, 4=3D6.21%, 10=3D8.90%, 20=3D6.60%, 50=3D2.37% lat (msec=
) : 100=3D0.01%<br>
&gt;&gt; cpu : usr=3D15.90%, sys=3D3.01%, ctx=3D765446, majf=3D0, minf=3D87=
10 IO depths :<br>
&gt;&gt; 1=3D0.4%, 2=3D0.9%, 4=3D2.3%, 8=3D7.4%, 16=3D75.5%, 32=3D13.6%, &g=
t;=3D64=3D0.0% submit :<br>
&gt;&gt; 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0%<br>
&gt;&gt; complete : 0=3D0.0%, 4=3D93.6%, 8=3D2.8%, 16=3D2.4%, 32=3D1.2%, 64=
=3D0.0%,<br>
&gt;&gt;&gt; =3D64=3D0.0% issued : total=3Dr=3D2958935/w=3D0/d=3D0, short=
=3Dr=3D0/w=3D0/d=3D0,<br>
&gt;&gt; drop=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, percent=
ile=3D100.00%,<br>
&gt;&gt; depth=3D32<br>
&gt;&gt;<br>
&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt; READ: io=3D11558MB, aggrb=3D451487KB/s, minb=3D451487KB/s, maxb=3D=
451487KB/s,<br>
&gt;&gt; mint=3D26215msec, maxt=3D26215msec<br>
&gt;&gt;<br>
&gt;&gt; Disk stats (read/write):<br>
&gt;&gt; sdg: ios=3D0/29, merge=3D0/16, ticks=3D0/3, in_queue=3D3, util=3D0=
.01%<br>
&gt;&gt; [root@ceph1-3 fiorbd]# ./fio fiorbd<br>
&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K=
,<br>
&gt;&gt; ioengine=3Drbd, iodepth=3D32<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; AFTER RESTARTING OSDS<br>
&gt;&gt; ----------------------<br>
&gt;&gt; [root@ceph1-3 fiorbd]# ./fio fiorbd<br>
&gt;&gt; rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K=
,<br>
&gt;&gt; ioengine=3Drbd, iodepth=3D32 ...<br>
&gt;&gt; fio-2.2.7-10-g51e9<br>
&gt;&gt; Starting 10 processes<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; rbd engine: RBD version: 0.1.9<br>
&gt;&gt; ^Cbs: 10 (f=3D10): [r(10)] [0.2% done] [1155MB/0KB/0KB /s] [296K/0=
/0<br>
&gt;&gt; iops] [eta 01h:09m:27s]<br>
&gt;&gt; fio: terminating on signal 2<br>
&gt;&gt;<br>
&gt;&gt; rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D1825=
2: Wed Apr<br>
&gt;&gt; 22 10:02:28 2015 read : io=3D7655.7MB, bw=3D1036.8MB/s, iops=3D265=
218,<br>
&gt;&gt; runt=3D 7389msec slat (usec): min=3D5, max=3D3406, avg=3D26.59, st=
dev=3D40.35<br>
&gt;&gt; clat<br>
&gt;&gt; (usec): min=3D8, max=3D684328, avg=3D930.43, stdev=3D6419.12 lat (=
usec):<br>
&gt;&gt; min=3D154, max=3D684342, avg=3D957.02, stdev=3D6419.28 clat percen=
tiles<br>
&gt;&gt; (usec):<br>
&gt;&gt; | 1.00th=3D[ 243], 5.00th=3D[ 314], 10.00th=3D[ 366], 20.00th=3D[ =
450],<br>
&gt;&gt; | 30.00th=3D[ 524], 40.00th=3D[ 604], 50.00th=3D[ 692], 60.00th=3D=
[ 796],<br>
&gt;&gt; | 70.00th=3D[ 924], 80.00th=3D[ 1096], 90.00th=3D[ 1400], 95.00th=
=3D[ 1720],<br>
&gt;&gt; | 99.00th=3D[ 2672], 99.50th=3D[ 3248], 99.90th=3D[ 5920], 99.95th=
=3D[ 9792],<br>
&gt;&gt; | 99.99th=3D[436224]<br>
&gt;&gt; bw (KB /s): min=3D32614, max=3D143160, per=3D10.19%, avg=3D108076.=
46,<br>
&gt;&gt; stdev=3D28263.82 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, =
100=3D0.01%,<br>
&gt;&gt; 250=3D1.23% lat (usec) : 500=3D25.64%, 750=3D29.15%, 1000=3D18.84%=
 lat (msec)<br>
&gt;&gt; : 2=3D22.19%, 4=3D2.69%, 10=3D0.21%, 20=3D0.02%, 50=3D0.01% lat (m=
sec) :<br>
&gt;&gt; 250=3D0.01%, 500=3D0.02%, 750=3D0.01% cpu : usr=3D44.06%, sys=3D11=
.26%,<br>
&gt;&gt; ctx=3D642620, majf=3D0, minf=3D6832 IO depths : 1=3D0.1%, 2=3D0.5%=
, 4=3D2.0%,<br>
&gt;&gt; 8=3D11.5%, 16=3D77.8%, 32=3D8.1%, &gt;=3D64=3D0.0% submit : 0=3D0.=
0%, 4=3D100.0%,<br>
&gt;&gt; 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0% comple=
te : 0=3D0.0%,<br>
&gt;&gt; 4=3D94.1%, 8=3D1.3%, 16=3D2.3%, 32=3D2.3%, 64=3D0.0%, &gt;=3D64=3D=
0.0% issued :<br>
&gt;&gt; total=3Dr=3D1959697/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, drop=
=3Dr=3D0/w=3D0/d=3D0 latency :<br>
&gt;&gt; target=3D0, window=3D0, percentile=3D100.00%, depth=3D32<br>
&gt;&gt;<br>
&gt;&gt; Run status group 0 (all jobs):<br>
&gt;&gt; READ: io=3D7655.7MB, aggrb=3D1036.8MB/s, minb=3D1036.8MB/s,<br>
&gt;&gt; maxb=3D1036.8MB/s, mint=3D7389msec, maxt=3D7389msec<br>
&gt;&gt;<br>
&gt;&gt; Disk stats (read/write):<br>
&gt;&gt; sdg: ios=3D0/21, merge=3D0/10, ticks=3D0/2, in_queue=3D2, util=3D0=
.03%<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; CEPH LOG<br>
&gt;&gt; --------<br>
&gt;&gt;<br>
&gt;&gt; before restarting osd<br>
&gt;&gt; ----------------------<br>
&gt;&gt;<br>
&gt;&gt; 2015-04-22 09:53:17.568095 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2144 : cluster<br>
&gt;&gt; [INF] pgmap v11330: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 298 MB/s rd, 76465 op/s<br>
&gt;&gt; 2015-04-22 09:53:18.574524 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2145 : cluster<br>
&gt;&gt; [INF] pgmap v11331: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 333 MB/s rd, 85355 op/s<br>
&gt;&gt; 2015-04-22 09:53:19.579351 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2146 : cluster<br>
&gt;&gt; [INF] pgmap v11332: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 343 MB/s rd, 87932 op/s<br>
&gt;&gt; 2015-04-22 09:53:20.591586 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2147 : cluster<br>
&gt;&gt; [INF] pgmap v11333: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 328 MB/s rd, 84151 op/s<br>
&gt;&gt; 2015-04-22 09:53:21.600650 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2148 : cluster<br>
&gt;&gt; [INF] pgmap v11334: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 237 MB/s rd, 60855 op/s<br>
&gt;&gt; 2015-04-22 09:53:22.607966 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2149 : cluster<br>
&gt;&gt; [INF] pgmap v11335: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 144 MB/s rd, 36935 op/s<br>
&gt;&gt; 2015-04-22 09:53:23.617780 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2150 : cluster<br>
&gt;&gt; [INF] pgmap v11336: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 321 MB/s rd, 82334 op/s<br>
&gt;&gt; 2015-04-22 09:53:24.622341 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2151 : cluster<br>
&gt;&gt; [INF] pgmap v11337: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 368 MB/s rd, 94211 op/s<br>
&gt;&gt; 2015-04-22 09:53:25.628432 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2152 : cluster<br>
&gt;&gt; [INF] pgmap v11338: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 244 MB/s rd, 62644 op/s<br>
&gt;&gt; 2015-04-22 09:53:26.632855 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2153 : cluster<br>
&gt;&gt; [INF] pgmap v11339: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 175 MB/s rd, 44997 op/s<br>
&gt;&gt; 2015-04-22 09:53:27.636573 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2154 : cluster<br>
&gt;&gt; [INF] pgmap v11340: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 122 MB/s rd, 31259 op/s<br>
&gt;&gt; 2015-04-22 09:53:28.645784 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2155 : cluster<br>
&gt;&gt; [INF] pgmap v11341: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 229 MB/s rd, 58674 op/s<br>
&gt;&gt; 2015-04-22 09:53:29.657128 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2156 : cluster<br>
&gt;&gt; [INF] pgmap v11342: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 271 MB/s rd, 69501 op/s<br>
&gt;&gt; 2015-04-22 09:53:30.662796 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2157 : cluster<br>
&gt;&gt; [INF] pgmap v11343: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 211 MB/s rd, 54020 op/s<br>
&gt;&gt; 2015-04-22 09:53:31.666421 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2158 : cluster<br>
&gt;&gt; [INF] pgmap v11344: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 164 MB/s rd, 42001 op/s<br>
&gt;&gt; 2015-04-22 09:53:32.670842 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2159 : cluster<br>
&gt;&gt; [INF] pgmap v11345: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 134 MB/s rd, 34380 op/s<br>
&gt;&gt; 2015-04-22 09:53:33.681357 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2160 : cluster<br>
&gt;&gt; [INF] pgmap v11346: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 293 MB/s rd, 75213 op/s<br>
&gt;&gt; 2015-04-22 09:53:34.692177 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2161 : cluster<br>
&gt;&gt; [INF] pgmap v11347: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 337 MB/s rd, 86353 op/s<br>
&gt;&gt; 2015-04-22 09:53:35.697401 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2162 : cluster<br>
&gt;&gt; [INF] pgmap v11348: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 229 MB/s rd, 58839 op/s<br>
&gt;&gt; 2015-04-22 09:53:36.699309 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2163 : cluster<br>
&gt;&gt; [INF] pgmap v11349: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 G=
B /<br>
&gt;&gt; 1295 GB avail; 152 MB/s rd, 39117 op/s<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; restarting osd<br>
&gt;&gt; ---------------<br>
&gt;&gt;<br>
&gt;&gt; 2015-04-22 10:00:09.766906 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2255 : cluster<br>
&gt;&gt; [INF] osd.0 marked itself down<br>
&gt;&gt; 2015-04-22 10:00:09.790212 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2256 : cluster<br>
&gt;&gt; [INF] osdmap e849: 9 osds: 8 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:09.793050 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2257 : cluster<br>
&gt;&gt; [INF] pgmap v11439: 964 pgs: 2 active+undersized+degraded, 8<br>
&gt;&gt; stale+active+remapped, 106 stale+active+clean, 54 active+remapped,=
<br>
</div></div>&gt;&gt; stale+active+794<br>
<span class=3D"">&gt;&gt; active+clean; 419 GB data, 420 GB used, 874 GB / =
1295 GB avail; 516<br>
&gt;&gt; kB/s rd, 130 op/s<br>
&gt;&gt; 2015-04-22 10:00:10.795966 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2258 : cluster<br>
&gt;&gt; [INF] osdmap e850: 9 osds: 8 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:10.796675 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2259 : cluster<br>
&gt;&gt; [INF] pgmap v11440: 964 pgs: 2 active+undersized+degraded, 8<br>
&gt;&gt; stale+active+remapped, 106 stale+active+clean, 54 active+remapped,=
<br>
</span>&gt;&gt; stale+active+794<br>
<span class=3D"">&gt;&gt; active+clean; 419 GB data, 420 GB used, 874 GB / =
1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:11.798257 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2260 : cluster<br>
&gt;&gt; [INF] pgmap v11441: 964 pgs: 2 active+undersized+degraded, 8<br>
&gt;&gt; stale+active+remapped, 106 stale+active+clean, 54 active+remapped,=
<br>
</span>&gt;&gt; stale+active+794<br>
<span class=3D"">&gt;&gt; active+clean; 419 GB data, 420 GB used, 874 GB / =
1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:12.339696 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2262 : cluster<br>
&gt;&gt; [INF] osd.1 marked itself down<br>
&gt;&gt; 2015-04-22 10:00:12.800168 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2263 : cluster<br>
&gt;&gt; [INF] osdmap e851: 9 osds: 7 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:12.806498 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2264 : cluster<br>
&gt;&gt; [INF] pgmap v11443: 964 pgs: 1 active+undersized+degraded, 13<br>
&gt;&gt; stale+active+remapped, 216 stale+active+clean, 49 active+remapped,=
<br>
</span>&gt;&gt; stale+active+684<br>
<span class=3D"">&gt;&gt; active+clean, 1 stale+active+undersized+degraded;=
 419 GB data, 420 GB<br>
&gt;&gt; used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:13.804186 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2265 : cluster<br>
&gt;&gt; [INF] osdmap e852: 9 osds: 7 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:13.805216 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2266 : cluster<br>
&gt;&gt; [INF] pgmap v11444: 964 pgs: 1 active+undersized+degraded, 13<br>
&gt;&gt; stale+active+remapped, 216 stale+active+clean, 49 active+remapped,=
<br>
</span>&gt;&gt; stale+active+684<br>
<span class=3D"">&gt;&gt; active+clean, 1 stale+active+undersized+degraded;=
 419 GB data, 420 GB<br>
&gt;&gt; used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:14.781785 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2268 : cluster<br>
&gt;&gt; [INF] osd.2 marked itself down<br>
&gt;&gt; 2015-04-22 10:00:14.810571 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2269 : cluster<br>
&gt;&gt; [INF] osdmap e853: 9 osds: 6 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:14.813871 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2270 : cluster<br>
&gt;&gt; [INF] pgmap v11445: 964 pgs: 1 active+undersized+degraded, 22<br>
&gt;&gt; stale+active+remapped, 300 stale+active+clean, 40 active+remapped,=
<br>
</span>&gt;&gt; stale+active+600<br>
<span class=3D"">&gt;&gt; active+clean, 1 stale+active+undersized+degraded;=
 419 GB data, 420 GB<br>
&gt;&gt; used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:15.810333 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2271 : cluster<br>
&gt;&gt; [INF] osdmap e854: 9 osds: 6 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:15.811425 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2272 : cluster<br>
&gt;&gt; [INF] pgmap v11446: 964 pgs: 1 active+undersized+degraded, 22<br>
&gt;&gt; stale+active+remapped, 300 stale+active+clean, 40 active+remapped,=
<br>
</span>&gt;&gt; stale+active+600<br>
<span class=3D"">&gt;&gt; active+clean, 1 stale+active+undersized+degraded;=
 419 GB data, 420 GB<br>
&gt;&gt; used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:16.395105 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2273 : cluster<br>
&gt;&gt; [INF] HEALTH_WARN; 2 pgs degraded; 323 pgs stale; 2 pgs stuck<br>
&gt;&gt; degraded; 64 pgs stuck unclean; 2 pgs stuck undersized; 2 pgs<br>
&gt;&gt; undersized; 3/9 in osds are down; clock skew detected on mon.ceph1=
-2<br>
&gt;&gt; 2015-04-22 10:00:16.814432 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2274 : cluster<br>
&gt;&gt; [INF] osd.1 <a href=3D"http://10.7.0.152:6800/14848" target=3D"_bl=
ank">10.7.0.152:6800/14848</a> boot<br>
&gt;&gt; 2015-04-22 10:00:16.814938 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2275 : cluster<br>
&gt;&gt; [INF] osdmap e855: 9 osds: 7 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:16.815942 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2276 : cluster<br>
&gt;&gt; [INF] pgmap v11447: 964 pgs: 1 active+undersized+degraded, 22<br>
&gt;&gt; stale+active+remapped, 300 stale+active+clean, 40 active+remapped,=
<br>
</span>&gt;&gt; stale+active+600<br>
<span class=3D"">&gt;&gt; active+clean, 1 stale+active+undersized+degraded;=
 419 GB data, 420 GB<br>
&gt;&gt; used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:17.222281 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2278 : cluster<br>
&gt;&gt; [INF] osd.3 marked itself down<br>
&gt;&gt; 2015-04-22 10:00:17.819371 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2279 : cluster<br>
&gt;&gt; [INF] osdmap e856: 9 osds: 6 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:17.822041 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2280 : cluster<br>
&gt;&gt; [INF] pgmap v11448: 964 pgs: 1 active+undersized+degraded, 25<br>
&gt;&gt; stale+active+remapped, 394 stale+active+clean, 37 active+remapped,=
<br>
</span>&gt;&gt; stale+active+506<br>
<span class=3D"">&gt;&gt; active+clean, 1 stale+active+undersized+degraded;=
 419 GB data, 420 GB<br>
&gt;&gt; used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:18.551068 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2282 : cluster<br>
&gt;&gt; [INF] osd.6 marked itself down<br>
&gt;&gt; 2015-04-22 10:00:18.819387 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2283 : cluster<br>
&gt;&gt; [INF] osd.2 <a href=3D"http://10.7.0.152:6812/15410" target=3D"_bl=
ank">10.7.0.152:6812/15410</a> boot<br>
&gt;&gt; 2015-04-22 10:00:18.821134 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2284 : cluster<br>
&gt;&gt; [INF] osdmap e857: 9 osds: 6 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:18.824440 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2285 : cluster<br>
&gt;&gt; [INF] pgmap v11449: 964 pgs: 1 active+undersized+degraded, 30<br>
&gt;&gt; stale+active+remapped, 502 stale+active+clean, 32 active+remapped,=
<br>
</span>&gt;&gt; stale+active+398<br>
<span class=3D"">&gt;&gt; active+clean, 1 stale+active+undersized+degraded;=
 419 GB data, 420 GB<br>
&gt;&gt; used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:19.820947 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2287 : cluster<br>
&gt;&gt; [INF] osdmap e858: 9 osds: 6 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:19.821853 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2288 : cluster<br>
&gt;&gt; [INF] pgmap v11450: 964 pgs: 1 active+undersized+degraded, 30<br>
&gt;&gt; stale+active+remapped, 502 stale+active+clean, 32 active+remapped,=
<br>
</span>&gt;&gt; stale+active+398<br>
<span class=3D"">&gt;&gt; active+clean, 1 stale+active+undersized+degraded;=
 419 GB data, 420 GB<br>
&gt;&gt; used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:20.828047 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2290 : cluster<br>
&gt;&gt; [INF] osd.3 <a href=3D"http://10.7.0.152:6816/15971" target=3D"_bl=
ank">10.7.0.152:6816/15971</a> boot<br>
&gt;&gt; 2015-04-22 10:00:20.828431 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2291 : cluster<br>
&gt;&gt; [INF] osdmap e859: 9 osds: 7 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:20.829126 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2292 : cluster<br>
&gt;&gt; [INF] pgmap v11451: 964 pgs: 1 active+undersized+degraded, 30<br>
&gt;&gt; stale+active+remapped, 502 stale+active+clean, 32 active+remapped,=
<br>
</span>&gt;&gt; stale+active+398<br>
<span class=3D"">&gt;&gt; active+clean, 1 stale+active+undersized+degraded;=
 419 GB data, 420 GB<br>
&gt;&gt; used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:20.991343 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2294 : cluster<br>
&gt;&gt; [INF] osd.7 marked itself down<br>
&gt;&gt; 2015-04-22 10:00:21.830389 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2295 : cluster<br>
&gt;&gt; [INF] osd.0 <a href=3D"http://10.7.0.152:6804/14481" target=3D"_bl=
ank">10.7.0.152:6804/14481</a> boot<br>
&gt;&gt; 2015-04-22 10:00:21.832518 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2296 : cluster<br>
&gt;&gt; [INF] osdmap e860: 9 osds: 7 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:21.836129 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2297 : cluster<br>
&gt;&gt; [INF] pgmap v11452: 964 pgs: 1 active+undersized+degraded, 35<br>
&gt;&gt; stale+active+remapped, 608 stale+active+clean, 27 active+remapped,=
<br>
</span>&gt;&gt; stale+active+292<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;&gt; active+clean, 1 stale+acti=
ve+undersized+degraded; 419 GB data, 420 GB<br>
&gt;&gt; used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:22.830456 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2298 : cluster<br>
&gt;&gt; [INF] osd.6 <a href=3D"http://10.7.0.153:6808/21955" target=3D"_bl=
ank">10.7.0.153:6808/21955</a> boot<br>
&gt;&gt; 2015-04-22 10:00:22.832171 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2299 : cluster<br>
&gt;&gt; [INF] osdmap e861: 9 osds: 8 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:22.836272 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2300 : cluster<br>
&gt;&gt; [INF] pgmap v11453: 964 pgs: 3 active+undersized+degraded, 27<br>
&gt;&gt; stale+active+remapped, 498 stale+active+clean, 2 peering, 28<br>
&gt;&gt; active+remapped, 402 active+clean, 4 remapped+peering; 419 GB data=
,<br>
&gt;&gt; 420 GB used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:23.420309 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2302 : cluster<br>
&gt;&gt; [INF] osd.8 marked itself down<br>
&gt;&gt; 2015-04-22 10:00:23.833708 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2303 : cluster<br>
&gt;&gt; [INF] osdmap e862: 9 osds: 7 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:23.836459 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2304 : cluster<br>
&gt;&gt; [INF] pgmap v11454: 964 pgs: 3 active+undersized+degraded, 44<br>
&gt;&gt; stale+active+remapped, 587 stale+active+clean, 2 peering, 11<br>
&gt;&gt; active+remapped, 313 active+clean, 4 remapped+peering; 419 GB data=
,<br>
&gt;&gt; 420 GB used, 874 GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:24.832905 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2305 : cluster<br>
&gt;&gt; [INF] osd.7 <a href=3D"http://10.7.0.153:6804/22536" target=3D"_bl=
ank">10.7.0.153:6804/22536</a> boot<br>
&gt;&gt; 2015-04-22 10:00:24.834381 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2306 : cluster<br>
&gt;&gt; [INF] osdmap e863: 9 osds: 8 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:24.836977 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2307 : cluster<br>
&gt;&gt; [INF] pgmap v11455: 964 pgs: 3 active+undersized+degraded, 31<br>
&gt;&gt; stale+active+remapped, 503 stale+active+clean, 4<br>
&gt;&gt; active+undersized+degraded+remapped, 5 peering, 13 active+remapped=
,<br>
&gt;&gt; 397 active+clean, 8 remapped+peering; 419 GB data, 420 GB used, 87=
4<br>
&gt;&gt; GB / 1295 GB avail<br>
&gt;&gt; 2015-04-22 10:00:25.834459 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2309 : cluster<br>
&gt;&gt; [INF] osdmap e864: 9 osds: 8 up, 9 in<br>
&gt;&gt; 2015-04-22 10:00:25.835727 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2310 : cluster<br>
&gt;&gt; [INF] pgmap v11456: 964 pgs: 3 active+undersized+degraded, 31<br>
&gt;&gt; stale+active+remapped, 503 stale+active+clean, 4<br>
&gt;&gt; active+undersized+degraded+remapped, 5 peering, 13 active<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; AFTER OSD RESTART<br>
&gt;&gt; ------------------<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; 2015-04-22 10:09:27.609052 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2339 : cluster<br>
&gt;&gt; [INF] pgmap v11478: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 786 MB/s rd, 196 kop/s<br>
&gt;&gt; 2015-04-22 10:09:28.618082 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2340 : cluster<br>
&gt;&gt; [INF] pgmap v11479: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 1578 MB/s rd, 394 kop/s<br>
&gt;&gt; 2015-04-22 10:09:30.629067 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2341 : cluster<br>
&gt;&gt; [INF] pgmap v11480: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 932 MB/s rd, 233 kop/s<br>
&gt;&gt; 2015-04-22 10:09:32.645890 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2342 : cluster<br>
&gt;&gt; [INF] pgmap v11481: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 627 MB/s rd, 156 kop/s<br>
&gt;&gt; 2015-04-22 10:09:33.652634 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2343 : cluster<br>
&gt;&gt; [INF] pgmap v11482: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 1034 MB/s rd, 258 kop/s<br>
&gt;&gt; 2015-04-22 10:09:35.655657 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2344 : cluster<br>
&gt;&gt; [INF] pgmap v11483: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 529 MB/s rd, 132 kop/s<br>
&gt;&gt; 2015-04-22 10:09:37.674332 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2345 : cluster<br>
&gt;&gt; [INF] pgmap v11484: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 770 MB/s rd, 192 kop/s<br>
&gt;&gt; 2015-04-22 10:09:38.679445 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2346 : cluster<br>
&gt;&gt; [INF] pgmap v11485: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 1358 MB/s rd, 339 kop/s<br>
&gt;&gt; 2015-04-22 10:09:40.690037 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2347 : cluster<br>
&gt;&gt; [INF] pgmap v11486: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 649 MB/s rd, 162 kop/s<br>
&gt;&gt; 2015-04-22 10:09:42.707164 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2348 : cluster<br>
&gt;&gt; [INF] pgmap v11487: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 580 MB/s rd, 145 kop/s<br>
&gt;&gt; 2015-04-22 10:09:43.713736 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2349 : cluster<br>
&gt;&gt; [INF] pgmap v11488: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 962 MB/s rd, 240 kop/s<br>
&gt;&gt; 2015-04-22 10:09:45.718658 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2350 : cluster<br>
&gt;&gt; [INF] pgmap v11489: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 506 MB/s rd, 126 kop/s<br>
&gt;&gt; 2015-04-22 10:09:47.737358 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2351 : cluster<br>
&gt;&gt; [INF] pgmap v11490: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 774 MB/s rd, 193 kop/s<br>
&gt;&gt; 2015-04-22 10:09:48.743338 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2352 : cluster<br>
&gt;&gt; [INF] pgmap v11491: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 1363 MB/s rd, 340 kop/s<br>
&gt;&gt; 2015-04-22 10:09:50.746685 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2353 : cluster<br>
&gt;&gt; [INF] pgmap v11492: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 662 MB/s rd, 165 kop/s<br>
&gt;&gt; 2015-04-22 10:09:52.762461 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2354 : cluster<br>
&gt;&gt; [INF] pgmap v11493: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 593 MB/s rd, 148 kop/s<br>
&gt;&gt; 2015-04-22 10:09:53.767729 mon.0 <a href=3D"http://10.7.0.152:6789=
/0" target=3D"_blank">10.7.0.152:6789/0</a> 2355 : cluster<br>
&gt;&gt; [INF] pgmap v11494: 964 pgs: 2 active+undersized+degraded, 62<br>
&gt;&gt; active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 G=
B /<br>
&gt;&gt; 1295 GB avail; 938 MB/s rd, 234 kop/s<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; ceph-users mailing list<br>
&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com</a><br>
&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com"=
 target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</=
a><br>
&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" tar=
get=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><b=
r>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; PLEASE NOTE: The information contained in this electronic mail message=
 is intended only for the use of the designated recipient(s) named above. I=
f the reader of this message is not the intended recipient, you are hereby =
notified that you have received this message in error and that any review, =
dissemination, distribution, or copying of this message is strictly prohibi=
ted. If you have received this communication in error, please notify the se=
nder by telephone or e-mail (as shown above) immediately and destroy any an=
d all copies of this message in your possession (whether hard copies or ele=
ctronically stored copies).<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" tar=
get=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><b=
r>
&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" tar=
get=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><b=
r>
&gt;<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr">=D0=A1 =D1=83=D0=B2=D0=B0=
=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=
=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=
=D0=BE=D0=B2=D0=B8=D1=87<div>=D0=9C=D0=BE=D0=B1.: +79229045757</div></div><=
/div>
</div>

--001a11c3db82dc51e6051476d4eb--

--===============2050199614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2050199614==--
