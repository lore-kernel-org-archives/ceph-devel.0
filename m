From: Sage Weil <sage@newdream.net>
Subject: RE: Ceph code tests / teuthology
Date: Fri, 24 Apr 2015 09:02:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504240900330.5458@cobra.newdream.net>
References: <06681238D8946F44A60AA400760A1CBF01F237CC@SHSMSX104.ccr.corp.intel.com> <552B89FF.70809@dachary.org> <06681238D8946F44A60AA400760A1CBF01F42F47@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1128371804-1429891321=:5458"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33549 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030464AbbDXQCC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Apr 2015 12:02:02 -0400
In-Reply-To: <06681238D8946F44A60AA400760A1CBF01F42F47@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Zack Cerza <zack@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1128371804-1429891321=:5458
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Apr 2015, Zhou, Yuan wrote:
> Hi Loic/Zack,
>=20
> So I've got some progress here. I was able to run a single job with=20
> teuthology xxx.yaml targets.yaml. From the code, teuthology-suite needs=
=20
> to query the lock-server for some machine info, like os_type, platform.=
=20
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
> > I'm trying to setup an internal Teuthology cluster here. I was able t=
o setup a 3 node cluster now. however there's not much docs and I'm confu=
sed about some questions here:
> >=20
> > =20
> >=20
> > 1)      how does Ceph upstream do tests? Currently I see there's a) J=
ekins(make check on each PR)=20
>=20
> Yes.
>=20
> > b) Teuthology Integration tests(on important PR only).
> >
>=20
> The teuthology tests are run either by cron jobs or by people. http://p=
ulpito.ceph.com/. They are not run on pull request.
>=20
> > 2)      Teuthology automatically fetch the binary files from gitbuild=
er.ceph.com currently. However the binary will not be built for each pull=
 request?=20
>=20
> Right. Teuthology can be pointed to an alternate repository but there i=
s a catch: it needs to have the same naming conventions as gitbuilder.cep=
h.com. These naming convention are not documented (as far as I know) and =
you would need to read the code to figure them out. When I tried to custo=
mize the repository, I replaced the code locating the repository with som=
ething that was configurable instead (reading the yaml file). But I did i=
t in a hackish way and did not take the time to figure out how to contrib=
ute that back properly.
>=20
> > 3)      Can Teuthology working on VMs? I got some info from your blog=
, looks like you're running Teuthology on a Openstack/Docker.
>=20
> The easiest way is to prepare three VMs and make sure you can ssh to th=
em without password. You then create a targets.yaml file with these three=
 machines. And you can run a single job that will use them. It will save =
you the trouble of setting up a full teuthology cluster (I think http://d=
achary.org/?p=3D2204 is still mostly valid). The downside is that it only=
 allows you to run a single job at a time and will not allow you to run t=
euthology-suite to schedule a number of jobs and have them wait in the qu=
eue.
>=20
> I'm not actually using the docker backend I hacked together, therefore =
I don't recommend you try this route, unless you have a week or two to de=
vote to it. =20
>=20
> > 4)      If I have a working Teuthology cluster now, how do I start a =
full run? or only the workunits/* is good enough?
>=20
> For instance:
>=20
> ./virtualenv/bin/teuthology-suite --filter-out btrfs,ext4 --priority 10=
00 --suite rados --suite-branch giant --machine-type plana,burnupi,mira -=
-distro ubuntu --email abhishek.lekshmanan@gmail.com --owner abhishek.lek=
shmanan@gmail.com --ceph giant-backports
>=20
> http://tracker.ceph.com/issues/11153 contains many examples of how teut=
hology is run to test stable releases.
>=20
> The easiest way to create a single job probably is to run ./virtualenv/=
bin/teuthology-suite : it will output calls to teuthology that you can pr=
obalby copy / paste to run a single job. I've not tried that and went a m=
ore difficult route instead (manually assembling yaml files to create a j=
ob).=20
>=20
> Zack will probably have more hints and advices on how to run your own t=
euthology suite.
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
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1128371804-1429891321=:5458--
