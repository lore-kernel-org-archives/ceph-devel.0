From: Loic Dachary <loic@dachary.org>
Subject: rbd: default map options, new options, misc (Re: creating the issue
 for the v0.94.4 release)
Date: Mon, 17 Aug 2015 18:09:44 +0200
Message-ID: <55D20748.9030809@dachary.org>
References: <55CF14CB.1040900@dachary.org> <CAP3mxSyGkYz6vfbE4sNkV2K6iS4waBrptQ+Vnfprqc75Uc2CHg@mail.gmail.com> <55CF6607.8010808@dachary.org> <CAP3mxSyqMCicjzPGo119j5krgr74NnN1cp9D1mswdg=FLGqD_A@mail.gmail.com> <55CF9DD9.9020000@dachary.org> <1724454033.38265287.1439819503323.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cdQ4fLQoX9kCj2ijuQFmsBekkeCqMi2x6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39271 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755341AbbHQQJq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 12:09:46 -0400
In-Reply-To: <1724454033.38265287.1439819503323.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cdQ4fLQoX9kCj2ijuQFmsBekkeCqMi2x6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Josh,

Do you think it would make sense to backport https://github.com/ceph/ceph=
/pull/3979 to hammer ?

Cheers

On 17/08/2015 15:51, Alexandre DERUMIER wrote:
> Hi Loic,
>=20
> I wonder if we could backport
>=20
> https://github.com/ceph/ceph/pull/3979
>=20
> to hammer.
>=20
> It's mainly to add support to last kernels to cephx_require_signature a=
nd tcp_nodelay mount options.
>=20
>=20
> For example since kernel 3.19, cephx_require_signatures is the default,=
=20
> and they are no way to mount a rbd device without cephx_require_signatu=
re, with current hammer "rbd map ..."
>=20
> Regards,
>=20
> alexandre
>=20
>=20
> ----- Mail original -----
> De: "Loic Dachary" <loic@dachary.org>
> =C3=80: "Abhishek Varshney" <abhishek.varshney@flipkart.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Samedi 15 Ao=C3=BBt 2015 22:15:21
> Objet: Re: creating the issue for the v0.94.4 release
>=20
> Hi,=20
>=20
> On 15/08/2015 19:54, Abhishek Varshney wrote:=20
>> Done ! Let me know if it is fine.=20
>=20
> Perfect ! I have run the commands for you and the corresponding suite c=
an be seen at http://pulpito.ceph.com/. We usually add a link to each h4.=
 with something like:=20
>=20
> * *running* http://pulpito.ceph.com/loic-2015-08-15_22:00:55-rados-hamm=
er-backports---basic-multi=20
>=20
> etc. I expect teuthology will do something similar eventually but right=
 now we have to do that manually.=20
>=20
> As much as I like to be your command line proxy, things will be easier =
if you can run those yourself in the future ;-) I opened an issue to that=
 end at http://tracker.ceph.com/issues/12705. The staff in charge of the =
sepia lab is extremely busy and it may take a few weeks before you actual=
ly have access.=20
>=20
> Cheers=20
>=20
>>
>> Thanks=20
>> Abhishek=20
>>
>> On Sat, Aug 15, 2015 at 9:47 PM, Loic Dachary <loic@dachary.org <mailt=
o:loic@dachary.org>> wrote:=20
>>
>>
>>
>> On 15/08/2015 17:49, Abhishek Varshney wrote:> Hi Loic,=20
>>>
>>> Thanks for the detailed explanation. I have created an issue to keep =
track of hammer v0.94.4 release here : http://tracker.ceph.com/issues/127=
01. I guess the HOWTO page (http://tracker.ceph.com/projects/ceph-release=
s/wiki/HOWTO) would be updated with this tracker issue once v0.94.3 is re=
leased? Please correct me if I am wrong.=20
>>
>> You are correct.=20
>>
>> Could you also update the header http://tracker.ceph.com/issues/12701#=
teuthology-run-commit to mimic http://tracker.ceph.com/issues/11990#teuth=
ology-run-commit-1e841b08cc9534e654de50967f06113fb7383b0chammer-backports=
-July-20 ? It should be=20
>>
>> .h3 teuthology run commit e1dadd3da9e39daf669f94715c7833d2b280bbed=20
>> (hammer backports August-14)=20
>>
>> Because $ git rev-parse ceph/hammer-backports=20
>> e1dadd3da9e39daf669f94715c7833d2b280bbed=20
>>
>> which is the branch you populated and that was compiled by http://ceph=
=2Ecom/gitbuilder.cgi.=20
>>
>> The content of this h3. section should the the output of the command=20
>>
>> git --no-pager log --format=3D'%H %s' --graph ceph/hammer..ceph/hammer=
-backports | perl -p -e 's/"/ /g; if (/\w+\s+Merge (\d+)/) { s|\w+\s+Merg=
e (\d+).*|"Pull request $1":https://github.com/ceph/ceph/pull/$1|; } else=
 { s|(\w+)\s+(.*)|"$2":https://github.com/ceph/ceph/commit/$1|; } s/\*/+/=
; s/^/* /;'=20
>>
>> it starts with:=20
>>
>> * + "Pull request 5202":https://github.com/ceph/ceph/pull/5202=20
>> * |\=20
>> * | + "rpm: add missing Java conditionals":https://github.com/ceph/cep=
h/commit/6417e8eff942dbbf6cd231ffb73136b7bdcd837f=20
>> * + "Pull request 5203":https://github.com/ceph/ceph/pull/5203=20
>> * |\=20
>> * | + "Add rpm conditionals : cephfs_java":https://github.com/ceph/cep=
h/commit/37284773a754ef4b91d2b5436d46a5fd2be4f67e=20
>> * + "Pull request 5204":https://github.com/ceph/ceph/pull/5204=20
>> ...=20
>>
>> and should render nicely.=20
>>
>> This should then be followed by h4. section, one per test suite we are=
 going to run.=20
>>
>> h4. rbd=20
>>
>> <pre>=20
>> ./virtualenv/bin/teuthology-suite --priority 1000 --suite rbd --subset=
 $(expr $RANDOM % 5)/5 --suite-branch hammer --distro ubuntu --email loic=
@dachary.org <mailto:loic@dachary.org> --ceph hammer-backports --machine-=
type plana,burnupi,mira=20
>> </pre>=20
>>
>> etc.=20
>>
>> Once this is done, I will copy paste the command to actually schedule =
the test. And then we'll have to wait a few days for it to complete.=20
>>
>> Cheers=20
>>
>>>
>>> Regards=20
>>> Abhishek Varshney=20
>>>
>>> On Sat, Aug 15, 2015 at 4:00 PM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.org>>>=
 wrote:=20
>>>
>>> Hi Abhishek,=20
>>>
>>> I'll be driving the next hammer point release (v0.94.4) and theanalys=
t will participate as I did for v0.94.3 (i.e. helping and mentoring when =
there is a need). During the v0.94.4 release you will have the opportunit=
y to participate in all the steps. When we move to v0.94.5 you'll hopeful=
ly know all you need to drive it, should you want to. As you discovered o=
ver the past few weeks, it's not a complex process, but there are a lot o=
f details.=20
>>>
>>> Contrary to what I told you the other day=20
>>>
>>> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_backp=
orting_a_stable_release/diff?utf8=3D%E2%9C%93&version=3D7&version_from=3D=
6&commit=3DView+differences=20
>>>
>>> is not the documentation you need to create a new ticket for v0.94.4 =
and I removed this chapter to avoid further confusion. There is a more de=
tailed explanation at:=20
>>>
>>> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_worki=
ng_on_a_new_point_release=20
>>>
>>> A section was added as a reminder that someone has to volunteer to dr=
ive the release.=20
>>>
>>> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_worki=
ng_on_a_new_point_release/diff?utf8=3D%E2%9C%93&version=3D9&version_from=3D=
8&commit=3DView+differences=20
>>>
>>> Let me know if you need anything else to create the issue vor v0.94.4=
=2E=20
>>>
>>> Cheers=20
>>> --=20
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre=20
>>>
>>>
>>>
>>> ---------------------------------------------------------------------=
---------------------------------------------------------------------=20
>>>
>>> This email and any files transmitted with it are confidential and int=
ended solely for the use of the individual or entity to whom they are add=
ressed. If you have received this email in error please notify the system=
 manager. This message contains confidential information and is intended =
only for the individual named. If you are not the named addressee you sho=
uld not disseminate, distribute or copy this e-mail. Please notify the se=
nder immediately by e-mail if you have received this e-mail by mistake an=
d delete this e-mail from your system. If you are not the intended recipi=
ent you are notified that disclosing, copying, distributing or taking any=
 action in reliance on the contents of this information is strictly prohi=
bited. Although Flipkart has taken reasonable precautions to ensure no vi=
ruses are present in this email, the company cannot accept responsibility=
 for any loss or damage arising from the use of this email or attachments=
=20
>>>
>>
>> --=20
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre=20
>>
>>
>>
>> ----------------------------------------------------------------------=
--------------------------------------------------------------------=20
>>
>> This email and any files transmitted with it are confidential and inte=
nded solely for the use of the individual or entity to whom they are addr=
essed. If you have received this email in error please notify the system =
manager. This message contains confidential information and is intended o=
nly for the individual named. If you are not the named addressee you shou=
ld not disseminate, distribute or copy this e-mail. Please notify the sen=
der immediately by e-mail if you have received this e-mail by mistake and=
 delete this e-mail from your system. If you are not the intended recipie=
nt you are notified that disclosing, copying, distributing or taking any =
action in reliance on the contents of this information is strictly prohib=
ited. Although Flipkart has taken reasonable precautions to ensure no vir=
uses are present in this email, the company cannot accept responsibility =
for any loss or damage arising from the use of this email or attachments =

>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--cdQ4fLQoX9kCj2ijuQFmsBekkeCqMi2x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXSB0gACgkQ8dLMyEl6F23AfwCgjob3iAKs+JGjXwfFUYcelbmY
cK8AoIMEQmb39YHxaFLBkAab7tJBN7c2
=RWJ+
-----END PGP SIGNATURE-----

--cdQ4fLQoX9kCj2ijuQFmsBekkeCqMi2x6--
