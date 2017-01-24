From: Mike Lovell <mike.lovell-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>
Subject: Re: Issue with upgrade from 0.94.9 to 10.2.5
Date: Mon, 23 Jan 2017 19:57:34 -0700
Message-ID: <CAK9wOaBS9VrrbQoSu65=Cm4rmenwYjODEH5epP+31XC8+pOUew@mail.gmail.com>
References: <9fd022a0-d09e-b3ff-ce5c-f55d5b2d1167@corp.ovh.com>
	<b51dfc8f-eae7-8dc5-6e68-dcaa47f64f0e@corp.ovh.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0373544131=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <b51dfc8f-eae7-8dc5-6e68-dcaa47f64f0e-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0373544131==
Content-Type: multipart/alternative; boundary=001a1136fd142c567b0546ce4738

--001a1136fd142c567b0546ce4738
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

i was just testing an upgrade of some monitors in a test cluster from
hammer (0.94.7) to jewel (10.2.5). after upgrade each of the first two
monitors, i stopped and restarted a single osd to cause changes in the
maps. the same error messages showed up in ceph -w. i haven't dug into it
much but just wanted to second that i've seen this happen on a recent
hammer to recent jewel upgrade.

mike

On Wed, Jan 18, 2017 at 4:25 AM, Piotr Da=C5=82ek <piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org=
>
wrote:

> On 01/17/2017 12:52 PM, Piotr Da=C5=82ek wrote:
>
>> During our testing we found out that during upgrade from 0.94.9 to 10.2.=
5
>> we're hitting issue http://tracker.ceph.com/issues/17386 ("Upgrading
>> 0.94.6
>> -> 0.94.9 saturating mon node networking"). Apparently, there's a few
>> commits for both hammer and jewel which are supposed to fix this issue f=
or
>> upgrades from 0.94.6 to 0.94.9 (and possibly for others), but we're stil=
l
>> seeing this upgrading to Jewel, and symptoms are exactly same - after
>> upgrading MONs, each not yet upgraded OSD takes full OSDMap from monitor=
s
>> after failing the CRC check. Anyone else encountered this?
>>
>
> http://tracker.ceph.com/issues/18582
>
> --
> Piotr Da=C5=82ek
> piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org
> https://www.ovh.com/us/
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a1136fd142c567b0546ce4738
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">i was just testing an upgrade of some monitors in a test c=
luster from hammer (0.94.7) to jewel (10.2.5). after upgrade each of the fi=
rst two monitors, i stopped and restarted a single osd to cause changes in =
the maps. the same error messages showed up in ceph -w. i haven&#39;t dug i=
nto it much but just wanted to second that i&#39;ve seen this happen on a r=
ecent hammer to recent jewel upgrade.<div><br></div><div>mike</div></div><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jan 18, 201=
7 at 4:25 AM, Piotr Da=C5=82ek <span dir=3D"ltr">&lt;<a href=3D"mailto:piot=
r.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org" target=3D"_blank">piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 01/17/201=
7 12:52 PM, Piotr Da=C5=82ek wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
During our testing we found out that during upgrade from 0.94.9 to 10.2.5<b=
r>
we&#39;re hitting issue <a href=3D"http://tracker.ceph.com/issues/17386" re=
l=3D"noreferrer" target=3D"_blank">http://tracker.ceph.com/issues<wbr>/1738=
6</a> (&quot;Upgrading 0.94.6<br>
-&gt; 0.94.9 saturating mon node networking&quot;). Apparently, there&#39;s=
 a few<br>
commits for both hammer and jewel which are supposed to fix this issue for<=
br>
upgrades from 0.94.6 to 0.94.9 (and possibly for others), but we&#39;re sti=
ll<br>
seeing this upgrading to Jewel, and symptoms are exactly same - after<br>
upgrading MONs, each not yet upgraded OSD takes full OSDMap from monitors<b=
r>
after failing the CRC check. Anyone else encountered this?<br>
</blockquote>
<br>
</span><a href=3D"http://tracker.ceph.com/issues/18582" rel=3D"noreferrer" =
target=3D"_blank">http://tracker.ceph.com/issues<wbr>/18582</a><span class=
=3D""><br>
<br>
-- <br>
Piotr Da=C5=82ek<br>
<a href=3D"mailto:piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org" target=3D"_blank">piotr.dalek@c=
orp.ovh.com</a><br>
<a href=3D"https://www.ovh.com/us/" rel=3D"noreferrer" target=3D"_blank">ht=
tps://www.ovh.com/us/</a><br></span>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
</blockquote></div><br></div>

--001a1136fd142c567b0546ce4738--

--===============0373544131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0373544131==--
