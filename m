From: =?utf-8?Q?Steffen_W_S=C3=B8rensen?= <stefws-BUHhN+a2lJ4@public.gmane.org>
Subject: Re: [ceph-calamari] Does anyone understand Calamari??
Date: Wed, 13 May 2015 12:55:06 +0200
Message-ID: <F5A37530-68AB-47D7-A862-38B9578D09FD@me.com>
References: <7E8CF9C16F722345A89076330719CB1F4A82525D@EXMAIL1.taec.toshiba.com>
	<607C9580-DF69-4CA0-9D65-550700893CA8@redhat.com>
	<7E8CF9C16F722345A89076330719CB1F4A825343@EXMAIL1.taec.toshiba.com>
	<95DFDC74-A336-46C4-B72E-24E9747CDD6F@redhat.com>
	<7E8CF9C16F722345A89076330719CB1F4A8253D3@EXMAIL1.taec.toshiba.com>
	<D363AFC4-84C1-42EB-A5F0-792A88B685C4@redhat.com>
	<666078A3-277A-4442-B2E4-29774B8470BB@me.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: multipart/mixed; boundary="===============1499416224=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-reply-to: <666078A3-277A-4442-B2E4-29774B8470BB-BUHhN+a2lJ4@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Meno <gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel (ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1499416224==
Content-type: multipart/alternative;
 boundary="Apple-Mail=_3844D6AA-0BEA-4A5C-9867-339728601761"


--Apple-Mail=_3844D6AA-0BEA-4A5C-9867-339728601761
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 13/05/2015, at 11.23, Steffen W S=C3=B8rensen <stefws-BUHhN+a2lJ4@public.gmane.org> =
wrote:
>=20
>=20
>> On 13/05/2015, at 04.08, Gregory Meno <gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org =
<mailto:gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>> wrote:
>>=20
>> Ideally I would like everything in /var/log/calmari
>>=20
>> be sure to set calamari.conf like so:
>> [shadow_man@vpm107 ~]$ grep DEBUG /etc/calamari/calamari.conf=20
>> log_level =3D DEBUG
>> db_log_level =3D DEBUG
>> log_level =3D DEBUG
>>=20
>> then restart cthulhu and apache
>>=20
>> visit http://essperf3/api/v2/cluster <http://essperf3/api/v2/cluster>
>> and http://essperf3 <http://essperf3/>
>>=20
>> and then share the logs here. Hopefully something obvious will be off =
in either calamari or cthulhu log
>=20
> Since I got similar issue, I sneak my log data in here as well, no =
offence=E2=80=A6
=E2=80=A6 had similar issue, dunno what changed, but just but revisiting =
our calamari UI, it seems to be working again=E2=80=A6 knowing of our =
cluster at least :)
only it=E2=80=99ll not update [health] state, which seems stuck, but IO =
and other stats are updated fine.



--Apple-Mail=_3844D6AA-0BEA-4A5C-9867-339728601761
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 13/05/2015, at 11.23, Steffen W S=C3=B8rensen &lt;<a =
href=3D"mailto:stefws-BUHhN+a2lJ4@public.gmane.org" class=3D"">stefws-BUHhN+a2lJ4@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><meta =
http-equiv=3D"Content-Type" content=3D"text/html charset=3Dutf-8" =
class=3D""><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space;" class=3D""><br =
class=3D""><div class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 13/05/2015, at 04.08, Gregory Meno &lt;<a =
href=3D"mailto:gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" class=3D"">gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div =
class=3D"">Ideally I would like everything in /var/log/calmari<br =
class=3D""><br class=3D"">be sure to set calamari.conf like so:<br =
class=3D"">[shadow_man@vpm107 ~]$ grep DEBUG /etc/calamari/calamari.conf =
<br class=3D"">log_level =3D DEBUG<br class=3D"">db_log_level =3D =
DEBUG<br class=3D"">log_level =3D DEBUG<br class=3D""><br class=3D"">then =
restart cthulhu and apache<br class=3D""><br class=3D"">visit <a =
href=3D"http://essperf3/api/v2/cluster" =
class=3D"">http://essperf3/api/v2/cluster</a><br class=3D"">and <a =
href=3D"http://essperf3/" class=3D"">http://essperf3</a><br class=3D""><br=
 class=3D"">and then share the logs here. Hopefully something obvious =
will be off in either calamari or cthulhu log<br =
class=3D""></div></blockquote></div><div class=3D"">Since I got similar =
issue, I sneak my log data in here as well, no =
offence=E2=80=A6</div></div></div></blockquote>=E2=80=A6 had similar =
issue, dunno what changed, but just but revisiting our calamari UI, it =
seems to be working again=E2=80=A6 knowing of our cluster at least =
:)</div><div>only it=E2=80=99ll not update [health] state, which seems =
stuck, but IO and other stats are updated fine.</div><div><br =
class=3D""></div><br class=3D""></body></html>=

--Apple-Mail=_3844D6AA-0BEA-4A5C-9867-339728601761--

--===============1499416224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1499416224==--
