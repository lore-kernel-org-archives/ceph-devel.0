From: Arne Wiebalck <Arne.Wiebalck@cern.ch>
Subject: Re: CDS blueprint: strong auth for cephfs
Date: Thu, 14 Nov 2013 13:13:24 +0000
Message-ID: <92F612DDE3CDEA439793C598481F5702CDE3C764@CERNXCHG02.cern.ch>
References: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com>
 <CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="Apple-Mail=_F30608A3-9E15-4429-B936-FD6B94625E70";
	protocol="application/pkcs7-signature"; micalg=sha1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:4071 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753068Ab3KNNSe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Nov 2013 08:18:34 -0500
In-Reply-To: <CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Andrea Ieri <andrea.ieri@cern.ch>

--Apple-Mail=_F30608A3-9E15-4429-B936-FD6B94625E70
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On Nov 13, 2013, at 6:45 PM, Gregory Farnum <greg@inktank.com> wrote:

> On Wed, Nov 13, 2013 at 8:05 AM, Dan van der Ster <dan@vanderster.com> =
wrote:
>> Hi all,
>> This mail is just to let you know that we've prepared a draft
>> blueprint related to adding strong(er) authn/authz to cephfs:
>>=20
>> =
http://wiki.ceph.com/01Planning/02Blueprints/Firefly/Strong_AuthN_and_Auth=
Z_for_CephFS
>>=20
>> The main goal of the idea is that we'd like to be able to use CephFS
>> from untrusted clients:
>>  - the CephX key gives full rw access to pools (e.g. data/metadata)
>> via rados; we cannot distribute this key to untrusted hosts.
>>  - root on untrusted clients can forge their uid/gid and rm -rf =
/cephfs/*.
>>=20
>> In the doc we've proposed one way to add authn/authz to the ceph
>> server side, but perhaps there is a simpler (more feasible in the
>> short term) solution which would enable us to allow untrusted cephfs
>> clients.
>=20
> You want to check out:
> http://wiki.ceph.com/01Planning/Sideboard/Client_Security_for_CephFS,
> the previous edition of the client security blueprint
> http://www.ssrc.ucsc.edu/Papers/leung-sc07.pdf, "Scalable Security for
> Petascale Parallel File Systems", which discusses one way of using
> MDS-granted permissions
> http://www.ssrc.ucsc.edu/Papers/li-fast13.pdf, "Horus: Fine-Grained
> Encryption-Based Security for Large-Scale Storage" is largely
> orthogonal in specifics but might inspire some other ides
>=20
> It looks to me like you've actually got two different blueprints
> there, though =96 "Allow Ceph clients to use Kerberos as an entry =
point"
> and "Enable stronger CephFS security". You're going to need to discuss
> the MDS tickets in a lot more detail than you have there, though =97 =
for
> instance, with your current description you'll need a shared secret
> between the OSD and MDS, and you'll need to expire the client extra
> keys, etc. You may want to consider skipping this in the first
> iteration and just implementing proper security on the MDS while
> relying on RADOS-level options to keep data secure (separate
> namespaces or pools for different users, and providing narrow caps to
> clients). That would also leave more time for some serious research
> into how to do a scalable implementation of any ticketing system we
> create.

It looks to me like Maat is already pretty close to what the use of =
CephFS on untrusted
clients would require.

Any idea why Maat does not use a kerberized Ceph service and the =
corresponding
shared session keys? I think that could avoid the generation and =
distribution of per
client keys and outsource the shared key negotation to a standardized =
mechanism
(and allow for integration with existing authN service infrastructures, =
of course).

Also, why was the Maat idea (which was apparently implemented, tested =
and
benchmarked) not integrated into mainline Ceph?

Thanks!
 Arne


--Apple-Mail=_F30608A3-9E15-4429-B936-FD6B94625E70
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIINuDCCBi4w
ggUWoAMCAQICCmEPqkwAAAAAAAMwDQYJKoZIhvcNAQEFBQAwQTESMBAGCgmSJomT8ixkARkWAmNo
MRQwEgYKCZImiZPyLGQBGRYEY2VybjEVMBMGA1UEAxMMQ0VSTiBSb290IENBMB4XDTA2MTAwMzA5
MzYxM1oXDTE2MTAwMzA5NDYxM1owWTESMBAGCgmSJomT8ixkARkWAmNoMRQwEgYKCZImiZPyLGQB
GRYEY2VybjEtMCsGA1UEAxMkQ0VSTiBUcnVzdGVkIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwdFGqthhWlgUOSZ6C6hReNEVGzbjf2IQgxo7
/rOfOQHZH3krQPQ37fqFroEr46PrruymZ/U+QAzmESZQ4Z+nCfBhm7cEi0TIhihHd4cEPaPxawGR
T9Ck7BBk9za8TUljF6c/JodnIcmIrpbazEbSAS1KEXwETHDsTrQ7lJ+6SzDP4/oOwrHrgJx+tKsm
gOsFSbBEK4OYx1UYQpYS9OJQk2Sc0q4a/SCSu+xbN8ppmgV3WFytN8NW20n3NpCCWYPzo9rXmPRA
7a/c6mf+RV5gPCnUqeW6KUvix5kz9+X8/4SQV/fU12OPdRvtkqcC+PpiePK7bjMLQJEYwvchJrSz
AwIDAQABo4IDDjCCAwowDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUmMyS0EYwNoyw7ZgNclGp
R0zdviEwCwYDVR0PBAQDAgGGMBAGCSsGAQQBgjcVAQQDAgECMCMGCSsGAQQBgjcVAgQWBBT/Rljl
vgfrVK8GmAaYe+TbiXbJ7DBRBgNVHSAESjBIMEYGCisGAQQBYAoCAQEwODA2BggrBgEFBQcCARYq
aHR0cDovL2NhLmNlcm4uY2gvY2EvY3JsL3BvbGljeS9jcC1jcHMucGRmMBkGCSsGAQQBgjcUAgQM
HgoAUwB1AGIAQwBBMB8GA1UdIwQYMBaAFJgK9+w+7FnWHa2ZvLUBPt7spudQMIH8BgNVHR8EgfQw
gfEwge6ggeuggeiGLWh0dHA6Ly9jYS5jZXJuLmNoL2NhL2NybC9DRVJOJTIwUm9vdCUyMENBLmNy
bIaBtmxkYXA6Ly8vQ049Q0VSTiUyMFJvb3QlMjBDQSxDTj1jZXJucm9vdGNhLENOPUNEUCxDTj1Q
dWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWNl
cm4sREM9Y2g/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERp
c3RyaWJ1dGlvblBvaW50MIIBBAYIKwYBBQUHAQEEgfcwgfQwRAYIKwYBBQUHMAKGOGh0dHA6Ly9j
YS5jZXJuLmNoL2NhL2NybC9jZXJucm9vdGNhX0NFUk4lMjBSb290JTIwQ0EuY3J0MIGrBggrBgEF
BQcwAoaBnmxkYXA6Ly8vQ049Q0VSTiUyMFJvb3QlMjBDQSxDTj1BSUEsQ049UHVibGljJTIwS2V5
JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1jZXJuLERDPWNoP2NB
Q2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MA0GCSqG
SIb3DQEBBQUAA4IBAQAfEzvOeYohKndmJqnVdiCqZ38tSBxOOPsKUHW4UY1jBfYMXbnZ9keFQFlK
/g5X4aZPNBEHXw0eKpQVsMhEPWQrvx8T/f7GwtU+JNQhkgK9tnezmHxYzWgEC9MXZhfYzFSwMIF6
kSKllmUTnN35uF1EnT8+64daje+yEVcpmM34p8Fw125/WpKnRmwNp0YkUk6uMti6Y6vOTHttzIN5
P6elGoat8sadMqrVnaMNzG8hGUvSkYivYBs7msAPuwmXgLvIkXWPW+MDFs+x5Kzx75ZHv3c2WoKg
UxL5KZH9QqiR7t8P6YBfYW6SpzyGRi4QHN/iOLhXZ06R6aPljLEOn41JMIIHgjCCBmqgAwIBAgIK
HYLrgQACAAHOszANBgkqhkiG9w0BAQUFADBZMRIwEAYKCZImiZPyLGQBGRYCY2gxFDASBgoJkiaJ
k/IsZAEZFgRjZXJuMS0wKwYDVQQDEyRDRVJOIFRydXN0ZWQgQ2VydGlmaWNhdGlvbiBBdXRob3Jp
dHkwHhcNMTMwMzI2MDkxNjM1WhcNMTQwMzI2MDkxNjM1WjCBjjESMBAGCgmSJomT8ixkARkWAmNo
MRQwEgYKCZImiZPyLGQBGRYEY2VybjEWMBQGA1UECxMNT3JnYW5pYyBVbml0czEOMAwGA1UECxMF
VXNlcnMxETAPBgNVBAMTCHdpZWJhbGNrMQ8wDQYDVQQDEwY1NTg1MTAxFjAUBgNVBAMTDUFybmUg
V2llYmFsY2swggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKWiuJsxwe2ZAkHn+FKzTT
VBNe7lhl2PmTjPmZsedrVI0gZkUpjlb6x21avo3S+kacxPpVdNVmidE1k7Dmn+MLLwli8Ha+ePqN
e2kD33K01bjf8G1l5KquZwMsJKB2gSwSs1JK5uq3qcB5b1mrzPVOqOqNPUMg1NUkEjYql4ooG5Cj
GfVwlAhRarBssM07JtnToszp/fiCqttCR4pAAjURvQKV3T+Epiexwgzkv57mLAXe3vNf8giDigJP
zvNc+3pGqA8faVOGSqOo+9m6NheYPH4pcYcnhgA177HRfHxJ9fqzEahLNzXjoa9vtW8cpbSxyzY1
wbOCvQW1hz/uCP/5AgMBAAGjggQUMIIEEDAdBgNVHQ4EFgQUFIvKPnfKzu1UVQjsxgpwQPtpkwAw
HwYDVR0jBBgwFoAUmMyS0EYwNoyw7ZgNclGpR0zdviEwggEyBgNVHR8EggEpMIIBJTCCASGgggEd
oIIBGYZHaHR0cDovL2NhLmNlcm4uY2gvY2EvY3JsL0NFUk4lMjBUcnVzdGVkJTIwQ2VydGlmaWNh
dGlvbiUyMEF1dGhvcml0eS5jcmyGgc1sZGFwOi8vL0NOPUNFUk4lMjBUcnVzdGVkJTIwQ2VydGlm
aWNhdGlvbiUyMEF1dGhvcml0eSxDTj1DRVJOUEtJLENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBT
ZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWNlcm4sREM9Y2g/Y2VydGlm
aWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50
MIIBLwYIKwYBBQUHAQEEggEhMIIBHTCBxQYIKwYBBQUHMAKGgbhsZGFwOi8vL0NOPUNFUk4lMjBU
cnVzdGVkJTIwQ2VydGlmaWNhdGlvbiUyMEF1dGhvcml0eSxDTj1BSUEsQ049UHVibGljJTIwS2V5
JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1jZXJuLERDPWNoP2NB
Q2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MFMGCCsG
AQUFBzAChkdodHRwOi8vY2EuY2Vybi5jaC9jYS9jcmwvQ0VSTiUyMFRydXN0ZWQlMjBDZXJ0aWZp
Y2F0aW9uJTIwQXV0aG9yaXR5LmNydDAOBgNVHQ8BAf8EBAMCBaAwPQYJKwYBBAGCNxUHBDAwLgYm
KwYBBAGCNxUIg73QCYLtjQ2G7Ysrgd71N4WA0GIehb+6A4TEzEwCAWQCAQowKQYDVR0lBCIwIAYI
KwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgMEMCUGA1UdIAQeMBwwDAYKKwYBBAFgCgIBAjAM
BgoqhkiG90wFAgIBMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQwDAYK
KwYBBAGCNwoDBDBHBgNVHREEQDA+oCUGCisGAQQBgjcUAgOgFwwVYXJuZS53aWViYWxja0BjZXJu
LmNogRVBcm5lLldpZWJhbGNrQGNlcm4uY2gwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgIC
AIAwDgYIKoZIhvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBBQUAA4IB
AQBPiPoalqg44BSHOfc5XKMLl8dbU2ixH84cWFWmv8WrkM1oTVOopGUi9dO2qiN3PbzgkW3h4yB6
hEvTn7CVCfuzPXjEb9dQEJEmVheW8xA96GYWYWdXqdNHWtPMJB4tFh0skOMo35DwavZlrE30LLR+
BK8faePfnQ6PgPrdBESQaU4ZemLS5Q/eKfz2d4kSt5+70rj8ypD7pmMdUu/n1TFxuG3UNCFSMs6G
SUV0/PBjyV1O8jGtVbE9vNZE+NTuzWiYgI5Z6Pl6cHefI6miSn++PDjHzfaIPi0san0KMOXLqvA8
ZfjtAb2QMEvvKziTdg9Q4Y7wHCdi7aqKWmTbwyqUMYIC4TCCAt0CAQEwZzBZMRIwEAYKCZImiZPy
LGQBGRYCY2gxFDASBgoJkiaJk/IsZAEZFgRjZXJuMS0wKwYDVQQDEyRDRVJOIFRydXN0ZWQgQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkCCh2C64EAAgABzrMwCQYFKw4DAhoFAKCCAU8wGAYJKoZIhvcN
AQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTMxMTE0MTMxMzQxWjAjBgkqhkiG9w0B
CQQxFgQUcNNBnf956rBSEgtLtfN0p6sdjgswdgYJKwYBBAGCNxAEMWkwZzBZMRIwEAYKCZImiZPy
LGQBGRYCY2gxFDASBgoJkiaJk/IsZAEZFgRjZXJuMS0wKwYDVQQDEyRDRVJOIFRydXN0ZWQgQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkCCh2C64EAAgABzrMweAYLKoZIhvcNAQkQAgsxaaBnMFkxEjAQ
BgoJkiaJk/IsZAEZFgJjaDEUMBIGCgmSJomT8ixkARkWBGNlcm4xLTArBgNVBAMTJENFUk4gVHJ1
c3RlZCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eQIKHYLrgQACAAHOszANBgkqhkiG9w0BAQEFAASC
AQC0OflSFbID1B67VU6EE68DoSd/Ma8EpfAgjPwpgOyooec7LUbL9Pbvu8z49Y596p6er2v+uKua
TImxHtlx2NT0f5IeAPTvntlcSfBkfCMT5OR8yFROroRXPae8yHRtIgy+cqJ3t9nPe+Lq/Zwke0Ie
HioniRtyJMQSa80po1A0z8J+ETP5ju0eRGaU2cwDgV54TzHM+8dBHzOfpRu5874+EiJFgW6toGLb
+ePpQzSJzUZy/2RJriemqsA5L6vtu3TLWdQc+h7SiEyNujR7jGuzfBv+PrxyJN/MJUawg0h2svRl
lSwDiWyNrfTrQCnIvJyZi5331vCpXQdJvNRFNoYRAAAAAAAA

--Apple-Mail=_F30608A3-9E15-4429-B936-FD6B94625E70--
