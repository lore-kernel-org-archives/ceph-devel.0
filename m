From: Erik McCormick <emccormick-hzxOQuFdzaZcUxcyEe/BTA@public.gmane.org>
Subject: Re: removing cluster name support
Date: Tue, 7 Nov 2017 16:08:36 -0500
Message-ID: <CAHUi5cM05dsQ3G09B1hkQsDs3pXrHpb_LUYDKMcYpQBVWeqz8A@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
 <CAJE9aOP99gD3iZbduuRV-nM_fPpNtfW4ah_X11Acag5_a+YTxg@mail.gmail.com>
 <CAC-Np1xa19Q8rYmAvfxZqFDDTWuMqv0GCfDLZBYVg+k15Jvj0w@mail.gmail.com>
 <alpine.DEB.2.11.1711071931540.29217@piezo.novalocal>
 <CAKPXa=YDxV1G-sgFEsJ9WpUwDn5N0o3eB1=WZKyG3Cr2uTRXWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5119108909436670566=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAKPXa=YDxV1G-sgFEsJ9WpUwDn5N0o3eB1=WZKyG3Cr2uTRXWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Vasu Kulkarni <vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============5119108909436670566==
Content-Type: multipart/alternative; boundary="94eb2c05aba07d9f24055d6af9a3"

--94eb2c05aba07d9f24055d6af9a3
Content-Type: text/plain; charset="UTF-8"

On Nov 8, 2017 7:33 AM, "Vasu Kulkarni" <vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

On Tue, Nov 7, 2017 at 11:38 AM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> On Tue, 7 Nov 2017, Alfredo Deza wrote:
>> On Tue, Nov 7, 2017 at 7:09 AM, kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > On Fri, Jun 9, 2017 at 3:37 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> >> At CDM yesterday we talked about removing the ability to name your
ceph
>> >> clusters.  There are a number of hurtles that make it difficult to
fully
>> >> get rid of this functionality, not the least of which is that some
>> >> (many?) deployed clusters make use of it.  We decided that the most
we can
>> >> do at this point is remove support for it in ceph-deploy and
ceph-ansible
>> >> so that no new clusters or deployed nodes use it.
>> >>
>> >> The first PR in this effort:
>> >>
>> >>         https://github.com/ceph/ceph-deploy/pull/441
>> >
>> > okay, i am closing https://github.com/ceph/ceph/pull/18638 and
>> > http://tracker.ceph.com/issues/3253
>>
>> This brings us to a limbo were we aren't supporting it in some places
>> but we do in some others.
>>
>> It was disabled for ceph-deploy, but ceph-ansible wants to support it
>> still (see:  https://bugzilla.redhat.com/show_bug.cgi?id=1459861 )
>
> I still haven't seen a case where customer server names for *daemons* is
> needed.  Only for client-side $cluster.conf info for connecting.
>
>> Sebastien argues that these reasons are strong enough to keep that
support in:
>>
>> - Ceph cluster on demand with containers
>
> With kubernetes, the cluster will existin in a cluster namespace, and
> daemons live in containers, so inside the container hte cluster will be
> 'ceph'.
>
>> - Distributed compute nodes
>
> ?
>
>> - rbd-mirror integration as part of OSPd
>
> This is the client-side $cluster.conf for connecting to the remove
> cluster.
>
>> - Disaster scenario with OpenStack Cinder in OSPd
>
> Ditto.
>
>> The problem is that, as you can see with the ceph-disk PR just closed,
>> there are still other tools that have to implement the juggling of
>> custom cluster names
>> all over the place and they will hit some corner place where the
>> cluster name was not added and things will fail.
>>
>> Just recently ceph-volume hit one of these places:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1507943
>>
>> Are we going to support custom cluster names? In what
>> context/scenarios are we going to allow it?
>
> It seems like we could drop this support in ceph-volume, unless someone
> can present a compelling reason to keep it?
>
> ...
>
> I'd almost want to go a step further and change
>
> /var/lib/ceph/$type/$cluster-$id/
>
> to
>
>  /var/lib/ceph/$type/$id
+1 for custom name support to be disabled from master/stable ansible
releases,
And I think rbd-mirror and openstack are mostly configuration issues
that could use different conf files to talk
to different clusters.


Agreed on the Openstack part. I actually changed nothing on that side of
things. The clients still run with a custom config name with no issues.

-Erik


>
> In kubernetes, we're planning on bind mounting the host's
> /var/lib/ceph/$namespace/$type/$id to the container's
> /var/lib/ceph/$type/ceph-$id.  It might be a good time to drop some of the
> awkward path names, though.  Or is it useless churn?
>
> sage
>
>
>
>>
>>
>> >
>> >>
>> >> Background:
>> >>
>> >> The cluster name concept was added to allow multiple clusters to have
>> >> daemons coexist on the same host.  At the type it was a hypothetical
>> >> requirement for a user that never actually made use of it, and the
>> >> support is kludgey:
>> >>
>> >>  - default cluster name is 'ceph'
>> >>  - default config is /etc/ceph/$cluster.conf, so that the normal
>> >> 'ceph.conf' still works
>> >>  - daemon data paths include the cluster name,
>> >>      /var/lib/ceph/osd/$cluster-$id
>> >>    which is weird (but mostly people are used to it?)
>> >>  - any cli command you want to touch a non-ceph cluster name
>> >> needs -C $name or --cluster $name passed to it.
>> >>
>> >> Also, as of jewel,
>> >>
>> >>  - systemd only supports a single cluster per host, as defined by
$CLUSTER
>> >> in /etc/{sysconfig,default}/ceph
>> >>
>> >> which you'll notice removes support for the original "requirement".
>> >>
>> >> Also note that you can get the same effect by specifying the config
path
>> >> explicitly (-c /etc/ceph/foo.conf) along with the various options that
>> >> substitute $cluster in (e.g., osd_data=/var/lib/ceph/osd/$
cluster-$id).
>> >>
>> >>
>> >> Crap preventing us from removing this entirely:
>> >>
>> >>  - existing daemon directories for existing clusters
>> >>  - various scripts parse the cluster name out of paths
>> >>
>> >>
>> >> Converting an existing cluster "foo" back to "ceph":
>> >>
>> >>  - rename /etc/ceph/foo.conf -> ceph.conf
>> >>  - rename /var/lib/ceph/*/foo-* -> /var/lib/ceph/*/ceph-*
>> >>  - remove the CLUSTER=foo line in /etc/{default,sysconfig}/ceph
>> >>  - reboot
>> >>
>> >>
>> >> Questions:
>> >>
>> >>  - Does anybody on the list use a non-default cluster name?
>> >>  - If so, do you have a reason not to switch back to 'ceph'?
>> >>
>> >> Thanks!
>> >> sage
>> >> _______________________________________________
>> >> ceph-users mailing list
>> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >
>> >
>> >
>> > --
>> > Regards
>> > Kefu Chai
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--94eb2c05aba07d9f24055d6af9a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Nov 8, 2017 7:33 AM, &quot;Vasu Kulkarni&quot; &lt;<a href=3D"=
mailto:vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br type=3D"a=
ttribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div class=3D"elided-text">On Tue, Nov=
 7, 2017 at 11:38 AM, Sage Weil &lt;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">sa=
ge-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; wrote:<br>
&gt; On Tue, 7 Nov 2017, Alfredo Deza wrote:<br>
&gt;&gt; On Tue, Nov 7, 2017 at 7:09 AM, kefu chai &lt;<a href=3D"mailto:tc=
haikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; &gt; On Fri, Jun 9, 2017 at 3:37 AM, Sage Weil &lt;<a href=3D"mail=
to:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; At CDM yesterday we talked about removing the ability to =
name your ceph<br>
&gt;&gt; &gt;&gt; clusters.=C2=A0 There are a number of hurtles that make i=
t difficult to fully<br>
&gt;&gt; &gt;&gt; get rid of this functionality, not the least of which is =
that some<br>
&gt;&gt; &gt;&gt; (many?) deployed clusters make use of it.=C2=A0 We decide=
d that the most we can<br>
&gt;&gt; &gt;&gt; do at this point is remove support for it in ceph-deploy =
and ceph-ansible<br>
&gt;&gt; &gt;&gt; so that no new clusters or deployed nodes use it.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; The first PR in this effort:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://githu=
b.com/ceph/ceph-deploy/pull/441" rel=3D"noreferrer" target=3D"_blank">https=
://github.com/ceph/ceph-<wbr>deploy/pull/441</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; okay, i am closing <a href=3D"https://github.com/ceph/ceph/pu=
ll/18638" rel=3D"noreferrer" target=3D"_blank">https://github.com/ceph/ceph=
/<wbr>pull/18638</a> and<br>
&gt;&gt; &gt; <a href=3D"http://tracker.ceph.com/issues/3253" rel=3D"norefe=
rrer" target=3D"_blank">http://tracker.ceph.com/<wbr>issues/3253</a><br>
&gt;&gt;<br>
&gt;&gt; This brings us to a limbo were we aren&#39;t supporting it in some=
 places<br>
&gt;&gt; but we do in some others.<br>
&gt;&gt;<br>
&gt;&gt; It was disabled for ceph-deploy, but ceph-ansible wants to support=
 it<br>
&gt;&gt; still (see:=C2=A0 <a href=3D"https://bugzilla.redhat.com/show_bug.=
cgi?id=3D1459861" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.red=
hat.com/<wbr>show_bug.cgi?id=3D1459861</a> )<br>
&gt;<br>
&gt; I still haven&#39;t seen a case where customer server names for *daemo=
ns* is<br>
&gt; needed.=C2=A0 Only for client-side $cluster.conf info for connecting.<=
br>
&gt;<br>
&gt;&gt; Sebastien argues that these reasons are strong enough to keep that=
 support in:<br>
&gt;&gt;<br>
&gt;&gt; - Ceph cluster on demand with containers<br>
&gt;<br>
&gt; With kubernetes, the cluster will existin in a cluster namespace, and<=
br>
&gt; daemons live in containers, so inside the container hte cluster will b=
e<br>
&gt; &#39;ceph&#39;.<br>
&gt;<br>
&gt;&gt; - Distributed compute nodes<br>
&gt;<br>
&gt; ?<br>
&gt;<br>
&gt;&gt; - rbd-mirror integration as part of OSPd<br>
&gt;<br>
&gt; This is the client-side $cluster.conf for connecting to the remove<br>
&gt; cluster.<br>
&gt;<br>
&gt;&gt; - Disaster scenario with OpenStack Cinder in OSPd<br>
&gt;<br>
&gt; Ditto.<br>
&gt;<br>
&gt;&gt; The problem is that, as you can see with the ceph-disk PR just clo=
sed,<br>
&gt;&gt; there are still other tools that have to implement the juggling of=
<br>
&gt;&gt; custom cluster names<br>
&gt;&gt; all over the place and they will hit some corner place where the<b=
r>
&gt;&gt; cluster name was not added and things will fail.<br>
&gt;&gt;<br>
&gt;&gt; Just recently ceph-volume hit one of these places:<br>
&gt;&gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1507943" =
rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/<wbr>show_=
bug.cgi?id=3D1507943</a><br>
&gt;&gt;<br>
&gt;&gt; Are we going to support custom cluster names? In what<br>
&gt;&gt; context/scenarios are we going to allow it?<br>
&gt;<br>
&gt; It seems like we could drop this support in ceph-volume, unless someon=
e<br>
&gt; can present a compelling reason to keep it?<br>
&gt;<br>
&gt; ...<br>
&gt;<br>
&gt; I&#39;d almost want to go a step further and change<br>
&gt;<br>
&gt; /var/lib/ceph/$type/$cluster-$<wbr>id/<br>
&gt;<br>
&gt; to<br>
&gt;<br>
&gt;=C2=A0 /var/lib/ceph/$type/$id<br>
</div>+1 for custom name support to be disabled from master/stable ansible =
releases,<br>
And I think rbd-mirror and openstack are mostly configuration issues<br>
that could use different conf files to talk<br>
to different clusters.<br>
<div class=3D"elided-text"></div></blockquote></div></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Agreed on the Openstack part. I actually=
 changed nothing on that side of things. The clients still run with a custo=
m config name with no issues.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">-Erik</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div c=
lass=3D"elided-text"><br>
&gt;<br>
&gt; In kubernetes, we&#39;re planning on bind mounting the host&#39;s<br>
&gt; /var/lib/ceph/$namespace/$<wbr>type/$id to the container&#39;s<br>
&gt; /var/lib/ceph/$type/ceph-$id.=C2=A0 It might be a good time to drop so=
me of the<br>
&gt; awkward path names, though.=C2=A0 Or is it useless churn?<br>
&gt;<br>
&gt; sage<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Background:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; The cluster name concept was added to allow multiple clus=
ters to have<br>
&gt;&gt; &gt;&gt; daemons coexist on the same host.=C2=A0 At the type it wa=
s a hypothetical<br>
&gt;&gt; &gt;&gt; requirement for a user that never actually made use of it=
, and the<br>
&gt;&gt; &gt;&gt; support is kludgey:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 - default cluster name is &#39;ceph&#39;<br>
&gt;&gt; &gt;&gt;=C2=A0 - default config is /etc/ceph/$cluster.conf, so tha=
t the normal<br>
&gt;&gt; &gt;&gt; &#39;ceph.conf&#39; still works<br>
&gt;&gt; &gt;&gt;=C2=A0 - daemon data paths include the cluster name,<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 /var/lib/ceph/osd/$cluster-$id<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 which is weird (but mostly people are used t=
o it?)<br>
&gt;&gt; &gt;&gt;=C2=A0 - any cli command you want to touch a non-ceph clus=
ter name<br>
&gt;&gt; &gt;&gt; needs -C $name or --cluster $name passed to it.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Also, as of jewel,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 - systemd only supports a single cluster per host, =
as defined by $CLUSTER<br>
&gt;&gt; &gt;&gt; in /etc/{sysconfig,default}/ceph<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; which you&#39;ll notice removes support for the original =
&quot;requirement&quot;.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Also note that you can get the same effect by specifying =
the config path<br>
&gt;&gt; &gt;&gt; explicitly (-c /etc/ceph/foo.conf) along with the various=
 options that<br>
&gt;&gt; &gt;&gt; substitute $cluster in (e.g., osd_data=3D/var/lib/ceph/os=
d/$<wbr>cluster-$id).<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Crap preventing us from removing this entirely:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 - existing daemon directories for existing clusters=
<br>
&gt;&gt; &gt;&gt;=C2=A0 - various scripts parse the cluster name out of pat=
hs<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Converting an existing cluster &quot;foo&quot; back to &q=
uot;ceph&quot;:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 - rename /etc/ceph/foo.conf -&gt; ceph.conf<br>
&gt;&gt; &gt;&gt;=C2=A0 - rename /var/lib/ceph/*/foo-* -&gt; /var/lib/ceph/=
*/ceph-*<br>
&gt;&gt; &gt;&gt;=C2=A0 - remove the CLUSTER=3Dfoo line in /etc/{default,sy=
sconfig}/ceph<br>
&gt;&gt; &gt;&gt;=C2=A0 - reboot<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Questions:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 - Does anybody on the list use a non-default cluste=
r name?<br>
&gt;&gt; &gt;&gt;=C2=A0 - If so, do you have a reason not to switch back to=
 &#39;ceph&#39;?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Thanks!<br>
&gt;&gt; &gt;&gt; sage<br>
&gt;&gt; &gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt; &gt;&gt; ceph-users mailing list<br>
&gt;&gt; &gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@l=
ists.ceph.com</a><br>
&gt;&gt; &gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>l=
istinfo.cgi/ceph-users-ceph.<wbr>com</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; Regards<br>
&gt;&gt; &gt; Kefu Chai<br>
&gt;&gt; &gt; ______________________________<wbr>_________________<br>
&gt;&gt; &gt; ceph-users mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users@lists=
.ceph.com</a><br>
&gt;&gt; &gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph=
.com" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listi=
nfo.cgi/ceph-users-ceph.<wbr>com</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
</div><div class=3D"quoted-text">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<=
wbr>majordomo-info.html</a><br>
</div><div class=3D"elided-text">______________________________<wbr>_______=
__________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
</div></blockquote></div><br></div></div></div>

--94eb2c05aba07d9f24055d6af9a3--

--===============5119108909436670566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============5119108909436670566==--
