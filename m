From: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Log message -->
 "bdev(/var/lib/ceph/osd/ceph-x/block) aio_submit retries"
Date: Thu, 16 Mar 2017 12:03:30 +0530
Message-ID: <CALWuvY-m4JyaohTJCfzeC==CnfJ2cGK1n8P+49pS65u5n8hnfQ@mail.gmail.com>
References: <CALWuvY8dEyWiUxg9VDaMkfQGwPSsWG0adrtzvGa9k7fhNmdsGw@mail.gmail.com>
	<CALWuvY9wY08n2AE9HMfZgZCU9ZEtk2XOwa353_stxT-7x7L30A@mail.gmail.com>
	<CALWuvY_9uWE_DKg5UaYZrc_GchfMK1EpX1rkWrJEuAV+Y3+Uww@mail.gmail.com>
	<CAF-wwdFvgzkYMnkheomsWMikZoZU+THyrxzovORx3bCDfPZ7Ng@mail.gmail.com>
	<alpine.DEB.2.11.1703151422110.10776@piezo.novalocal>
	<CALWuvY8f1j9_ccbzrchfdhZ66RYDTqRuL2A2qy9XFHTARitPBQ@mail.gmail.com>
	<CAF-wwdGBF5yDMOpdxm0S5fXcYYt94LaEiAXw8qXT2g66pB30xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1647310207=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF-wwdGBF5yDMOpdxm0S5fXcYYt94LaEiAXw8qXT2g66pB30xg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1647310207==
Content-Type: multipart/alternative; boundary=001a113e243c52bb47054ad33d04

--001a113e243c52bb47054ad33d04
Content-Type: text/plain; charset=UTF-8

Hello Brad,

I meant for this parameter bdev_aio_max_queue_depth , Sage suggested try
diff values, 128,1024 , 4096 . So my doubt how this calculation happens? Is
this  related to memory?

Thanks




On Thu, Mar 16, 2017 at 11:53 AM, Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Thu, Mar 16, 2017 at 4:15 PM, nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Hello,
> >
> > We are running latest kernel - 3.10.0-514.2.2.el7.x86_64 { RHEL 7.3 }
> >
> > Sure I will try to alter this directive - bdev_aio_max_queue_depth and
> will
> > share our results.
> >
> > Could you please explain how this calculation happens?
>
> What calculation are you referring to?
>
> > Thanks
> >
> >
> > On Wed, Mar 15, 2017 at 7:54 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> >>
> >> On Wed, 15 Mar 2017, Brad Hubbard wrote:
> >> > +ceph-devel
> >> >
> >> > On Wed, Mar 15, 2017 at 5:25 PM, nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >
> >> > wrote:
> >> > > Hello,
> >> > >
> >> > > We suspect these messages not only at the time of OSD creation. But
> in
> >> > > idle
> >> > > conditions also. May I know what is the impact of these error? Can
> we
> >> > > safely
> >> > > ignore this? Or is there any way/config to fix this problem
> >> > >
> >> > > Few occurrence for these events as follows:---
> >> > >
> >> > > ====
> >> > > 2017-03-14 17:16:09.500370 7fedeba61700  4 rocksdb: (Original Log
> Time
> >> > > 2017/03/14-17:16:09.453130) [default] Level-0 commit table #60
> started
> >> > > 2017-03-14 17:16:09.500374 7fedeba61700  4 rocksdb: (Original Log
> Time
> >> > > 2017/03/14-17:16:09.500273) [default] Level-0 commit table #60:
> >> > > memtable #1
> >> > > done
> >> > > 2017-03-14 17:16:09.500376 7fedeba61700  4 rocksdb: (Original Log
> Time
> >> > > 2017/03/14-17:16:09.500297) EVENT_LOG_v1 {"time_micros":
> >> > > 1489511769500289,
> >> > > "job": 17, "event": "flush_finished", "lsm_state": [2, 4, 6, 0, 0,
> 0,
> >> > > 0],
> >> > > "immutable_memtables": 0}
> >> > > 2017-03-14 17:16:09.500382 7fedeba61700  4 rocksdb: (Original Log
> Time
> >> > > 2017/03/14-17:16:09.500330) [default] Level summary: base level 1
> max
> >> > > bytes
> >> > > base 268435456 files[2 4 6 0 0 0 0] max score 0.76
> >> > >
> >> > > 2017-03-14 17:16:09.500390 7fedeba61700  4 rocksdb: [JOB 17] Try to
> >> > > delete
> >> > > WAL files size 244090350, prev total WAL file size 247331500, number
> >> > > of live
> >> > > WAL files 2.
> >> > >
> >> > > 2017-03-14 17:34:11.610513 7fedf3a71700 -1
> >> > > bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 6
> >> >
> >> > These errors come from here.
> >> >
> >> > void KernelDevice::aio_submit(IOContext *ioc)
> >> > {
> >> > ...
> >> >     int r = aio_queue.submit(*cur, &retries);
> >> >     if (retries)
> >> >       derr << __func__ << " retries " << retries << dendl;
> >> >
> >> > The submit function is this one which calls libaio's io_submit
> >> > function directly and increments retries if it receives EAGAIN.
> >> >
> >> > #if defined(HAVE_LIBAIO)
> >> > int FS::aio_queue_t::submit(aio_t &aio, int *retries)
> >> > {
> >> >   // 2^16 * 125us = ~8 seconds, so max sleep is ~16 seconds
> >> >   int attempts = 16;
> >> >   int delay = 125;
> >> >   iocb *piocb = &aio.iocb;
> >> >   while (true) {
> >> >     int r = io_submit(ctx, 1, &piocb);     <-------------NOTE
> >> >     if (r < 0) {
> >> >       if (r == -EAGAIN && attempts-- > 0) {     <-------------NOTE
> >> >         usleep(delay);
> >> >         delay *= 2;
> >> >         (*retries)++;
> >> >         continue;
> >> >       }
> >> >       return r;
> >> >     }
> >> >     assert(r == 1);
> >> >     break;
> >> >   }
> >> >   return 0;
> >> > }
> >> >
> >> >
> >> > From the man page.
> >> >
> >> > IO_SUBMIT(2)                                   Linux Programmer's
> >> > Manual                                  IO_SUBMIT(2)
> >> >
> >> > NAME
> >> >        io_submit - submit asynchronous I/O blocks for processing
> >> > ...
> >> > RETURN VALUE
> >> >        On success, io_submit() returns the number of iocbs submitted
> >> > (which may be 0 if nr is zero).  For the  failure
> >> >        return, see NOTES.
> >> >
> >> > ERRORS
> >> >        EAGAIN Insufficient resources are available to queue any iocbs.
> >> >
> >> > I suspect increasing bdev_aio_max_queue_depth may help here but some
> >> > of the other devs may have more/better ideas.
> >>
> >> Yes--try increasing bdev_aio_max_queue_depth.  It defaults to 32; try
> >> changing it to 128, 1024, or 4096 and see if these errors go away.
> >>
> >> I've never been able to trigger this on my test boxes, but I put in the
> >> warning to help ensure we pick a good default.
> >>
> >> What kernel version are you running?
> >>
> >> Thanks!
> >> sage
> >
> >
>
>
>
> --
> Cheers,
> Brad
>

--001a113e243c52bb47054ad33d04
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Brad,<div><br></div><div>I meant for this parameter=
=C2=A0<span style=3D"color:rgb(80,0,80);font-size:12.8px">bdev_aio_max_queu=
e_<wbr>depth , Sage suggested try diff values, 128,1024 , 4096 . So my doub=
t how this calculation happens? Is this =C2=A0related to memory?=C2=A0</spa=
n></div><div><br></div><div>Thanks</div><div><br></div><div><span style=3D"=
color:rgb(80,0,80);font-size:12.8px"><br></span></div><div><span style=3D"c=
olor:rgb(80,0,80);font-size:12.8px"><br></span></div></div><div class=3D"gm=
ail_extra"><br><div class=3D"gmail_quote">On Thu, Mar 16, 2017 at 11:53 AM,=
 Brad Hubbard <span dir=3D"ltr">&lt;<a href=3D"mailto:bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" =
target=3D"_blank">bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><span class=3D"">On Thu, Mar 16, 2017 at 4:15 PM, nokia =
ceph &lt;<a href=3D"mailto:nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">nokiacephusers@gmail.c=
om</a>&gt; wrote:<br>
&gt; Hello,<br>
&gt;<br>
</span><span class=3D"">&gt; We are running latest kernel - 3.10.0-514.2.2.=
el7.x86_64 { RHEL 7.3 }<br>
&gt;<br>
&gt; Sure I will try to alter this directive - bdev_aio_max_queue_depth and=
 will<br>
&gt; share our results.<br>
&gt;<br>
&gt; Could you please explain how this calculation happens?<br>
<br>
</span>What calculation are you referring to?<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; Thanks<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Mar 15, 2017 at 7:54 PM, Sage Weil &lt;<a href=3D"mailto:sage@=
newdream.net">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Wed, 15 Mar 2017, Brad Hubbard wrote:<br>
&gt;&gt; &gt; +ceph-devel<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Wed, Mar 15, 2017 at 5:25 PM, nokia ceph &lt;<a href=3D"ma=
ilto:nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; &gt; wrote:<br>
&gt;&gt; &gt; &gt; Hello,<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; We suspect these messages not only at the time of OSD cr=
eation. But in<br>
&gt;&gt; &gt; &gt; idle<br>
&gt;&gt; &gt; &gt; conditions also. May I know what is the impact of these =
error? Can we<br>
&gt;&gt; &gt; &gt; safely<br>
&gt;&gt; &gt; &gt; ignore this? Or is there any way/config to fix this prob=
lem<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Few occurrence for these events as follows:---<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; =3D=3D=3D=3D<br>
&gt;&gt; &gt; &gt; 2017-03-14 17:16:09.500370 7fedeba61700=C2=A0 4 rocksdb:=
 (Original Log Time<br>
&gt;&gt; &gt; &gt; 2017/03/14-17:16:09.453130) [default] Level-0 commit tab=
le #60 started<br>
&gt;&gt; &gt; &gt; 2017-03-14 17:16:09.500374 7fedeba61700=C2=A0 4 rocksdb:=
 (Original Log Time<br>
&gt;&gt; &gt; &gt; 2017/03/14-17:16:09.500273) [default] Level-0 commit tab=
le #60:<br>
&gt;&gt; &gt; &gt; memtable #1<br>
&gt;&gt; &gt; &gt; done<br>
&gt;&gt; &gt; &gt; 2017-03-14 17:16:09.500376 7fedeba61700=C2=A0 4 rocksdb:=
 (Original Log Time<br>
&gt;&gt; &gt; &gt; 2017/03/14-17:16:09.500297) EVENT_LOG_v1 {&quot;time_mic=
ros&quot;:<br>
&gt;&gt; &gt; &gt; 1489511769500289,<br>
&gt;&gt; &gt; &gt; &quot;job&quot;: 17, &quot;event&quot;: &quot;flush_fini=
shed&quot;, &quot;lsm_state&quot;: [2, 4, 6, 0, 0, 0,<br>
&gt;&gt; &gt; &gt; 0],<br>
&gt;&gt; &gt; &gt; &quot;immutable_memtables&quot;: 0}<br>
&gt;&gt; &gt; &gt; 2017-03-14 17:16:09.500382 7fedeba61700=C2=A0 4 rocksdb:=
 (Original Log Time<br>
&gt;&gt; &gt; &gt; 2017/03/14-17:16:09.500330) [default] Level summary: bas=
e level 1 max<br>
&gt;&gt; &gt; &gt; bytes<br>
&gt;&gt; &gt; &gt; base 268435456 files[2 4 6 0 0 0 0] max score 0.76<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; 2017-03-14 17:16:09.500390 7fedeba61700=C2=A0 4 rocksdb:=
 [JOB 17] Try to<br>
&gt;&gt; &gt; &gt; delete<br>
&gt;&gt; &gt; &gt; WAL files size 244090350, prev total WAL file size 24733=
1500, number<br>
&gt;&gt; &gt; &gt; of live<br>
&gt;&gt; &gt; &gt; WAL files 2.<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; 2017-03-14 17:34:11.610513 7fedf3a71700 -1<br>
&gt;&gt; &gt; &gt; bdev(/var/lib/ceph/osd/ceph-<wbr>73/block) aio_submit re=
tries 6<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; These errors come from here.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; void KernelDevice::aio_submit(<wbr>IOContext *ioc)<br>
&gt;&gt; &gt; {<br>
&gt;&gt; &gt; ...<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0int r =3D aio_queue.submit(*cur, &amp;retr=
ies);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (retries)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0derr &lt;&lt; __func__ &lt;&lt; &qu=
ot; retries &quot; &lt;&lt; retries &lt;&lt; dendl;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The submit function is this one which calls libaio&#39;s io_s=
ubmit<br>
&gt;&gt; &gt; function directly and increments retries if it receives EAGAI=
N.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; #if defined(HAVE_LIBAIO)<br>
&gt;&gt; &gt; int FS::aio_queue_t::submit(aio_t &amp;aio, int *retries)<br>
&gt;&gt; &gt; {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0// 2^16 * 125us =3D ~8 seconds, so max sleep is ~=
16 seconds<br>
&gt;&gt; &gt;=C2=A0 =C2=A0int attempts =3D 16;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0int delay =3D 125;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0iocb *piocb =3D &amp;aio.iocb;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0while (true) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0int r =3D io_submit(ctx, 1, &amp;piocb);=
=C2=A0 =C2=A0 =C2=A0&lt;-------------NOTE<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r =3D=3D -EAGAIN &amp;&amp; att=
empts-- &gt; 0) {=C2=A0 =C2=A0 =C2=A0&lt;-------------NOTE<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usleep(delay);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delay *=3D 2;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*retries)++;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0assert(r =3D=3D 1);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0}<br>
&gt;&gt; &gt;=C2=A0 =C2=A0return 0;<br>
&gt;&gt; &gt; }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; From the man page.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; IO_SUBMIT(2)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Linux Programmer&#39;s<br>
&gt;&gt; &gt; Manual=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IO_SUBMIT(2=
)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; NAME<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 io_submit - submit asynchronous I/=
O blocks for processing<br>
&gt;&gt; &gt; ...<br>
&gt;&gt; &gt; RETURN VALUE<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 On success, io_submit() returns th=
e number of iocbs submitted<br>
&gt;&gt; &gt; (which may be 0 if nr is zero).=C2=A0 For the=C2=A0 failure<b=
r>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return, see NOTES.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ERRORS<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 EAGAIN Insufficient resources are =
available to queue any iocbs.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I suspect increasing bdev_aio_max_queue_depth may help here b=
ut some<br>
&gt;&gt; &gt; of the other devs may have more/better ideas.<br>
&gt;&gt;<br>
&gt;&gt; Yes--try increasing bdev_aio_max_queue_depth.=C2=A0 It defaults to=
 32; try<br>
&gt;&gt; changing it to 128, 1024, or 4096 and see if these errors go away.=
<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ve never been able to trigger this on my test boxes, but I p=
ut in the<br>
&gt;&gt; warning to help ensure we pick a good default.<br>
&gt;&gt;<br>
&gt;&gt; What kernel version are you running?<br>
&gt;&gt;<br>
&gt;&gt; Thanks!<br>
&gt;&gt; sage<br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Cheers,<br>
Brad<br>
</font></span></blockquote></div><br></div>

--001a113e243c52bb47054ad33d04--

--===============1647310207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1647310207==--
