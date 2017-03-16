From: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Log message -->
 "bdev(/var/lib/ceph/osd/ceph-x/block) aio_submit retries"
Date: Thu, 16 Mar 2017 11:45:58 +0530
Message-ID: <CALWuvY8f1j9_ccbzrchfdhZ66RYDTqRuL2A2qy9XFHTARitPBQ@mail.gmail.com>
References: <CALWuvY8dEyWiUxg9VDaMkfQGwPSsWG0adrtzvGa9k7fhNmdsGw@mail.gmail.com>
	<CALWuvY9wY08n2AE9HMfZgZCU9ZEtk2XOwa353_stxT-7x7L30A@mail.gmail.com>
	<CALWuvY_9uWE_DKg5UaYZrc_GchfMK1EpX1rkWrJEuAV+Y3+Uww@mail.gmail.com>
	<CAF-wwdFvgzkYMnkheomsWMikZoZU+THyrxzovORx3bCDfPZ7Ng@mail.gmail.com>
	<alpine.DEB.2.11.1703151422110.10776@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0139952431=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1703151422110.10776-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0139952431==
Content-Type: multipart/alternative; boundary=f40304379b7c9bd73a054ad2fea8

--f40304379b7c9bd73a054ad2fea8
Content-Type: text/plain; charset=UTF-8

Hello,

We are running latest kernel - 3.10.0-514.2.2.el7.x86_64 { RHEL 7.3 }

Sure I will try to alter this directive - bdev_aio_max_queue_depth and will
share our results.

Could you please explain how this calculation happens?

Thanks


On Wed, Mar 15, 2017 at 7:54 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:

> On Wed, 15 Mar 2017, Brad Hubbard wrote:
> > +ceph-devel
> >
> > On Wed, Mar 15, 2017 at 5:25 PM, nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > > Hello,
> > >
> > > We suspect these messages not only at the time of OSD creation. But in
> idle
> > > conditions also. May I know what is the impact of these error? Can we
> safely
> > > ignore this? Or is there any way/config to fix this problem
> > >
> > > Few occurrence for these events as follows:---
> > >
> > > ====
> > > 2017-03-14 17:16:09.500370 7fedeba61700  4 rocksdb: (Original Log Time
> > > 2017/03/14-17:16:09.453130) [default] Level-0 commit table #60 started
> > > 2017-03-14 17:16:09.500374 7fedeba61700  4 rocksdb: (Original Log Time
> > > 2017/03/14-17:16:09.500273) [default] Level-0 commit table #60:
> memtable #1
> > > done
> > > 2017-03-14 17:16:09.500376 7fedeba61700  4 rocksdb: (Original Log Time
> > > 2017/03/14-17:16:09.500297) EVENT_LOG_v1 {"time_micros":
> 1489511769500289,
> > > "job": 17, "event": "flush_finished", "lsm_state": [2, 4, 6, 0, 0, 0,
> 0],
> > > "immutable_memtables": 0}
> > > 2017-03-14 17:16:09.500382 7fedeba61700  4 rocksdb: (Original Log Time
> > > 2017/03/14-17:16:09.500330) [default] Level summary: base level 1 max
> bytes
> > > base 268435456 files[2 4 6 0 0 0 0] max score 0.76
> > >
> > > 2017-03-14 17:16:09.500390 7fedeba61700  4 rocksdb: [JOB 17] Try to
> delete
> > > WAL files size 244090350, prev total WAL file size 247331500, number
> of live
> > > WAL files 2.
> > >
> > > 2017-03-14 17:34:11.610513 7fedf3a71700 -1
> > > bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 6
> >
> > These errors come from here.
> >
> > void KernelDevice::aio_submit(IOContext *ioc)
> > {
> > ...
> >     int r = aio_queue.submit(*cur, &retries);
> >     if (retries)
> >       derr << __func__ << " retries " << retries << dendl;
> >
> > The submit function is this one which calls libaio's io_submit
> > function directly and increments retries if it receives EAGAIN.
> >
> > #if defined(HAVE_LIBAIO)
> > int FS::aio_queue_t::submit(aio_t &aio, int *retries)
> > {
> >   // 2^16 * 125us = ~8 seconds, so max sleep is ~16 seconds
> >   int attempts = 16;
> >   int delay = 125;
> >   iocb *piocb = &aio.iocb;
> >   while (true) {
> >     int r = io_submit(ctx, 1, &piocb);     <-------------NOTE
> >     if (r < 0) {
> >       if (r == -EAGAIN && attempts-- > 0) {     <-------------NOTE
> >         usleep(delay);
> >         delay *= 2;
> >         (*retries)++;
> >         continue;
> >       }
> >       return r;
> >     }
> >     assert(r == 1);
> >     break;
> >   }
> >   return 0;
> > }
> >
> >
> > From the man page.
> >
> > IO_SUBMIT(2)                                   Linux Programmer's
> > Manual                                  IO_SUBMIT(2)
> >
> > NAME
> >        io_submit - submit asynchronous I/O blocks for processing
> > ...
> > RETURN VALUE
> >        On success, io_submit() returns the number of iocbs submitted
> > (which may be 0 if nr is zero).  For the  failure
> >        return, see NOTES.
> >
> > ERRORS
> >        EAGAIN Insufficient resources are available to queue any iocbs.
> >
> > I suspect increasing bdev_aio_max_queue_depth may help here but some
> > of the other devs may have more/better ideas.
>
> Yes--try increasing bdev_aio_max_queue_depth.  It defaults to 32; try
> changing it to 128, 1024, or 4096 and see if these errors go away.
>
> I've never been able to trigger this on my test boxes, but I put in the
> warning to help ensure we pick a good default.
>
> What kernel version are you running?
>
> Thanks!
> sage
>

--f40304379b7c9bd73a054ad2fea8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>We are running latest kernel -=
=C2=A03.10.0-514.2.2.el7.x86_64 { RHEL 7.3 }=C2=A0</div><div><br></div><div=
>Sure I will try to alter this directive -=C2=A0<span style=3D"font-size:12=
.8px">bdev_aio_max_queue_depth and will share our results.</span></div><div=
><span style=3D"font-size:12.8px"><br></span></div><div><span style=3D"font=
-size:12.8px">Could you please explain how this calculation happens?=C2=A0<=
/span></div><div><span style=3D"font-size:12.8px"><br></span></div><div><sp=
an style=3D"font-size:12.8px">Thanks</span></div><div><br></div></div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Mar 15, 2017 a=
t 7:54 PM, Sage Weil <span dir=3D"ltr">&lt;<a href=3D"mailto:sage@newdream.=
net" target=3D"_blank">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Wed, 15 Ma=
r 2017, Brad Hubbard wrote:<br>
&gt; +ceph-devel<br>
&gt;<br>
&gt; On Wed, Mar 15, 2017 at 5:25 PM, nokia ceph &lt;<a href=3D"mailto:noki=
acephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; Hello,<br>
&gt; &gt;<br>
&gt; &gt; We suspect these messages not only at the time of OSD creation. B=
ut in idle<br>
&gt; &gt; conditions also. May I know what is the impact of these error? Ca=
n we safely<br>
&gt; &gt; ignore this? Or is there any way/config to fix this problem<br>
&gt; &gt;<br>
&gt; &gt; Few occurrence for these events as follows:---<br>
&gt; &gt;<br>
&gt; &gt; =3D=3D=3D=3D<br>
&gt; &gt; 2017-03-14 17:16:09.500370 7fedeba61700=C2=A0 4 rocksdb: (Origina=
l Log Time<br>
&gt; &gt; 2017/03/14-17:16:09.453130) [default] Level-0 commit table #60 st=
arted<br>
&gt; &gt; 2017-03-14 17:16:09.500374 7fedeba61700=C2=A0 4 rocksdb: (Origina=
l Log Time<br>
&gt; &gt; 2017/03/14-17:16:09.500273) [default] Level-0 commit table #60: m=
emtable #1<br>
&gt; &gt; done<br>
&gt; &gt; 2017-03-14 17:16:09.500376 7fedeba61700=C2=A0 4 rocksdb: (Origina=
l Log Time<br>
&gt; &gt; 2017/03/14-17:16:09.500297) EVENT_LOG_v1 {&quot;time_micros&quot;=
: 1489511769500289,<br>
&gt; &gt; &quot;job&quot;: 17, &quot;event&quot;: &quot;flush_finished&quot=
;, &quot;lsm_state&quot;: [2, 4, 6, 0, 0, 0, 0],<br>
&gt; &gt; &quot;immutable_memtables&quot;: 0}<br>
&gt; &gt; 2017-03-14 17:16:09.500382 7fedeba61700=C2=A0 4 rocksdb: (Origina=
l Log Time<br>
&gt; &gt; 2017/03/14-17:16:09.500330) [default] Level summary: base level 1=
 max bytes<br>
&gt; &gt; base 268435456 files[2 4 6 0 0 0 0] max score 0.76<br>
&gt; &gt;<br>
&gt; &gt; 2017-03-14 17:16:09.500390 7fedeba61700=C2=A0 4 rocksdb: [JOB 17]=
 Try to delete<br>
&gt; &gt; WAL files size 244090350, prev total WAL file size 247331500, num=
ber of live<br>
&gt; &gt; WAL files 2.<br>
&gt; &gt;<br>
&gt; &gt; 2017-03-14 17:34:11.610513 7fedf3a71700 -1<br>
&gt; &gt; bdev(/var/lib/ceph/osd/ceph-<wbr>73/block) aio_submit retries 6<b=
r>
&gt;<br>
&gt; These errors come from here.<br>
&gt;<br>
&gt; void KernelDevice::aio_submit(<wbr>IOContext *ioc)<br>
&gt; {<br>
&gt; ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0int r =3D aio_queue.submit(*cur, &amp;retries);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (retries)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0derr &lt;&lt; __func__ &lt;&lt; &quot; retri=
es &quot; &lt;&lt; retries &lt;&lt; dendl;<br>
&gt;<br>
&gt; The submit function is this one which calls libaio&#39;s io_submit<br>
&gt; function directly and increments retries if it receives EAGAIN.<br>
&gt;<br>
&gt; #if defined(HAVE_LIBAIO)<br>
&gt; int FS::aio_queue_t::submit(aio_t &amp;aio, int *retries)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0// 2^16 * 125us =3D ~8 seconds, so max sleep is ~16 second=
s<br>
&gt;=C2=A0 =C2=A0int attempts =3D 16;<br>
&gt;=C2=A0 =C2=A0int delay =3D 125;<br>
&gt;=C2=A0 =C2=A0iocb *piocb =3D &amp;aio.iocb;<br>
&gt;=C2=A0 =C2=A0while (true) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0int r =3D io_submit(ctx, 1, &amp;piocb);=C2=A0 =C2=
=A0 =C2=A0&lt;-------------NOTE<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r =3D=3D -EAGAIN &amp;&amp; attempts-- &=
gt; 0) {=C2=A0 =C2=A0 =C2=A0&lt;-------------NOTE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usleep(delay);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delay *=3D 2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*retries)++;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0assert(r =3D=3D 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0return 0;<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt; From the man page.<br>
&gt;<br>
&gt; IO_SUBMIT(2)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux =
Programmer&#39;s<br>
&gt; Manual=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IO_SUBMIT(2)<br>
&gt;<br>
&gt; NAME<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 io_submit - submit asynchronous I/O blocks =
for processing<br>
&gt; ...<br>
&gt; RETURN VALUE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 On success, io_submit() returns the number =
of iocbs submitted<br>
&gt; (which may be 0 if nr is zero).=C2=A0 For the=C2=A0 failure<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return, see NOTES.<br>
&gt;<br>
&gt; ERRORS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 EAGAIN Insufficient resources are available=
 to queue any iocbs.<br>
&gt;<br>
&gt; I suspect increasing bdev_aio_max_queue_depth may help here but some<b=
r>
&gt; of the other devs may have more/better ideas.<br>
<br>
</div></div>Yes--try increasing bdev_aio_max_queue_depth.=C2=A0 It defaults=
 to 32; try<br>
changing it to 128, 1024, or 4096 and see if these errors go away.<br>
<br>
I&#39;ve never been able to trigger this on my test boxes, but I put in the=
<br>
warning to help ensure we pick a good default.<br>
<br>
What kernel version are you running?<br>
<br>
Thanks!<br>
<span class=3D"HOEnZb"><font color=3D"#888888">sage<br>
</font></span></blockquote></div><br></div>

--f40304379b7c9bd73a054ad2fea8--

--===============0139952431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0139952431==--
