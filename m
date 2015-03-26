From: =?iso-8859-1?Q?Steffen_W_S=F8rensen?= <stefws-BUHhN+a2lJ4@public.gmane.org>
Subject: Re: more human readable log to track request or using
 mapreduce for data statistics
Date: Thu, 26 Mar 2015 09:38:31 +0100
Message-ID: <73DF3172-2821-4BEC-B13F-064080FA9D93@me.com>
References: <CANE=7sXgs9qd_3o7zT6RempoVmc2SfgG8qDZeVKO-77oPvkTzw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/mixed; boundary="===============1434810006=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-reply-to: <CANE=7sXgs9qd_3o7zT6RempoVmc2SfgG8qDZeVKO-77oPvkTzw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?utf-8?B?5rGg5L+h5rO9?= <xmdxcxz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1434810006==
Content-type: multipart/signed;
 boundary="Apple-Mail=_D00B661C-E94E-4E9B-9434-EDFF727170F6";
 protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_D00B661C-E94E-4E9B-9434-EDFF727170F6
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_4A3DA559-EB7F-4BA1-83A0-CFEF3DCC4402"


--Apple-Mail=_4A3DA559-EB7F-4BA1-83A0-CFEF3DCC4402
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


On 26/03/2015, at 09.05, =E6=B1=A0=E4=BF=A1=E6=B3=BD <xmdxcxz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:

> hi=EF=BC=8Cceph:
>=20
> Currently, the command =E2=80=9Dceph --admin-daemon
> /var/run/ceph/ceph-osd.0.asok dump_historic_ops=E2=80=9C may return as =
below:
>=20
> { "description": "osd_op(client.4436.1:11617
> rb.0.1153.6b8b4567.000000000192 [] 2.8eb4757c ondisk+write e92)",
>          "received_at": "2015-03-25 19:41:47.146145",
>          "age": "2.186521",
>          "duration": "1.237882",
>          "type_data": [
>                "commit sent; apply or cleanup",
>                { "client": "client.4436",
>                  "tid": 11617},
>                [
>                    { "time": "2015-03-25 19:41:47.150803",
>                      "event": "event1"},
>                    { "time": "2015-03-25 19:41:47.150873",
>                      "event": "event2"},
>                    { "time": "2015-03-25 19:41:47.150895",
>                      "event": "event3"},
>                    { "time": "2015-03-25 19:41:48.384027",
>                      "event": "event4"}]]}
Seems like JSON format
So consider doing your custom conversion by some means of CLI
convert json format to string

>=20
> I think this message is not so suitable for grep log or using
> mapreduce for data statistics. Such as, I want to know
> the write request avg latency for each rbd everyday. If we could
> output the all latency in just one line, it would be very easy to
> achieve it.
>=20
> Such as, the output log maybe something like this:
> 2015-03-26 03:30:53.859759 osd=3Dosd.0 pg=3D2.11 =
op=3D(client.4436.1:11617
> rb.0.1153.6b8b4567.000000000192 [] 2.8eb4757c ondisk+write e92)
> received_at=3D1427355253 age=3D2.186521 duration=3D1.237882 tid=3D11617
> client=3Dclient.4436 event1=3D20ms event2=3D300ms event3=3D400ms =
event4=3D100ms.
>=20
> The above:
>=20
> duration means: the time between (reply_to_client_stamp -
> request_received_stamp)
> event1 means: the time between (the event1_stamp - =
request_received_stamp)
> ...
> event4 means: the time between (the event4_stamp - =
request_received_stamp)
>=20
> Now, If we output the every log as above. it would be every easy to
> know the write request avg latency for each rbd everyday.
> Or if I use grep it is more easy to find out which stage is the =
bottleneck.
>=20
> --=20
> Regards,
> xinze
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--Apple-Mail=_4A3DA559-EB7F-4BA1-83A0-CFEF3DCC4402
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br><div><div>On 26/03/2015, at 09.05, =E6=B1=A0=E4=BF=
=A1=E6=B3=BD &lt;<a =
href=3D"mailto:xmdxcxz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">xmdxcxz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite">hi=EF=BC=8Cceph:<br><br>Currently, the command =E2=80=9Dceph=
 --admin-daemon<br>/var/run/ceph/ceph-osd.0.asok dump_historic_ops=E2=80=9C=
 may return as below:<br><br>{ "description": =
"osd_op(client.4436.1:11617<br>rb.0.1153.6b8b4567.000000000192 [] =
2.8eb4757c ondisk+write e92)",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"received_at": =
"2015-03-25 19:41:47.146145",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"age": =
"2.186521",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"duration": =
"1.237882",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"type_data": [<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;"commit sent; apply or cleanup",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;{ "client": "client.4436",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;"tid": 11617},<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;[<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ "time": "2015-03-25 =
19:41:47.150803",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"event": =
"event1"},<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ "time": "2015-03-25 =
19:41:47.150873",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"event": =
"event2"},<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ "time": "2015-03-25 =
19:41:47.150895",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"event": =
"event3"},<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ "time": "2015-03-25 =
19:41:48.384027",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"event": =
"event4"}]]}<br></blockquote>Seems like&nbsp;<a =
href=3D"http://en.wikipedia.org/wiki/JSON">JSON format</a></div><div>So =
consider doing your custom conversion by some means of CLI</div><div><a =
href=3D"https://www.google.dk/search?q=3Dconvert+json+format+to+string">co=
nvert json format to string</a></div><div><br><blockquote =
type=3D"cite"><br>I think this message is not so suitable for grep log =
or using<br>mapreduce for data statistics. Such as, I want to =
know<br>the write request avg latency for each rbd everyday. If we =
could<br>output the all latency in just one line, it would be very easy =
to<br>achieve it.<br><br>Such as, the output log maybe something like =
this:<br>2015-03-26 03:30:53.859759 osd=3Dosd.0 pg=3D2.11 =
op=3D(client.4436.1:11617<br>rb.0.1153.6b8b4567.000000000192 [] =
2.8eb4757c ondisk+write e92)<br>received_at=3D1427355253 age=3D2.186521 =
duration=3D1.237882 tid=3D11617<br>client=3Dclient.4436 event1=3D20ms =
event2=3D300ms event3=3D400ms event4=3D100ms.<br><br>The =
above:<br><br>duration means: the time between (reply_to_client_stamp =
-<br>request_received_stamp)<br>event1 means: the time between (the =
event1_stamp - request_received_stamp)<br>...<br>event4 means: the time =
between (the event4_stamp - request_received_stamp)<br><br>Now, If we =
output the every log as above. it would be every easy to<br>know the =
write request avg latency for each rbd everyday.<br>Or if I use grep it =
is more easy to find out which stage is the bottleneck.<br><br>-- =
<br>Regards,<br>xinze<br>_______________________________________________<b=
r>ceph-users mailing list<br><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br=
>http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br></blockquote></=
div><br></body></html>=

--Apple-Mail=_4A3DA559-EB7F-4BA1-83A0-CFEF3DCC4402--

--Apple-Mail=_D00B661C-E94E-4E9B-9434-EDFF727170F6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlUTxYcACgkQOgahJBjB1txgFgCfYP6lBZV3/vJ+a3TZULZJpxsZ
KbgAnRy4yOKPpJjsEBTy3e/ipTjrnb2j
=8B8s
-----END PGP SIGNATURE-----

--Apple-Mail=_D00B661C-E94E-4E9B-9434-EDFF727170F6--

--===============1434810006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1434810006==--
