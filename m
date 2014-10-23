From: Andrea Ieri <andrea.ieri@cern.ch>
Subject: Re: kerberos / AD requirements, blueprint
Date: Thu, 23 Oct 2014 16:19:06 +0200
Message-ID: <54490E5A.408@cern.ch>
References: <alpine.DEB.2.00.1410161253090.5588@cobra.newdream.net> <8667CC8E-D4CD-4BD2-8299-3341FEB848B6@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms050009090803060004010304"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:54625 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178AbaJWOYl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Oct 2014 10:24:41 -0400
In-Reply-To: <8667CC8E-D4CD-4BD2-8299-3341FEB848B6@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Van Der Ster <daniel.vanderster@cern.ch>, Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "abartlet@catalyst.net.nz" <abartlet@catalyst.net.nz>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>

--------------ms050009090803060004010304
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

It's perhaps useful to clear up that Kerberos as a protocol provides your=
 service with the following information (at the end of the initial exchan=
ge):
1. a string representing a Kerberos principal (user@REALM)
2. a session key, known only to you and the principal above
3. a reasonable assurance that whoever sent you the ticket that contains =
the data above controls the principal mentioned (as in "knows its passwor=
d")

Now, you can choose what to do with the information above.
- you'll most likely need to map the "principal" to a "user", whatever th=
at means for your system (a UID/GID tuple obtained via LDAP? A user strin=
g in your own local database?)
- you'll have to decide what to do with the session key. Do you want to e=
ncrypt all communication? Implement a MAC? Throw it away? See for example=
 the different Kerberos options in NFSv4

In any case as you can see Kerberos is not concerned with authorization a=
t all. How you enforce permissions is out of its scope.

Cheers,
Andrea

On 22/10/2014 18:39, Dan Van Der Ster wrote:
> Hi Sage,
>
>> On 16 Oct 2014, at 21:57, Sage Weil <sage@newdream.net> wrote:
>>
>> I started to write up a blueprint for kerberos / LDAP / AD support:
>>
>> 	https://wiki.ceph.com/Planning/Blueprints/Hammer/kerberos_authn%2C_AD=
_authn%2F%2Fauthz
>>
>> In case it isn't clear from that document, I only sort of know what I'=
m=20
>> talking about here.  (This is largely based on what I managed to retai=
n=20
>> from a conversation with Andrew, but I suspect I got some of it wrong.=
)
>>
>> For anyone working in environments where kerberos is in use, I am *ver=
y*=20
>> interested in hearing what your requirements are for your environment.=
  In=20
>> particular, are you using AD or LDAP or something else?  How do you ex=
pect=20
>> RBAC to work for you?
> Let=E2=80=99s talk about requirements then. (Anyway, I=E2=80=99m not in=
 any way a kerberos expert and it is not 100% clear to me what you are tr=
ying to achieve.)
>
> Firstly, our environment is almost identical to that described by Marcu=
s (we use AD). For filesystems, our user communities are used to the way =
OpenAFS works with kerberos. Generally, that means they use kinit && aklo=
g to authenticate and they understand (mostly) how to use AFS groups and =
AFS ACLs for authz.
>
> Next I basically have a bunch of questions to clarify your goals. The f=
irst part of your blueprint seems to be a convenient way to distribute ce=
phx keyrings. To prevent harvesting/reuse, would you intend those to not =
be =E2=80=9Cnormal=E2=80=9D cephx keyrings as such, but rather to be keyr=
ings encrypted by the mon/whatever and time limited?
>
> For authz, is this mechanism meant to be used for RADOS only, or also f=
or CephFS?
>
> If RADOS only, then as I understand it you could basically add the curr=
ent cephx capabilities (with pool granularity) to the proposed ceph user =
db (perhaps scoped down to a few limited roles). I wouldn=E2=80=99t expec=
t to be able to manipulate ceph capabilities via some AD blob (due mostly=
 to my AD ignorance). I would probably expect to add our authorised ceph =
users to an AD group, then keep that in sync with your ceph user/role/cap=
ability db.
>
> If CephFS, then the problem I see is that the POSIX permissions/ACLs ar=
e being evaluated only on the client side. Were you thinking to change th=
at, i.e. to add some notion of CephFS file-granular cephx capabilities? W=
e thought a little bit about this before:
>   https://wiki.ceph.com/Planning/Blueprints/%3CSIDEBOARD%3E/Strong_Auth=
N_and_AuthZ_for_CephFS
> The basic idea was to have an MDS or other service that evaluates permi=
ssions/ACLs on the server side then hands out an extra signed capability =
to be used by the client for IOs with an OSD. It seems heavyweight, howev=
er, so I=E2=80=99m not sure how this would perform in practise.
>
> Hope that helps,
> Dan
>
>
>
>
>> We'll definitely have a slot for this at the upcoming CDS, but anythin=
g we=20
>> can hash out before then will make that conversation more productive.
>>
>> Thanks!
>> sage
>>



--------------ms050009090803060004010304
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIScDCC
CPIwggbaoAMCAQICCjV3Q6sAAAAAOiEwDQYJKoZIhvcNAQENBQAwVjESMBAGCgmSJomT8ixk
ARkWAmNoMRQwEgYKCZImiZPyLGQBGRYEY2VybjEqMCgGA1UEAxMhQ0VSTiBHcmlkIENlcnRp
ZmljYXRpb24gQXV0aG9yaXR5MB4XDTE0MDQyODE0MTM1N1oXDTE1MDQyODE0MTM1N1owgYkx
EjAQBgoJkiaJk/IsZAEZFgJjaDEUMBIGCgmSJomT8ixkARkWBGNlcm4xFjAUBgNVBAsTDU9y
Z2FuaWMgVW5pdHMxDjAMBgNVBAsTBVVzZXJzMQ4wDAYDVQQDEwVhaWVyaTEPMA0GA1UEAxMG
NzE5OTc3MRQwEgYDVQQDEwtBbmRyZWEgSWVyaTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAKzPu5qWuaqmhAp/fmJj8ZorOSoYejSb67xk4nM8VSeWZ//DIWJxSMM5f1oJKHba
EgMCriV7ytd8XViphcbqn+YZw8ap2i+oEXbTHw5FwI1L+f8CohX7S9ezMiPmijrXKuO7dYCh
s2Hr/U8O6sm1mn1DboHG+Cgetz20mdz21wekyq389IweHeeAqmq1+8A76/V08NGEAOo8WeIr
jQ34nF7lrN0BfiGQn7PLfcWjPeUBDaYURawsn5htWUOSLxctKuskFs3/TmFYogIg8HRfwwcJ
rte/N5b+ke1ZKmMlswGIUR9gV6k6iVNTyL0Lcex7bT7Jf4sYdHIjhdBztaKJPOUCAwEAAaOC
BIwwggSIMB0GA1UdDgQWBBRlnC3IJdPj8WSao8Dw0Nc0Xd2OqDAfBgNVHSMEGDAWgBSloP1m
WP253Xrhsp2fo9HlUBiU5zCCATgGA1UdHwSCAS8wggErMIIBJ6CCASOgggEfhk5odHRwOi8v
Y2FmaWxlcy5jZXJuLmNoL2NhZmlsZXMvY3JsL0NFUk4lMjBHcmlkJTIwQ2VydGlmaWNhdGlv
biUyMEF1dGhvcml0eS5jcmyGgcxsZGFwOi8vL0NOPUNFUk4lMjBHcmlkJTIwQ2VydGlmaWNh
dGlvbiUyMEF1dGhvcml0eSxDTj1DRVJOUEtJMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUy
MFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Y2VybixEQz1jaD9j
ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0
aW9uUG9pbnQwggFiBggrBgEFBQcBAQSCAVQwggFQMGMGCCsGAQUFBzAChldodHRwOi8vY2Fm
aWxlcy5jZXJuLmNoL2NhZmlsZXMvY2VydGlmaWNhdGVzL0NFUk4lMjBHcmlkJTIwQ2VydGlm
aWNhdGlvbiUyMEF1dGhvcml0eS5jcnQwgcIGCCsGAQUFBzAChoG1bGRhcDovLy9DTj1DRVJO
JTIwR3JpZCUyMENlcnRpZmljYXRpb24lMjBBdXRob3JpdHksQ049QUlBLENOPVB1YmxpYyUy
MEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Y2VybixE
Qz1jaD9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhv
cml0eTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY2Vybi5jaC9vY3NwMA4GA1UdDwEB/wQE
AwIFoDA9BgkrBgEEAYI3FQcEMDAuBiYrBgEEAYI3FQiDvdAJgu2NDYbtiyuB3vU3hYDQYh6F
iuNMgbWqBAIBZAIBDjApBgNVHSUEIjAgBgorBgEEAYI3CgMEBggrBgEFBQcDBAYIKwYBBQUH
AwIwaAYDVR0gBGEwXzBdBgorBgEEAWAKBAEBME8wTQYIKwYBBQUHAgEWQWh0dHA6Ly9jYS1k
b2NzLmNlcm4uY2gvY2EtZG9jcy9jcC1jcHMvY2Vybi10cnVzdGVkLWNhMi1jcC1jcHMucGRm
MDUGCSsGAQQBgjcVCgQoMCYwDAYKKwYBBAGCNwoDBDAKBggrBgEFBQcDBDAKBggrBgEFBQcD
AjBDBgNVHREEPDA6oCMGCisGAQQBgjcUAgOgFQwTYW5kcmVhLmllcmlAY2Vybi5jaIETYW5k
cmVhLmllcmlAY2Vybi5jaDBEBgkqhkiG9w0BCQ8ENzA1MA4GCCqGSIb3DQMCAgIAgDAOBggq
hkiG9w0DBAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwDQYJKoZIhvcNAQENBQADggIBALxA
i909FG0zFrs19J5iqsGe3k7kDzMBNxQkah9Bgl0n1TZYCwjPikefJ6GCvoBNvGWsHMTNY8xp
M3L3z0hTiQ67I24bHI/KNHW1l0kTCZY/0rl2pq9sQ22nlUT3qpOkd620m51jawoMkwmyKQ5B
L6ihxU8B1iyi57hAmcZndZ3/meLM10LPh/3PLZFruvqRMBnUfqIjMpSRC5xERDDwHKf7Oedz
JPdpU7cVpRxtQ4XhH3WvWaElUxLARjRWrES0xf3T17ku3UtGgQuIUTWQl0sgBoybEP67+H0w
021InpScliHBzvCODTq4qDR45NjK30VyKsfhnUOxXhoEXFjM/WRlwVK6EX8km4BKHso3+1nk
+AmY4MZTOhmUoop8qHSCHzm7tlPM0f5zgTw3qQOcnShgsDvayaU5RfoCptoAwhQUrcY0lIkr
AUYd2F8XvF2AfbRHLFj9W1W7Z7l05x79eJ1zREH1mceUF0trSsjim4SH6GmM57SV5bzu7kBM
q9uHr55jPA19mGZKsUjVrIHlIXJTlItPhAH2Jutk4phNLFVrAz2dw+xjTAVXmWkDUbq5Yur0
RLIKTKXtopjY80FiCljm6tJe2OExjiHYuRXmaPZeUuM4d+AG1TJ6c34o2hNQcFCB3tli2sfc
ka/3gzOL3OhJzjuuZfn/fXrdQw0FO5qvMIIJdjCCB16gAwIBAgIKYZhqPwAAAAAAAzANBgkq
hkiG9w0BAQ0FADBKMQswCQYDVQQGEwJjaDENMAsGA1UEChMEQ0VSTjEsMCoGA1UEAxMjQ0VS
TiBSb290IENlcnRpZmljYXRpb24gQXV0aG9yaXR5IDIwHhcNMTMwNDIyMTExMDE2WhcNMjMw
NDIyMTEyMDE2WjBWMRIwEAYKCZImiZPyLGQBGRYCY2gxFDASBgoJkiaJk/IsZAEZFgRjZXJu
MSowKAYDVQQDEyFDRVJOIEdyaWQgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDS9Ypy1csm0aZA4/QnWe2oaiQILqfeekV8kSSvOhW2
peo5cLNIKbXATOo1l2iwIbCWV8SRU2TLKxHIL8fAOJud5n9KmEKBew7nzubl1wG93B4dY0KR
Edb3/QB/7OkG8ZZvLqrvQZVGT1CgJ+NFFUiJ315DFWkKctZv27LjQamzCxpX+gZSsmwZmSRe
Y67cnm6P7z+/3xVNhwb+4Z+1Ww4vHhMcdh1Dsrkv9vXU01UN752QtQ6l56uQLYEB2+vaHB6I
pyC9zAQ/33GulCq8Gbj7ykPd9AcRVBeJAErSK+oMHThtdLD7mhTkZivakaNe4O1EhPFH0rWw
V45IFN7ipELA5qDxdjdzo6JtLJQMaSV/TV+amEf2CaKlD0giqGhjfSNiOX5HCmpqV14kbl+7
Qho6ykZyb1DGpf70yILnX+AUtdpd8lulTu1yg1Bg5cFQskUIk5+s4nsC1VpmeNxYaeFEcYZj
Ph2mdD7zLo889MtF7kZv7+6J6p4NBL3fQ9Os8/h8XVlfDatzbpVH4jYKKAd4nwJbknJaKPE0
LzLzVfJBwnDxqe8hb64gI8Frludp+jaOYzvMqlzAe9z4a9971iXIWaaGunbAoEkXj69y7Msv
CjWXB7o9HdBaS9FL+ZtXTKCyXl+XLFseYQoQburKr+eTcRedKLJNj4tRF1799PO69wIDAQAB
o4IEUDCCBEwwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFKWg/WZY/bndeuGynZ+j0eVQ
GJTnMIIBLQYDVR0gBIIBJDCCASAwggEcBgorBgEEAWAKBAEBMIIBDDCBvgYIKwYBBQUHAgIw
gbEega4AQwBFAFIATgAgAEcAcgBpAGQAIABDAGUAcgB0AGkAZgBpAGMAYQB0AGkAbwBuACAA
QQB1AHQAaABvAHIAaQB0AHkAIABDAGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAG8AbABpAGMA
eQAgAGEAbgBkACAAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAUAByAGEAYwB0AGkAYwBlACAA
UwB0AGEAdABlAG0AZQBuAHQwSQYIKwYBBQUHAgEWPWh0dHA6Ly9jYWZpbGVzLmNlcm4uY2gv
Y2FmaWxlcy9jcC1jcHMvY2Vybi1ncmlkLWNhLWNwLWNwcy5wZGYwGQYJKwYBBAGCNxQCBAwe
CgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAU
+nv73psNo/JSt2ztWw8Loqam+AQwggFEBgNVHR8EggE7MIIBNzCCATOgggEvoIIBK4ZSaHR0
cDovL2NhZmlsZXMuY2Vybi5jaC9jYWZpbGVzL2NybC9DRVJOJTIwUm9vdCUyMENlcnRpZmlj
YXRpb24lMjBBdXRob3JpdHklMjAyLmNybIaB1GxkYXA6Ly8vQ049Q0VSTiUyMFJvb3QlMjBD
ZXJ0aWZpY2F0aW9uJTIwQXV0aG9yaXR5JTIwMixDTj1DRVJOUEtJUk9PVDAyLENOPUNEUCxD
Tj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9u
LERDPWNlcm4sREM9Y2g/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENs
YXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MIIBRAYIKwYBBQUHAQEEggE2MIIBMjBnBggrBgEF
BQcwAoZbaHR0cDovL2NhZmlsZXMuY2Vybi5jaC9jYWZpbGVzL2NlcnRpZmljYXRlcy9DRVJO
JTIwUm9vdCUyMENlcnRpZmljYXRpb24lMjBBdXRob3JpdHklMjAyLmNydDCBxgYIKwYBBQUH
MAKGgblsZGFwOi8vL0NOPUNFUk4lMjBSb290JTIwQ2VydGlmaWNhdGlvbiUyMEF1dGhvcml0
eSUyMDIsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9Y2VybixEQz1jaD9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTANBgkqhkiG9w0BAQ0FAAOCAgEAQjzXhTV8
d+6HaLqSnp7k9whxK6E75BZQJNR2Q/rslhhwijs6nekBjb+JPgmM6M0a7ra+D1Oi4wKaWiCv
U9yleZZSqfEkRl7WK9trRYXHqkqVSnmwNJNsediqioBBDHn/ZMnyc25ZOLbM+99Z+awvoMby
Py0moUrR7ZqKi3C02N2mkiidO0m3bYnXKwxDUvka5n06oLnIYSZfwFNJ7IEvSSF4mEzdDeQI
+A+87+deb5XOTXee8i1ZUyI08Cg6tuZ8W6NdvY7t+5iNxRmZJ6DBVwrvXutz0JSqklBCw267
osEpX0AKGSL9fE2yGlWBX8WfDLB43lVEz/HP7kQwYEmsfnfT2yTLzkMJrHSeR0Zymm/oB3am
ZziKex4kGk+/v7yV1pSYKJce9QDZE+LYio/ndz01sejMPS87prYJqnII5hDYUjg9F1Coaejh
jOlpmCU/10wyEVN0nhSP9Wc5z0+lhzU5C1A9r1gXQMuqCA2e7Cv5wv+r9dS+12Uly52jwmYf
8mm6H0ZYLZQbvMayHebD4WCnB7HNdp2Va4z5JrLvwG3J1EXfTjWiPhqOweevOg0rc6t2yhkM
iB9RXMlFoFzbsuE/4Z4Hd0GQcDijcnWJ/VbT15OD2C16yyBiLvu88nXX1gKuOzxLvu4cw9FO
uQZo147y9KPelpUT/SO+nrePzVsxggNGMIIDQgIBATBkMFYxEjAQBgoJkiaJk/IsZAEZFgJj
aDEUMBIGCgmSJomT8ixkARkWBGNlcm4xKjAoBgNVBAMTIUNFUk4gR3JpZCBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eQIKNXdDqwAAAAA6ITAJBgUrDgMCGgUAoIIBtzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNDEwMjMxNDE5MDZaMCMGCSqGSIb3DQEJ
BDEWBBTXjNKrabZmk9N53k0qQRc7ORL8+TBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQB
KjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMC
AgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMHMGCSsGAQQBgjcQBDFmMGQwVjESMBAGCgmS
JomT8ixkARkWAmNoMRQwEgYKCZImiZPyLGQBGRYEY2VybjEqMCgGA1UEAxMhQ0VSTiBHcmlk
IENlcnRpZmljYXRpb24gQXV0aG9yaXR5Ago1d0OrAAAAADohMHUGCyqGSIb3DQEJEAILMWag
ZDBWMRIwEAYKCZImiZPyLGQBGRYCY2gxFDASBgoJkiaJk/IsZAEZFgRjZXJuMSowKAYDVQQD
EyFDRVJOIEdyaWQgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkCCjV3Q6sAAAAAOiEwDQYJKoZI
hvcNAQEBBQAEggEAb1IL0fKrwDxozwofDlpmbExLndT4A+7SEUQAo9oQ6i9g67eDFGxEqWa9
c/uVWYlu3Oq8C/lRxnIz33lHRuXqsSCVMygBP0LoxXyYhD3beSsk+/Ga4wkmQ/TPH6nDZIoF
bVK9Q7EebRoU6uhhTKNmYnry5zLFjplQo6b2vimHg1JytTmVBaNSNpZcnQq70wjOHmHP9gde
g4tKFMGvE678Qh+/C/PlU20q3bUFH4VxLDWjFpT6zDLyGumL53DOIwt6Y9isW87/NhoJACWR
ZNh9GHj7EIcfyRKPwSlbCe1jsbN2iYFqllZ5xsYkav6M27ldyGwjvmPEHxKC1OsZfZjctwAA
AAAAAA==
--------------ms050009090803060004010304--
