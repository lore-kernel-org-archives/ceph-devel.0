From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: Re: removing cluster name support
Date: Thu, 8 Jun 2017 21:55:15 +0200
Message-ID: <CABZ+qqk-kSL4XsG=7F2zrnzaa552xLb=T7w_6dRTR6ST7amY-g@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0185772262=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1706081936570.3646-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0185772262==
Content-Type: multipart/alternative; boundary="94eb2c18d98c4b975b0551783bd5"

--94eb2c18d98c4b975b0551783bd5
Content-Type: text/plain; charset="UTF-8"

Hi Sage,

We need named clusters on the client side. RBD or CephFS clients, or
monitoring/admin machines all need to be able to access several clusters.

Internally, each cluster is indeed called "ceph", but the clients use
distinct names to differentiate their configs/keyrings.

Cheers, Dan


On Jun 8, 2017 9:37 PM, "Sage Weil" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

At CDM yesterday we talked about removing the ability to name your ceph
clusters.  There are a number of hurtles that make it difficult to fully
get rid of this functionality, not the least of which is that some
(many?) deployed clusters make use of it.  We decided that the most we can
do at this point is remove support for it in ceph-deploy and ceph-ansible
so that no new clusters or deployed nodes use it.

The first PR in this effort:

        https://github.com/ceph/ceph-deploy/pull/441

Background:

The cluster name concept was added to allow multiple clusters to have
daemons coexist on the same host.  At the type it was a hypothetical
requirement for a user that never actually made use of it, and the
support is kludgey:

 - default cluster name is 'ceph'
 - default config is /etc/ceph/$cluster.conf, so that the normal
'ceph.conf' still works
 - daemon data paths include the cluster name,
     /var/lib/ceph/osd/$cluster-$id
   which is weird (but mostly people are used to it?)
 - any cli command you want to touch a non-ceph cluster name
needs -C $name or --cluster $name passed to it.

Also, as of jewel,

 - systemd only supports a single cluster per host, as defined by $CLUSTER
in /etc/{sysconfig,default}/ceph

which you'll notice removes support for the original "requirement".

Also note that you can get the same effect by specifying the config path
explicitly (-c /etc/ceph/foo.conf) along with the various options that
substitute $cluster in (e.g., osd_data=/var/lib/ceph/osd/$cluster-$id).


Crap preventing us from removing this entirely:

 - existing daemon directories for existing clusters
 - various scripts parse the cluster name out of paths


Converting an existing cluster "foo" back to "ceph":

 - rename /etc/ceph/foo.conf -> ceph.conf
 - rename /var/lib/ceph/*/foo-* -> /var/lib/ceph/*/ceph-*
 - remove the CLUSTER=foo line in /etc/{default,sysconfig}/ceph
 - reboot


Questions:

 - Does anybody on the list use a non-default cluster name?
 - If so, do you have a reason not to switch back to 'ceph'?

Thanks!
sage
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--94eb2c18d98c4b975b0551783bd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Sage,<div dir=3D"auto"><br></div><div dir=3D"auto=
">We need named clusters on the client side. RBD or CephFS clients, or moni=
toring/admin machines all need to be able to access several clusters.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Internally, each cluster is i=
ndeed called &quot;ceph&quot;, but the clients use distinct names to differ=
entiate their configs/keyrings.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Cheers, Dan</div><div dir=3D"auto"><br></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Jun 8, 2017 9:37 PM, &quot;Sage We=
il&quot; &lt;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">sweil@re=
dhat.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"m_9222=
119785087177509quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">At CDM yesterday we talked about removing the ability to=
 name your ceph<br>
clusters.=C2=A0 There are a number of hurtles that make it difficult to ful=
ly<br>
get rid of this functionality, not the least of which is that some<br>
(many?) deployed clusters make use of it.=C2=A0 We decided that the most we=
 can<br>
do at this point is remove support for it in ceph-deploy and ceph-ansible<b=
r>
so that no new clusters or deployed nodes use it.<br>
<br>
The first PR in this effort:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/ceph/ceph-deploy/=
pull/441" rel=3D"noreferrer" target=3D"_blank">https://github.com/ceph/ceph=
-d<wbr>eploy/pull/441</a><br>
<br>
Background:<br>
<br>
The cluster name concept was added to allow multiple clusters to have<br>
daemons coexist on the same host.=C2=A0 At the type it was a hypothetical<b=
r>
requirement for a user that never actually made use of it, and the<br>
support is kludgey:<br>
<br>
=C2=A0- default cluster name is &#39;ceph&#39;<br>
=C2=A0- default config is /etc/ceph/$cluster.conf, so that the normal<br>
&#39;ceph.conf&#39; still works<br>
=C2=A0- daemon data paths include the cluster name,<br>
=C2=A0 =C2=A0 =C2=A0/var/lib/ceph/osd/$cluster-$<wbr>id<br>
=C2=A0 =C2=A0which is weird (but mostly people are used to it?)<br>
=C2=A0- any cli command you want to touch a non-ceph cluster name<br>
needs -C $name or --cluster $name passed to it.<br>
<br>
Also, as of jewel,<br>
<br>
=C2=A0- systemd only supports a single cluster per host, as defined by $CLU=
STER<br>
in /etc/{sysconfig,default}/ceph<br>
<br>
which you&#39;ll notice removes support for the original &quot;requirement&=
quot;.<br>
<br>
Also note that you can get the same effect by specifying the config path<br=
>
explicitly (-c /etc/ceph/foo.conf) along with the various options that<br>
substitute $cluster in (e.g., osd_data=3D/var/lib/ceph/osd/$cl<wbr>uster-$i=
d).<br>
<br>
<br>
Crap preventing us from removing this entirely:<br>
<br>
=C2=A0- existing daemon directories for existing clusters<br>
=C2=A0- various scripts parse the cluster name out of paths<br>
<br>
<br>
Converting an existing cluster &quot;foo&quot; back to &quot;ceph&quot;:<br=
>
<br>
=C2=A0- rename /etc/ceph/foo.conf -&gt; ceph.conf<br>
=C2=A0- rename /var/lib/ceph/*/foo-* -&gt; /var/lib/ceph/*/ceph-*<br>
=C2=A0- remove the CLUSTER=3Dfoo line in /etc/{default,sysconfig}/ceph<br>
=C2=A0- reboot<br>
<br>
<br>
Questions:<br>
<br>
=C2=A0- Does anybody on the list use a non-default cluster name?<br>
=C2=A0- If so, do you have a reason not to switch back to &#39;ceph&#39;?<b=
r>
<br>
Thanks!<br>
sage<br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
</blockquote></div><br></div></div></div>

--94eb2c18d98c4b975b0551783bd5--

--===============0185772262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0185772262==--
