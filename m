From: Karan Singh <karan.singh-Gn+qtVAUx6s@public.gmane.org>
Subject: Re: Ceph Dumpling/Firefly/Hammer SSD/Memstore
	performance comparison
Date: Tue, 17 Feb 2015 22:25:14 +0200
Message-ID: <BC41E825-12FA-4FD0-AD3A-8D30E81B7D3F@csc.fi>
References: <54E37C3D.5030702@redhat.com>
	<CANPbtN830yy7AJ6ziWr7V7sN80vHobpy7j8XwGpFizhd7fJynQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: multipart/mixed; boundary="===============0349678863=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANPbtN830yy7AJ6ziWr7V7sN80vHobpy7j8XwGpFizhd7fJynQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============0349678863==
Content-Type: multipart/signed; boundary="Apple-Mail=_4BC57425-DB8A-4DAC-9F3F-51FB646A5A1A"; protocol="application/pkcs7-signature"; micalg=sha1


--Apple-Mail=_4BC57425-DB8A-4DAC-9F3F-51FB646A5A1A
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_D56BB6B9-3264-497D-8C27-101AD50D2591"


--Apple-Mail=_D56BB6B9-3264-497D-8C27-101AD50D2591
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Thanks Mark , for a superb explanation . This is indeed very useful.

****************************************************************
Karan Singh=20
Systems Specialist , Storage Platforms
CSC - IT Center for Science,
Keilaranta 14, P. O. Box 405, FIN-02101 Espoo, Finland
mobile: +358 503 812758
tel. +358 9 4572001
fax +358 9 4572302
http://www.csc.fi/
****************************************************************

> On 17 Feb 2015, at 22:16, Stephen Hindle <shindle-zIyXdg6N6CA@public.gmane.org> wrote:
>=20
> I was wondering what the 'CBT' tool is ?  Google is useless for that =
acronym...
>=20
> Thanks!
> Steve
>=20
> On Tue, Feb 17, 2015 at 10:37 AM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> =
wrote:
>> Hi All,
>>=20
>> I wrote up a short document describing some tests I ran recently to =
look at
>> how SSD backed OSD performance has changed across our LTS releases. =
This is
>> just looking at RADOS performance and not RBD or RGW.  It also =
doesn't offer
>> any real explanations regarding the results.  It's just a first high =
level
>> step toward understanding some of the behaviors folks on the mailing =
list
>> have reported over the last couple of releases.  I hope you find it =
useful.
>>=20
>> Mark
>>=20
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>=20
>=20
> --=20
> The information in this message may be confidential.  It is intended =
solely=20
> for
> the addressee(s).  If you are not the intended recipient, any =
disclosure,
> copying or distribution of the message, or any action or omission =
taken by=20
> you
> in reliance on it, is prohibited and may be unlawful.  Please =
immediately
> contact the sender if you have received this message in error.
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--Apple-Mail=_D56BB6B9-3264-497D-8C27-101AD50D2591
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Thanks Mark , for a superb explanation . This is indeed very =
useful.<div class=3D""><div apple-content-edited=3D"true" class=3D"">
<div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><br =
class=3D"Apple-interchange-newline">**************************************=
**************************</div><div style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Karan Singh&nbsp;</div><div style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Systems Specialist ,&nbsp;Storage Platforms</div><div =
style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D"">CSC - IT Center for Science,</div><div =
style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D"">Keilaranta 14, P. O. Box 405, FIN-02101 =
Espoo, Finland<br class=3D"">mobile: +358 503 812758<br class=3D"">tel. =
+358 9 4572001<br class=3D"">fax +358 9 4572302<br class=3D""><a =
href=3D"http://www.csc.fi/" class=3D"">http://www.csc.fi/</a></div><div =
style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" =
class=3D"">***************************************************************=
*</div></div></div>
</div>
<br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 17 Feb 2015, at 22:16, Stephen Hindle &lt;<a =
href=3D"mailto:shindle-zIyXdg6N6CA@public.gmane.org" class=3D"">shindle-zIyXdg6N6CA@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D"">I =
was wondering what the 'CBT' tool is ? &nbsp;Google is useless for that =
acronym...<br class=3D""><br class=3D"">Thanks!<br class=3D"">Steve<br =
class=3D""><br class=3D"">On Tue, Feb 17, 2015 at 10:37 AM, Mark Nelson =
&lt;<a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" =
class=3D"">mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br class=3D""><blockquote =
type=3D"cite" class=3D"">Hi All,<br class=3D""><br class=3D"">I wrote up =
a short document describing some tests I ran recently to look at<br =
class=3D"">how SSD backed OSD performance has changed across our LTS =
releases. This is<br class=3D"">just looking at RADOS performance and =
not RBD or RGW. &nbsp;It also doesn't offer<br class=3D"">any real =
explanations regarding the results. &nbsp;It's just a first high =
level<br class=3D"">step toward understanding some of the behaviors =
folks on the mailing list<br class=3D"">have reported over the last =
couple of releases. &nbsp;I hope you find it useful.<br class=3D""><br =
class=3D"">Mark<br class=3D""><br =
class=3D"">_______________________________________________<br =
class=3D"">ceph-users mailing list<br class=3D""><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br =
class=3D""><br class=3D""></blockquote><br class=3D"">-- <br =
class=3D"">The information in this message may be confidential. &nbsp;It =
is intended solely <br class=3D"">for<br class=3D"">the addressee(s). =
&nbsp;If you are not the intended recipient, any disclosure,<br =
class=3D"">copying or distribution of the message, or any action or =
omission taken by <br class=3D"">you<br class=3D"">in reliance on it, is =
prohibited and may be unlawful. &nbsp;Please immediately<br =
class=3D"">contact the sender if you have received this message in =
error.<br class=3D""><br =
class=3D"">_______________________________________________<br =
class=3D"">ceph-users mailing list<br class=3D""><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br =
class=3D""></div></blockquote></div><br class=3D""></div></body></html>=

--Apple-Mail=_D56BB6B9-3264-497D-8C27-101AD50D2591--

--Apple-Mail=_4BC57425-DB8A-4DAC-9F3F-51FB646A5A1A
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOYjCCBJ0w
ggOFoAMCAQICEDQ96SusJzT/j8s0lPvMcFQwDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UEBhMCU0Ux
FDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0
d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0wNTA2MDcwODA5MTBa
Fw0yMDA1MzAxMDQ4MzhaMIGuMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNVBAcTDlNh
bHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxITAfBgNVBAsTGGh0
dHA6Ly93d3cudXNlcnRydXN0LmNvbTE2MDQGA1UEAxMtVVROLVVTRVJGaXJzdC1DbGllbnQgQXV0
aGVudGljYXRpb24gYW5kIEVtYWlsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsjmF
pPJ9q0E7YkY3rs3BYHW8OWX5ShpHornMSMxqmNVNNRm5pELlzkniii8efNIxB8dOtINknS4p1aJk
xIW9hVE1eaROaJB7HHqkkqgX8pgV8pPMyaQylbsMTzC9mKALi+VuG6JG+ni8om+rWV6lL8/K2m2q
L+usobNqqrcuZzWLeeEeaYji5kbNoKXqvgvOdjp6Dpvq/NonWz1zHyLmSGHGTPNpsaguG7bUMSAs
vIKKjqQOpdeJQ/wWWq8dcdcRWdq6hw2v+vPhwvCkxWeM1tZUOt4KpLoDd7NlyP0e03RiqhjKaJMe
oYV+9Udly/hNVyh00jT/MLbu9mIwFIws6wIDAQABo4H0MIHxMB8GA1UdIwQYMBaAFK29mHo0tCb3
+sQmVO8DveAky1QaMB0GA1UdDgQWBBSJgmd9xJ0mcABLtFBIfN49rgRufTAOBgNVHQ8BAf8EBAMC
AQYwDwYDVR0TAQH/BAUwAwEB/zARBgNVHSAECjAIMAYGBFUdIAAwRAYDVR0fBD0wOzA5oDegNYYz
aHR0cDovL2NybC51c2VydHJ1c3QuY29tL0FkZFRydXN0RXh0ZXJuYWxDQVJvb3QuY3JsMDUGCCsG
AQUFBwEBBCkwJzAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG
9w0BAQUFAAOCAQEAAbyc42MosPMxAcLfe91ioAGdIzEPnJJzU1HqH0z61p/Eyi9nfngzD3QWuZGH
kfWKJvpkcADYHvkLBGJQh5OB1Nr1I9s0u4VWtHA0bniDNx6FHMURFZJfhxe9rGr98cLRzIlfsXzw
PlHyNfN87GCYazor4O/fs32G67Ub9VvsonyYE9cAULnRLXPeA3h04QWFMV7LmrmdlMa5lDd1ctxE
+2fo8PolHlKn2iXpR+CgxzygTrEKNvt3SJ/vl4r7tP7jlBSog7xcLT/SYHFg7sJxggzpiDbj2iC0
o6BsqpZLuICOdcpJB/Y7FLrf3AXZn9vgsuZNoHgm5+ctbn9fxh6IFTCCBNowggPCoAMCAQICEF3/
UOr+D1NGiJ+AQY/nQsgwDQYJKoZIhvcNAQEFBQAwga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJV
VDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29y
azEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNFUkZp
cnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwHhcNMDkwNTE4MDAwMDAwWhcNMjgx
MjMxMjM1OTU5WjBEMQswCQYDVQQGEwJOTDEPMA0GA1UEChMGVEVSRU5BMSQwIgYDVQQDExtURVJF
TkEgZVNjaWVuY2UgUGVyc29uYWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDE
vCV9ze9ZBKt0Jym2Y4rvxDVwoUYIr25QmxtxeJcChcA1/5AYEWb6MzkUnqQS9z3uBSyB5/ctLjZ4
Qw45tn96dMPLVT8vs8vDN2rhlQMjG7MimBODWDBfrDyRRdNtCy7L0ZFhsspx+sKJDHsJ1pK/o4EX
EVUg3zeBnx4mCR3SFxlDy4uZJXRBW+YyKtCnU9zSIY3Nkc97bPTJ/tDl0gZrGmFCG4CRB9wUSSc7
Coqy4jtpCITLgZnXuhQf2H6SY732LTH6lU7NNg2Z7xG6rUr7qMR4uXxaPsj1CDLAqQXHjBoojzC6
F6PxueIHp7j7Vb+fYlrVFA8ItBOZ0hJ5WvD9AgMBAAGjggFbMIIBVzAfBgNVHSMEGDAWgBSJgmd9
xJ0mcABLtFBIfN49rgRufTAdBgNVHQ4EFgQUyIlzmaddURZTRVR8o8I5fMvXqoEwDgYDVR0PAQH/
BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8CAQAwJgYDVR0gBB8wHTANBgsrBgEEAbIxAQICHTAMBgoq
hkiG90wFAgIFMFgGA1UdHwRRME8wTaBLoEmGR2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VVE4t
VVNFUkZpcnN0LUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kRW1haWwuY3JsMG8GCCsGAQUFBwEBBGMw
YTA4BggrBgEFBQcwAoYsaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VUTkFBQUNsaWVudF9DQS5j
cnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEFBQAD
ggEBAAgXpBz5FWuwGWFvoEjjeiTvQVWaoFBw2CPVU4ZKZ47o2lYWGCwbGCGJupgk7lY04xeGJr0h
WtQZk0rqYXRNtsSEjUfuyi5lbTaTmLHikmaI4k57dcdeRGkh3BJqMPxhgP4P8J3S3H6u5cJTTQtw
g2FWRfs933L2AkJ164iKmFdg9Z+ickmxej5BZzXDVSsNBzXoxivVuod5gHTnkja9RoF6Liniar7h
FxM1fBakJTMvYe7OyVLgQNvTvjlaz89MFOV/xUNXi025Wo7CDwZN3shJnYFzuuQ/mKWTPFlO25s1
3/5Nv1Wh6WTDRXysj3xH0TrxTnXZkGdA6LEvnhcvXDUwggTfMIIDx6ADAgECAhB37ILErqxVSnc1
ePJuNvJXMA0GCSqGSIb3DQEBBQUAMEQxCzAJBgNVBAYTAk5MMQ8wDQYDVQQKEwZURVJFTkExJDAi
BgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQTAeFw0xNDEwMzEwMDAwMDBaFw0xNTEx
MzAyMzU5NTlaMIGBMRMwEQYKCZImiZPyLGQBGRYDb3JnMRYwFAYKCZImiZPyLGQBGRYGdGVyZW5h
MRMwEQYKCZImiZPyLGQBGRYDdGNzMQswCQYDVQQGEwJGSTEMMAoGA1UEChMDQ1NDMSIwIAYDVQQD
FBlLYXJhbiBTaW5naCBrc2luZ2hAY3NjLmZpMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAua9GMiJ0pEMcMKOmNjldVeaFJyc34XPDGw3hYcBicv68bX7Ov+7XP0+s1zA4vw7M/oK9GXWn
nojVY7jR30saS4Z+DpS/7gY3yp/tGLCXZAhtn8ehOwx32pgsMQVUV55L7U7AEcJ4cunuU9Gqf25z
yqN4y6yeTYw1k5+ny+a9qBJjQMSAWatYnNBBN7BFawzL1a9/VnPvy7IkhKzQfAS6lCiuvxDZvG/z
tr1RgDXyX0JVya0B8XHO2wU3xVrJtF3K4g2I9DSYR05X2sjHa6wiXFvItZriQz2AjE6dOmvRW53E
4U5AyQRaY06oy5HlN9IaINKJ3WVf+5il9JoAZN68gwIDAQABo4IBjTCCAYkwHwYDVR0jBBgwFoAU
yIlzmaddURZTRVR8o8I5fMvXqoEwHQYDVR0OBBYEFMz+qQQcnAbKsqYs4UdOaFeQVxyYMA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjAm
BgNVHSAEHzAdMA0GCysGAQQBsjEBAgIdMAwGCiqGSIb3TAUCAgUwRwYDVR0fBEAwPjA8oDqgOIY2
aHR0cDovL2NybC50Y3MudGVyZW5hLm9yZy9URVJFTkFlU2NpZW5jZVBlcnNvbmFsQ0EuY3JsMHoG
CCsGAQUFBwEBBG4wbDBCBggrBgEFBQcwAoY2aHR0cDovL2NydC50Y3MudGVyZW5hLm9yZy9URVJF
TkFlU2NpZW5jZVBlcnNvbmFsQ0EuY3J0MCYGCCsGAQUFBzABhhpodHRwOi8vb2NzcC50Y3MudGVy
ZW5hLm9yZzAdBgNVHREEFjAUgRJrYXJhbi5zaW5naEBjc2MuZmkwDQYJKoZIhvcNAQEFBQADggEB
AKCP9egRCcShcjER4mSD0ziLoVVML8PF/NxEAG3x05LBSB/dSORR4qOz4RSQLRFOYCikc2RFjPrA
eQysx0KDp41tatPwmYgOrhcOaBVRhlvM4XpLLaqtDGTPzMrQQBDwAMaxIit2c4WtJ7EJippoWC8y
f/Xfs/ltDhD3FWsu+WSROHKRh1Cilix/03kk0f7qFjNZsEutSyo2tTeJgZwBUCLiWFMUBnqXESBJ
ZEnAPae4cKlpoTK+ib7njo5ePf7FFZBiLJgmCO3rGDU4NKgxCr25JmNVtxbaBz9jvag6eNoBsz7t
reCdKGTaqRvCK4fvpG1QhP3/73Ao0ZkqsDznIXoxggK0MIICsAIBATBYMEQxCzAJBgNVBAYTAk5M
MQ8wDQYDVQQKEwZURVJFTkExJDAiBgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQQIQ
d+yCxK6sVUp3NXjybjbyVzAJBgUrDgMCGgUAoIIBMTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0xNTAyMTcyMDI1MTRaMCMGCSqGSIb3DQEJBDEWBBQBi6WyoMY8T8lT
4pCI2pKFkhaqFDBnBgkrBgEEAYI3EAQxWjBYMEQxCzAJBgNVBAYTAk5MMQ8wDQYDVQQKEwZURVJF
TkExJDAiBgNVBAMTG1RFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQQIQd+yCxK6sVUp3NXjybjby
VzBpBgsqhkiG9w0BCRACCzFaoFgwRDELMAkGA1UEBhMCTkwxDzANBgNVBAoTBlRFUkVOQTEkMCIG
A1UEAxMbVEVSRU5BIGVTY2llbmNlIFBlcnNvbmFsIENBAhB37ILErqxVSnc1ePJuNvJXMA0GCSqG
SIb3DQEBAQUABIIBACGv4nn1TlSLoccq9Us8AVx1I1/mH0lu9PYIWHIHVgywBes5TbR8mh1Dyoq0
Mz0PCTKoJti/1Mi0Oi/EuPDnV8H7lczK+CyXne8HoUG4wtMh/cFKbEA11xKwREj4/xcxJjN8jR1L
vlseHzBcnWZPfyVlyzx7f1FmIBjSusucXsLxB4XRDdIQvt7PplmXLCaGY5FX6SMPvv/KSdE29wwL
pBKZP2x5ImYR+tNP6+dEcDAFHcUYWpS3F/cwOp43PvqbQHsV+U44hPkkG7P61TteRF6fcdGPcBJB
T/pgirO8Lq73Od2/7Gjj8POv+/jhZgxN8zYuaYd/UhpabdtfVfL73iMAAAAAAAA=
--Apple-Mail=_4BC57425-DB8A-4DAC-9F3F-51FB646A5A1A--

--===============0349678863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0349678863==--
