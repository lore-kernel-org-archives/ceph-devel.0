From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 17:22:07 +0000
Message-ID: <CAN-Gep+RmSB6gW5GRVsT8T7j60EAzGnfbgeqDjwCNDWocpgp3g@mail.gmail.com>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <1821337488.5487.1511856776936@ox.pcextreme.nl>
 <4c4b5589-b1ae-3f8b-e900-af0f2895fbc9@corp.ovh.com>
 <CAC-Np1zsf+uqFi+ZdR7K3=re5ODpJvWFrTX-JU_8DkkyVGOz7A@mail.gmail.com>
 <d548c5a8-c0dc-0737-66f4-e3fc04f900d7@digiware.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3352448473380986346=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <d548c5a8-c0dc-0737-66f4-e3fc04f900d7-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3352448473380986346==
Content-Type: multipart/alternative; boundary="94eb2c11a482d2a650055f0e42f6"

--94eb2c11a482d2a650055f0e42f6
Content-Type: text/plain; charset="UTF-8"

Isn't marking something as deprecated meaning that there is a better option
that we want you to use and you should switch to it sooner than later? I
don't understand how this is ready to be marked as such if ceph-volume
can't be switched to for all supported use cases. If ZFS, encryption,
FreeBSD, etc are all going to be supported under ceph-volume, then how can
ceph-disk be deprecated before ceph-volume can support them? I can imagine
many Ceph admins wasting time chasing an erroneous deprecated warning
because it came out before the new solution was mature enough to replace
the existing solution.
On Tue, Nov 28, 2017 at 9:26 AM Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org> wrote:

> On 28-11-2017 13:32, Alfredo Deza wrote:
> >
> > I understand that this would involve a significant effort to fully
> > port over and drop ceph-disk entirely, and I don't think that dropping
> > ceph-disk in Mimic is set in stone (yet).
>
> Alfredo,
>
> When I expressed my concers about deprecating ceph-disk, I was led to
> beleive that I had atleast two release cycles to come up with something
> of a 'ceph-volume zfs ....'
>
> Reading this, there is a possibility that it will get dropped IN mimic?
> Which means that there is less than 1 release cycle to get it working?
>
> Thanx,
> --WjW
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--94eb2c11a482d2a650055f0e42f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Isn&#39;t marking something as deprecated meaning tha=
t there is a better option that we want you to use and you should switch to=
 it sooner than later? I don&#39;t understand how this is ready to be marke=
d as such if ceph-volume can&#39;t be switched to for all supported use cas=
es. If ZFS, encryption, FreeBSD, etc are all going to be supported under ce=
ph-volume, then how can ceph-disk be deprecated before ceph-volume can supp=
ort them? I can imagine many Ceph admins wasting time chasing an erroneous =
deprecated warning because it came out before the new solution was mature e=
nough to replace the existing solution.</div><div><div class=3D"gmail_quote=
"><div dir=3D"ltr">On Tue, Nov 28, 2017 at 9:26 AM Willem Jan Withagen &lt;=
<a href=3D"mailto:wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org">wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On 28-11-2017 13:32, Alfredo Deza wrote:<br>
&gt;<br>
&gt; I understand that this would involve a significant effort to fully<br>
&gt; port over and drop ceph-disk entirely, and I don&#39;t think that drop=
ping<br>
&gt; ceph-disk in Mimic is set in stone (yet).<br>
<br>
Alfredo,<br>
<br>
When I expressed my concers about deprecating ceph-disk, I was led to<br>
beleive that I had atleast two release cycles to come up with something<br>
of a &#39;ceph-volume zfs ....&#39;<br>
<br>
Reading this, there is a possibility that it will get dropped IN mimic?<br>
Which means that there is less than 1 release cycle to get it working?<br>
<br>
Thanx,<br>
--WjW<br>
<br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div></div></div>

--94eb2c11a482d2a650055f0e42f6--

--===============3352448473380986346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3352448473380986346==--
