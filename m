From: Federico Lucifredi <federico-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Ceph QoS user stories
Date: Fri, 2 Dec 2016 17:13:34 -0500
Message-ID: <CAJhGp1F-UJfQeJf5nuiyauR+Ok1O7i++MAytS39XyOXF5brswQ@mail.gmail.com>
References: <alpine.DEB.2.11.1612021847590.22800@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0808800353=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1612021847590.22800-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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

--===============0808800353==
Content-Type: multipart/alternative; boundary=94eb2c05be68924f640542b44191

--94eb2c05be68924f640542b44191
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

 The primary QoS issue we see with OpenStack users is wanting to guarantee
minimum IOPS to each Cinder-mounted RBD volume as a way to guarantee the
health of well-mannered workloads against badly-behaving ones.

 As an OpenStack Administrator, I want to guarantee a minimum number of
IOPS to each Cinder volume to prevent any tenant from interfering with
another.

  The number of IOPS may vary per volume, but in many cases a "standard"
and "high" number would probably suffice. The guarantee is more important
than the granularity.

  This is something impacting users at today's Ceph performance level.

  Looking at the future, once Bluestore becomes the default,  there will
also be latency requirements from the crowd that wants to run databases
with RBD backends =E2=80=94 both low latency and low jitter in the latency,=
 but
rather than applying that to all volumes, it will be only to select ones
backing RDBMs. Well, at least in the case of a general purpose cluster.


 My hunch is that Enterprise users that want hard-QoS guarantees will
accept that a capacity planning exercise is necessary, software can only
allocate existing capacity, not create more. Community users may value more
some "fairness" in distributing existing resources instead. Just a hunch at
this point.

 Best -F

_________________________________________
-- "You must try until your brain hurts =E2=80=94Elon Musk
(Federico L. Lucifredi) - federico at redhat.com - GnuPG 0x4A73884C

On Fri, Dec 2, 2016 at 2:01 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi all,
>
> We're working on getting infrasture into RADOS to allow for proper
> distributed quality-of-service guarantees.  The work is based on the
> mclock paper published in OSDI'10
>
>         https://www.usenix.org/legacy/event/osdi10/tech/full_papers/
> Gulati.pdf
>
> There are a few ways this can be applied:
>
>  - We can use mclock simply as a better way to prioritize background
> activity (scrub, snap trimming, recovery, rebalancing) against client IO.
>  - We can use d-mclock to set QoS parameters (e.g., min IOPS or
> proportional priority/weight) on RADOS pools
>  - We can use d-mclock to set QoS parameters (e.g., min IOPS) for
> individual clients.
>
> Once the rados capabilities are in place, there will be a significant
> amount of effort needed to get all of the APIs in place to configure and
> set policy.  In order to make sure we build somethign that makes sense,
> I'd like to collection a set of user stores that we'd like to support so
> that we can make sure we capture everything (or at least the important
> things).
>
> Please add any use-cases that are important to you to this pad:
>
>         http://pad.ceph.com/p/qos-user-stories
>
> or as a follow-up to this email.
>
> mClock works in terms of a minimum allocation (of IOPS or bandwidth; they
> are sort of reduced into a single unit of work), a maximum (i.e. simple
> cap), and a proportional weighting (to allocation any additional capacity
> after the minimum allocations are satisfied).  It's somewhat flexible in
> terms of how we apply it to specific clients, classes of clients, or type=
s
> of work (e.g., recovery).  How we put it all together really depends on
> what kinds of things we need to accomplish (e.g., do we need to support a
> guaranteed level of service shared across a specific set of N different
> clients, or only individual clients?).
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--94eb2c05be68924f640542b44191
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Sage,<div><br></div><div>=C2=A0The primary QoS issue we=
 see with OpenStack users is wanting to guarantee minimum IOPS to each Cind=
er-mounted RBD volume as a way to guarantee the health of well-mannered wor=
kloads against badly-behaving ones.</div><div><br></div><div>=C2=A0As an Op=
enStack Administrator, I want to guarantee a minimum number of IOPS to each=
 Cinder volume to prevent any tenant from interfering with another.</div><d=
iv><br></div><div>=C2=A0 The number of IOPS may vary per volume, but in man=
y cases a &quot;standard&quot; and &quot;high&quot; number would probably s=
uffice. The guarantee is more important than the granularity.</div><div><br=
></div><div>=C2=A0 This is something impacting users at today&#39;s Ceph pe=
rformance level.=C2=A0</div><div><br></div><div>=C2=A0 Looking at the futur=
e, once Bluestore becomes the default, =C2=A0there will also be latency req=
uirements from the crowd that wants to run databases with RBD backends =E2=
=80=94 both low latency and low jitter in the latency, but rather than appl=
ying that to all volumes, it will be only to select ones backing RDBMs. Wel=
l, at least in the case of a general purpose cluster.</div><div><br></div><=
div><br></div><div>=C2=A0My hunch is that Enterprise users that want hard-Q=
oS guarantees will accept that a capacity planning exercise is necessary, s=
oftware can only allocate existing capacity, not create more. Community use=
rs may value more some &quot;fairness&quot; in distributing existing resour=
ces instead. Just a hunch at this point.</div><div><br></div><div>=C2=A0Bes=
t -F</div><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"g=
mail_signature"><div dir=3D"ltr"><div>_____________________________________=
____</div><div>-- &quot;You must try until your brain hurts =E2=80=94Elon M=
usk</div><div>(Federico L. Lucifredi) - federico at <a href=3D"http://redha=
t.com" target=3D"_blank">redhat.com</a> - GnuPG 0x4A73884C</div></div></div=
></div>
<br><div class=3D"gmail_quote">On Fri, Dec 2, 2016 at 2:01 PM, Sage Weil <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">s=
weil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:r=
gb(204,204,204);border-left-style:solid;padding-left:1ex">Hi all,<br>
<br>
We&#39;re working on getting infrasture into RADOS to allow for proper<br>
distributed quality-of-service guarantees.=C2=A0 The work is based on the<b=
r>
mclock paper published in OSDI&#39;10<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://www.usenix.org/legacy/event/=
osdi10/tech/full_papers/Gulati.pdf" rel=3D"noreferrer" target=3D"_blank">ht=
tps://www.usenix.org/legacy/<wbr>event/osdi10/tech/full_papers/<wbr>Gulati.=
pdf</a><br>
<br>
There are a few ways this can be applied:<br>
<br>
=C2=A0- We can use mclock simply as a better way to prioritize background<b=
r>
activity (scrub, snap trimming, recovery, rebalancing) against client IO.<b=
r>
=C2=A0- We can use d-mclock to set QoS parameters (e.g., min IOPS or<br>
proportional priority/weight) on RADOS pools<br>
=C2=A0- We can use d-mclock to set QoS parameters (e.g., min IOPS) for<br>
individual clients.<br>
<br>
Once the rados capabilities are in place, there will be a significant<br>
amount of effort needed to get all of the APIs in place to configure and<br=
>
set policy.=C2=A0 In order to make sure we build somethign that makes sense=
,<br>
I&#39;d like to collection a set of user stores that we&#39;d like to suppo=
rt so<br>
that we can make sure we capture everything (or at least the important<br>
things).<br>
<br>
Please add any use-cases that are important to you to this pad:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://pad.ceph.com/p/qos-user-stori=
es" rel=3D"noreferrer" target=3D"_blank">http://pad.ceph.com/p/qos-<wbr>use=
r-stories</a><br>
<br>
or as a follow-up to this email.<br>
<br>
mClock works in terms of a minimum allocation (of IOPS or bandwidth; they<b=
r>
are sort of reduced into a single unit of work), a maximum (i.e. simple<br>
cap), and a proportional weighting (to allocation any additional capacity<b=
r>
after the minimum allocations are satisfied).=C2=A0 It&#39;s somewhat flexi=
ble in<br>
terms of how we apply it to specific clients, classes of clients, or types<=
br>
of work (e.g., recovery).=C2=A0 How we put it all together really depends o=
n<br>
what kinds of things we need to accomplish (e.g., do we need to support a<b=
r>
guaranteed level of service shared across a specific set of N different<br>
clients, or only individual clients?).<br>
<br>
Thanks!<br>
sage<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<wbr>m=
ajordomo-info.html</a><br>
</blockquote></div><br></div></div>

--94eb2c05be68924f640542b44191--

--===============0808800353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0808800353==--
