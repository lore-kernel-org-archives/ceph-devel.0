From: Sage Weil <sage@newdream.net>
Subject: RE: [CEPH][Crush][Tunables] issue when updating tunables
Date: Thu, 12 Nov 2015 07:01:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511120657200.614@cobra.newdream.net>
References: <25091_1447144373_5641ABB5_25091_8387_1_B9C8EFBF13B1354DB5FA000660D66DD00D64A5FA@OPEXCLILM22.corporate.adroot.infra.ftgroup> <alpine.DEB.2.00.1511100221010.32494@cobra.newdream.net>
 <22767_1447337497_56449E19_22767_66_1_B9C8EFBF13B1354DB5FA000660D66DD00D64B970@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1340151619-1447340487=:614"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35668 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbbKLPB2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Nov 2015 10:01:28 -0500
In-Reply-To: <22767_1447337497_56449E19_22767_66_1_B9C8EFBF13B1354DB5FA000660D66DD00D64B970@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1340151619-1447340487=:614
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2015, ghislain.chevalier@orange.com wrote:
> Hi Sage,
> Thanks for the reply
>=20
> You said=20
> " You actually want straw_calc_version 1.  This is just confusing outpu=
t from the 'firefly' tunable detection... the straw_calc_version does not=
 have any client dependencies."
>=20
> My objective is to have the most relevant tunables for a firefly platfo=
rm.
>=20
> I didn't understand if :
> - it's better to have straw_calc_version set to 1 but  tunables_optimal=
 will be automatically set to 0.
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
> >   "has_v3_rules": 0}=20

It is best to also manually set straw_calc_version =3D 1.  It won't say=20
firefly, but it will still be compatible with firefly clients (that=20
tunable only affects the mon behavior when updating the crush map).

> - there's an issue with the tunables detection and update?

Yes and no.  We want 'ceph osd crush tunables firefly' to set options=20
supported by all firefly deployments, and the initial firefly releases di=
d=20
not have the straw_calc_version =3D 1 support.  In some cases switching i=
t=20
on can trigger some data movement the next time the crush map is adjusted=
,=20
so we leave it off to be conservative.  And we want the profile to match=20
exactly what setting the profile sets.  But it's confusing since it isn't=
=20
1:1 with what clients support.  And if it is a fresh cluster you are=20
better off with straw_calc_version =3D 1.  (Same goes for old clusters, i=
f=20
you can tolerate a bit of initial rebalancing.)

sage



>=20
> Best regards=20
>=20
> -----Message d'origine-----
> De=A0: Sage Weil [mailto:sage@newdream.net]=20
> Envoy=E9=A0: mardi 10 novembre 2015 11:23
> =C0=A0: CHEVALIER Ghislain IMT/OLPS
> Cc=A0: ceph-devel@vger.kernel.org
> Objet=A0: Re: [CEPH][Crush][Tunables] issue when updating tunables
>=20
> On Tue, 10 Nov 2015, ghislain.chevalier@orange.com wrote:
> > Hi all,
> >=20
> > Context:
> > Firefly 0.80.9
> > Ubuntu 14.04.1
> > Almost a production platform  in an openstack environment
> > 176 OSD (SAS and SSD), 2 crushmap-oriented storage classes , 8 server=
s=20
> > in 2 rooms, 3 monitors on openstack controllers
> > Usage: Rados Gateway for object service and RBD as back-end for Cinde=
r=20
> > and Glance
> >=20
> > The Ceph cluster was installed by Mirantis procedures (puppet/fuel/ce=
ph-deploy):
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
> > ceph  osd crush tunables optimal =3D=3D>
> > adjusted tunables profile to optimal
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
> You actually want straw_calc_version 1.  This is just confusing output =
from the 'firefly' tunable detection... the straw_calc_version does not h=
ave any client dependencies.
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
> > Does the "ceph osd crush tunables <profile>" command change all the r=
equested parameters in order to set the tunables to the right profile?
> >=20
> > Brgds
> >=20
> > _____________________________________________________________________=
_
> > ___________________________________________________
> >=20
> > Ce message et ses pieces jointes peuvent contenir des informations=20
> > confidentielles ou privilegiees et ne doivent donc pas etre diffuses,=
=20
> > exploites ou copies sans autorisation. Si vous avez recu ce message=20
> > par erreur, veuillez le signaler a l'expediteur et le detruire ainsi=20
> > que les pieces jointes. Les messages electroniques etant susceptibles=
=20
> > d'alteration, France Telecom - Orange decline toute responsabilite si=
=20
> > ce message a ete altere, deforme ou falsifie. Merci
> >=20
> > This message and its attachments may contain confidential or=20
> > privileged information that may be protected by law; they should not =
be distributed, used or copied without authorization.
> > If you have received this email in error, please notify the sender an=
d delete this message and its attachments.
> > As emails may be altered, France Telecom - Orange shall not be liable=
 if this message was modified, changed or falsified.
> > Thank you.
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> > in the body of a message to majordomo@vger.kernel.org More majordomo=20
> > info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
>=20
> _______________________________________________________________________=
__________________________________________________
>=20
> Ce message et ses pieces jointes peuvent contenir des informations conf=
identielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez =
recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les message=
s electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, deforme=
 ou falsifie. Merci.
>=20
> This message and its attachments may contain confidential or privileged=
 information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender and =
delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have b=
een modified, changed or falsified.
> Thank you.
>=20
>=20
--557981400-1340151619-1447340487=:614--
