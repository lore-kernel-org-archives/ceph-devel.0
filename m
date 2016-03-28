From: Loic Dachary <loic@dachary.org>
Subject: Re: Teuthology
Date: Mon, 28 Mar 2016 13:17:00 +0200
Message-ID: <56F912AC.40202@dachary.org>
References: <CAPFmEhZ3BGag3BBx505UyhtYA3+PLFLDz=oDHheWKPQyoQyQYQ@mail.gmail.com>
 <56F00270.5010901@dachary.org>
 <CAPFmEhbbpwm2KS1FaCxzCXhnwAJ5TxcqDj2RsMLMnnNcOeWWkw@mail.gmail.com>
 <56F900EE.90106@dachary.org>
 <CAPFmEhYPFJR==JcgasQqwwDrA277DjXF4oe49utwHStjKkFq=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50412 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbcC1LRH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2016 07:17:07 -0400
In-Reply-To: <CAPFmEhYPFJR==JcgasQqwwDrA277DjXF4oe49utwHStjKkFq=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Herman Narkaytis <hnarkaytis@mirantis.com>
Cc: Vitalii Solovei <vsolovei@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>, Maksym Shalamov <mshalamov@mirantis.com>, Thierry Delamare <t.delamare@laposte.net>

Hi Herman,

I recently succeeded (thanks to Thierry's help ;-) to install paddles u=
sing ansible[1]. The playbook was developped recently by Zack. Even if =
you don't otherwise use ansible, it's a better option than more complex=
 instructions. And easier to maintain as you can rely on Andrew, Dan an=
d Zack (and maybe others) to maintain the playbook. One thing that I li=
ke (but is frowned upon by more seasoned ansible users) is to use ansib=
le from the node where paddles is to be installed. For instance:

   ansible-playbook -i paddles, -c local paddles.yml

I suppose the http://docs.ceph.com/teuthology/docs/LAB_SETUP.html docum=
ent should be updated with this new recommended deployment method (the =
main document is at https://github.com/ceph/teuthology/blob/master/docs=
/LAB_SETUP.rst).

Toward the end of your document, the "Submitting slave node" is where t=
he I don't have any experience. But David Galloway and Dan Mick and may=
be others do as they have deployed and configured all the hardware curr=
ently in the sepia lab. It's a significant undertaking but is fortunate=
ly well documented and all files you need are public.

I chose an easier alternative which is to rely on an OpenStack cluster =
to provision the resources required to run teuthology jobs[2].

The last pitfall that comes to mind, and it's a significant one, is tha=
t a number of teuthology jobs are sensitive to the infrastructure. For =
instance, I recently worked around a paramiko bug that only showed on O=
penStack although it is by no mean specific to OpenStack[3]. Fixing cep=
h-qa-suite so that it does not break because the infrastructure is slow=
er or faster, has 1G network or 10G, has fast or slow internet connecti=
ons etc. is sometime non trivial. But for the most part it's easy and a=
 little tedious: you just have to do it on a regular basis :-)

My 2cts

[1] installing paddles via ansible http://www.spinics.net/lists/ceph-de=
vel/msg28974.html
[2] OpenStack backend https://github.com/dachary/teuthology/tree/openst=
ack#openstack-backend
[3] openstack: SSHException: Key-exchange timed out http://tracker.ceph=
=2Ecom/issues/15236

On 28/03/2016 12:14, Herman Narkaytis wrote:
> We intended to publish this instruction as public document, so feedba=
ck from broader community would be valuable.
>=20
> HHN.
>=20
> On Mon, Mar 28, 2016 at 1:01 PM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>=20
>     Hi,
>=20
>     On 28/03/2016 10:55, Herman Narkaytis wrote:
>     > Loic,
>     >   Below you will find a link on Teuthology deployment instructi=
ons. I would be appreciated to get your feedback on it.
>=20
>     This is a precise and detailed documentation, very useful. Do you=
 mind if I post my remarks about it with ceph-devel in cc ? Other devel=
opers will certainly have interesting contributions to make.
>=20
>     >   https://docs.google.com/document/d/18MW0NAwEZB45lGgsgjpb4fFdi=
8ope1YGr5OA-uvsIR8/edit
>     >
>     >   We are still figuring out how to deploy GitBuilder, but it sh=
ould not be as hard as it was with Teuthology.
>     > HHN.
>=20
>     :-)
>=20
>     Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
