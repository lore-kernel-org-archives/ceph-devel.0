From: Ian Colle <ian.colle-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Swift API and object versioning
Date: Sun, 27 Apr 2014 16:32:32 -0600
Message-ID: <CALyuY=5-TYbOhsUsy4t3tznOs48WRh5cZ6JP8WhwaxxLG74BRg@mail.gmail.com>
References: <53581AC1.9080403@yipikai.org>
	<535CE147.7040408@yipikai.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1435655654=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <535CE147.7040408-3iBRyvDzmqZAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Cedric Lemarchand <cedric-3iBRyvDzmqZAfugRpC6u6w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1435655654==
Content-Type: multipart/alternative; boundary=047d7bb04dce5122dc04f80dc6aa

--047d7bb04dce5122dc04f80dc6aa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

C=C3=A9dric,

See http://tracker.ceph.com/issues/8221

The S3 and Swift APIs handle versioning very differently, so we'll
implement S3 in the Giant time frame and consider how to handle Swift once
that's completed.

Ian Colle
Director of Engineering
Inktank

On Sunday, April 27, 2014, Cedric Lemarchand <cedric-3iBRyvDzmqZAfugRpC6u6w@public.gmane.org> wrote:

> By digging a bit more I found a part of the answer :
>
> http://wiki.ceph.com/Planning/Blueprints/Firefly/rgw%3A_object_versioning
>
> Are there any future plans for swift ?
>
> Thanks
>
> --
> C=C3=A9dric
>
> Le 23/04/2014 21:55, Cedric Lemarchand a =C3=A9crit :
> > Hi Cephers,
> >
> > I would like to know if is the swift object versioning feature [1] is
> > (or will be) on the road map ?
> > Because ... it would be great ;-)
> >
> > Thx,
> >
> > C=C3=A9dric
> >
> >
> > [1]
> >
> http://docs.openstack.org/api/openstack-object-storage/1.0/content/set-ob=
ject-versions.html
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <javascript:;>
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--047d7bb04dce5122dc04f80dc6aa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

C=C3=A9dric,<div><br></div><div>See=C2=A0<a href=3D"http://tracker.ceph.com=
/issues/8221">http://tracker.ceph.com/issues/8221</a><div><br></div><div>Th=
e S3 and Swift APIs handle versioning very differently, so we&#39;ll implem=
ent S3 in the=C2=A0Giant time frame and=C2=A0consider how to handle Swift o=
nce that&#39;s completed.</div>
<div><br></div><div>Ian Colle</div><div>Director of Engineering</div><div>I=
nktank<br><br>On Sunday, April 27, 2014, Cedric Lemarchand &lt;<a href=3D"m=
ailto:cedric-3iBRyvDzmqZAfugRpC6u6w@public.gmane.org">cedric-3iBRyvDzmqZAfugRpC6u6w@public.gmane.org</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
By digging a bit more I found a part of the answer :<br>
<br>
<a href=3D"http://wiki.ceph.com/Planning/Blueprints/Firefly/rgw%3A_object_v=
ersioning" target=3D"_blank">http://wiki.ceph.com/Planning/Blueprints/Firef=
ly/rgw%3A_object_versioning</a><br>
<br>
Are there any future plans for swift ?<br>
<br>
Thanks<br>
<br>
--<br>C=C3=A9dric<br>
<br>
Le 23/04/2014 21:55, Cedric Lemarchand a =C3=A9crit :<br>
&gt; Hi Cephers,<br>
&gt;<br>
&gt; I would like to know if is the swift object versioning feature [1] is<=
br>
&gt; (or will be) on the road map ?<br>
&gt; Because ... it would be great ;-)<br>
&gt;<br>
&gt; Thx,<br>
&gt;<br>
&gt; C=C3=A9dric<br>
&gt;<br>
&gt;<br>
&gt; [1]<br>
&gt; <a href=3D"http://docs.openstack.org/api/openstack-object-storage/1.0/=
content/set-object-versions.html" target=3D"_blank">http://docs.openstack.o=
rg/api/openstack-object-storage/1.0/content/set-object-versions.html</a><br=
>

<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;ceph-use=
rs-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&#39;)">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div></div>

--047d7bb04dce5122dc04f80dc6aa--

--===============1435655654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1435655654==--
