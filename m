From: Loic Dachary <loic@dachary.org>
Subject: Re: Fwd: Running a single teuthology job locally using containers
Date: Fri, 11 Sep 2015 21:42:20 +0200
Message-ID: <55F32E9C.60701@dachary.org>
References: <1559779519.12046158.1441271711230.JavaMail.zimbra@redhat.com> <55E81C46.6060805@dachary.org> <CAJw4g7W9g6Hkk3w5c=psM5xRviF+AYqxu4hcHLTNzhJC_n8DYg@mail.gmail.com> <CAJw4g7XUek_0BaBFqJnJOaLSK7NVgWmbrJuKpfa5NOzTcPqy-Q@mail.gmail.com> <55E8C85B.600@dachary.org> <CAJw4g7WG__XJs7rH2BROU1Rsb9ZxXw2+35qCzYM2P98Jz7GWKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BgG4a3nq9Fxuo2tTNlS9N42PXDlc189wT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54000 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753815AbbIKTmY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 15:42:24 -0400
In-Reply-To: <CAJw4g7WG__XJs7rH2BROU1Rsb9ZxXw2+35qCzYM2P98Jz7GWKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ivo Jimenez <ivo@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BgG4a3nq9Fxuo2tTNlS9N42PXDlc189wT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ivo,

On 11/09/2015 21:07, Ivo Jimenez wrote:
> Hi Loic,
>=20
> Based on your feedback, a few action-items emerged for improving this
> containerized approach to running teuthology jobs:
>=20
>  1. use install-deps.sh for installing dependencies
>  2. modify the sshd configuration so that the ssh port is specified at
>     runtime via an environment variable. This has the consequence of
>     being able to use --net=3Dhost and thus more than one remote can ru=
n
>     locally (for jobs with multiple remotes).
>  3. add an option to provide a sha1 so that the code gets checked out
>     as part of the entrypoint of the container and gets built.

Would it be something like http://tracker.ceph.com/issues/13031 ?=20

>  4. write a 'dockerize-config' script for taking a failed job's YAML
>     file and modify it so that it can run with containers.

+1 :-)

>  5. write a 'failed-devenv' script that given a url to a failed job
>     (a) fetches the YAML file (b) runs the dockerize-config script (c)
>     checks out the corresponding sha1 version (d) compiles the code

In this case it might be easier to have the original teuthology-suite com=
mand available as part of the job config (original-cli-call: teuthology-s=
uite --ceph foo --....) and just re-run that command with --filter=3D"$de=
scription" where $description is the description of the job. It's a lot m=
ore stable / reliable than reworking the config.yaml file. Doing that kin=
d of dockerization of the config.yaml is very useful for any existing job=
 archive for which you don't have enough information to reschedule the jo=
b with --filter. But if you have the original command, then it's way easi=
er to just re-issue a teuthology-suite with a change in argumente to use =
--filter.

>  6. write a 'run-failed-job' that (a) re-builds the code (b)
>     instantiates one container for each specified remote and (c)
>     executes the job.

+2000=20

Here is how we do it for backports : http://tracker.ceph.com/projects/cep=
h-releases/wiki/HOWTO_run_integration_and_upgrade_tests#Re-scheduling-fai=
led-or-dead-jobs-from-an-existing-suite

It's simple and tedious. It would be awesome to have something easier and=
 shorter :-)

>=20
> I've implemented 1-3 and am working on 4-6. In short, the goal of all
> the above is to capture the dev/build/test loop and make it easier to
> go from 'failed job' to 'working on a fix'. The high-level sequence is
> (1) run 'make-failed-devenv' so you get the dev environment for the
> failed job (2) work on a fix and (3) invoke 'run-failed-job' and
> inspect results (possibly going back to 2 if need it).
>=20
> Thoughts on 4-6?
>=20
> cheers,
> ivo
>=20

Cheers

>=20
> On Thu, Sep 3, 2015 at 3:23 PM, Loic Dachary <loic@dachary.org> wrote:
>>
>>
>> On 03/09/2015 23:45, Ivo Jimenez wrote:> On Thu, Sep 3, 2015 at 3:09 A=
M Loic Dachary <loic@dachary.org> wrote:
>>>>
>>>>>  2. Initialize a `cephdev` container (the following assumes `$PWD` =
is
>>>>>     the folder containing the ceph code in your machine):
>>>>>
>>>>>     ```bash
>>>>>     docker run \
>>>>>       --name remote0
>>>>>       -p 2222:22
>>>>>       -d -e AUTHORIZED_KEYS=3D"`cat ~/.ssh/id_rsa.pub`" \
>>>>>       -v `pwd`:/ceph \
>>>>>       -v /dev:/dev \
>>>>>       -v /tmp/ceph_data/$RANDOM:/var/lib/ceph \
>>>>>       --cap-add=3DSYS_ADMIN --privileged \
>>>>>       --device /dev/fuse
>>>>>       ivotron/cephdev
>>>>>     ```
>>>>
>>>> $PWD is ceph built from sources ? Could you share the dockerfile you=
 used to create ivotron/cephdev ?
>>>
>>>
>>> Yes, the idea is to wrap your ceph folder in a container so that it
>>> becomes a target for teuthology. The link to the dockerfile:
>>>
>>> https://github.com/ivotron/docker-cephdev
>>
>> You may want to use install-deps.sh instead of apt-get build-dep to ge=
t the packages from sources instead of a presumably older from the source=
 repositories.
>>>
>>>>
>>>>>
>>>>> Caveats:
>>>>>
>>>>>   * only a single job can be executed and has to be manually
>>>>>     assembled. I plan to work on supporting suites, which, in short=
,
>>>>>     implies stripping out the `install` task from existing suites a=
nd
>>>>>     leaving only the `install.ship_utilities` subtask instead (the
>>>>>     container image has all the dependencies in it already).
>>>>
>>>> Maybe there could be a script to transform config files such as http=
://qa-proxy.ceph.com/teuthology/loic-2015-09-02_15:41:18-rbd-master---bas=
ic-multi/1042448/config.yaml into a config file suitable for this use cas=
e ?
>>>
>>>
>>> that's what I have in mind but haven't looked into it yet. I was
>>> thinking about extending teuthology-suite so that you pass a
>>> --filter-tasks flag so that we can remove the unwanted tasks, in the
>>> similar way that --filter leaves some suites out.
>>>
>>>>
>>>> Together with git clone -b $sha1 + make in the container, it would b=
e a nice way to replay / debug a failed job using a single vm and without=
 going through packages.
>>>
>>>
>>> that'd be relatively straight-forward to accomplish, at least the
>>> docker-side of things (a dockerfile that is given the $SHA1). Prior t=
o
>>> that, we'd need to have a script that extracts the failed job from
>>> paddles (does this exist already?), creates a new sha1-predicated
>>
>> What do you mean by "extract the failed job" ? Do you expect paddles t=
o have more information than the config.yaml file ( loic-2015-09-02_15:41=
:18-rbd-master---basic-multi/1042448/config.yaml for instance) ?
>>
>>> container and passes the yaml file of the failed job to teuthology
>>> (which would be invoked with the hypothetical --filter-tasks flag
>>> mentioned above).
>>
>> It's probably more than just filtering out tasks. What about a script =
that would
>>
>>    dockerize-config < config.yaml > docker-config.yaml
>>
>> and be smart enough to do whatever is necessary to transform an existi=
ng config.yaml so that it is suitable to run on docker targets. And fail =
loudly if it can't ;-)
>>
>>>
>>>>
>>>>>   * I have only tried the above with the `radosbench` and `ceph-fus=
e`
>>>>>     tasks. Using `--cap-add=3DALL` and `-v /lib/modules:/lib/module=
s`
>>>>>     flags allows a container to load kernel modules so, in principl=
e,
>>>>>     it should work for `rbd` and  `kclient` tasks but I haven't tri=
ed
>>>>>     it yet.
>>>>>   * For jobs specifying multiple remotes, multiple containers can b=
e
>>>>>     launched (one per remote). While it is possible to run these
>>>>>     on the same docker host, the way ceph daemons dynamically
>>>>>     bind to ports in the 6800-7300 range makes it difficult to
>>>>>     determine which ports to expose from each container (exposing t=
he
>>>>>     same port from multiple containers in the same host is not
>>>>>     allowed, for obvious reasons). So either each remote runs on a
>>>>>     distinct docker host machine, or a deterministic port assignmen=
t
>>>>>     is implemented such that, for example, 6800 is always assigned =
to
>>>>>     osd.0, regardless of where it runs.
>>>>
>>>> Would docker run --publish-all=3Dtrue help ?
>>>
>>>
>>> That option doesn't work with --net=3Dcontainer, which is what we are=

>>> using in this case since we remap sshd's 22 port of the container. In=

>>> other words, for --publish-all to work we need to use --net=3Dhost bu=
t
>>> that disables the virtual network that docker provides. An alternativ=
e
>>> would be to configure the base image we're using
>>> (https://github.com/tutumcloud/tutum-ubuntu/) so that the port that
>>> sshd uses is passed in an env var.
>>
>> Why not use --net=3Dhost then ?
>>
>>>
>>>>
>>>>
>>>> Clever hack, congrats :-)
>>>
>>>
>>> thanks!
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--BgG4a3nq9Fxuo2tTNlS9N42PXDlc189wT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXzLpwACgkQ8dLMyEl6F23JfgCgxGfpRsgYtI1AFGscODGQp4ho
xekAoLy63FAvp5mntlXG8wTKF89xCMOI
=tNaL
-----END PGP SIGNATURE-----

--BgG4a3nq9Fxuo2tTNlS9N42PXDlc189wT--
