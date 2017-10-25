From: Hans van den Bogert <hansbogert-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: announcing ceph-helm (ceph on kubernetes
 orchestration)
Date: Wed, 25 Oct 2017 21:26:32 +0200
Message-ID: <CAOugy1vGkPDf7w_+ZMKpA7R2r-MV71=3KnaQ2V6WTaLg5fmTyA@mail.gmail.com>
References: <alpine.DEB.2.11.1710251848140.22592@piezo.us.to>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2128437353619236527=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1710251848140.22592-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============2128437353619236527==
Content-Type: multipart/alternative; boundary="94eb2c14c7e68bb0be055c6408d2"

--94eb2c14c7e68bb0be055c6408d2
Content-Type: text/plain; charset="UTF-8"

Very interesting.
I've been toying around with Rook.io [1]. Did you know of this project, and
if so can you tell if ceph-helm and Rook.io have similar goals?

Regards,

Hans

[1] https://rook.io/

On 25 Oct 2017 21:09, "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> There is a new repo under the ceph org, ceph-helm, which includes helm
> charts for deploying ceph on kubernetes.  The code is based on the ceph
> charts from openstack-helm, but we've moved them into their own upstream
> repo here so that they can be developed more quickly and independently
> from the openstack-helm work.  The code has already evolved a fair bit,
> mostly to support luminous and fix a range of issues:
>
>         https://github.com/ceph/ceph-helm/tree/master/ceph/ceph
>
> The repo is a fork of the upstream kubernetes/charts.git repo with an eye
> toward eventually merging the chart upstream into that repo.  How useful
> that would be in practice is not entirely clear to me since the version in
> the ceph-helm repo will presumably always be more up to date and users
> have to point to *some* source for the chart either way.  Also the current
> structure of the files in the repo is carried over from openstack-helm,
> which uses the helm-toolkit stuff and isn't in the correct form for the
> upstream charts.git.  Suggestions/input here on what direction makes more
> sense would be welcome!
>
> There are also some docs on getting a ceph cluster up in kubernetes using
> these charts at
>
>         https://github.com/ceph/ceph/pull/18520
>         http://docs.ceph.com/ceph-prs/18520/start/kube-helm/
>
> that should be merged shortly.  Not terribly detailed and we're not
> covering much on the operations side yet, but that all is coming.
>
> A very rough sketch of the direction currently being considered from
> running ceph in kubernetes is here:
>
>         http://pad.ceph.com/p/containers
>
> and there is a trello board here
>
>         https://trello.com/b/kcXOllJp/kubehelm
>
> All of this builds on the container image that Sebastien has been working
> on for some time, that has recently been renamed from ceph-docker ->
> ceph-container
>
>         https://github.com/ceph/ceph-container
>
> Dan is working on getting an image registry up at registry.ceph.com so
> that we can publish test build images, releases, or both.
>
> We also have a daily sync up call for the folks who are actively working
> on this.
>
> That's all for now!  :)
> sage
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--94eb2c14c7e68bb0be055c6408d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Very interesting.<div dir=3D"auto">I&#39;ve been toying a=
round with Rook.io [1]. Did you know of this project, and if so can you tel=
l if ceph-helm and Rook.io have similar goals?<div dir=3D"auto"><br></div><=
div dir=3D"auto">Regards,</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Hans</div><div dir=3D"auto"><br></div><div dir=3D"auto">[1]=C2=A0<a href=
=3D"https://rook.io/">https://rook.io/</a></div></div></div><div class=3D"g=
mail_extra"><br><div class=3D"gmail_quote">On 25 Oct 2017 21:09, &quot;Sage=
 Weil&quot; &lt;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">sweil=
@redhat.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">There is a new repo under the ceph org, ceph-helm, which includes he=
lm<br>
charts for deploying ceph on kubernetes.=C2=A0 The code is based on the cep=
h<br>
charts from openstack-helm, but we&#39;ve moved them into their own upstrea=
m<br>
repo here so that they can be developed more quickly and independently<br>
from the openstack-helm work.=C2=A0 The code has already evolved a fair bit=
,<br>
mostly to support luminous and fix a range of issues:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/ceph/ceph-helm/tr=
ee/master/ceph/ceph" rel=3D"noreferrer" target=3D"_blank">https://github.co=
m/ceph/ceph-<wbr>helm/tree/master/ceph/ceph</a><br>
<br>
The repo is a fork of the upstream kubernetes/charts.git repo with an eye<b=
r>
toward eventually merging the chart upstream into that repo.=C2=A0 How usef=
ul<br>
that would be in practice is not entirely clear to me since the version in<=
br>
the ceph-helm repo will presumably always be more up to date and users<br>
have to point to *some* source for the chart either way.=C2=A0 Also the cur=
rent<br>
structure of the files in the repo is carried over from openstack-helm,<br>
which uses the helm-toolkit stuff and isn&#39;t in the correct form for the=
<br>
upstream charts.git.=C2=A0 Suggestions/input here on what direction makes m=
ore<br>
sense would be welcome!<br>
<br>
There are also some docs on getting a ceph cluster up in kubernetes using<b=
r>
these charts at<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/ceph/ceph/pull/18=
520" rel=3D"noreferrer" target=3D"_blank">https://github.com/ceph/ceph/<wbr=
>pull/18520</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://docs.ceph.com/ceph-prs/18520/=
start/kube-helm/" rel=3D"noreferrer" target=3D"_blank">http://docs.ceph.com=
/ceph-prs/<wbr>18520/start/kube-helm/</a><br>
<br>
that should be merged shortly.=C2=A0 Not terribly detailed and we&#39;re no=
t<br>
covering much on the operations side yet, but that all is coming.<br>
<br>
A very rough sketch of the direction currently being considered from<br>
running ceph in kubernetes is here:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://pad.ceph.com/p/containers" re=
l=3D"noreferrer" target=3D"_blank">http://pad.ceph.com/p/<wbr>containers</a=
><br>
<br>
and there is a trello board here<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://trello.com/b/kcXOllJp/kubehe=
lm" rel=3D"noreferrer" target=3D"_blank">https://trello.com/b/kcXOllJp/<wbr=
>kubehelm</a><br>
<br>
All of this builds on the container image that Sebastien has been working<b=
r>
on for some time, that has recently been renamed from ceph-docker -&gt;<br>
ceph-container<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/ceph/ceph-contain=
er" rel=3D"noreferrer" target=3D"_blank">https://github.com/ceph/ceph-<wbr>=
container</a><br>
<br>
Dan is working on getting an image registry up at <a href=3D"http://registr=
y.ceph.com" rel=3D"noreferrer" target=3D"_blank">registry.ceph.com</a> so<b=
r>
that we can publish test build images, releases, or both.<br>
<br>
We also have a daily sync up call for the folks who are actively working<br=
>
on this.<br>
<br>
That&#39;s all for now!=C2=A0 :)<br>
sage<br>
<br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
</blockquote></div></div>

--94eb2c14c7e68bb0be055c6408d2--

--===============2128437353619236527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2128437353619236527==--
