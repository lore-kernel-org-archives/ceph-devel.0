From: Tom Christensen <pavera-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Kernel RBD hang on OSD Failure
Date: Tue, 8 Dec 2015 02:57:43 -0700
Message-ID: <CAAsTndwa95Vxeri=DOckQEiSfMQ04VBKvVbzdVhZw0dke1WgEQ@mail.gmail.com>
References: <CAKeiORSsNQ-LOWQ0heLZQkekN_mwYQ81XSXfdJe-R1eP1Osz1w@mail.gmail.com>
	<CA+z5DswarP0KHomWJocCxT29W1-kyzV2RhDOg7tc-0_DV0D1Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0595431695=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+z5DswarP0KHomWJocCxT29W1-kyzV2RhDOg7tc-0_DV0D1Kg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0595431695==
Content-Type: multipart/alternative; boundary=001a11c3d4ca4275290526600198

--001a11c3d4ca4275290526600198
Content-Type: text/plain; charset=UTF-8

We aren't running NFS, but regularly use the kernel driver to map RBDs and
mount filesystems in same.  We see very similar behavior across nearly all
kernel versions we've tried.  In my experience only very few versions of
the kernel driver survive any sort of crush map change/update while
something is mapped.  In fact in the last 2 years I think I've only seen
this work on 1 kernel version unfortunately its badly out of date and we
can't run it in our environment anymore, I think it was a 3.0 kernel
version running on ubuntu 12.04.  We have just recently started trying to
find a kernel that will survive OSD outages or changes to the cluster.
We're on ubuntu 14.04, and have tried 3.16, 3.19.0-25, 4.3, and 4.2 without
success in the last week.  We only map 1-3 RBDs per client machine at a
time but we regularly will get processes stuck in D state which are
accessing the filesystem inside the RBD and will have to hard reboot the
RBD client machine.  This is always associated with a cluster change in
some way, reweighting OSDs, rebooting an OSD host, restarting an individual
OSD, adding OSDs, and removing OSDs all cause the kernel client to hang.
If no change is made to the cluster, the kernel client will be happy for
weeks.

On Mon, Dec 7, 2015 at 2:55 PM, Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hi Matt,
>
> (CC'ing in ceph-users too - similar reports there:
> http://www.spinics.net/lists/ceph-users/msg23037.html)
>
> We've seen something similar for KVM [lib]RBD clients acting as NFS
> gateways within our OpenStack cloud, the NFS services were locking up
> and causing client timeouts whenever we started doing Ceph
> maintenance. We eventually realised we'd somehow set the pool min_size
> == size, so any single OSD outage was blocking client IO - *oops*.
> Your issue sounds like something different, but NFS does seem to be
> very touchy and lacking any graceful recovery from issues with the
> underlying FS.
>
>
> On 8 December 2015 at 07:56, Matt Conner <matt.conner-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org>
> wrote:
> > Hi,
> >
> > We have a Ceph cluster in which we have been having issues with RBD
> > clients hanging when an OSD failure occurs. We are using a NAS gateway
> > server which maps RBD images to filesystems and serves the filesystems
> > out via NFS. The gateway server has close to 180 NFS clients and
> > almost every time even 1 OSD goes down during heavy load, the NFS
> > exports lock up and the clients are unable to access the NAS share via
> > NFS. When the OSD fails, Ceph recovers without issue, but the gateway
> > kernel RBD module appears to get stuck waiting on the now failed OSD.
> > Note that this works correctly when under lighter loads.
> >
> > From what we have been able to determine, the NFS server daemon hangs
> > waiting for I/O from the OSD that went out and never recovers.
> > Similarly, attempting to access files from the exported FS locally on
> > the gateway server will result in a similar hang. We also noticed that
> > Ceph health details will continue to report blocked I/O on the now
> > down OSD until either the OSD is recovered or the gateway server is
> > rebooted.  Based on a few kernel logs from NFS and PVS, we were able
> > to trace the problem to the RBD kernel module.
> >
> > Unfortunately, the only way we have been able to recover our gateway
> > is by hard rebooting the server.
> >
> > Has anyone else encountered this issue and/or have a possible solution?
> > Are there suggestions for getting more detailed debugging information
> > from the RBD kernel module?
> >
> >
> > Few notes on our setup:
> > We are using Kernel RBD on a gateway server that exports filesystems via
> NFS
> > The exported filesystems are XFS on LVMs which are each composed of 16
> > striped images (NFS->LVM->XFS->PVS->RBD)
> > There are currently 176 mapped RBD images on the server (11
> > filesystems, 16 mapped RBD images per FS)
> > Gateway Kernel: 3.18.6
> > Ceph version: 0.80.9
> > Note - We've tried using different kernels all the way up to 4.3.0 but
> > the problem persists.
> >
> > Thanks,
> > Matt Conner
> > Keeper Technology
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Cheers,
> ~Blairo
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a11c3d4ca4275290526600198
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">We aren&#39;t running NFS, but regularly use the kernel dr=
iver to map RBDs and mount filesystems in same.=C2=A0 We see very similar b=
ehavior across nearly all kernel versions we&#39;ve tried.=C2=A0 In my expe=
rience only very few versions of the kernel driver survive any sort of crus=
h map change/update while something is mapped.=C2=A0 In fact in the last 2 =
years I think I&#39;ve only seen this work on 1 kernel version unfortunatel=
y its badly out of date and we can&#39;t run it in our environment anymore,=
 I think it was a 3.0 kernel version running on ubuntu 12.04.=C2=A0 We have=
 just recently started trying to find a kernel that will survive OSD outage=
s or changes to the cluster.=C2=A0 We&#39;re on ubuntu 14.04, and have trie=
d 3.16, 3.19.0-25, 4.3, and 4.2 without success in the last week.=C2=A0 We =
only map 1-3 RBDs per client machine at a time but we regularly will get pr=
ocesses stuck in D state which are accessing the filesystem inside the RBD =
and will have to hard reboot the RBD client machine.=C2=A0 This is always a=
ssociated with a cluster change in some way, reweighting OSDs, rebooting an=
 OSD host, restarting an individual OSD, adding OSDs, and removing OSDs all=
 cause the kernel client to hang.=C2=A0 If no change is made to the cluster=
, the kernel client will be happy for weeks.</div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">On Mon, Dec 7, 2015 at 2:55 PM, Blair Beth=
waite <span dir=3D"ltr">&lt;<a href=3D"mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" ta=
rget=3D"_blank">blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Hi Matt,<br>
<br>
(CC&#39;ing in ceph-users too - similar reports there:<br>
<a href=3D"http://www.spinics.net/lists/ceph-users/msg23037.html" rel=3D"no=
referrer" target=3D"_blank">http://www.spinics.net/lists/ceph-users/msg2303=
7.html</a>)<br>
<br>
We&#39;ve seen something similar for KVM [lib]RBD clients acting as NFS<br>
gateways within our OpenStack cloud, the NFS services were locking up<br>
and causing client timeouts whenever we started doing Ceph<br>
maintenance. We eventually realised we&#39;d somehow set the pool min_size<=
br>
=3D=3D size, so any single OSD outage was blocking client IO - *oops*.<br>
Your issue sounds like something different, but NFS does seem to be<br>
very touchy and lacking any graceful recovery from issues with the<br>
underlying FS.<br>
<br>
<br>
On 8 December 2015 at 07:56, Matt Conner &lt;<a href=3D"mailto:matt.conner@=
keepertech.com">matt.conner-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org</a>&gt; wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; We have a Ceph cluster in which we have been having issues with RBD<br=
>
&gt; clients hanging when an OSD failure occurs. We are using a NAS gateway=
<br>
&gt; server which maps RBD images to filesystems and serves the filesystems=
<br>
&gt; out via NFS. The gateway server has close to 180 NFS clients and<br>
&gt; almost every time even 1 OSD goes down during heavy load, the NFS<br>
&gt; exports lock up and the clients are unable to access the NAS share via=
<br>
&gt; NFS. When the OSD fails, Ceph recovers without issue, but the gateway<=
br>
&gt; kernel RBD module appears to get stuck waiting on the now failed OSD.<=
br>
&gt; Note that this works correctly when under lighter loads.<br>
&gt;<br>
&gt; From what we have been able to determine, the NFS server daemon hangs<=
br>
&gt; waiting for I/O from the OSD that went out and never recovers.<br>
&gt; Similarly, attempting to access files from the exported FS locally on<=
br>
&gt; the gateway server will result in a similar hang. We also noticed that=
<br>
&gt; Ceph health details will continue to report blocked I/O on the now<br>
&gt; down OSD until either the OSD is recovered or the gateway server is<br=
>
&gt; rebooted.=C2=A0 Based on a few kernel logs from NFS and PVS, we were a=
ble<br>
&gt; to trace the problem to the RBD kernel module.<br>
&gt;<br>
&gt; Unfortunately, the only way we have been able to recover our gateway<b=
r>
&gt; is by hard rebooting the server.<br>
&gt;<br>
&gt; Has anyone else encountered this issue and/or have a possible solution=
?<br>
&gt; Are there suggestions for getting more detailed debugging information<=
br>
&gt; from the RBD kernel module?<br>
&gt;<br>
&gt;<br>
&gt; Few notes on our setup:<br>
&gt; We are using Kernel RBD on a gateway server that exports filesystems v=
ia NFS<br>
&gt; The exported filesystems are XFS on LVMs which are each composed of 16=
<br>
&gt; striped images (NFS-&gt;LVM-&gt;XFS-&gt;PVS-&gt;RBD)<br>
&gt; There are currently 176 mapped RBD images on the server (11<br>
&gt; filesystems, 16 mapped RBD images per FS)<br>
&gt; Gateway Kernel: 3.18.6<br>
&gt; Ceph version: 0.80.9<br>
&gt; Note - We&#39;ve tried using different kernels all the way up to 4.3.0=
 but<br>
&gt; the problem persists.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Matt Conner<br>
&gt; Keeper Technology<br>
<span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/m=
ajordomo-info.html</a><br>
<br>
<br>
<br>
--<br>
Cheers,<br>
~Blairo<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</font></span></blockquote></div><br></div>

--001a11c3d4ca4275290526600198--

--===============0595431695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0595431695==--
