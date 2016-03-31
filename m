From: Loic Dachary <loic@dachary.org>
Subject: Re: getting ready for jewel 10.2.1
Date: Fri, 1 Apr 2016 00:13:05 +0200
Message-ID: <56FDA0F1.5000800@dachary.org>
References: <56FBAADF.3020407@dachary.org>
 <CAJ4mKGYg++sGuqHQPkNa1GrVeDO=KFZNtp4FTYX=zOkrAbnFeQ@mail.gmail.com>
 <56FD34AC.1030501@dachary.org>
 <CAJ4mKGZHyR3m7LVRuqv5jw19sGCWTStX+Sfbj6AkZr5byrrN1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58376 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352AbcCaWNM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 18:13:12 -0400
In-Reply-To: <CAJ4mKGZHyR3m7LVRuqv5jw19sGCWTStX+Sfbj6AkZr5byrrN1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 31/03/2016 21:01, Gregory Farnum wrote:
> On Thu, Mar 31, 2016 at 7:31 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi Gregory,
>>
>> On 30/03/2016 20:47, Gregory Farnum wrote:
>>> On Wed, Mar 30, 2016 at 3:30 AM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>> Hi,
>>>>
>>>> Now is a good time to get ready for jewel 10.2.1 and I created htt=
p://tracker.ceph.com/issues/15317 for that purpose. The goal is to be a=
ble to run as many suites as possible on OpenStack, so that we do not h=
ave to wait days (sometime a week) for runs to complete on Sepia. Best =
case scenario, all OpenStack specific problems are fixed by the time 10=
=2E2.1 is being prepared. Worst case scenario there is no time to fix i=
ssues and we keep using the sepia lab. I guess we'll end up somewhere i=
n the middle : some suites will run fine on Openstack and we'll use sep=
ia for others.
>>>>
>>>> In a previous mail I voiced my concerns regarding the lack of inte=
rest of developers regarding teuthology job failures that are cause by =
variations in the infrastructure. I still have no clue how to convey my=
 belief that it is important for teuthology jobs to succeed despite inf=
rastructure variations. But instead of just giving up and do nothing, I=
 will work on that for the rados suite and hope things will evolve in a=
 good way. To be honest, figuring out http://tracker.ceph.com/issues/15=
236 and seeing a good run of the rados suite on jewel as a result renew=
ed my motivation in that area :-)
>>>
>>> I think you've convinced us all it's important in the abstract; tha=
t's
>>> just very different from putting it on top of our list of prioritie=
s,
>>> especially since we alleviated many of our needs in the sepia lab.
>>> Beyond that, a lot of the issues we're seeing have very little to d=
o
>>> with Ceph itself, or even the testing programs, and that can make i=
t
>>> more difficult to get interested as we lack the necessary expertise=
=2E I
>>> spent some time trying to get disk sizes and things matched up (and=
 I
>>> suddenly realize that never got merged), but some of the other odde=
r
>>> issues we're having:
>>>
>>> http://tracker.ceph.com/issues/13980, in which we are failing to mo=
unt
>>> anything with nfs v3. This is a config file that needs to get updat=
ed;
>>> we do it for the sepia lab (probably in ansible?) but somehow that
>>> information isn't getting into the ovh slaves. (Or else it is in
>>> there, and there's something *else* broken.) If we are using a
>>> separate setup regimen for OpenStack than we are in the sepia lab
>>> there will be persistent breakage as new dependencies and
>>> environmental expectations get added to one and not the other. :/
>>
>> ceph-cm-ansible does not have any OpenStack specific instructions. I=
t's supposed to work exactly the same on both sepia and OpenStack. When=
 teuthology provisions an OpenStack target, it does so in the same way =
it provisions VPS in sepia. The only difference is that OpenStack uses =
images that come from http://cloud.centos.org/centos/7/images/ etc., un=
modified. The VPS images have sometime been modified. However, this has=
 only been an issue once, over six months ago.
>>
>> On OVH the UDP ports were firewalled, and that created the problem. =
I changed the firewall rules and I'm hopefull http://pulpito.ovh.sepia.=
ceph.com:8081/loic-2016-03-31_14:10:18-knfs-jewel-testing-basic-opensta=
ck/ will now pass.
>>
>>> http://tracker.ceph.com/issues/13876, in which MPI is just failing =
to
>>> get any connections going. Why? No idea; there's a teuthology commi=
t
>>> from you that's supposed to have opened up all the ports in the
>>> firewall (and it sure *looks* like it does do that, but I don't kno=
w
>>> how the rules work), but this works in sepia and inasmuch as we hav=
e
>>> debugging info sure looks like some kind of network blockage...
>>
>> I opened the required port on the OVH lab. I don't think there is an=
 ansible rule that does it but I'll ask Zack to be sure.
>>
>>> So I think this isn't something that's going to get done properly
>>> unless somebody gets assigned to just make everything work in all t=
he
>>> suites, who has the time to learn all the fiddly little bits. (Or w=
e
>>> somehow take a break for it as a project. But I don't see that goin=
g
>>> well.) :/
>>
>> If you suspect an OpenStack specific problem, feel free to ping me. =
There is a good chance I can help and together we can make teuthology h=
appy with OpenStack :-)
>=20
> I really wasn't fishing with those, but hey! thanks so much for those=
 fixes. :)
>=20
> Do we have any way to automate those kinds of things for external
> users? It sounds like right now these are just some random things any
> third party needs to know to do, or their tests will mysteriously
> fail?

https://github.com/ceph/teuthology/pull/834/files automates that.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
