From: Valery Tschopp <valery.tschopp@switch.ch>
Subject: Re: ceph nagios plugins
Date: Thu, 3 Aug 2017 17:15:04 +0200
Message-ID: <4e03d988-19c1-9ceb-12ce-e77594259d7e@switch.ch>
References: <alpine.DEB.2.11.1708011414210.20435@piezo.novalocal>
 <CALqRxCw2EWH4cHuogSgYSFrqZa0F-nfdgbgG_R1PUbkJekcheg@mail.gmail.com>
 <80e8e181-3c8a-7932-f1ac-a78fb4358153@switch.ch>
 <alpine.DEB.2.11.1708021404130.20435@piezo.novalocal>
 <CALqRxCy=O2iP-8zv=FcqKLvJ+U_ZkL1wGTjkBuncyc4MdcZT=Q@mail.gmail.com>
 <1f8f7749-dd0c-fa29-b05d-e0d3373a2147@switch.ch>
 <CALqRxCzqpvgFA95+RTA74O4q7xoB0HFxC85oJ3=kGNfn8UwOew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030903080402040804030805"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from iberico.switch.ch ([130.59.113.143]:53191 "EHLO
        iberico.switch.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbdHCPPT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Aug 2017 11:15:19 -0400
In-Reply-To: <CALqRxCzqpvgFA95+RTA74O4q7xoB0HFxC85oJ3=kGNfn8UwOew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms030903080402040804030805
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Ken,

It is done, the repository is now transferred to the Ceph organization:

    https://github.com/ceph/ceph-nagios-plugins

I don't know if the permissions are correct for the other members of=20
Ceph. For me it is OK, I still can commit.

Cheers,
Valery

On 03/08/17 16:42 , Ken Dreyer wrote:
> Hi Valery,
>=20
> Shoot, I think I may have to be added as an admin in
> https://github.com/red-hat-storage/valerytschopp/ceph-nagios-plugins/se=
ttings/collaboration.
>=20
> If that doesn't work, I've temporarily toggled "Allow members to
> create repositories" at
> https://github.com/organizations/ceph/settings/member_privileges , so
> it might work for you now.
>=20
> - Ken
>=20
> On Thu, Aug 3, 2017 at 2:21 AM, Valery Tschopp <valery.tschopp@switch.c=
h> wrote:
>> Hi Ken and Sage,
>>
>> Ok. I've accepted the invitation, and then tried to transfer my
>> ceph-nagios-plugins repository to the Ceph org, but I only get the fol=
lowing
>> error:
>>
>> "You don=E2=80=99t have the permission to create repositories on ceph"=

>>
>> So I've add Ken account 'ktdreyer' as a collaborator. How should we
>> continue?
>>
>> Cheers,
>> Valery
>>
>>
>> On 02/08/17 18:38 , Ken Dreyer wrote:
>>>
>>> On Wed, Aug 2, 2017 at 8:13 AM, Sage Weil <sweil@redhat.com> wrote:
>>>>
>>>>    We can also either just fork your
>>>> repo into the ceph org and start sending pull requests there, or we =
can
>>>> transfer your repo over.  (I'm not sure it matters?)
>>>
>>>
>>> It would be great to do the transfer because GitHub handles redirects=

>>> for the old URLs seamlessly, retains the issues and PR numbers, etc.
>>>
>>> I've created a "nagios" team https://github.com/orgs/ceph/teams/nagio=
s
>>> and invited you to it Valery. I'm not sure if you have access to star=
t
>>> the transfer at
>>> https://github.com/valerytschopp/ceph-nagios-plugins/settings into th=
e
>>> Ceph org or if you'll need to add me as a collaborator.
>>>
>>> - Ken
>>>
>>
>> --
>> SWITCH
>> Val=C3=A9ry Tschopp, Software Engineer
>> Werdstrasse 2, P.O. Box, 8021 Zurich, Switzerland
>> email: valery.tschopp@switch.ch phone: +41 44 268 1544
>>
>> 30 years of pioneering the Swiss Internet.
>> Celebrate with us at https://swit.ch/30years
>>
>>

--=20
SWITCH
Val=C3=A9ry Tschopp, Software Engineer
Werdstrasse 2, P.O. Box, 8021 Zurich, Switzerland
email: valery.tschopp@switch.ch phone: +41 44 268 1544

30 years of pioneering the Swiss Internet.
Celebrate with us at https://swit.ch/30years



--------------ms030903080402040804030805
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
C40wggWaMIIEgqADAgECAhRqKArzRiMoMclbQsKdJMSoLMM14zANBgkqhkiG9w0BAQsFADB/
MQswCQYDVQQGEwJCTTEZMBcGA1UEChMQUXVvVmFkaXMgTGltaXRlZDElMCMGA1UECxMcUm9v
dCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEuMCwGA1UEAxMlUXVvVmFkaXMgUm9vdCBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xNDA1MzAxODUwMTNaFw0yMTAzMTcxODMzMzNaMGMx
CzAJBgNVBAYTAkNIMSwwKgYDVQQKEyNRdW9WYWRpcyBUcnVzdGxpbmsgU3dpdHplcmxhbmQg
THRkLjEmMCQGA1UEAxMdUXVvVmFkaXMgU3dpc3MgQWR2YW5jZWQgQ0EgRzIwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQCyge5EB5ZP/fnk47KPgdEpuiBd9u7lcdLWxeGLOtrv
YYp52fawKeNgm3oQogK4gPQxBMD2Wa080nOPo307UzrQQAe37lFCJqXlLpVBluVqjQdPpk9g
syucalNwstNBHmj1xoXgUfTXhTrRWgkAuxGhGL9odj2+9QxbwVywjikgcidsDzVmo23mXc3x
KWik6BIp3zbDjfTTyitIX+NIlDiaMxwq6L5QPnazrE2eNsSJrHmwz/Ie3gm8aDVy14+gE1sn
Ew6CK2x/NncRcl/WcdaBjQN338DHN5u/FJI84NMt58y0BYiH3V3zF6qvntm4n0W216jHXcyy
DHmSIEDMpbApuAOh/jhRj+BXq9K/Vnm3PghWJAHXembeS4Ax0sXMUrrC8mQUW+OOELONE2L+
odG0+1cwnnLD2CEJmXCIcoCLsQL1Op7zmF8XXOExLZUtR73oNi1sIs8Ic3mrOln8shz8tVkL
lKmSskr3ilUKQn7M5zKX7F6WKlbA3Vy4hz+IMyjEMAg2cAxNuu6MKEneoUrlGUiEJnxjvFmW
segwFRVbBcZepRV+cX0d3aViVieUektNjUGsXrRBeADSqH7jj42IdlA6J0Mcv6HnPjuYn+hU
8XyR2EhycpVfWzsA3LuKmSfqQfty1qNNE6Tsxb7YCBbEt+ijnnNHQJ1XNV/jR5wg3wIDAQAB
o4IBKDCCASQwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAIMAYGBFUdIAAwcQYIKwYB
BQUHAQEEZTBjMCoGCCsGAQUFBzABhh5odHRwOi8vb2NzcC5xdW92YWRpc2dsb2JhbC5jb20w
NQYIKwYBBQUHMAKGKWh0dHA6Ly90cnVzdC5xdW92YWRpc2dsb2JhbC5jb20vcXZyY2EuY3J0
MA4GA1UdDwEB/wQEAwIBBjAfBgNVHSMEGDAWgBSLS23t0ym5BhnsOTmp8JeEasvv3zA4BgNV
HR8EMTAvMC2gK6AphidodHRwOi8vY3JsLnF1b3ZhZGlzZ2xvYmFsLmNvbS9xdnJjYS5jcmww
HQYDVR0OBBYEFKAgbW1JXbpKhdN3ILJ6uIsO7dWdMA0GCSqGSIb3DQEBCwUAA4IBAQCuMV65
UC3RkrbWAhVOWN8VKS1am+0sRTHC379oueJLAv3aWkNL9kDlTC0m+cNiK1/IQ/vVxpPtloqF
bqWL4VtIlqauzSLOQuSNCuRPftMDkHf5IgbcHEeyCMi5z7ZM8Q3thlDSV6vC+F8lhQ1CNB8Y
CHL99BtAGwhQs3Zn33FQjCguqAYsAkbmOkXMUSJ9UflrALhI6YXPUqn74JpZVu2lNJ6UgXzl
d9QpYV3E130Tjx1jdcCBynDL7ibco5VV9CBFxUGdoRiBJr9lomVPyzm7rZJy5hx+qoNnNGoD
StJklLF7eogKKYZGxgy9DJDmUevdmBiSaUYNmzCOpJwgXlcmMIIF6zCCA9OgAwIBAgIUEZ+8
ZD67NDFHeP9D8dyVsWSUlH8wDQYJKoZIhvcNAQELBQAwYzELMAkGA1UEBhMCQ0gxLDAqBgNV
BAoTI1F1b1ZhZGlzIFRydXN0bGluayBTd2l0emVybGFuZCBMdGQuMSYwJAYDVQQDEx1RdW9W
YWRpcyBTd2lzcyBBZHZhbmNlZCBDQSBHMjAeFw0xNDEyMjIxMDAyMTNaFw0xNzEyMjIxMDAy
MDlaMFwxCzAJBgNVBAYTAkNIMRAwDgYDVQQIEwdadWVyaWNoMRAwDgYDVQQHEwdadWVyaWNo
MQ8wDQYDVQQKEwZTV0lUQ0gxGDAWBgNVBAMMD1ZhbMOpcnkgVHNjaG9wcDCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBALw/VUBYWrCYOvbf+sF+bGuY2KKPg3HtZydZjBeQwUiD
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
--------------ms030903080402040804030805--
