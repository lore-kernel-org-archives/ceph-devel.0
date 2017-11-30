From: Peter Woodman <peter-SlCTtNaFtPRg9hUCZPvPmw@public.gmane.org>
Subject: Re: ceph-disk removal roadmap (was ceph-disk is now
 deprecated)
Date: Thu, 30 Nov 2017 16:35:37 +0000
Message-ID: <CADfA06Tjkp70AwUr6oxx0fLaq3zNMAT0LvemeRq8irrhTDdUPA@mail.gmail.com>
References: <CAC-Np1zdwLALBE_eheCJ+bR_A4-Gway6fpv6smcQNjt-4=9RxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6678429167680194814=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1zdwLALBE_eheCJ+bR_A4-Gway6fpv6smcQNjt-4=9RxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============6678429167680194814==
Content-Type: multipart/alternative; boundary="001a11c15a548fd6d7055f35d7c2"

--001a11c15a548fd6d7055f35d7c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

how quickly are you planning to cut 12.2.3?

On Thu, Nov 30, 2017 at 4:25 PM, Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Thanks all for your feedback on deprecating ceph-disk, we are very
> excited to be able to move forwards on a much more robust tool and
> process for deploying and handling activation of OSDs, removing the
> dependency on UDEV which has been a tremendous source of constant
> issues.
>
> Initially (see "killing ceph-disk" thread [0]) we planned for removal
> of Mimic, but we didn't want to introduce the deprecation warnings up
> until we had an out for those who had OSDs deployed in previous
> releases with ceph-disk (we are now able to handle those as well).
> That is the reason ceph-volume, although present since the first
> Luminous release, hasn't been pushed forward much.
>
> Now that we feel like we can cover almost all cases, we would really
> like to see a wider usage so that we can improve on issues/experience.
>
> Given that 12.2.2 is already in the process of getting released, we
> can't undo the deprecation warnings for that version, but we will
> remove them for 12.2.3, add them back again in Mimic, which will mean
> ceph-disk will be kept around a bit longer, and finally fully removed
> by N.
>
> To recap:
>
> * ceph-disk deprecation warnings will stay for 12.2.2
> * deprecation warnings will be removed in 12.2.3 (and from all later
> Luminous releases)
> * deprecation warnings will be added again in ceph-disk for all Mimic
> releases
> * ceph-disk will no longer be available for the 'N' release, along
> with the UDEV rules
>
> I believe these four points address most of the concerns voiced in
> this thread, and should give enough time to port clusters over to
> ceph-volume.
>
> [0] http://lists.ceph.com/pipermail/ceph-users-ceph.com/
> 2017-October/021358.html
>
> On Thu, Nov 30, 2017 at 8:22 AM, Daniel Baumann <daniel.baumann-omB+W0Dpw2o@public.gmane.org>
> wrote:
> > On 11/30/17 14:04, Fabian Gr=C3=BCnbichler wrote:
> >> point is - you should not purposefully attempt to annoy users and/or
> >> downstreams by changing behaviour in the middle of an LTS release cycl=
e,
> >
> > exactly. upgrading the patch level (x.y.z to x.y.z+1) should imho never
> > introduce a behaviour-change, regardless if it's "just" adding new
> > warnings or not.
> >
> > this is a stable update we're talking about, even more so since it's an
> > LTS release. you never know how people use stuff (e.g. by parsing stupi=
d
> > things), so such behaviour-change will break stuff for *some* people
> > (granted, most likely a really low number).
> >
> > my expection to an stable release is, that it stays, literally, stable.
> > that's the whole point of having it in the first place. otherwise we
> > would all be running git snapshots and update randomly to newer ones.
> >
> > adding deprecation messages in mimic makes sense, and getting rid of
> > it/not provide support for it in mimic+1 is reasonable.
> >
> > Regards,
> > Daniel
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a11c15a548fd6d7055f35d7c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">how quickly are you planning to cut 12.2.3?</div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Nov 30, 2017 at 4:=
25 PM, Alfredo Deza <span dir=3D"ltr">&lt;<a href=3D"mailto:adeza-H+wXaHxf7aJhl2p70BpVqQ@public.gmane.org=
m" target=3D"_blank">adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">Thanks all for your feedback on deprecating ceph-disk, w=
e are very<br>
excited to be able to move forwards on a much more robust tool and<br>
process for deploying and handling activation of OSDs, removing the<br>
dependency on UDEV which has been a tremendous source of constant<br>
issues.<br>
<br>
Initially (see &quot;killing ceph-disk&quot; thread [0]) we planned for rem=
oval<br>
of Mimic, but we didn&#39;t want to introduce the deprecation warnings up<b=
r>
until we had an out for those who had OSDs deployed in previous<br>
releases with ceph-disk (we are now able to handle those as well).<br>
That is the reason ceph-volume, although present since the first<br>
Luminous release, hasn&#39;t been pushed forward much.<br>
<br>
Now that we feel like we can cover almost all cases, we would really<br>
like to see a wider usage so that we can improve on issues/experience.<br>
<br>
Given that 12.2.2 is already in the process of getting released, we<br>
can&#39;t undo the deprecation warnings for that version, but we will<br>
remove them for 12.2.3, add them back again in Mimic, which will mean<br>
ceph-disk will be kept around a bit longer, and finally fully removed<br>
by N.<br>
<br>
To recap:<br>
<br>
* ceph-disk deprecation warnings will stay for 12.2.2<br>
* deprecation warnings will be removed in 12.2.3 (and from all later<br>
Luminous releases)<br>
* deprecation warnings will be added again in ceph-disk for all Mimic relea=
ses<br>
* ceph-disk will no longer be available for the &#39;N&#39; release, along<=
br>
with the UDEV rules<br>
<br>
I believe these four points address most of the concerns voiced in<br>
this thread, and should give enough time to port clusters over to<br>
ceph-volume.<br>
<br>
[0] <a href=3D"http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-Oct=
ober/021358.html" rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.co=
m/<wbr>pipermail/ceph-users-ceph.com/<wbr>2017-October/021358.html</a><br>
<br>
On Thu, Nov 30, 2017 at 8:22 AM, Daniel Baumann &lt;<a href=3D"mailto:danie=
l.baumann-omB+W0Dpw2o@public.gmane.org">daniel.baumann-omB+W0Dpw2o@public.gmane.org</a>&gt; wrote:<br>
&gt; On 11/30/17 14:04, Fabian Gr=C3=BCnbichler wrote:<br>
&gt;&gt; point is - you should not purposefully attempt to annoy users and/=
or<br>
&gt;&gt; downstreams by changing behaviour in the middle of an LTS release =
cycle,<br>
&gt;<br>
&gt; exactly. upgrading the patch level (x.y.z to x.y.z+1) should imho neve=
r<br>
&gt; introduce a behaviour-change, regardless if it&#39;s &quot;just&quot; =
adding new<br>
&gt; warnings or not.<br>
&gt;<br>
&gt; this is a stable update we&#39;re talking about, even more so since it=
&#39;s an<br>
&gt; LTS release. you never know how people use stuff (e.g. by parsing stup=
id<br>
&gt; things), so such behaviour-change will break stuff for *some* people<b=
r>
&gt; (granted, most likely a really low number).<br>
&gt;<br>
&gt; my expection to an stable release is, that it stays, literally, stable=
.<br>
&gt; that&#39;s the whole point of having it in the first place. otherwise =
we<br>
&gt; would all be running git snapshots and update randomly to newer ones.<=
br>
&gt;<br>
&gt; adding deprecation messages in mimic makes sense, and getting rid of<b=
r>
&gt; it/not provide support for it in mimic+1 is reasonable.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Daniel<br>
&gt; ______________________________<wbr>_________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/c=
eph-users-ceph.<wbr>com</a><br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
</blockquote></div><br></div>

--001a11c15a548fd6d7055f35d7c2--

--===============6678429167680194814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6678429167680194814==--
