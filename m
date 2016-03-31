From: Loic Dachary <loic@dachary.org>
Subject: Re: getting ready for jewel 10.2.1
Date: Thu, 31 Mar 2016 16:31:08 +0200
Message-ID: <56FD34AC.1030501@dachary.org>
References: <56FBAADF.3020407@dachary.org>
 <CAJ4mKGYg++sGuqHQPkNa1GrVeDO=KFZNtp4FTYX=zOkrAbnFeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54981 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbcCaObO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 10:31:14 -0400
In-Reply-To: <CAJ4mKGYg++sGuqHQPkNa1GrVeDO=KFZNtp4FTYX=zOkrAbnFeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Gregory,

On 30/03/2016 20:47, Gregory Farnum wrote:
> On Wed, Mar 30, 2016 at 3:30 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi,
>>
>> Now is a good time to get ready for jewel 10.2.1 and I created http:=
//tracker.ceph.com/issues/15317 for that purpose. The goal is to be abl=
e to run as many suites as possible on OpenStack, so that we do not hav=
e to wait days (sometime a week) for runs to complete on Sepia. Best ca=
se scenario, all OpenStack specific problems are fixed by the time 10.2=
=2E1 is being prepared. Worst case scenario there is no time to fix iss=
ues and we keep using the sepia lab. I guess we'll end up somewhere in =
the middle : some suites will run fine on Openstack and we'll use sepia=
 for others.
>>
>> In a previous mail I voiced my concerns regarding the lack of intere=
st of developers regarding teuthology job failures that are cause by va=
riations in the infrastructure. I still have no clue how to convey my b=
elief that it is important for teuthology jobs to succeed despite infra=
structure variations. But instead of just giving up and do nothing, I w=
ill work on that for the rados suite and hope things will evolve in a g=
ood way. To be honest, figuring out http://tracker.ceph.com/issues/1523=
6 and seeing a good run of the rados suite on jewel as a result renewed=
 my motivation in that area :-)
>=20
> I think you've convinced us all it's important in the abstract; that'=
s
> just very different from putting it on top of our list of priorities,
> especially since we alleviated many of our needs in the sepia lab.
> Beyond that, a lot of the issues we're seeing have very little to do
> with Ceph itself, or even the testing programs, and that can make it
> more difficult to get interested as we lack the necessary expertise. =
I
> spent some time trying to get disk sizes and things matched up (and I
> suddenly realize that never got merged), but some of the other odder
> issues we're having:
>=20
> http://tracker.ceph.com/issues/13980, in which we are failing to moun=
t
> anything with nfs v3. This is a config file that needs to get updated=
;
> we do it for the sepia lab (probably in ansible?) but somehow that
> information isn't getting into the ovh slaves. (Or else it is in
> there, and there's something *else* broken.) If we are using a
> separate setup regimen for OpenStack than we are in the sepia lab
> there will be persistent breakage as new dependencies and
> environmental expectations get added to one and not the other. :/

ceph-cm-ansible does not have any OpenStack specific instructions. It's=
 supposed to work exactly the same on both sepia and OpenStack. When te=
uthology provisions an OpenStack target, it does so in the same way it =
provisions VPS in sepia. The only difference is that OpenStack uses ima=
ges that come from http://cloud.centos.org/centos/7/images/ etc., unmod=
ified. The VPS images have sometime been modified. However, this has on=
ly been an issue once, over six months ago.

On OVH the UDP ports were firewalled, and that created the problem. I c=
hanged the firewall rules and I'm hopefull http://pulpito.ovh.sepia.cep=
h.com:8081/loic-2016-03-31_14:10:18-knfs-jewel-testing-basic-openstack/=
 will now pass.

> http://tracker.ceph.com/issues/13876, in which MPI is just failing to
> get any connections going. Why? No idea; there's a teuthology commit
> from you that's supposed to have opened up all the ports in the
> firewall (and it sure *looks* like it does do that, but I don't know
> how the rules work), but this works in sepia and inasmuch as we have
> debugging info sure looks like some kind of network blockage...

I opened the required port on the OVH lab. I don't think there is an an=
sible rule that does it but I'll ask Zack to be sure.

> So I think this isn't something that's going to get done properly
> unless somebody gets assigned to just make everything work in all the
> suites, who has the time to learn all the fiddly little bits. (Or we
> somehow take a break for it as a project. But I don't see that going
> well.) :/

If you suspect an OpenStack specific problem, feel free to ping me. The=
re is a good chance I can help and together we can make teuthology happ=
y with OpenStack :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
