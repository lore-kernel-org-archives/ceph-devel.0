From: Ajitha Robert <ajitharobert01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Error in ceph rbd
 mirroring(rbd::mirror::InstanceWatcher: C_NotifyInstanceRequestfinish:
 resending after timeout)
Date: Fri, 26 Jul 2019 16:40:35 +0530
Message-ID: <CAEbG6hFgvWFMgaYHRRtZdth-OkJ7ib4vWxf__b7QvGPd1rF6Qg@mail.gmail.com>
References: <CAEbG6hG7dAhg=Z9JUKcCCTOEPyXZ6cZcS=jar7SeL-5VTcqEgA@mail.gmail.com>
 <20190726093147.GA31242@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4221330536792230175=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20190726093147.GA31242-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============4221330536792230175==
Content-Type: multipart/alternative; boundary="0000000000003d890c058e9398ed"

--0000000000003d890c058e9398ed
Content-Type: text/plain; charset="UTF-8"

Thank you for the clarification.

But i was trying with openstack-cinder.. when i load some data into the
volume around 50gb, the image sync will stop by 5 % or something within
15%...  What could be the reason?






On Fri, Jul 26, 2019 at 3:01 PM Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> On Fri, Jul 26, 2019 at 12:31:59PM +0530, Ajitha Robert wrote:
> >  I have a rbd mirroring setup with primary and secondary clusters as
> peers
> > and I have a pool enabled image mode.., In this i created a rbd image ,
> > enabled with journaling.
> > But whenever i enable mirroring on the image,  I m getting error in
> > rbdmirror.log and  osd.log.
> > I have increased the timeouts.. nothing worked and couldnt traceout the
> > error
> > please guide me to solve this error.
> >
> > *Logs*
> > http://paste.openstack.org/show/754766/
>
> What do you mean by "nothing worked"? According to mirroring status
> the image is mirroring: it is in "up+stopped" state on the primary as
> expected, and in "up+replaying" state on the secondary with 0 entries
> behind master.
>
> The "failed to get omap key" error in the osd log is harmless, and
> just a week ago the fix was merged upstream not to display it.
>
> The cause of "InstanceWatcher: ... resending after timeout" error in
> the rbd-mirror log is not clear but if it is not repeating it is
> harmless too.
>
> I see you were trying to map the image with krbd. It is expected to
> fail as the krbd does not support "journaling" feature, which is
> necessary for mirroring. You can access those images only with librbd
> (e.g. mapping with rbd-nbd driver or via qemu).
>
> --
> Mykola Golub
>


-- 


*Regards,Ajitha R*

--0000000000003d890c058e9398ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Thank you for the clarification. <br><br></div>B=
ut i was trying with openstack-cinder.. when i load some data into the volu=
me around 50gb, the image sync will stop by 5 % or something within 15%...=
=C2=A0 What could be the reason? <br><br></div><div><br></div><div><br></di=
v><div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 26, 2019 at 3:01 PM Mykola Golu=
b &lt;<a href=3D"mailto:to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Fri, Jul 26, 2019 at 12:31:59PM +0530, Ajitha Robert wrote:<br>
&gt;=C2=A0 I have a rbd mirroring setup with primary and secondary clusters=
 as peers<br>
&gt; and I have a pool enabled image mode.., In this i created a rbd image =
,<br>
&gt; enabled with journaling.<br>
&gt; But whenever i enable mirroring on the image,=C2=A0 I m getting error =
in<br>
&gt; rbdmirror.log and=C2=A0 osd.log.<br>
&gt; I have increased the timeouts.. nothing worked and couldnt traceout th=
e<br>
&gt; error<br>
&gt; please guide me to solve this error.<br>
&gt; <br>
&gt; *Logs*<br>
&gt; <a href=3D"http://paste.openstack.org/show/754766/" rel=3D"noreferrer"=
 target=3D"_blank">http://paste.openstack.org/show/754766/</a><br>
<br>
What do you mean by &quot;nothing worked&quot;? According to mirroring stat=
us<br>
the image is mirroring: it is in &quot;up+stopped&quot; state on the primar=
y as<br>
expected, and in &quot;up+replaying&quot; state on the secondary with 0 ent=
ries<br>
behind master.<br>
<br>
The &quot;failed to get omap key&quot; error in the osd log is harmless, an=
d<br>
just a week ago the fix was merged upstream not to display it.<br>
<br>
The cause of &quot;InstanceWatcher: ... resending after timeout&quot; error=
 in<br>
the rbd-mirror log is not clear but if it is not repeating it is<br>
harmless too.<br>
<br>
I see you were trying to map the image with krbd. It is expected to<br>
fail as the krbd does not support &quot;journaling&quot; feature, which is<=
br>
necessary for mirroring. You can access those images only with librbd<br>
(e.g. mapping with rbd-nbd driver or via qemu).<br>
<br>
-- <br>
Mykola Golub<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><b><i style=3D"background-color:rgb(255,25=
5,255);color:rgb(102,0,0)">Regards,<span></span><br>Ajitha R</i><br></b></d=
iv></div>

--0000000000003d890c058e9398ed--

--===============4221330536792230175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4221330536792230175==--
