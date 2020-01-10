From: "Liu, Chunmei" <chunmei.liu@intel.com>
Subject: RE: crimson-osd vs legacy-osd: should the perf difference be already
 noticeable?
Date: Fri, 10 Jan 2020 23:28:59 +0000
Message-ID: <BY5PR11MB4273BE8C4A3FB0E3D01A20ACE0380@BY5PR11MB4273.namprd11.prod.outlook.com>
References: <02e2209f66f18217aa45b8f7caf715f6@suse.de>
 <CAJE9aON93O75PPRjfuFGYrtpBxRHHuepGX+tEC3FkBSgM6TgNQ@mail.gmail.com>
 <f3a976a6d2eba9cd8bd6bf46c0fc9967@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46942 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbgAJX3M (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:29:12 -0500
In-Reply-To: <f3a976a6d2eba9cd8bd6bf46c0fc9967@suse.de>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Penyaev <rpenyaev@suse.de>, kefu chai <tchaikov@gmail.com>, "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Radoslaw Zarzynski <rzarzyns@redhat.com>, Samuel Just <sjust@redhat.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org <ceph-devel-owner@vger.kernel.org>
> On Behalf Of Roman Penyaev
> Sent: Friday, January 10, 2020 10:54 AM
> To: kefu chai <tchaikov@gmail.com>
> Cc: Radoslaw Zarzynski <rzarzyns@redhat.com>; Samuel Just
> <sjust@redhat.com>; The Esoteric Order of the Squid Cybernetic <ceph-
> devel@vger.kernel.org>
> Subject: Re: crimson-osd vs legacy-osd: should the perf difference be alr=
eady
> noticeable?
>=20
> On 2020-01-10 17:18, kefu chai wrote:
>=20
> [skip]
>=20
> >>
> >> First thing that catches my eye is that for small blocks there is no
> >> big difference at all, but as the block increases, crimsons iops
> >> starts to
> >
> > that's also our findings. and it's expected. as async messenger uses
> > the same reactor model as seastar does. actually its original
> > implementation was adapted from seastar's socket stream
> > implementation.
>=20
> Hm, regardless of model messenger should not be a bottleneck.  Take a loo=
k on
> the results of fio_ceph_messenger load (runs pure messenger), I can squee=
ze
> IOPS=3D89.8k, BW=3D351MiB/s on 4k block size, iodepth=3D32.
> (also good example https://github.com/ceph/ceph/pull/26932 , almost
> ~200k)
>=20
> With PG layer (memstore_debug_omit_block_device_write=3Dtrue option) I ca=
n
> reach 40k iops max.  Without PG layer (immediate completion from the
> transport callback, osd_immediate_completions=3Dtrue) I get almost 60k.
>=20
> Seems that here starts playing costs on client side and these costs preva=
il.
>=20
> >
> >> decline. Can it be the transport issue? Can be tested as well.
> >
> > because seastar's socket facility reads from the wire with 4K chunk
> > size, while classic OSD's async messenger reads the payload with the
> > size suggested by the header. so when it comes to larger block size,
> > it takes crimson-osd multiple syscalls and memcpy calls to read the
> > request from wire, that's why classic OSD wins in this case.
>=20
> Do you plan to fix that?
>=20
> > have you tried to use multiple fio clients to saturate CPU capacity of
> > OSD nodes?
>=20
> Not yet.  But regarding CPU I have these numbers:
>=20
> output of pidstat while rbd.fio is running, 4k block only:
>=20
> legacy-osd
>=20
> [roman@dell ~]$ pidstat 1 -p 109930
> Linux 5.3.13-arch1-1 (dell)     01/09/2020      _x86_64_        (8 CPU)
>=20
> 03:51:49 PM   UID       PID    %usr %system  %guest   %wait    %CPU
> CPU  Command
> 03:51:51 PM  1000    109930   14.00    8.00    0.00    0.00   22.00
> 1  ceph-osd
> 03:51:52 PM  1000    109930   40.00   19.00    0.00    0.00   59.00
> 1  ceph-osd
> 03:51:53 PM  1000    109930   44.00   17.00    0.00    0.00   61.00
> 1  ceph-osd
> 03:51:54 PM  1000    109930   40.00   20.00    0.00    0.00   60.00
> 1  ceph-osd
> 03:51:55 PM  1000    109930   39.00   18.00    0.00    0.00   57.00
> 1  ceph-osd
> 03:51:56 PM  1000    109930   41.00   20.00    0.00    0.00   61.00
> 1  ceph-osd
> 03:51:57 PM  1000    109930   41.00   15.00    0.00    0.00   56.00
> 1  ceph-osd
> 03:51:58 PM  1000    109930   42.00   16.00    0.00    0.00   58.00
> 1  ceph-osd
> 03:51:59 PM  1000    109930   42.00   15.00    0.00    0.00   57.00
> 1  ceph-osd
> 03:52:00 PM  1000    109930   43.00   15.00    0.00    0.00   58.00
> 1  ceph-osd
> 03:52:01 PM  1000    109930   24.00   12.00    0.00    0.00   36.00
> 1  ceph-osd
>=20
>=20
> crimson-osd
>=20
> [roman@dell ~]$ pidstat 1  -p 108141
> Linux 5.3.13-arch1-1 (dell)     01/09/2020      _x86_64_        (8 CPU)
>=20
> 03:47:50 PM   UID       PID    %usr %system  %guest   %wait    %CPU
> CPU  Command
> 03:47:55 PM  1000    108141   67.00   11.00    0.00    0.00   78.00
> 0  crimson-osd
> 03:47:56 PM  1000    108141   79.00   12.00    0.00    0.00   91.00
> 0  crimson-osd
> 03:47:57 PM  1000    108141   81.00    9.00    0.00    0.00   90.00
> 0  crimson-osd
> 03:47:58 PM  1000    108141   78.00   12.00    0.00    0.00   90.00
> 0  crimson-osd
> 03:47:59 PM  1000    108141   78.00   12.00    0.00    1.00   90.00
> 0  crimson-osd
> 03:48:00 PM  1000    108141   78.00   13.00    0.00    0.00   91.00
> 0  crimson-osd
> 03:48:01 PM  1000    108141   79.00   13.00    0.00    0.00   92.00
> 0  crimson-osd
> 03:48:02 PM  1000    108141   78.00   12.00    0.00    0.00   90.00
> 0  crimson-osd
> 03:48:03 PM  1000    108141   77.00   11.00    0.00    0.00   88.00
> 0  crimson-osd
> 03:48:04 PM  1000    108141   79.00   12.00    0.00    1.00   91.00
> 0  crimson-osd
>=20
>=20
> Seems quite saturated, almost twice more than legacy-osd.  Did you see
> something similar?
Crimson-osd (seastar) use epoll, by default, it will use more cpu capacity,=
(you can change epoll mode setting to reduce it), add Ma, Jianpeng in the t=
hread since he did more study on it.=20
BTW, by default crimson-osd is one thread, and legacy ceph-osd (3 threads f=
or async messenger, 2x8 threads for osd (SDD), finisher thread etc,) ,so by=
 default setting, it is 1 thread compare to over 10 threads work,  it is ex=
pected crimson-osd not show obvious difference. you can change the default =
thread number for legacy ceph-osd(such as thread=3D1 for each layer to see =
more difference.)
BTW, please use release build to do test.=20
Crimson-osd is aysnc model, if workload is very light, can't take more adva=
ntage of it.
>=20
> --
> Roman
