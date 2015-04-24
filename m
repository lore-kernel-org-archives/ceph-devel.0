From: Zack Cerza <zack@redhat.com>
Subject: Re: Ceph code tests / teuthology
Date: Fri, 24 Apr 2015 12:10:43 -0400 (EDT)
Message-ID: <35624459.5136277.1429891843222.JavaMail.zimbra@redhat.com>
References: <06681238D8946F44A60AA400760A1CBF01F237CC@SHSMSX104.ccr.corp.intel.com> <552B89FF.70809@dachary.org> <06681238D8946F44A60AA400760A1CBF01F42F47@SHSMSX104.ccr.corp.intel.com> <alpine.DEB.2.00.1504240900330.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:56399 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967046AbbDXQLt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Apr 2015 12:11:49 -0400
In-Reply-To: <alpine.DEB.2.00.1504240900330.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yuan Zhou <yuan.zhou@intel.com>, Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

If you're scheduling jobs with teuthology-suite *and* disabling locking=
, my guess is you're in for an adventure.

The lock server is called paddles:
 https://github.com/ceph/paddles/

The setup instructions are up-to-date but note that the API docs are no=
t (but you shouldn't need those anyway).

There are additional docs covering new lab setup here:
 http://ceph.com/teuthology/docs/LAB_SETUP.html

Thanks,
Zack

----- Original Message -----
=46rom: "Sage Weil" <sage@newdream.net>
To: "Yuan Zhou" <yuan.zhou@intel.com>
Cc: "Loic Dachary" <loic@dachary.org>, "Ceph Development" <ceph-devel@v=
ger.kernel.org>, "Zack Cerza" <zack@redhat.com>
Sent: Friday, April 24, 2015 10:02:01 AM
Subject: RE: Ceph code tests / teuthology

On Fri, 24 Apr 2015, Zhou, Yuan wrote:
> Hi Loic/Zack,
>=20
> So I've got some progress here. I was able to run a single job with=20
> teuthology xxx.yaml targets.yaml. From the code, teuthology-suite nee=
ds=20
> to query the lock-server for some machine info, like os_type, platfor=
m.=20
> Is there any documents for the lock-server?

You can skip these checks with=20

 check-locks: false

in the job yaml.

sage


>=20
> Thanks, -yuan
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Monday, April 13, 2015 5:19 PM
> To: Zhou, Yuan
> Cc: Ceph Development; Zack Cerza
> Subject: Re: Ceph code tests / teuthology
>=20
> Hi,
>=20
> On 13/04/2015 04:39, Zhou, Yuan wrote:> Hi Loic,
> >=20
> > =20
> >=20
> > I'm trying to setup an internal Teuthology cluster here. I was able=
 to setup a 3 node cluster now. however there's not much docs and I'm c=
onfused about some questions here:
> >=20
> > =20
> >=20
> > 1)      how does Ceph upstream do tests? Currently I see there's a)=
 Jekins(make check on each PR)=20
>=20
> Yes.
>=20
> > b) Teuthology Integration tests(on important PR only).
> >
>=20
> The teuthology tests are run either by cron jobs or by people. http:/=
/pulpito.ceph.com/. They are not run on pull request.
>=20
> > 2)      Teuthology automatically fetch the binary files from gitbui=
lder.ceph.com currently. However the binary will not be built for each =
pull request?=20
>=20
> Right. Teuthology can be pointed to an alternate repository but there=
 is a catch: it needs to have the same naming conventions as gitbuilder=
=2Eceph.com. These naming convention are not documented (as far as I kn=
ow) and you would need to read the code to figure them out. When I trie=
d to customize the repository, I replaced the code locating the reposit=
ory with something that was configurable instead (reading the yaml file=
). But I did it in a hackish way and did not take the time to figure ou=
t how to contribute that back properly.
>=20
> > 3)      Can Teuthology working on VMs? I got some info from your bl=
og, looks like you're running Teuthology on a Openstack/Docker.
>=20
> The easiest way is to prepare three VMs and make sure you can ssh to =
them without password. You then create a targets.yaml file with these t=
hree machines. And you can run a single job that will use them. It will=
 save you the trouble of setting up a full teuthology cluster (I think =
http://dachary.org/?p=3D2204 is still mostly valid). The downside is th=
at it only allows you to run a single job at a time and will not allow =
you to run teuthology-suite to schedule a number of jobs and have them =
wait in the queue.
>=20
> I'm not actually using the docker backend I hacked together, therefor=
e I don't recommend you try this route, unless you have a week or two t=
o devote to it. =20
>=20
> > 4)      If I have a working Teuthology cluster now, how do I start =
a full run? or only the workunits/* is good enough?
>=20
> For instance:
>=20
> ./virtualenv/bin/teuthology-suite --filter-out btrfs,ext4 --priority =
1000 --suite rados --suite-branch giant --machine-type plana,burnupi,mi=
ra --distro ubuntu --email abhishek.lekshmanan@gmail.com --owner abhish=
ek.lekshmanan@gmail.com --ceph giant-backports
>=20
> http://tracker.ceph.com/issues/11153 contains many examples of how te=
uthology is run to test stable releases.
>=20
> The easiest way to create a single job probably is to run ./virtualen=
v/bin/teuthology-suite : it will output calls to teuthology that you ca=
n probalby copy / paste to run a single job. I've not tried that and we=
nt a more difficult route instead (manually assembling yaml files to cr=
eate a job).=20
>=20
> Zack will probably have more hints and advices on how to run your own=
 teuthology suite.
>=20
> Cheers
>=20
> > =20
> >=20
> > Thanks for any hints!
> >=20
> > -yuan
> >=20
> > =20
> >=20
>=20
> --=20
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
