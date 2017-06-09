From: Wes Dillingham <wes_dillingham-nRXb03v5zC6Vc3sceRu5cw@public.gmane.org>
Subject: Re: removing cluster name support
Date: Fri, 9 Jun 2017 09:11:05 -0400
Message-ID: <CAMrEFZ62a7dToADh=-nbLy15Xx9=_mmJkmDjP-JY4mfarpd_5Q@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
	<5BCB72AC-A5E4-4CE3-BF6A-5164F4B64496@quantum.com>
	<alpine.DEB.2.11.1706081951440.23631@piezo.novalocal>
	<CAC-Np1wjRX99N4q69XfWY0m0fDETpRQZj5Hrgoe6kbrh7riE+A@mail.gmail.com>
Reply-To: wes_dillingham-nRXb03v5zC6Vc3sceRu5cw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0105619485=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1wjRX99N4q69XfWY0m0fDETpRQZj5Hrgoe6kbrh7riE+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0105619485==
Content-Type: multipart/alternative; boundary="001a11352e46e88d05055186b4c4"

--001a11352e46e88d05055186b4c4
Content-Type: text/plain; charset="UTF-8"

Similar to Dan's situation we utilize the --cluster name concept for our
operations. Primarily for "datamover" nodes which do incremental rbd
import/export between distinct clusters. This is entirely coordinated by
utilizing the --cluster option throughout.

The way we set it up is that all clusters are actually named "ceph" on the
mons and osds etc, but the clients themselves get /etc/ceph/clusterA.conf
and /etc/ceph/clusterB.conf so that we can differentiate. I would like to
see the functionality of clients being able to specify which conf file to
read preserved.

As a note though we went the route of naming all clusters "ceph" to
workaround difficulties in non-standard naming so this issue does need some
attention.

On Fri, Jun 9, 2017 at 8:19 AM, Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Thu, Jun 8, 2017 at 3:54 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > On Thu, 8 Jun 2017, Bassam Tabbara wrote:
> >> Thanks Sage.
> >>
> >> > At CDM yesterday we talked about removing the ability to name your
> ceph
> >> > clusters.
> >>
> >> Just to be clear, it would still be possible to run multiple ceph
> >> clusters on the same nodes, right?
> >
> > Yes, but you'd need to either (1) use containers (so that different
> > daemons see a different /etc/ceph/ceph.conf) or (2) modify the systemd
> > unit files to do... something.
>
> In the container case, I need to clarify that ceph-docker deployed
> with ceph-ansible is not capable of doing this, since
> the ad-hoc systemd units use the hostname as part of the identifier
> for the daemon, e.g:
>
>     systemctl enable ceph-mon@{{ ansible_hostname }}.service
>
>
> >
> > This is actually no different from Jewel. It's just that currently you
> can
> > run a single cluster on a host (without containers) but call it 'foo' and
> > knock yourself out by passing '--cluster foo' every time you invoke the
> > CLI.
> >
> > I'm guessing you're in the (1) case anyway and this doesn't affect you at
> > all :)
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Respectfully,

Wes Dillingham
wes_dillingham-nRXb03v5zC6Vc3sceRu5cw@public.gmane.org
Research Computing | Senior CyberInfrastructure Storage Engineer
Harvard University | 38 Oxford Street, Cambridge, Ma 02138 | Room 102

--001a11352e46e88d05055186b4c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Similar to Dan&#39;s situation we utilize the --cluster na=
me concept for our operations. Primarily for &quot;datamover&quot; nodes wh=
ich do incremental rbd import/export between distinct clusters. This is ent=
irely coordinated by utilizing the --cluster option throughout.<div><br><di=
v>The way we set it up is that all clusters are actually named &quot;ceph&q=
uot; on the mons and osds etc, but the clients themselves get /etc/ceph/clu=
sterA.conf and /etc/ceph/clusterB.conf so that we can differentiate. I woul=
d like to see the functionality of clients being able to specify which conf=
 file to read preserved.=C2=A0</div></div><div><br></div><div>As a note tho=
ugh we went the route of naming all clusters &quot;ceph&quot; to workaround=
 difficulties in non-standard naming so this issue does need some attention=
.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Ju=
n 9, 2017 at 8:19 AM, Alfredo Deza <span dir=3D"ltr">&lt;<a href=3D"mailto:=
adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><span class=3D"">On Thu, Jun 8, 2017 at 3=
:54 PM, Sage Weil &lt;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org<=
/a>&gt; wrote:<br>
&gt; On Thu, 8 Jun 2017, Bassam Tabbara wrote:<br>
&gt;&gt; Thanks Sage.<br>
&gt;&gt;<br>
&gt;&gt; &gt; At CDM yesterday we talked about removing the ability to name=
 your ceph<br>
&gt;&gt; &gt; clusters.<br>
&gt;&gt;<br>
&gt;&gt; Just to be clear, it would still be possible to run multiple ceph<=
br>
&gt;&gt; clusters on the same nodes, right?<br>
&gt;<br>
&gt; Yes, but you&#39;d need to either (1) use containers (so that differen=
t<br>
&gt; daemons see a different /etc/ceph/ceph.conf) or (2) modify the systemd=
<br>
&gt; unit files to do... something.<br>
<br>
</span>In the container case, I need to clarify that ceph-docker deployed<b=
r>
with ceph-ansible is not capable of doing this, since<br>
the ad-hoc systemd units use the hostname as part of the identifier<br>
for the daemon, e.g:<br>
<br>
=C2=A0 =C2=A0 systemctl enable ceph-mon@{{ ansible_hostname }}.service<br>
<span class=3D"im HOEnZb"><br>
<br>
&gt;<br>
&gt; This is actually no different from Jewel. It&#39;s just that currently=
 you can<br>
&gt; run a single cluster on a host (without containers) but call it &#39;f=
oo&#39; and<br>
&gt; knock yourself out by passing &#39;--cluster foo&#39; every time you i=
nvoke the<br>
&gt; CLI.<br>
&gt;<br>
&gt; I&#39;m guessing you&#39;re in the (1) case anyway and this doesn&#39;=
t affect you at<br>
&gt; all :)<br>
&gt;<br>
&gt; sage<br>
</span><span class=3D"im HOEnZb">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<=
wbr>majordomo-info.html</a><br>
</span><div class=3D"HOEnZb"><div class=3D"h5">____________________________=
__<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div><div dir=3D"ltr"><span style=3D"font-size:12.8000001907349px">Respectf=
ully,</span><div style=3D"font-size:12.8000001907349px"><br></div><div styl=
e=3D"font-size:12.8000001907349px">Wes Dillingham</div><div style=3D"font-s=
ize:12.8000001907349px"><a href=3D"mailto:wes_dillingham-nRXb03v5zC6Vc3sceRu5cw@public.gmane.org" targe=
t=3D"_blank">wes_dillingham-nRXb03v5zC6Vc3sceRu5cw@public.gmane.org</a></div><div style=3D"font-size:12=
.8000001907349px">Research Computing | Senior CyberInfrastructure Storage E=
ngineer</div><div style=3D"font-size:12.8000001907349px">Harvard University=
 | 38 Oxford Street, Cambridge, Ma 02138 | Room 102</div></div></div></div>=
</div></div></div></div></div></div></div>
</div></div>

--001a11352e46e88d05055186b4c4--

--===============0105619485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0105619485==--
