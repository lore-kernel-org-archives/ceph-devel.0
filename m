From: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Tue, 12 Sep 2017 09:52:00 +1000
Message-ID: <CA+z5DsynZUK9qD4Ad_JfHGspC-B32dxy+GM6WzWC130Low1Asw@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6723882976309152056=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============6723882976309152056==
Content-Type: multipart/alternative; boundary="94eb2c0988eeed8ae40558f29c2e"

--94eb2c0988eeed8ae40558f29c2e
Content-Type: text/plain; charset="UTF-8"

On 7 September 2017 at 01:23, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> * Drop the odd releases, and aim for a ~9 month cadence. This splits the
> difference between the current even/odd pattern we've been doing.
>
> + eliminate the confusing odd releases with dubious value
> + waiting for the next release isn't quite as bad
> - required upgrades every 9 months instead of ever 12 months
>
> * Drop the odd releases, but relax the "must upgrade through every LTS" to
> allow upgrades across 2 versions (e.g., luminous -> mimic or luminous ->
> nautilus). Shorten release cycle (~6-9 months).
>
> + more flexibility for users
> + downstreams have greater choice in adopting an upstrema release
> - more LTS branches to maintain
> - more upgrade paths to consider
>
> Other options we should consider? Other thoughts?

We currently use both upstream and distro (RHCS) versions on different
clusters. Downstream releases are still free to apply their own models.

I like the idea of a predictable (and more regular) train model (and I'd
point out that trains can run a little late - there just needs to be some
process around that.

If you were to keep the even/odd release model then I'd suggest considering
a 4 monthly train cadence on these. If the even/odd model is dropped (which
would be my preference) then I like the sound of ~9 monthly releases
splitting the difference between today's model. OpenStack does 6 monthly
cycles, and I think the data shows this is too frequent for most operators
(of course OpenStack is much more complex an multifaceted as well) - many
deployments are well behind the stable deprecation schedule and it's the
norm to hear people talking about doing "skip upgrades".

-- 
Cheers,
~Blairo

--94eb2c0988eeed8ae40558f29c2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">On 7 September 2017 at 01:23, Sage Weil &lt;<a href=3D"ma=
ilto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>&gt; * Drop the o=
dd releases, and aim for a ~9 month cadence. This splits the<br>&gt; differ=
ence between the current even/odd pattern we&#39;ve been doing.<br>&gt;<br>=
&gt;   + eliminate the confusing odd releases with dubious value<br>&gt;   =
+ waiting for the next release isn&#39;t quite as bad<br>&gt;   - required =
upgrades every 9 months instead of ever 12 months<br>&gt;<br>&gt; * Drop th=
e odd releases, but relax the &quot;must upgrade through every LTS&quot; to=
<br>&gt; allow upgrades across 2 versions (e.g., luminous -&gt; mimic or lu=
minous -&gt;<br>&gt; nautilus).  Shorten release cycle (~6-9 months).<br>&g=
t;<br>&gt;   + more flexibility for users<br>&gt;   + downstreams have grea=
ter choice in adopting an upstrema release<br>&gt;   - more LTS branches to=
 maintain<br>&gt;   - more upgrade paths to consider<br>&gt;<br>&gt; Other =
options we should consider?  Other thoughts?<br><br>We currently use both u=
pstream and distro (RHCS) versions on different clusters. Downstream releas=
es are still free to apply their own models.<br><br>I like the idea of a pr=
edictable (and more regular) train model (and I&#39;d point out that trains=
 can run a little late - there just needs to be some process around that.<b=
r><br>If you were to keep the even/odd release model then I&#39;d suggest c=
onsidering a 4 monthly train cadence on these. If the even/odd model is dro=
pped (which would be my preference) then I like the sound of ~9 monthly rel=
eases splitting the difference between today&#39;s model. OpenStack does 6 =
monthly cycles, and I think the data shows this is too frequent for most op=
erators (of course OpenStack is much more complex an multifaceted as well) =
- many deployments are well behind the stable deprecation schedule and it&#=
39;s the norm to hear people talking about doing &quot;skip upgrades&quot;.=
<div dir=3D"auto"><br>-- <br>Cheers,<br>~Blairo</div></div>

--94eb2c0988eeed8ae40558f29c2e--

--===============6723882976309152056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6723882976309152056==--
