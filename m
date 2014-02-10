From: Kurt Bauer <kurt.bauer-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org>
Subject: Re: Kernel rbd & cephx signatures
Date: Mon, 10 Feb 2014 09:04:10 +0100
Message-ID: <52F887FA.7000901@univie.ac.at>
References: <52F3A32E.1080507@univie.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1869224200=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <52F3A32E.1080507-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a cryptographically signed message in MIME format.

--===============1869224200==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060405080509090900020607"

This is a cryptographically signed message in MIME format.

--------------ms060405080509090900020607
Content-Type: multipart/alternative;
 boundary="------------070406010204010203070502"

This is a multi-part message in MIME format.
--------------070406010204010203070502
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

I found two maybe related bugs in the tracker (#4287, #3657) but both
are resolved, so I'm wondering if there's spmething I'm doing wrong.
Has anybody sucessfully mapped rbd images with kernel rbd, when cephx
require signatures is set to true in the cluster?

Thanks for your help,
best regards,
Kurt

Kurt Bauer schrieb:
> Hi,
>
> I have to "open" our CEPH cluster for some clients, that only support
> kernel rbd. In general that's no problem and works just fine (verified
> in our test-cluster ;-) ). I then tried to map images from our
> production cluster and failed: rbd: add failed: (95) Operation not
> supported
> After some testing and comparing test and production cluster, it
> turned out that the config option, that hinders the kernel to map the
> image is cephx require signatures = true
> If I read the documentation
> (http://ceph.com/docs/master/rados/operations/authentication/#backward-compatibility)
> correctly that flag is recommended, which leads to two questions:
> 1. When will cephx signatures make it to kernel rbd (it's not there
> till at least 3.12.0 and I've found no reference in the changelogs of
> subsequent versions) ?
> 2. As I have to assess the risk when disabling cephx signatures, do
> you have some estimations how probable a "real life" attack is, ie.
> are there real threats for the whole infrastructure or is it "just"
> possible to disturb the communication of exactly that client in whose
> communicationmalicious messages are forced?
>
> Thanks a lot for your help,
> best regards,
> Kurt
>
> PS.: If my conclusion is correct, maybe that should be mentioned
> somewhere at http://ceph.com/docs/master/rbd/rbd-ko/
>
> -- 
> Kurt Bauer <kurt.bauer-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org>
> Vienna University Computer Center - ACOnet - VIX
> Universitaetsstrasse 7, A-1010 Vienna, Austria, Europe
> Tel: ++43 1 4277 - 14070 (Fax: - 814070)  KB1970-RIPE
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

-- 
Kurt Bauer <kurt.bauer-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org>
Vienna University Computer Center - ACOnet - VIX
Universitaetsstrasse 7, A-1010 Vienna, Austria, Europe
Tel: ++43 1 4277 - 14070 (Fax: - 9140)  KB1970-RIPE

--------------070406010204010203070502
Content-Type: text/html; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta content=3D"text/html; charset=3DISO-8859-15" http-equiv=3D"Content-=
Type">
</head><body bgcolor=3D"#FFFFFF" text=3D"#000000">Hi,<br>
<br>
I found two maybe related bugs in the tracker (#4287, #3657) but both=20
are resolved, so I'm wondering if there's spmething I'm doing wrong.<br>
Has anybody sucessfully mapped rbd images with kernel rbd, when cephx=20
require signatures is set to true in the cluster?<br>
<br>
Thanks for your help,<br>
best regards,<br>
Kurt<br>
<br>
Kurt Bauer schrieb:
<blockquote cite=3D"mid:52F3A32E.1080507-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org" type=3D"cite">
  <meta http-equiv=3D"content-type" content=3D"text/html;=20
charset=3DISO-8859-15">

Hi,<br>

  <br>

I have to "open" our CEPH cluster for some clients, that only support=20
kernel rbd. In general that's no problem and works just fine (verified=20
in our test-cluster ;-) ). I then tried to map images from our=20
production cluster and failed: <span style=3D"font-style: italic;">rbd:=20
add failed: (95) Operation not supported</span><br>

After some testing and comparing test and production cluster, it turned=20
out that the config option, that hinders the kernel to map the image is <=
span
 style=3D"font-style: italic;">cephx require signatures =3D true</span><b=
r>

If I read the documentation=20
(<a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext"=20
href=3D"http://ceph.com/docs/master/rados/operations/authentication/#back=
ward-compatibility">http://ceph.com/docs/master/rados/operations/authenti=
cation/#backward-compatibility</a>)
 correctly that flag is recommended, which leads to two questions:<br>

1. When will cephx signatures make it to kernel rbd (it's not there till
 at least 3.12.0 and I've found no reference in the changelogs of=20
subsequent versions) ?<br>

2. As I have to assess the risk when disabling cephx signatures, do you=20
have some estimations how probable a "real life" attack is, ie. are=20
there real threats for the whole infrastructure or is it "just" possible
 to disturb the communication of exactly that client in whose=20
communication<span> malicious messages are </span><span><span>forced</spa=
n></span><span>
 </span>?<br>

  <br>

Thanks a lot for your help,<br>

best regards,<br>

Kurt<br>

  <br>

PS.: If my conclusion is correct, maybe that should be mentioned=20
somewhere at <a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext" =

href=3D"http://ceph.com/docs/master/rbd/rbd-ko/">http://ceph.com/docs/mas=
ter/rbd/rbd-ko/</a><br>

  <br>

 =20
  <div class=3D"moz-signature">-- <br>Kurt Bauer=20
<a moz-do-not-send=3D"true" class=3D"moz-txt-link-rfc2396E"=20
href=3D"mailto:kurt.bauer-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org">&lt;kurt.bauer-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org&gt;</=
a><br>

Vienna University Computer Center - ACOnet - VIX<br>

Universitaetsstrasse 7, A-1010 Vienna, Austria, Europe<br>

Tel: ++43 1 4277 - 14070 (Fax: - 814070)=A0 KB1970-RIPE<br>

<br>
  </div>




  <pre wrap=3D"">_______________________________________________
ceph-users mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:ceph-users-idqoXFIVOFJ4Eiagz67IpQ@public.gmane.org=
h.com">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"http://lists.ceph.com/listinfo=
=2Ecgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users=
-ceph.com</a>
</pre>
</blockquote>
<br>
<div class=3D"moz-signature">-- <br><span>Kurt Bauer <a=20
class=3D"moz-txt-link-rfc2396E" href=3D"mailto:kurt.bauer-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org">&=
lt;kurt.bauer-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org&gt;</a>
<br>Vienna University Computer Center - ACOnet - VIX
<br>Universitaetsstrasse 7, A-1010 Vienna, Austria, Europe
<br>Tel: ++43 1 4277 - 14070 (Fax: - 9140)=A0 KB1970-RIPE<br>
</span></div>
</body></html>

--------------070406010204010203070502--

--------------ms060405080509090900020607
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISXTCC
BGYwggNOoAMCAQICEFEmCpMc4n+cw6VfeeByroIwDQYJKoZIhvcNAQEFBQAwgZMxCzAJBgNV
BAYTAlVTMQswCQYDVQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3Qu
Y29tMRswGQYDVQQDExJVVE4gLSBEQVRBQ29ycCBTR0MwHhcNMDUwNjA3MDgwOTEwWhcNMTkw
NjI0MTkwNjMwWjBvMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNV
BAsTHUFkZFRydXN0IEV4dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBF
eHRlcm5hbCBDQSBSb290MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt/caM+by
AAQtOeBOW+0fvGwPzbX6I7bO3psRM5ekKUx9k5+9SryT7QMa44/P5W1QWtaXKZRagLBJetsu
lf24yr83OC0ePpFBrXBWx/BPP+gynnTKyJBU6cZfD3idmkA8Dqxhql4Uj56HoWpQ3NeaTq8F
s6ZxlJxxs1BgCscTnTgHhgKo6ahpJhiQq0ywTyOrOk+E2N/On+Fpb7vXQtdrROTHre5tQV9y
WnEIN7N5ZaRZoJQ39wAvDcKSctrQOHLbFKhFxF0qfbe01sTurM0TRLfJK91DACX6Yblpalgj
EbenM49WdVn1zSnXRrcKK2W200JvFbK4e/vv6V1T1TRaJwIDAQABo4HYMIHVMB8GA1UdIwQY
MBaAFFMy0bPPf/rg8aBdhU6S0p5FHbRPMB0GA1UdDgQWBBStvZh6NLQm9/rEJlTvA73gJMtU
GjAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zARBglghkgBhvhCAQEEBAMCAQIw
IAYDVR0lBBkwFwYKKwYBBAGCNwoDAwYJYIZIAYb4QgQBMD0GA1UdHwQ2MDQwMqAwoC6GLGh0
dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VVE4tREFUQUNvcnBTR0MuY3JsMA0GCSqGSIb3DQEB
BQUAA4IBAQDG7lMXaBSyUSIekFgNlP298XDlhi3DNjGPVEhG5y0IN7xsCmDhDq1RNOASk+m+
uKu4JrTplj0oj65kB/7gAezF45HrGKDxdX7bCuafkduvrnXfI5Fo3RcAWkv/ZGxw6wEa0JDZ
x6bWbfYT5P+1ydIeKsuxJUMmeNkwm04NHr5p79/q/i2zzPmw3bUUypHUsrWl+wEZo0d5n52M
lYc0+B84kto2phH6a+tr6dxFeBU5BtdNQeQhyNwvh9G3v0hgdaViyyTeO2GgKSCmvsVsnMTp
Cmki75E6+iav0VtBpzri+DgHQqvBW/jObboPBD8yNKzcBCjXcDAUJgbE5JuY1c94MIIEijCC
A3KgAwIBAgIQJ/TqEfR6hsRunbtuqRcHBzANBgkqhkiG9w0BAQUFADBvMQswCQYDVQQGEwJT
RTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRU
UCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTA1MDYw
NzA4MDkxMFoXDTIwMDUzMDEwNDgzOFowga4xCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJVVDEX
MBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29y
azEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQDEy1VVE4tVVNF
UkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCyOYWk8n2rQTtiRjeuzcFgdbw5ZflKGkeiucxIzGqY1U01Gbmk
QuXOSeKKLx580jEHx060g2SdLinVomTEhb2FUTV5pE5okHsceqSSqBfymBXyk8zJpDKVuwxP
ML2YoAuL5W4bokb6eLyib6tZXqUvz8rabaov66yhs2qqty5nNYt54R5piOLmRs2gpeq+C852
OnoOm+r82idbPXMfIuZIYcZM82mxqC4bttQxICy8goqOpA6l14lD/BZarx1x1xFZ2rqHDa/6
8+HC8KTFZ4zW1lQ63gqkugN3s2XI/R7TdGKqGMpokx6hhX71R2XL+E1XKHTSNP8wtu72YjAU
jCzrAgMBAAGjgeEwgd4wHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTLVBowHQYDVR0O
BBYEFImCZ33EnSZwAEu0UEh83j2uBG59MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTAD
AQH/MHsGA1UdHwR0MHIwOKA2oDSGMmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FkZFRydXN0
RXh0ZXJuYWxDQVJvb3QuY3JsMDagNKAyhjBodHRwOi8vY3JsLmNvbW9kby5uZXQvQWRkVHJ1
c3RFeHRlcm5hbENBUm9vdC5jcmwwDQYJKoZIhvcNAQEFBQADggEBABnYiRFvKKymAKLnh8Gb
kAPbfqES/R7z4vABqZRUQmuaCcSgbdeQkgQDZnlDcfz4b6/bdkXiNxo93eRZBHisHPSDRvN6
z1uEci3lRsG6GBEp88tJeYc8um0FnaRtaE+tchQ2qLmx/b/Pf/CkapQ1UI/PgW1Vsd1ZMErf
baCcZB9JfO82u/TjafT4OY9arUuFOrcO7dPPDUSi+wS/5C9wjiX7WlQGs9DEvG2N+3MyLOmb
hCQt1n+RemgCUB8OP03pzPW7Z+jcHC47/E7N/gKO46gTCqUmRGXpEPJNUqeu3D7KazJcQWz+
9V2g6v/R+puGWG09lkfl/i6VBMIAzI6h8rswggSaMIIDgqADAgECAhEAxMBl1udi5nsR1ulD
Epd3gjANBgkqhkiG9w0BAQUFADA7MQswCQYDVQQGEwJOTDEPMA0GA1UEChMGVEVSRU5BMRsw
GQYDVQQDExJURVJFTkEgUGVyc29uYWwgQ0EwHhcNMTIxMjAxMDAwMDAwWhcNMTUxMjAxMjM1
OTU5WjBeMQswCQYDVQQGEwJBVDEaMBgGA1UEChMRVW5pdmVyc2l0YWV0IFdpZW4xEzARBgNV
BAMTCkt1cnQgQmF1ZXIxHjAcBgkqhkiG9w0BCQIWD2tiQHVuaXZpZS5hYy5hdDCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAM555E3EayeccVOwbh57Sg57mNPVGruTCjk5pAnZ
5FiOuYjOiletdapcg7niN4yaJSwRdYGyFeEpyl80mLErUp+N3+QLoNZpplvDkXjZ7E5LaQ4C
21gmDTVP6n+nr7MecASsTAB3NTvdYY494lePlq5L0mlyY1RR4Oa3uPw3/TlRTxxaK7jScpD0
hSg98P/OLy2BM3mn1wVjMMqwDtgTcHWMW7J+LYktd+HccBF0l6cUIt4K1PgB7/L6hvTLS0US
GboxBhoVq8dJFvFq5GLCO2eANryyamchhcWKc+JWQCCmnVjResH1DOiy7Ej/8H2Ozce5IuaW
SFNvrWHUetP/8isCAwEAAaOCAXQwggFwMB8GA1UdIwQYMBaAFGNNQ1oZSD/ERsECur/uDuWC
t2amMB0GA1UdDgQWBBTeJ5Hvjt6CXSfKav7VfKSUfraJ+zAOBgNVHQ8BAf8EBAMCBaAwDAYD
VR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwGAYDVR0gBBEwDzAN
BgsrBgEEAbIxAQICHTA/BgNVHR8EODA2MDSgMqAwhi5odHRwOi8vY3JsLnRjcy50ZXJlbmEu
b3JnL1RFUkVOQVBlcnNvbmFsQ0EuY3JsMHIGCCsGAQUFBwEBBGYwZDA6BggrBgEFBQcwAoYu
aHR0cDovL2NydC50Y3MudGVyZW5hLm9yZy9URVJFTkFQZXJzb25hbENBLmNydDAmBggrBgEF
BQcwAYYaaHR0cDovL29jc3AudGNzLnRlcmVuYS5vcmcwIgYDVR0RBBswGYEXa3VydC5iYXVl
ckB1bml2aWUuYWMuYXQwDQYJKoZIhvcNAQEFBQADggEBAJiuuaEbc5x3X802RdOdw97UQDhI
TMh5MNaF0C9hZ0bz2vXbis8Q6NiPqqiMggRg2gkHybsHbGB3EmJpPnAZ71S6cBaxEaF0JTId
bXdLcxJ3NGwF8Ru8LFuKlqZMQDHEjmGTgeCbto2U52ZxEPw7VdN8/3uVc+aDeyKsJaev2hGK
6R3T/QGRCvQCFUfJSnNBh4n9bjqVafaHaZog8boSm7si5cZ75A1X59CNBJSF3a4yAEs3PQvt
4QvMheeBtzhA7fwjPGwHk4Vaj3ATCCYHx3uZawsYOUYUX+tbdcgqridZf8wIH0SIzi6fgLmJ
D/xZYzmvx/DKPM+hTzy5tyN7WVgwggTDMIIDq6ADAgECAhBz/lf637jFCIF7Zrlr8C3vMA0G
CSqGSIb3DQEBBQUAMIGuMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNVBAcTDlNh
bHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxITAfBgNVBAsT
GGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTE2MDQGA1UEAxMtVVROLVVTRVJGaXJzdC1DbGll
bnQgQXV0aGVudGljYXRpb24gYW5kIEVtYWlsMB4XDTA5MDUxODAwMDAwMFoXDTI4MTIzMTIz
NTk1OVowOzELMAkGA1UEBhMCTkwxDzANBgNVBAoTBlRFUkVOQTEbMBkGA1UEAxMSVEVSRU5B
IFBlcnNvbmFsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyBXZ9TNqI6GQ
Dc+7BUTDqx9KNYUaIYWgT/jwQOJKQ5v+W7Gwv7RX3HWAQUtkGvbbT2+P0CVFNfnqy0r6+9rT
7UWIEZQ25MyoDe/FPTftFnvjwpWeWDN/Ivv4/+zmvtuuCmUlIofab4SLRuhAhig/v1YI4krp
g6LpIvst+rYoH5HBw3H7U8ArTqQMoW6dVe3s4SSHOgjiDRzkxE3Qyyf6hGTm0ZedViRbk7sp
LkPiQWo94kpl/JpfWoaHvIfHeYCWmVHGkA9kkZl9EN2sLAMq4Xhk/s49TvQrUBFL0VjUmwPw
f/U7U7BTQ/vFL8QEKRo6rNdV6dEOldE7MX94T64pLQIDAQABo4IBTTCCAUkwHwYDVR0jBBgw
FoAUiYJnfcSdJnAAS7RQSHzePa4Ebn0wHQYDVR0OBBYEFGNNQ1oZSD/ERsECur/uDuWCt2am
MA4GA1UdDwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMBgGA1UdIAQRMA8wDQYLKwYB
BAGyMQECAh0wWAYDVR0fBFEwTzBNoEugSYZHaHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VU
Ti1VU0VSRmlyc3QtQ2xpZW50QXV0aGVudGljYXRpb25hbmRFbWFpbC5jcmwwbwYIKwYBBQUH
AQEEYzBhMDgGCCsGAQUFBzAChixodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVROQUFBQ2xp
ZW50X0NBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkq
hkiG9w0BAQUFAAOCAQEABiupUy8T3Fw5FsyGn15Me3L77I1Vil6aCv9TTHb0Bj1Qz1fwos+v
mYyq/qAZdj6ZAzL6dYM4irtrmqUME7LUG3bmlC5nmFnjkWwCkJqcyGBLVavKiFqNK+VplQMH
0dQO/CQiLlmxY6Rf7dkjcuSczjpcbB9PqQDJHf76f0Utti6E3Q8noFkYTtV2JUX0mSZ522+f
I/dDuysPBKOBJiy3ezX5PXdfQCHmfx2lllq90MsWOmy7YYuK/QQ5RArLLOHLzi4QmBrb4JPt
SWRkCCCft6NQ8KLdyrTGfAw9514V3CeG5Do7UloXq6kGUyudCXNkHAHD/TDShwNv5BUDejlf
aDGCAjgwggI0AgEBMFAwOzELMAkGA1UEBhMCTkwxDzANBgNVBAoTBlRFUkVOQTEbMBkGA1UE
AxMSVEVSRU5BIFBlcnNvbmFsIENBAhEAxMBl1udi5nsR1ulDEpd3gjAJBgUrDgMCGgUAoIG+
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0MDIxMDA4MDQx
MFowIwYJKoZIhvcNAQkEMRYEFDuNYCZBhk2GDfoyBGBbqWNQGmWkMF8GCSqGSIb3DQEJDzFS
MFAwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0D
AgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQCpUlsFvInF
hrGNml+sOUFjUlrIF/oUF5skpwPQx6vGlW8gdeTQHeUWybyUYs/wWk0PJBHQDxAhLlz85he5
oDIZIeCoLGNGKu0FGVlPExDKD9cMpQRNkJDkJzE3+xtIdhe8gXZr+w+Xuqphn2TahVh2FO6h
WG0JzCt+AOOLREtYzRTCW0ULYeUttnp5BLvDCsZD9pz28XIMDhvhsiWBLtgKQ/+KoL5yqh5I
JnXwn3+uAfHZb3g4e7Brf64iDm6zThUaTx7auuqauXzUowWxPbRmwPz4fRN3zvMJ/pBuxyv1
w8Zfp0gVOHvH2FKbdJuG/GYHohyclv9XqG0ilrpFrR2hAAAAAAAA
--------------ms060405080509090900020607--

--===============1869224200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1869224200==--
