From: Hunter Nield <hunter-iEdvRClfnV0@public.gmane.org>
Subject: Re: announcing ceph-helm (ceph on kubernetes
 orchestration)
Date: Mon, 06 Nov 2017 09:25:57 +0000
Message-ID: <CAGRK8cwTs34q3D06xp_L2quE8zVGw9kFdYT2A9Ceb5X35ztZhw@mail.gmail.com>
References: <alpine.DEB.2.11.1710251848140.22592@piezo.us.to>
 <CAOugy1vGkPDf7w_+ZMKpA7R2r-MV71=3KnaQ2V6WTaLg5fmTyA@mail.gmail.com>
 <alpine.DEB.2.11.1710251928080.22592@piezo.us.to>
 <FD899CA1-D199-4E3F-AE28-292B0F9B062B@tabbara.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3999883825490751235=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <FD899CA1-D199-4E3F-AE28-292B0F9B062B-7zw3Wi+BkiFBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Bassam Tabbara <bassam-7zw3Wi+BkiFBDgjK7y7TUQ@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============3999883825490751235==
Content-Type: multipart/alternative; boundary="001a113a15e85f9c8e055d4d0b9a"

--001a113a15e85f9c8e055d4d0b9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99m not sure how I missed this earlier in the lists but having done=
 a lot
of work on Ceph helm charts, this is of definite interest to us. We=E2=80=
=99ve been
running various states of Ceph in Docker and Kubernetes (in production
environments) for over a year now.

There is a lot of overlap between the Rook and the Ceph related projects
(ceph-docker/ceph-container and now ceph-helm) and I agree with Bassam
about finding ways of bringing things closer. Having felt (and contributed
to) the pain of the complex ceph-container entrypoint scripts, the
importance of the simpler initial configuration and user experience with
Rook and it=E2=80=99s Operator approach can=E2=80=99t be understated. There=
 is a definite
need for a vanilla project to run Ceph on Kubernetes but the most useful
part lies in encapsulating the day-to-day operation of a Ceph cluster that
builds on the strengths of Kubernetes (CRDs, Operators, dynamic scaling,
etc).

Looking forward to seeing where this goes (and joining the discussion)

Hunter

On Sat, Nov 4, 2017 at 5:13 AM Bassam Tabbara <bassam-7zw3Wi+BkiFBDgjK7y7TUQ@public.gmane.org> wrote:

> (sorry for the late response, just catching up on ceph-users)
>
> > Probably the main difference is that ceph-helm aims to run Ceph as part
> of
> > the container infrastructure.  The containers are privileged so they ca=
n
> > interact with hardware where needed (e.g., lvm for dm-crypt) and the
> > cluster runs on the host network.  We use kubernetes some orchestration=
:
> > kube is a bit of a headache for mons and osds but will be very helpful
> for
> > scheduling everything else: mgrs, rgw, rgw-nfs, iscsi, mds, ganesha,
> > samba, rbd-mirror, etc.
> >
> > Rook, as I understand it at least (the rook folks on the list can speak
> up
> > here), aims to run Ceph more as a tenant of kubernetes.  The cluster ru=
ns
> > in the container network space, and the aim is to be able to deploy cep=
h
> > more like an unprivileged application on e.g., a public cloud providing
> > kubernetes as the cloud api.
>
> Yes Rook=E2=80=99s goal is to run wherever Kubernetes runs without making=
 changes
> at the host level. Eventually we plan to remove the need to run some of t=
he
> containers privileged, and automatically work with different kernel
> versions and heterogeneous environments. It's fair to think of Rook as an
> application of Kubernetes. As a result you could run it on AWS, Google,
> bare-metal or wherever.
>
> > The other difference is around rook-operator, which is the thing that
> lets
> > you declare what you want (ceph clusters, pools, etc) via kubectl and
> goes
> > off and creates the cluster(s) and tells it/them what to do.  It makes
> the
> > storage look like it is tightly integrated with and part of kubernetes
> but
> > means that kubectl becomes the interface for ceph cluster management.
>
> Rook extends Kubernetes to understand storage concepts like Pool, Object
> Store, FileSystems. Our goal is for storage to be integrated deeply into
> Kuberentes. That said, you can easily launch the Rook toolbox and use the
> ceph tools at any point. I don=E2=80=99t think the goal is for Rook to re=
place the
> ceph tools, but instead to offer a Kuberentes-native alternative to them.
>
> > Some of that seems useful to me (still developing opinions here!) and
> > perhaps isn't so different than the declarations in your chart's
> > values.yaml but I'm unsure about the wisdom of going too far down the
> road
> > of administering ceph via yaml.
> >
> > Anyway, I'm still pretty new to kubernetes-land and very interested in
> > hearing what people are interested in or looking for here!
>
> Would be great to find ways to get these two projects closer.
>
> Bassam
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a113a15e85f9c8e055d4d0b9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div>I=E2=80=99m not sure how I missed this earl=
ier in the lists but having done a lot of work on Ceph helm charts, this is=
 of definite interest to us. We=E2=80=99ve been running various states of C=
eph in Docker and Kubernetes (in production environments) for over a year n=
ow.<div><br></div><div>There is a lot of overlap between the Rook and the C=
eph related projects (ceph-docker/ceph-container and now ceph-helm) and I a=
gree with Bassam about finding ways of bringing things closer. Having felt =
(and contributed to) the pain of the complex ceph-container entrypoint scri=
pts, the importance of the simpler initial configuration and user experienc=
e with Rook and it=E2=80=99s Operator approach can=E2=80=99t be understated=
. There is a definite need for a vanilla project to run Ceph on Kubernetes =
but the most useful part lies in encapsulating the day-to-day operation of =
a Ceph cluster that builds on the strengths of Kubernetes (CRDs, Operators,=
 dynamic scaling, etc).</div><div><br></div><div>Looking forward to seeing =
where this goes (and joining the discussion)</div><div><br></div><div>Hunte=
r</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sat, Nov 4,=
 2017 at 5:13 AM Bassam Tabbara &lt;<a href=3D"mailto:bassam-7zw3Wi+BkiFBDgjK7y7TUQ@public.gmane.org">b=
assam-7zw3Wi+BkiFBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">(s=
orry for the late response, just catching up on ceph-users)<br>
<br>
&gt; Probably the main difference is that ceph-helm aims to run Ceph as par=
t of<br>
&gt; the container infrastructure.=C2=A0 The containers are privileged so t=
hey can<br>
&gt; interact with hardware where needed (e.g., lvm for dm-crypt) and the<b=
r>
&gt; cluster runs on the host network.=C2=A0 We use kubernetes some orchest=
ration:<br>
&gt; kube is a bit of a headache for mons and osds but will be very helpful=
 for<br>
&gt; scheduling everything else: mgrs, rgw, rgw-nfs, iscsi, mds, ganesha,<b=
r>
&gt; samba, rbd-mirror, etc.<br>
&gt;<br>
&gt; Rook, as I understand it at least (the rook folks on the list can spea=
k up<br>
&gt; here), aims to run Ceph more as a tenant of kubernetes.=C2=A0 The clus=
ter runs<br>
&gt; in the container network space, and the aim is to be able to deploy ce=
ph<br>
&gt; more like an unprivileged application on e.g., a public cloud providin=
g<br>
&gt; kubernetes as the cloud api.<br>
<br>
Yes Rook=E2=80=99s goal is to run wherever Kubernetes runs without making c=
hanges at the host level. Eventually we plan to remove the need to run some=
 of the containers privileged, and automatically work with different kernel=
 versions and heterogeneous environments. It&#39;s fair to think of Rook as=
 an application of Kubernetes. As a result you could run it on AWS, Google,=
 bare-metal or wherever.<br>
<br>
&gt; The other difference is around rook-operator, which is the thing that =
lets<br>
&gt; you declare what you want (ceph clusters, pools, etc) via kubectl and =
goes<br>
&gt; off and creates the cluster(s) and tells it/them what to do.=C2=A0 It =
makes the<br>
&gt; storage look like it is tightly integrated with and part of kubernetes=
 but<br>
&gt; means that kubectl becomes the interface for ceph cluster management.<=
br>
<br>
Rook extends Kubernetes to understand storage concepts like Pool, Object St=
ore, FileSystems. Our goal is for storage to be integrated deeply into Kube=
rentes. That said, you can easily launch the Rook toolbox and use the ceph =
tools at any point. I don=E2=80=99t think the goal is for Rook to replace t=
he ceph tools, but instead to offer a Kuberentes-native alternative to them=
.<br>
<br>
&gt; Some of that seems useful to me (still developing opinions here!) and<=
br>
&gt; perhaps isn&#39;t so different than the declarations in your chart&#39=
;s<br>
&gt; values.yaml but I&#39;m unsure about the wisdom of going too far down =
the road<br>
&gt; of administering ceph via yaml.<br>
&gt;<br>
&gt; Anyway, I&#39;m still pretty new to kubernetes-land and very intereste=
d in<br>
&gt; hearing what people are interested in or looking for here!<br>
<br>
Would be great to find ways to get these two projects closer.<br>
<br>
Bassam<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" targe=
t=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/majord=
omo-info.html</a><br>
</blockquote></div>

--001a113a15e85f9c8e055d4d0b9a--

--===============3999883825490751235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3999883825490751235==--
