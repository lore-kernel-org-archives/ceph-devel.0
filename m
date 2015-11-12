From: <ghislain.chevalier@orange.com>
Subject: RE: [CEPH][Crush][Tunables] issue when updating tunables
Date: Thu, 12 Nov 2015 17:40:17 +0000
Message-ID: <7684_1447350018_5644CF02_7684_2786_1_B9C8EFBF13B1354DB5FA000660D66DD00D64BBC0@OPEXCLILM22.corporate.adroot.infra.ftgroup>
References: <25091_1447144373_5641ABB5_25091_8387_1_B9C8EFBF13B1354DB5FA000660D66DD00D64A5FA@OPEXCLILM22.corporate.adroot.infra.ftgroup>
 <alpine.DEB.2.00.1511100221010.32494@cobra.newdream.net>
 <22767_1447337497_56449E19_22767_66_1_B9C8EFBF13B1354DB5FA000660D66DD00D64B970@OPEXCLILM22.corporate.adroot.infra.ftgroup>
 <alpine.DEB.2.00.1511120657200.614@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias91.francetelecom.com ([193.251.215.91]:50873 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753699AbbKLRrk convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 Nov 2015 12:47:40 -0500
In-Reply-To: <alpine.DEB.2.00.1511120657200.614@cobra.newdream.net>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thx Sage
It's clear now

Best regards

-----Message d'origine-----
De=A0: Sage Weil [mailto:sage@newdream.net]=20
Envoy=E9=A0: jeudi 12 novembre 2015 16:01
=C0=A0: CHEVALIER Ghislain IMT/OLPS
Cc=A0: ceph-devel@vger.kernel.org
Objet=A0: RE: [CEPH][Crush][Tunables] issue when updating tunables

On Thu, 12 Nov 2015, ghislain.chevalier@orange.com wrote:
> Hi Sage,
> Thanks for the reply
>=20
> You said
> " You actually want straw_calc_version 1.  This is just confusing out=
put from the 'firefly' tunable detection... the straw_calc_version does=
 not have any client dependencies."
>=20
> My objective is to have the most relevant tunables for a firefly plat=
form.
>=20
> I didn't understand if :
> - it's better to have straw_calc_version set to 1 but  tunables_optim=
al will be automatically set to 0.
> In other words are the following tunables OK ?
> { "choose_local_tries": 0,
> >   "choose_local_fallback_tries": 0,
> >   "choose_total_tries": 50,
> >   "chooseleaf_descend_once": 1,
> >   "chooseleaf_vary_r": 1,
> >   "straw_calc_version": 0,
> >   "profile": "firefly",
> >   "optimal_tunables": 1,
> >   "legacy_tunables": 0,
> >   "require_feature_tunables": 1,
> >   "require_feature_tunables2": 1,
> >   "require_feature_tunables3": 1,
> >   "has_v2_rules": 0,
> >   "has_v3_rules": 0}

It is best to also manually set straw_calc_version =3D 1.  It won't say=
 firefly, but it will still be compatible with firefly clients (that tu=
nable only affects the mon behavior when updating the crush map).

> - there's an issue with the tunables detection and update?

Yes and no.  We want 'ceph osd crush tunables firefly' to set options s=
upported by all firefly deployments, and the initial firefly releases d=
id not have the straw_calc_version =3D 1 support.  In some cases switch=
ing it on can trigger some data movement the next time the crush map is=
 adjusted, so we leave it off to be conservative.  And we want the prof=
ile to match exactly what setting the profile sets.  But it's confusing=
 since it isn't
1:1 with what clients support.  And if it is a fresh cluster you are be=
tter off with straw_calc_version =3D 1.  (Same goes for old clusters, i=
f you can tolerate a bit of initial rebalancing.)

sage



>=20
> Best regards
>=20
> -----Message d'origine-----
> De=A0: Sage Weil [mailto:sage@newdream.net] Envoy=E9=A0: mardi 10 nov=
embre=20
> 2015 11:23 =C0=A0: CHEVALIER Ghislain IMT/OLPS Cc=A0:=20
> ceph-devel@vger.kernel.org Objet=A0: Re: [CEPH][Crush][Tunables] issu=
e=20
> when updating tunables
>=20
> On Tue, 10 Nov 2015, ghislain.chevalier@orange.com wrote:
> > Hi all,
> >=20
> > Context:
> > Firefly 0.80.9
> > Ubuntu 14.04.1
> > Almost a production platform  in an openstack environment
> > 176 OSD (SAS and SSD), 2 crushmap-oriented storage classes , 8=20
> > servers in 2 rooms, 3 monitors on openstack controllers
> > Usage: Rados Gateway for object service and RBD as back-end for=20
> > Cinder and Glance
> >=20
> > The Ceph cluster was installed by Mirantis procedures (puppet/fuel/=
ceph-deploy):
> >=20
> > I noticed that tunables were curiously set.
> > ceph  osd crush show-tunables =3D=3D>
> > { "choose_local_tries": 0,
> >   "choose_local_fallback_tries": 0,
> >   "choose_total_tries": 50,
> >   "chooseleaf_descend_once": 1,
> >   "chooseleaf_vary_r": 1,
> >   "straw_calc_version": 1,
> >   "profile": "unknown",
> >   "optimal_tunables": 0,
> >   "legacy_tunables": 0,
> >   "require_feature_tunables": 1,
> >   "require_feature_tunables2": 1,
> >   "require_feature_tunables3": 1,
> >   "has_v2_rules": 0,
> >   "has_v3_rules": 0}
> >=20
> > I tried to update them
> > ceph  osd crush tunables optimal =3D=3D> adjusted tunables profile =
to=20
> > optimal
> >=20
> > But when checking
> > ceph  osd crush show-tunables =3D=3D>
> > { "choose_local_tries": 0,
> >   "choose_local_fallback_tries": 0,
> >   "choose_total_tries": 50,
> >   "chooseleaf_descend_once": 1,
> >   "chooseleaf_vary_r": 1,
> >   "straw_calc_version": 1,
> >   "profile": "unknown",
> >   "optimal_tunables": 0,
> >   "legacy_tunables": 0,
> >   "require_feature_tunables": 1,
> >   "require_feature_tunables2": 1,
> >   "require_feature_tunables3": 1,
> >   "has_v2_rules": 0,
> >   "has_v3_rules": 0}
> >=20
> > Nothing has changed.
> >=20
> > I finally did
> > ceph osd crush set-tunable straw_calc_version 0
>=20
> You actually want straw_calc_version 1.  This is just confusing outpu=
t from the 'firefly' tunable detection... the straw_calc_version does n=
ot have any client dependencies.
>=20
> sage
>=20
>=20
> >=20
> > and
> > ceph  osd crush show-tunables =3D=3D>
> > { "choose_local_tries": 0,
> >   "choose_local_fallback_tries": 0,
> >   "choose_total_tries": 50,
> >   "chooseleaf_descend_once": 1,
> >   "chooseleaf_vary_r": 1,
> >   "straw_calc_version": 0,
> >   "profile": "firefly",
> >   "optimal_tunables": 1,
> >   "legacy_tunables": 0,
> >   "require_feature_tunables": 1,
> >   "require_feature_tunables2": 1,
> >   "require_feature_tunables3": 1,
> >   "has_v2_rules": 0,
> >   "has_v3_rules": 0}
> >=20
> > It's OK
> >=20
> > My question:
> > Does the "ceph osd crush tunables <profile>" command change all the=
 requested parameters in order to set the tunables to the right profile=
?
> >=20
> > Brgds
> >=20
> > ___________________________________________________________________=
_
> > __ ___________________________________________________
> >=20
> > Ce message et ses pieces jointes peuvent contenir des informations=20
> > confidentielles ou privilegiees et ne doivent donc pas etre=20
> > diffuses, exploites ou copies sans autorisation. Si vous avez recu=20
> > ce message par erreur, veuillez le signaler a l'expediteur et le=20
> > detruire ainsi que les pieces jointes. Les messages electroniques=20
> > etant susceptibles d'alteration, France Telecom - Orange decline=20
> > toute responsabilite si ce message a ete altere, deforme ou=20
> > falsifie. Merci
> >=20
> > This message and its attachments may contain confidential or=20
> > privileged information that may be protected by law; they should no=
t be distributed, used or copied without authorization.
> > If you have received this email in error, please notify the sender =
and delete this message and its attachments.
> > As emails may be altered, France Telecom - Orange shall not be liab=
le if this message was modified, changed or falsified.
> > Thank you.
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"=20
> > in the body of a message to majordomo@vger.kernel.org More majordom=
o=20
> > info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
>=20
> _____________________________________________________________________=
_
> ___________________________________________________
>=20
> Ce message et ses pieces jointes peuvent contenir des informations=20
> confidentielles ou privilegiees et ne doivent donc pas etre diffuses,=
=20
> exploites ou copies sans autorisation. Si vous avez recu ce message=20
> par erreur, veuillez le signaler a l'expediteur et le detruire ainsi =
que les pieces jointes. Les messages electroniques etant susceptibles d=
'alteration, Orange decline toute responsabilite si ce message a ete al=
tere, deforme ou falsifie. Merci.
>=20
> This message and its attachments may contain confidential or=20
> privileged information that may be protected by law; they should not =
be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender an=
d delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have=
 been modified, changed or falsified.
> Thank you.
>=20
>=20

_______________________________________________________________________=
__________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations conf=
identielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez =
recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les message=
s electroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme=
 ou falsifie. Merci.

This message and its attachments may contain confidential or privileged=
 information that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and =
delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have b=
een modified, changed or falsified.
Thank you.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
