From: Oliver Freyermuth <freyermuth-PRwTpj6vllKyLsESG3L8NIQuADTiUCJX@public.gmane.org>
Subject: Re: v12.2.7 Luminous released
Date: Wed, 18 Jul 2018 13:33:35 +0200
Message-ID: <d8e1d1f4-b6ca-2f6b-09b3-8a6757c71105@physik.uni-bonn.de>
References: <87tvox968t.fsf@suse.com> <20180717182419.GA1559@shell.dmz.bit.nl>
 <alpine.DEB.2.11.1807171838180.15696@piezo.novalocal>
 <MEAPR01MB3333E2C456B441629674B2BE81530@MEAPR01MB3333.ausprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7620251567298232587=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <MEAPR01MB3333E2C456B441629674B2BE81530-6Cj2JuxXxgYyJjs6S75NOcNU+h3Mz0HLvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Linh Vu <vul-keaFvQtjc6i7NGdpmJTKYQ@public.gmane.org>, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Stefan Kooman <stefan-68+x73Hep80@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, Peter Wienemann <wienemann-PRwTpj6vllKyLsESG3L8NIQuADTiUCJX@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>, "ceph-announce-Qp0mS5GaXlQ@public.gmane.org" <ceph-announce-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a cryptographically signed message in MIME format.

--===============7620251567298232587==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020700020605090803060605"

This is a cryptographically signed message in MIME format.

--------------ms020700020605090803060605
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Also many thanks from my side!=20

Am 18.07.2018 um 03:04 schrieb Linh Vu:
> Thanks for all your hard work in putting out the fixes so quickly! :)
>=20
> We have a cluster on 12.2.5 with Bluestore and EC pool but for CephFS, =
not RGW. In the release notes, it says RGW is a risk especially the garba=
ge collection, and the recommendation is to either pause IO or disable RG=
W garbage collection.=A0
>=20
>=20
> In our case with CephFS, not RGW, is it a lot less risky to perform the=
 upgrade to 12.2.7 without the need to pause IO?=A0
>=20
>=20
> What does pause IO do? Do current sessions just get queued up and IO re=
sume normally with no problem after unpausing?=20

That's my understanding, pause blocks any reads and writes. If the proces=
ses accessing CephFS do not have any wallclock-related timeout handlers, =
they should be fine IMHO.=20
I'm unsure how NFS Ganesha=20
But indeed I have the very same question - we also have a pure CephFS clu=
ster, without RGW, EC-pool-backed, on 12.2.5. Should we pause IO during u=
pgrade?=20

I wonder whether it is risky / unrisky to upgrade without pausing I/O?=20
The update notes in the blog do not state whether a pure CephFS setup is =
affected.=20

Cheers,
	Oliver

>=20
>=20
> If we have to pause IO, is it better to do=A0something like: pause IO, =
restart OSDs on one node, unpause IO - repeated for all the nodes involve=
d in the EC pool?=A0
>=20
>=20
> Regards,
>=20
> Linh
>=20
> -----------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------
> *From:* ceph-users <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org> on behalf of Sag=
e Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
> *Sent:* Wednesday, 18 July 2018 4:42:41 AM
> *To:* Stefan Kooman
> *Cc:* ceph-announce-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-maintain=
ers-Qp0mS5GaXlQ@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org
> *Subject:* Re: [ceph-users] v12.2.7 Luminous released
> =A0
> On Tue, 17 Jul 2018, Stefan Kooman wrote:
>> Quoting Abhishek Lekshmanan (abhishek-IBi9RG/b67k@public.gmane.org):
>>
>> > *NOTE* The v12.2.5 release has a potential data corruption issue wit=
h
>> > erasure coded pools. If you ran v12.2.5 with erasure coding, please =
see
> ^^^^^^^^^^^^^^^^^^^
>> > below.
>>
>> < snip >
>>
>> > Upgrading from v12.2.5 or v12.2.6
>> > ---------------------------------
>> >
>> > If you used v12.2.5 or v12.2.6 in combination with erasure coded
> ^^^^^^^^^^^^^
>> > pools, there is a small risk of corruption under certain workloads.
>> > Specifically, when:
>>
>> < snip >
>>
>> One section mentions Luminous clusters _with_ EC pools specifically, t=
he other
>> section mentions Luminous clusters running 12.2.5.
>=20
> I think they both do?
>=20
>> I might be misreading this, but to make things clear for current Ceph
>> Luminous 12.2.5 users. Is the following statement correct?
>>
>> If you do _NOT_ use EC in your 12.2.5 cluster (only replicated pools),=
 there is
>> no need to quiesce IO (ceph osd pause).
>=20
> Correct.
>=20
>> http://docs.ceph.com/docs/master/releases/luminous/#upgrading-from-oth=
er-versions
>> If your cluster did not run v12.2.5 or v12.2.6 then none of the above
>> issues apply to you and you should upgrade normally.
>>
>> ^^ Above section would indicate all 12.2.5 luminous clusters.
>=20
> The intent here is to clarify that any cluster running 12.2.4 or
> older can upgrade without reading carefully. If the cluster
> does/did run 12.2.5 or .6, then read carefully because it may (or may n=
ot)
> be affected.
>=20
> Does that help? Any suggested revisions to the wording in the release
> notes that make it clearer are welcome!
>=20
> Thanks-
> sage
>=20
>=20
>>
>> Please clarify,
>>
>> Thanks,
>>
>> Stefan
>>
>> --
>> | BIT BV http://www.bit.nl/ Kamer van Koophandel 09090351
>> | GPG: 0xD14839C6 +31 318 648 688 / info-68+x73Hep80@public.gmane.org
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20



--------------ms020700020605090803060605
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EIowggTVMIIDvaADAgECAghQTsb1PRG0ZDANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJE
RTEcMBoGA1UEChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2VjIFRy
dXN0IENlbnRlcjEjMCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcNMTQw
NzIyMTIwODI2WhcNMTkwNzA5MjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZO
LVZlcmVpbjEQMA4GA1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xv
YmFsIC0gRzAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71jVTD
llA1PWLpbkztlNcAW5UidNQg6zSP1uzAMQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsWyyg1
OXstkEXQ7aAAeny/Sg4bAMOG6VwrMRF7DPOCJEOMHDiLamgAmu7cT3ir0sYTm3at7t4m6O8B
r3QPwQmi9mvOvdPNFDBP9eXjpMhim4IaAycwDQJlYE3t0QkjKpY1WCfTdsZxtpAdxO3/NYZ9
bzOz2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO72uuLFlZWQ8/h1RM9ph8nMM1JVNvJEzSa
cXXFbOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQABo4IBhjCCAYIwDgYDVR0PAQH/BAQD
AgEGMB0GA1UdDgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAfBgNVHSMEGDAWgBQxw3kbuvVT
1xfgiXotF2wKsyudMzASBgNVHRMBAf8ECDAGAQH/AgECMGIGA1UdIARbMFkwEQYPKwYBBAGB
rSGCLAEBBAICMBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIsAQEEAwEwDwYNKwYB
BAGBrSGCLAEBBDANBgsrBgEEAYGtIYIsHjA+BgNVHR8ENzA1MDOgMaAvhi1odHRwOi8vcGtp
MDMzNi50ZWxlc2VjLmRlL3JsL0RUX1JPT1RfQ0FfMi5jcmwweAYIKwYBBQUHAQEEbDBqMCwG
CCsGAQUFBzABhiBodHRwOi8vb2NzcDAzMzYudGVsZXNlYy5kZS9vY3NwcjA6BggrBgEFBQcw
AoYuaHR0cDovL3BraTAzMzYudGVsZXNlYy5kZS9jcnQvRFRfUk9PVF9DQV8yLmNlcjANBgkq
hkiG9w0BAQsFAAOCAQEAYyAo/ZwhhnK+OUZZOTIlvKkBmw3Myn1BnIZtCm4ssxNZdbEzkhth
Jxb/w7LVNYL7hCoBSb1mu2YvssIGXW4/buMBWlvKQ2NclbbhMacf1QdfTeZlgk4y+cN8ekvN
TVx07iHydQLsUj7SyWrTkCNuSWc1vn9NVqTszC/Pt6GXqHI+ybxA1lqkCD3WvILDt7cyjrEs
jmpttzUCGc/1OURYY6ckABCwu/xOr24vOLulV0k/2G5QbyyXltwdRpplic+uzPLl2Z9Tsz6h
L5Kp2AvGhB8Exuse6J99tXulAvEkxSRjETTMWpMgKnmIOiVCkKllO3yG0xIVIyn8LNrMOVtU
FzCCBZgwggSAoAMCAQICBxekJLPtcY4wDQYJKoZIhvcNAQELBQAwWjELMAkGA1UEBhMCREUx
EzARBgNVBAoTCkRGTi1WZXJlaW4xEDAOBgNVBAsTB0RGTi1QS0kxJDAiBgNVBAMTG0RGTi1W
ZXJlaW4gUENBIEdsb2JhbCAtIEcwMTAeFw0xNDA1MjcxNDU0MjdaFw0xOTA3MDkyMzU5MDBa
MIG6MQswCQYDVQQGEwJERTEcMBoGA1UECBMTTm9yZHJoZWluLVdlc3RmYWxlbjENMAsGA1UE
BxMEQm9ubjEaMBgGA1UEChMRVW5pdmVyc2l0YWV0IEJvbm4xHzAdBgNVBAsTFkhvY2hzY2h1
bHJlY2hlbnplbnRydW0xHTAbBgNVBAMTFFVuaXZlcnNpdGFldCBCb25uIENBMSIwIAYJKoZI
hvcNAQkBFhNjYWFkbWluQHVuaS1ib25uLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAkmUpoQytKXOFQLXlt6x0jkrPOGGoYSENdtfd5Jpvgao+ODpn7TPbPrG70N8oinhS
YQaqwE7ehB5aNsHZQZD8MMDl7hRkSH10xNabQLzKK1IzxA5/JqFH5ypFBVqDmh4xIi5f8ERk
ABXEpOf55mdekMJwbOvz3Q6mqQ1jt8uSQo+tF2NPee6+kPWWqKURzPYcWjsQJl8enZ7u1BHz
TwUvZ1c5/j9geG6jnM1SlAKqhkw8KvKxUNZm+WgY1Eq+r/GQR+qlLTTAWn1goKBIOfPba42a
WRZyf5MpS6YQPO3cVIjKkaQfh5WG2i8/jJkGn2o0DIpXyr7EtV0hZjVU3nfXrwIDAQABo4IC
ADCCAfwwEgYDVR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwEQYDVR0gBAowCDAG
BgRVHSAAMB0GA1UdDgQWBBTrN9Dr14QuRp4S07MY243lguRopzAfBgNVHSMEGDAWgBRJt8bP
6D0ff+pEexMp9/EKcD7eZDAeBgNVHREEFzAVgRNjYWFkbWluQHVuaS1ib25uLmRlMIGIBgNV
HR8EgYAwfjA9oDugOYY3aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9w
dWIvY3JsL2NhY3JsLmNybDA9oDugOYY3aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1jYS9wdWIvY3JsL2NhY3JsLmNybDCB1wYIKwYBBQUHAQEEgcowgccwMwYIKwYBBQUH
MAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBHBggrBgEFBQcw
AoY7aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY2FjZXJ0L2Nh
Y2VydC5jcnQwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJv
b3QtY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQDlFylCpSEM
49LqfmHcYSA25DnXWQC7iRlmnNK3uA5zozZa7HCgcxBxdNH/GXxJHfAaUs8kCgQRNhDnhd2p
ldhcdOUL7XAFumOD6/9nOuBuJe984ydrWmHL2mKtEp+c+jjEczIGJDyMX3lIvy7J2Amj5SdF
lljiGQ/QOP18/gVsVIKSHjqdslRuzgwEv9s2YQNzVwiwRjYwtqWpJQenFDNeDkOkgI3y6v/D
8ZkRuwiH3IYGGvSkeHCierB0kIppahFZqVcd4EuXeiSPita+2q3PF5QOvRSRK7qcKgNgInwf
o4TrJq6ymoPTnL5SvSHln/mum8BNNrAUmOpwVZhDi9YJMIIGETCCBPmgAwIBAgIHG6w7KfsB
9TANBgkqhkiG9w0BAQsFADCBujELMAkGA1UEBhMCREUxHDAaBgNVBAgTE05vcmRyaGVpbi1X
ZXN0ZmFsZW4xDTALBgNVBAcTBEJvbm4xGjAYBgNVBAoTEVVuaXZlcnNpdGFldCBCb25uMR8w
HQYDVQQLExZIb2Noc2NodWxyZWNoZW56ZW50cnVtMR0wGwYDVQQDExRVbml2ZXJzaXRhZXQg
Qm9ubiBDQTEiMCAGCSqGSIb3DQEJARYTY2FhZG1pbkB1bmktYm9ubi5kZTAeFw0xNjA3MTgx
MTI5MzBaFw0xOTA3MDkyMzU5MDBaMIGQMQswCQYDVQQGEwJERTEcMBoGA1UECAwTTm9yZHJo
ZWluLVdlc3RmYWxlbjENMAsGA1UEBwwEQm9ubjE4MDYGA1UECgwvUmhlaW5pc2NoZSBGcmll
ZHJpY2gtV2lsaGVsbXMtVW5pdmVyc2l0YWV0IEJvbm4xGjAYBgNVBAMMEU9saXZlciBGcmV5
ZXJtdXRoMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6a1YHUpB6WiOyNU59Xe5
Z++/GeKLIPiB6vbFrjVFNIAlg5zWHpqewAEk4N92m0sTdHU1ocXwmPlK4rOua5AT1ZSs11pr
XH/fL0Wm9JJpCflZuRRcYA+zi+usET6mqflRPfil5ICC7ZCuFi6lMIZoEhrJbbu9o/cuAN/e
id9DuHt8Gp/feGJzBNA0l5ZjizLendzixNI+Kn147KssRotMhjGdO4MJ3AduPahJ3QM9pMNk
fKj1pJJ0btoiHoT8Oi6KJx7J5T/qaTl9FURjDCaqRF5XCnkHCx2yFbvK6jYCjmrOoMq/VdU4
PS6j2I2w9C6K5mCgXjeRrfNPqoDK7kn6nwIDAQABo4ICQjCCAj4wQAYDVR0gBDkwNzARBg8r
BgEEAYGtIYIsAQEEAwUwEQYPKwYBBAGBrSGCLAIBBAMBMA8GDSsGAQQBga0hgiwBAQQwCQYD
VR0TBAIwADAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MB0GA1UdDgQWBBQLsi+Tp4LWlSQaZyVEJgvpLq9+OjAfBgNVHSMEGDAWgBTrN9Dr14QuRp4S
07MY243lguRopzAoBgNVHREEITAfgR1mcmV5ZXJtdXRoQHBoeXNpay51bmktYm9ubi5kZTCB
gQYDVR0fBHoweDA6oDigNoY0aHR0cDovL2NkcDEucGNhLmRmbi5kZS91bmktYm9ubi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA6oDigNoY0aHR0cDovL2NkcDIucGNhLmRmbi5kZS91bmktYm9u
bi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB0QYIKwYBBQUHAQEEgcQwgcEwMwYIKwYBBQUHMAGG
J2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBEBggrBgEFBQcwAoY4
aHR0cDovL2NkcDEucGNhLmRmbi5kZS91bmktYm9ubi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5j
cnQwRAYIKwYBBQUHMAKGOGh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvdW5pLWJvbm4tY2EvcHVi
L2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQA+5K1isTxmWTmGb6QNVDQp
thzyzFlmQ49CPAoxP0tN2fJRHwmUmTfQaTXJ32sqYFuHb/tGl+IJKzutHGm6BLxtmkOr6Cfn
K4JEnxZc6xFSb1p2vmK2b0pmepzgH9VxiPRsEpqLpUvSJNfUyT2++9PKHnCDo/Q8c/Ajrq1A
9A9BGriCELW/SbWm7LT8EsXEddHKc9OM29tlZde5kRTqNU7EsxotPdG2HfHSn+D2YQwU3aBv
e46kr8lQhddJ2IVT7W9Tieszv0TsANr7DS9K8fXIu4oWFo25h48kl6fttP3vYJOaQqKUrRdY
j1+3zmjbfE4BzjWCMWZTumroU/2HKfBeMYIEgzCCBH8CAQEwgcYwgboxCzAJBgNVBAYTAkRF
MRwwGgYDVQQIExNOb3JkcmhlaW4tV2VzdGZhbGVuMQ0wCwYDVQQHEwRCb25uMRowGAYDVQQK
ExFVbml2ZXJzaXRhZXQgQm9ubjEfMB0GA1UECxMWSG9jaHNjaHVscmVjaGVuemVudHJ1bTEd
MBsGA1UEAxMUVW5pdmVyc2l0YWV0IEJvbm4gQ0ExIjAgBgkqhkiG9w0BCQEWE2NhYWRtaW5A
dW5pLWJvbm4uZGUCBxusOyn7AfUwDQYJYIZIAWUDBAIBBQCgggKNMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDcxODExMzMzNVowLwYJKoZIhvcNAQkE
MSIEIPRKWD3b+T3bl3zDFsLsxWXYJz1j28v/3OXHEPV6jVrgMGwGCSqGSIb3DQEJDzFfMF0w
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAw
DQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgdcGCSsGAQQBgjcQBDGB
yTCBxjCBujELMAkGA1UEBhMCREUxHDAaBgNVBAgTE05vcmRyaGVpbi1XZXN0ZmFsZW4xDTAL
BgNVBAcTBEJvbm4xGjAYBgNVBAoTEVVuaXZlcnNpdGFldCBCb25uMR8wHQYDVQQLExZIb2No
c2NodWxyZWNoZW56ZW50cnVtMR0wGwYDVQQDExRVbml2ZXJzaXRhZXQgQm9ubiBDQTEiMCAG
CSqGSIb3DQEJARYTY2FhZG1pbkB1bmktYm9ubi5kZQIHG6w7KfsB9TCB2QYLKoZIhvcNAQkQ
AgsxgcmggcYwgboxCzAJBgNVBAYTAkRFMRwwGgYDVQQIExNOb3JkcmhlaW4tV2VzdGZhbGVu
MQ0wCwYDVQQHEwRCb25uMRowGAYDVQQKExFVbml2ZXJzaXRhZXQgQm9ubjEfMB0GA1UECxMW
SG9jaHNjaHVscmVjaGVuemVudHJ1bTEdMBsGA1UEAxMUVW5pdmVyc2l0YWV0IEJvbm4gQ0Ex
IjAgBgkqhkiG9w0BCQEWE2NhYWRtaW5AdW5pLWJvbm4uZGUCBxusOyn7AfUwDQYJKoZIhvcN
AQEBBQAEggEAA5Z7HzZarXNqZTX/iUGf/SpcBsEhuMEzJPn2BQlgBrFPxbzUWxDGVqtRUZAe
o5AwI0QveAynjbyAPLsDzGO6OFs+7ewX4g/P8qHxZ017/J1kfaLjp8cWx+MtzVRUviD/dOgb
ddYdGqbJvRCnugFA4RWxjzRxuNTXHrECN9eLJhh9cNTAaUpZPz6+Y6sLP+GU05RrgLEuRK0Z
cUh6I1ONBjwZhuqXwRYOVSeNi1SypfbnyyK3eazDv3s45ItKbMiJ1PxP+NNSILkQ8WIngdxW
ZAzsgDK+I5xzcDmwxKMvXPUQws7KSGRF7lRpruI5wSzXeUb2ob26vWqDcmb/sGx24AAAAAAA
AA==
--------------ms020700020605090803060605--

--===============7620251567298232587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7620251567298232587==--
