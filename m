From: Oliver Freyermuth <freyermuth-PRwTpj6vllKyLsESG3L8NIQuADTiUCJX@public.gmane.org>
Subject: Re: HELP! --> CLUSER DOWN (was "v13.2.1 Mimic
 released")
Date: Mon, 30 Jul 2018 10:44:16 +0200
Message-ID: <df40714b-4dd4-06cc-b104-d70b9f3d3536@physik.uni-bonn.de>
References: <alpine.DEB.2.11.1807271924250.15688@piezo.novalocal>
 <086B2EB1-4349-4694-856C-ECA50FBF6211@godaddy.com>
 <trinity-977054d3-80b8-4be9-9a69-009e8b25c718-1532789176388@3c-app-gmx-bs12>
 <422702b2-35c6-413e-bb9f-506921ccb3fc@email.android.com>
 <trinity-331a4fa8-ed1e-4a06-8e8f-0b2519cf5904-1532813725473@3c-app-gmx-bs14>
 <trinity-ac10e367-ef5e-458d-b5aa-d1d671b3a5c7-1532826164122@3c-app-gmx-bs02>
 <CAKPXa=ZLDi17fnf5gq0RfGPp_RGoFWQ7EutbqPuJ7OoJte=G_w@mail.gmail.com>
 <trinity-5e17c1fa-bf9a-4faf-b6d8-4ddde0463064-1532855791187@3c-app-gmx-bs56>
 <7404124f-008d-744e-9866-9a41ca88bd79@suse.cz>
 <trinity-6a6dc71a-9bf5-4999-817a-ba833afe2a8d-1532937024317@3c-app-gmx-bs73>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3783547048603127868=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <trinity-6a6dc71a-9bf5-4999-817a-ba833afe2a8d-1532937024317@3c-app-gmx-bs73>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org, Nathan Cutler <ncutler-AlSwsSmVLrQ@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Peter Wienemann <wienemann-PRwTpj6vllKyLsESG3L8NIQuADTiUCJX@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a cryptographically signed message in MIME format.

--===============3783547048603127868==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000705040505030700030902"

This is a cryptographically signed message in MIME format.

--------------ms000705040505030700030902
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi together,

for all others on this list, it might also be helpful to know which setup=
s are likely affected.=20
Does this only occur for Filestore disks, i.e. if ceph-volume has taken o=
ver taking care of these?=20
Does it happen on every RHEL 7.5 system?=20

We're still on 13.2.0 here and ceph-detect-init works fine on our CentOS =
7.5 systems (it just echoes "systemd").=20
We're on Bluestore.=20
Should we hold off on an upgrade, or are we unaffected?=20

Cheers,
Oliver

Am 30.07.2018 um 09:50 schrieb ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org:
> Hey Nathan.
>=20
> No blaming here. I'm very thankful for this great peace (ok, sometime m=
ore of a beast ;) ) of open-source SDS and all the great work around it i=
ncl. community and users... and happy the problem is identified and can b=
e fixed for others/the future as well :)
> =C2=A0
> Well, yes, can confirm your found "error" also here:
>=20
> [root@sds20 ~]# ceph-detect-init
> Traceback (most recent call last):
>   File "/usr/bin/ceph-detect-init", line 9, in <module>
>     load_entry_point('ceph-detect-init=3D=3D1.0.1', 'console_scripts', =
'ceph-detect-init')()
>   File "/usr/lib/python2.7/site-packages/ceph_detect_init/main.py", lin=
e 56, in run
>     print(ceph_detect_init.get(args.use_rhceph).init)
>   File "/usr/lib/python2.7/site-packages/ceph_detect_init/__init__.py",=
 line 42, in get
>     release=3Drelease)
> ceph_detect_init.exc.UnsupportedPlatform: Platform is not supported.: r=
hel  7.5
>=20
>=20
> Gesendet:=C2=A0Sonntag, 29. Juli 2018 um 20:33 Uhr
> Von:=C2=A0"Nathan Cutler" <ncutler-AlSwsSmVLrQ@public.gmane.org>
> An:=C2=A0ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org, "Vasu Kulkarni" <vakulkar@redhat=
=2Ecom>
> Cc:=C2=A0ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "Ceph Development" <ce=
ph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Betreff:=C2=A0Re: [ceph-users] HELP! --> CLUSER DOWN (was "v13.2.1 Mimi=
c released")
>> Strange...
>> - wouldn't swear, but pretty sure v13.2.0 was working ok before
>> - so what do others say/see?
>> - no one on v13.2.1 so far (hard to believe) OR
>> - just don't have this "systemctl ceph-osd.target" problem and all jus=
t works?
>>
>> If you also __MIGRATED__ from Luminous (say ~ v12.2.5 or older) to Mim=
ic (say v13.2.0 -> v13.2.1) and __DO NOT__ see the same systemctl problem=
s, whats your Linix OS and version (I'm on RHEL 7.5 here) ? :O
>=20
> Best regards
>  Anton
>=20
> ----------------------------
>=20
> Hi ceph.novice:
>=20
> I'm the one to blame for this regretful incident. Today I have
> reproduced the issue in teuthology:
>=20
> 2018-07-29T18:20:07.288 INFO:teuthology.orchestra.run.ovh093:Running:
> 'sudo TESTDIR=3D/home/ubuntu/cephtest bash -c ceph-detect-init'
> 2018-07-29T18:20:07.796
> INFO:teuthology.orchestra.run.ovh093.stderr:Traceback (most recent call=

> last):
> 2018-07-29T18:20:07.797 INFO:teuthology.orchestra.run.ovh093.stderr:
> File "/bin/ceph-detect-init", line 9, in <module>
> 2018-07-29T18:20:07.797 INFO:teuthology.orchestra.run.ovh093.stderr:
> load_entry_point('ceph-detect-init=3D=3D1.0.1', 'console_scripts',
> 'ceph-detect-init')()
> 2018-07-29T18:20:07.797 INFO:teuthology.orchestra.run.ovh093.stderr:
> File "/usr/lib/python2.7/site-packages/ceph_detect_init/main.py", line
> 56, in run
> 2018-07-29T18:20:07.797 INFO:teuthology.orchestra.run.ovh093.stderr:
> print(ceph_detect_init.get(args.use_rhceph).init)
> 2018-07-29T18:20:07.797 INFO:teuthology.orchestra.run.ovh093.stderr:
> File "/usr/lib/python2.7/site-packages/ceph_detect_init/__init__.py",
> line 42, in get
> 2018-07-29T18:20:07.797 INFO:teuthology.orchestra.run.ovh093.stderr:
> release=3Drelease)
> 2018-07-29T18:20:07.797
> INFO:teuthology.orchestra.run.ovh093.stderr:ceph_detect_init.exc.Unsupp=
ortedPlatform:
> Platform is not supported.: rhel 7.5
>=20
> Just to be sure, can you confirm? (I.e. issue the command
> "ceph-detect-init" on your RHEL 7.5 system. Instead of saying "systemd"=

> it gives an error like above?)
>=20
> I'm working on a fix now at https://github.com/ceph/ceph/pull/23303
>=20
> Nathan
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20



--------------ms000705040505030700030902
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDczMDA4NDQxNlowLwYJKoZIhvcNAQkE
MSIEIIi6hbvF/5dd75Qci6s6Zw3hC2RcccvV3BS4oMqLBAQzMGwGCSqGSIb3DQEJDzFfMF0w
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
AQEBBQAEggEAfIbNCDPgHOeoZaoms4yFswdPM0bWs1IpfMHAxaXFc+XRDClpg6vTfHYoKxXP
UzprjeVEfO+5h97kysp2d/lGSwbX6XE57UKj7dgEaI2TYQYIHNXgfknqtzxg7oOmHNmO49//
BOCId4+3rhimbxUfjhyW/++IwIYe+0HkUWmdtOE6BY0C86QybR4uGiw0zALtkDCqCovW8VV/
1PstO3wmUpAZoL/Im1tMwVhPmLmY2VprL5pLe3dSqZ3mJ82v1sziciVImF7Iyp5XuyIhdjCF
Sjxl9X+nGfTY7MByUkvVk63o37CY2cI3Ad+1zfECMRyLebB6eDiHvSeBUo0Py70bSQAAAAAA
AA==
--------------ms000705040505030700030902--

--===============3783547048603127868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3783547048603127868==--
