From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: RE: Ceph code tests / teuthology
Date: Fri, 24 Apr 2015 13:57:44 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF01F42F47@SHSMSX104.ccr.corp.intel.com>
References: <06681238D8946F44A60AA400760A1CBF01F237CC@SHSMSX104.ccr.corp.intel.com>
 <552B89FF.70809@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18434 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbbDXN54 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Apr 2015 09:57:56 -0400
In-Reply-To: <552B89FF.70809@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Zack Cerza <zack@redhat.com>

Hi Loic/Zack,

So I've got some progress here. I was able to run a single job with teu=
thology xxx.yaml targets.yaml.=20
=46rom the code,  teuthology-suite needs to query the lock-server for s=
ome machine info, like os_type, platform. Is there any documents for th=
e lock-server?

Thanks, -yuan

-----Original Message-----
=46rom: Loic Dachary [mailto:loic@dachary.org]=20
Sent: Monday, April 13, 2015 5:19 PM
To: Zhou, Yuan
Cc: Ceph Development; Zack Cerza
Subject: Re: Ceph code tests / teuthology

Hi,

On 13/04/2015 04:39, Zhou, Yuan wrote:> Hi Loic,
>=20
> =20
>=20
> I'm trying to setup an internal Teuthology cluster here. I was able t=
o setup a 3 node cluster now. however there's not much docs and I'm con=
fused about some questions here:
>=20
> =20
>=20
> 1)      how does Ceph upstream do tests? Currently I see there's a) J=
ekins(make check on each PR)=20

Yes.

> b) Teuthology Integration tests(on important PR only).
>

The teuthology tests are run either by cron jobs or by people. http://p=
ulpito.ceph.com/. They are not run on pull request.

> 2)      Teuthology automatically fetch the binary files from gitbuild=
er.ceph.com currently. However the binary will not be built for each pu=
ll request?=20

Right. Teuthology can be pointed to an alternate repository but there i=
s a catch: it needs to have the same naming conventions as gitbuilder.c=
eph.com. These naming convention are not documented (as far as I know) =
and you would need to read the code to figure them out. When I tried to=
 customize the repository, I replaced the code locating the repository =
with something that was configurable instead (reading the yaml file). B=
ut I did it in a hackish way and did not take the time to figure out ho=
w to contribute that back properly.

> 3)      Can Teuthology working on VMs? I got some info from your blog=
, looks like you're running Teuthology on a Openstack/Docker.

The easiest way is to prepare three VMs and make sure you can ssh to th=
em without password. You then create a targets.yaml file with these thr=
ee machines. And you can run a single job that will use them. It will s=
ave you the trouble of setting up a full teuthology cluster (I think ht=
tp://dachary.org/?p=3D2204 is still mostly valid). The downside is that=
 it only allows you to run a single job at a time and will not allow yo=
u to run teuthology-suite to schedule a number of jobs and have them wa=
it in the queue.

I'm not actually using the docker backend I hacked together, therefore =
I don't recommend you try this route, unless you have a week or two to =
devote to it. =20

> 4)      If I have a working Teuthology cluster now, how do I start a =
full run? or only the workunits/* is good enough?

=46or instance:

=2E/virtualenv/bin/teuthology-suite --filter-out btrfs,ext4 --priority =
1000 --suite rados --suite-branch giant --machine-type plana,burnupi,mi=
ra --distro ubuntu --email abhishek.lekshmanan@gmail.com --owner abhish=
ek.lekshmanan@gmail.com --ceph giant-backports

http://tracker.ceph.com/issues/11153 contains many examples of how teut=
hology is run to test stable releases.

The easiest way to create a single job probably is to run ./virtualenv/=
bin/teuthology-suite : it will output calls to teuthology that you can =
probalby copy / paste to run a single job. I've not tried that and went=
 a more difficult route instead (manually assembling yaml files to crea=
te a job).=20

Zack will probably have more hints and advices on how to run your own t=
euthology suite.

Cheers

> =20
>=20
> Thanks for any hints!
>=20
> -yuan
>=20
> =20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
