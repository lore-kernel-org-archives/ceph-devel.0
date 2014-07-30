From: Loic Dachary <loic@dachary.org>
Subject: Re: giant and hammer dates
Date: Wed, 30 Jul 2014 22:05:54 +0600
Message-ID: <53D917E2.3060906@dachary.org>
References: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net> <53D87BBF.2020408@dachary.org> <alpine.DEB.2.00.1407300706441.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cgLPaLK1QSu89H0rksiwD47MSWkiMwJTH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50998 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755118AbaG3QGT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 12:06:19 -0400
In-Reply-To: <alpine.DEB.2.00.1407300706441.18917@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cgLPaLK1QSu89H0rksiwD47MSWkiMwJTH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

Thanks for taking the time to write this overview of the release cycle to=
ols and their evolutions : I did not realize so much work was going on :-=
)

Cheers

On 30/07/2014 20:22, Sage Weil wrote:
> On Wed, 30 Jul 2014, Loic Dachary wrote:
>> Hi Sage,
>>
>> From my (biased) point of view, the upside is that it will give me mor=
e=20
>> time to complete the locally repairable code for Giant ;-). The downsi=
de=20
>> is that it puts a little less pressure to improve the tools and method=
s=20
>> that make a rapid release cycles possible (i.e. unit tests, bug=20
>> tracking, patch acceptance workflow, package building/gitbuilder,=20
>> teuthology, pulpito, upgrades testing, ...). In a perfect world Ceph=20
>> could sustain a three month release cycle without inconveniencing=20
>> anyone. A longer release cycle (five or six months) would encourage ev=
en=20
>> more complex / bigger changes within a release cycle. It would also=20
>> probably encourage Ceph developers to forget about the release process=
=20
>> tools during two or three months and not improve them as they should b=
e.
>>
>> IMHO the test cycle is significantly slowing down the release process =

>> and a faster, more comprehensive test cycle would help a lot.
>=20
> No argument here. :)
>=20
> I should clarify that this is the "stable release cycle" for the named =

> released.  I still think we should maintain a ~2 week "development rele=
ase=20
> cycle" where we are continuously integrating changes and regularly putt=
ing=20
> out a usable release.  The 'next' or 'last' branches should be recent a=
nd=20
> stable starting points for doing any new work so that the integration=20
> tests, when run, will reflect bugs in your code and not stuff that was =

> already there.  We've slipped a bit here (0.82 to 0.83 was 5 weeks); th=
is=20
> is partly because the release process itself is still pretty expensive =
in=20
> terms of effort and we don't want to eat up more of Alfredo's and Sando=
n's=20
> time than we need to, but it is getting better.
>=20
> In any case, the real point of a longer "stable release cycle" is just =

> that there are fewer stable releases in flight that we are backporting =

> fixes too.  In practice, having all of dumpling, emperor, and firefly=20
> outstanding hasn't worked particularly well (IMO).  We backport to=20
> dumpling and firefly and urge people away from emperor to avoid the=20
> cognitive overhead of keeping track of another release.  Going from 3 t=
o 4=20
> months means only 3 stable releases per year, which I think is enough..=
=2E?
>=20
>> Each commit should be unit / functional tested within seconds, locally=
=20
>> (see=20
>> https://github.com/ceph/ceph/blob/master/src/test/osd/types.cc#L1295 f=
or=20
>> instance). It is usually more difficult to diagnose / fix a border cas=
e=20
>> when it is discovered during integration tests (i.e. teuthology) rathe=
r=20
>> than with a unit / functional test designed for it. Creating unit test=
s=20
>> is often problematic because some of the code base cannot be easily=20
>> isolated. With a continuous effort to re-arrange parts of the code to =
be=20
>> more test friendly, this can eventually be resolved.
>>
>> Every commit proposed to master should be run against the relevant=20
>> teuthology suite to help the reviewer. The problem here is that it=20
>> requires more resources than what Ceph currently has. Harvesting more =

>> machines, making it possible for people and organizations amicable to =

>> Ceph to easily donate virtual machines could probably help.
>=20
> Zack is making good progress on rejiggering the way that teuthology=20
> separates the core task locking and task runners from the tasks themsel=
ves=20
> (which get versioned along with the test suite for firefly, dumpling,=20
> etc.).  This is all groundwork to enable the important bits, like pulli=
ng=20
> machine locking into a single, easy to deploy process, and plugging in =

> different providers (in addition to bare metal and downburst) like=20
> OpenStack.  The end goal is to make teuthology much easier to deploy in=
=20
> other environments.  I'm hoping we can get to a place similar to openst=
ack=20
> where organizations can hang their CI deployment off the 'upstream'=20
> build/CI infrastructure and supplement by running the same suites on=20
> different hardware or by adding their own test suites...
>=20
>> This deserves a separate discussions but I wanted to expand on what I =

>> meant by "test cycle" and its impact on the release cycle.
>=20
> We had a discussion during the G/H CDS about doing an ephemeral=20
> 'integration' branch to group things together for full testing by the=20
> teuthology test suites that you probably caught.  There was a follow-on=
=20
> internal discussion while you were gone on how to get this rolling and =
Sam=20
> is currently working on a tool to easily build an integration branch=20
> merging pending work on a nightly so that it can go through the tests=20
> before getting merged into master.  I think this will help.
>=20
> We also have our first batch of new hardware ordered inside Red Hat=20
> (another ~130 machines) that will expand our testing throughput, and=20
> Sandon is working on reclaiming a lot of existing machines that aren't =

> getting put to good use (burnupi) so that we can expand the size of the=
=20
> existing test pool.
>=20
> Alfredo recently did some background research on what other projects ar=
e=20
> doing for CI and releases, and he and Sandon have some work in flight t=
o=20
> move some of the bursty release builds into openstack VMs.  Unfortunate=
ly=20
> nobody has their full bandwidth allocated to improving the state of=20
> things, but I think we're making some slow progress.
>=20
> sage
>=20
>=20
>>
>> Cheers
>>
>> On 30/07/2014 05:11, Sage Weil wrote:
>>> We've talked a bit about moving to a ~4 month (instead of 3 month)=20
>>> cadence.  I'm still inclined in this direction because it means fewer=
=20
>>> stable releases that we will be maintaining and a longer and (hopeful=
ly)=20
>>> more productive interval to do real work in between.
>>>
>>> The other key point is that we don't want a repeat of the firefly del=
ay. =20
>>> I think we should stay as close to a train model as we can.  If somet=
hing=20
>>> isn't ready by freeze, let it wait for the next cycle.  We shouldn't =
be=20
>>> cramming things in at the end, especially big things.  As a general r=
ule,=20
>>> big things should be merged early in the cycle so that we have lots o=
f=20
>>> time to shake out the issues that only come out of lots of testing an=
d=20
>>> aren't obvious from code review.
>>>
>>> Anyway, how about:
>>>
>>>           Freeze         Approx Release
>>>   Giant   Mon Sep  1     Mon Sep 29
>>>   Hammer  Mon Jan  4     Mon Feb  2
>>>
>>> That gives us another month for Giant, then September to shake out=20
>>> anything issues.  And then three full months before the Hammer freeze=
=2E
>>>
>>> What say ye?
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --=20
>> Lo?c Dachary, Artisan Logiciel Libre
>>
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--cgLPaLK1QSu89H0rksiwD47MSWkiMwJTH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPZF+IACgkQ8dLMyEl6F20NmgCfXPQ6rRJyeCjxupgxxzoSn1oP
CWcAn1ZOHc11TCCpp4Is6ve0YDSf3+EE
=XzZy
-----END PGP SIGNATURE-----

--cgLPaLK1QSu89H0rksiwD47MSWkiMwJTH--
