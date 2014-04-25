From: Kurt Bauer <kurt.bauer@univie.ac.at>
Subject: Re: OSD crashing permanently
Date: Fri, 25 Apr 2014 10:17:34 +0200
Message-ID: <535A1A1E.9000605@univie.ac.at>
References: <535A0B09.5080702@univie.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020104090907010905040509"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from grace.univie.ac.at ([131.130.3.115]:52246 "EHLO
	grace.univie.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaDYIRc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Apr 2014 04:17:32 -0400
Received: from justin.univie.ac.at ([131.130.3.111] helo=justin.univie.ac.at)
	by grace.univie.ac.at with esmtp (Exim 4.82)
	(envelope-from <kurt.bauer@univie.ac.at>)
	id 1WdbK6-0006tn-Ub
	for ceph-devel@vger.kernel.org; Fri, 25 Apr 2014 10:17:30 +0200
Received: from [2001:628:1:5:f11a:34b8:2634:a586] (helo=kb.aco.net)
	by justin.univie.ac.at with esmtpsa (TLSv1:ECDHE-RSA-AES256-SHA:256)
	(Exim 4.82)
	(envelope-from <kurt.bauer@univie.ac.at>)
	id 1WdbK6-0007Mi-SW
	for ceph-devel@vger.kernel.org; Fri, 25 Apr 2014 10:17:30 +0200
In-Reply-To: <535A0B09.5080702@univie.ac.at>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms020104090907010905040509
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi again,

it seems the reason is either a corrupted file-system or disk-error.
Correlating with the last daemon crash we saw i/o error messages from
the kernel for the specific disk, for whatever reason there where no
such errors previously.
I did an xfs_repair, which showed no errors, but at least the daemon
didn't crash after a few minutes, like the last times. At least it seems
to be nothing 'ceph related', but a simple disk or fs error.

Best regards,
Kurt

> Kurt Bauer <mailto:kurt.bauer@univie.ac.at>
> 25. April 2014 09:13
> Hi,
>
> since a few days we have one OSD (osd.23) permanently crashing. It can
> be restarted without problem but after a few minutes (one time it lived
> for a few hours) it crashes. The logfile of the specific osd for one of
> those crashes is attached. Other OSDs on the same host work without
> problem.
> I tried a xfs_check on the specific disk, which showed no errors.
>
> Maybe you can give us a hint where the problem could be and what has to
> be done to solve it. If any further information or logs would help, I'd
> be happy to provide them.
>
> Many thanks,
> best regards,
> Kurt
>
> PS.: Maybe the outline of the cluster could be helpful:
> vmstor1:~# ceph osd tree
> # id weight type name up/down reweight
> -1 78 root default
> -13 52 city Vienna
> -11 26 datacenter NIG
> -8 26 room B1
> -3 26 rack B2
> -2 26 host vmstor1
> 0 2 osd.0
> up 1
> 1 2 osd.1
> up 1
> 2 2 osd.2
> up 1
> 3 2 osd.3
> up 1
> 12 3 osd.12
> up 1
> 14 3 osd.14
> up 1
> 15 3 osd.15
> up 1
> 16 3 osd.16
> up 1
> 17 3 osd.17
> up 1
> 18 3 osd.18
> up 1
> -12 26 datacenter IXION
> -10 26 room 3
> -7 26 rack R0
> -4 26 host vmstor21
> 10 2 osd.10
> up 1
> 11 2 osd.11
> up 1
> 8 2 osd.8
> up 1
> 9 2 osd.9
> up 1
> 13 3 osd.13
> up 1
> 25 3 osd.25
> up 1
> 26 3 osd.26
> up 1
> 27 3 osd.27
> up 1
> 28 3 osd.28
> up 1
> 29 3 osd.29
> up 1
> -15 26 city Linz
> -14 26 datacenter OOE
> -9 26 room SYS2
> -6 26 rack LIK1N
> -5 26 host vmstor2
> 4 2 osd.4
> up 1
> 5 2 osd.5
> up 1
> 6 2 osd.6
> up 1
> 7 2 osd.7
> up 1
> 19 3 osd.19
> up 1
> 20 3 osd.20
> up 1
> 21 3 osd.21
> up 1
> 22 3 osd.22
> up 1
> 23 3 osd.23
> down 0
> 24 3 osd.24
> up 1
>
>

--------------ms020104090907010905040509
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
9V2g6v/R+puGWG09lkfl/i6VBMIAzI6h8rswggSaMIIDgqADAgECAhEAr5ge2aKKXKWWxGma
4v+XuDANBgkqhkiG9w0BAQUFADA7MQswCQYDVQQGEwJOTDEPMA0GA1UEChMGVEVSRU5BMRsw
GQYDVQQDExJURVJFTkEgUGVyc29uYWwgQ0EwHhcNMTMwNjEwMDAwMDAwWhcNMTYwNjA5MjM1
OTU5WjBeMQswCQYDVQQGEwJBVDEaMBgGA1UEChMRVW5pdmVyc2l0YWV0IFdpZW4xEzARBgNV
BAMTCkt1cnQgQmF1ZXIxHjAcBgkqhkiG9w0BCQIWD2tiQHVuaXZpZS5hYy5hdDCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAKUHAwBabmLShrwgz1f8mOb6gEvLaa1XNuQtIDxs
g8Mpra2i/B22rWdRvC6SHT3QWaHJVAOZuVbXpA8Nneio3IA56KkW/fjO7iq08szkWX8X83zF
c4zHV38vQ7BV0WEoVLAqYuoDb/pKCk/YLTe5yFwbB8dRxbeFfAv3idG3yk6eqRDIJxGRFAXA
fUsM6MBwv3EFODD51MTPBs2CoOTqkcgG0bOgddrqUdTjH6bgGslQcG6P4yp9y0B2CDS17e0A
1Q4s2mpV9zqj2O3URTGBWZGOTLMs8FN03v3Y8yN/2mHZXcHSVyjcoTtSO0GHlNpGbwHjuGrT
dyHd7gpY8z5wV8ECAwEAAaOCAXQwggFwMB8GA1UdIwQYMBaAFGNNQ1oZSD/ERsECur/uDuWC
t2amMB0GA1UdDgQWBBRocRnmRuqrwEMtoMy08RoOODCaQjAOBgNVHQ8BAf8EBAMCBaAwDAYD
VR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwGAYDVR0gBBEwDzAN
BgsrBgEEAbIxAQICHTA/BgNVHR8EODA2MDSgMqAwhi5odHRwOi8vY3JsLnRjcy50ZXJlbmEu
b3JnL1RFUkVOQVBlcnNvbmFsQ0EuY3JsMHIGCCsGAQUFBwEBBGYwZDA6BggrBgEFBQcwAoYu
aHR0cDovL2NydC50Y3MudGVyZW5hLm9yZy9URVJFTkFQZXJzb25hbENBLmNydDAmBggrBgEF
BQcwAYYaaHR0cDovL29jc3AudGNzLnRlcmVuYS5vcmcwIgYDVR0RBBswGYEXa3VydC5iYXVl
ckB1bml2aWUuYWMuYXQwDQYJKoZIhvcNAQEFBQADggEBABPtAX3Oj5PwJf+xHyvsFivb23m4
xbH6fquT1vNsPaEi8vcS4wvlvBZy/XIztjNpZdEdIpa05g11EXVdGumDu7MsSvHyvYVxwXkJ
E+DUsBlFQLAtRg3LNr4KblWOZZRVm1OUIWfNs6XbVnI3V67W3rm5FfzTBBrGl9+qxrfSVEko
kJTcEzWOxh/Xpa85IciHkkY/oxbSges7Z3qmEAKreCXjAZckDRu+gsoeP6t8kQGck2F85Pgi
1EETsgjSb5cxttdaoJ1/hvNUNKaPqevxr5tcU+vmyWfzSkhBHgtCNf99OIzfbwfP62PGfCpf
VIRVxhthtMn/eoUI7rsU/5wv5F4wggTDMIIDq6ADAgECAhBz/lf637jFCIF7Zrlr8C3vMA0G
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
aDGCAv0wggL5AgEBMFAwOzELMAkGA1UEBhMCTkwxDzANBgNVBAoTBlRFUkVOQTEbMBkGA1UE
AxMSVEVSRU5BIFBlcnNvbmFsIENBAhEAr5ge2aKKXKWWxGma4v+XuDAJBgUrDgMCGgUAoIIB
gjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNDA0MjUwODE3
MzRaMCMGCSqGSIb3DQEJBDEWBBSiZwf2XIUx3rPb+Qp8YYerMDxzOzBfBgkqhkiG9w0BCQ8x
UjBQMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwXwYJKwYBBAGCNxAEMVIwUDA7MQswCQYD
VQQGEwJOTDEPMA0GA1UEChMGVEVSRU5BMRswGQYDVQQDExJURVJFTkEgUGVyc29uYWwgQ0EC
EQCvmB7ZoopcpZbEaZri/5e4MGEGCyqGSIb3DQEJEAILMVKgUDA7MQswCQYDVQQGEwJOTDEP
MA0GA1UEChMGVEVSRU5BMRswGQYDVQQDExJURVJFTkEgUGVyc29uYWwgQ0ECEQCvmB7Zoopc
pZbEaZri/5e4MA0GCSqGSIb3DQEBAQUABIIBAGWTIdJypb6W5yfB07GXreyucJFhFOdBnlyR
d0/jM4tJH9R+ymkETcIiRA1fl2g7mG8Bmh0DIWTz1SAUaErChsi1JpNCrWsaqEzu9hiFd/n7
6kzJRgdggttVbqFqcH3DkKB7mgaJlNfuiXeAS0Q9bjQdsttXqfHle8ACkin7qrIsZbNI78ee
oHtBWhOt2HBvttqhNIEKbzPi8JV2ZlTG+ReaOvLDX7cvEZK0BRpczTa6RL+l/qMCnZGbAf8l
AvvjB+EDaumHXXcrgSV0N4Ln2jMWQyHAmdQ5oJYXUgd9LCSV0hf55FYA1mfgnenS8s4UZK0Z
T9+xi2if7dCScUKcztoAAAAAAAA=
--------------ms020104090907010905040509--
