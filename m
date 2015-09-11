From: Ivo Jimenez <ivo@cs.ucsc.edu>
Subject: Re: Fwd: Running a single teuthology job locally using containers
Date: Fri, 11 Sep 2015 12:07:22 -0700
Message-ID: <CAJw4g7WG__XJs7rH2BROU1Rsb9ZxXw2+35qCzYM2P98Jz7GWKA@mail.gmail.com>
References: <1559779519.12046158.1441271711230.JavaMail.zimbra@redhat.com>
 <55E81C46.6060805@dachary.org> <CAJw4g7W9g6Hkk3w5c=psM5xRviF+AYqxu4hcHLTNzhJC_n8DYg@mail.gmail.com>
 <CAJw4g7XUek_0BaBFqJnJOaLSK7NVgWmbrJuKpfa5NOzTcPqy-Q@mail.gmail.com> <55E8C85B.600@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:33820 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbbIKTHo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 15:07:44 -0400
Received: by iofb144 with SMTP id b144so109369641iof.1
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2015 12:07:44 -0700 (PDT)
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com. [209.85.213.182])
        by smtp.gmail.com with ESMTPSA id 10sm2050442igt.2.2015.09.11.12.07.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2015 12:07:42 -0700 (PDT)
Received: by igcrk20 with SMTP id rk20so49072443igc.1
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2015 12:07:42 -0700 (PDT)
In-Reply-To: <55E8C85B.600@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Hi Loic,

Based on your feedback, a few action-items emerged for improving this
containerized approach to running teuthology jobs:

 1. use install-deps.sh for installing dependencies
 2. modify the sshd configuration so that the ssh port is specified at
    runtime via an environment variable. This has the consequence of
    being able to use --net=3Dhost and thus more than one remote can ru=
n
    locally (for jobs with multiple remotes).
 3. add an option to provide a sha1 so that the code gets checked out
    as part of the entrypoint of the container and gets built.
 4. write a 'dockerize-config' script for taking a failed job's YAML
    file and modify it so that it can run with containers.
 5. write a 'failed-devenv' script that given a url to a failed job
    (a) fetches the YAML file (b) runs the dockerize-config script (c)
    checks out the corresponding sha1 version (d) compiles the code
 6. write a 'run-failed-job' that (a) re-builds the code (b)
    instantiates one container for each specified remote and (c)
    executes the job.

I've implemented 1-3 and am working on 4-6. In short, the goal of all
the above is to capture the dev/build/test loop and make it easier to
go from 'failed job' to 'working on a fix'. The high-level sequence is
(1) run 'make-failed-devenv' so you get the dev environment for the
failed job (2) work on a fix and (3) invoke 'run-failed-job' and
inspect results (possibly going back to 2 if need it).

Thoughts on 4-6?

cheers,
ivo


On Thu, Sep 3, 2015 at 3:23 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 03/09/2015 23:45, Ivo Jimenez wrote:> On Thu, Sep 3, 2015 at 3:09 =
AM Loic Dachary <loic@dachary.org> wrote:
>>>
>>>>  2. Initialize a `cephdev` container (the following assumes `$PWD`=
 is
>>>>     the folder containing the ceph code in your machine):
>>>>
>>>>     ```bash
>>>>     docker run \
>>>>       --name remote0
>>>>       -p 2222:22
>>>>       -d -e AUTHORIZED_KEYS=3D"`cat ~/.ssh/id_rsa.pub`" \
>>>>       -v `pwd`:/ceph \
>>>>       -v /dev:/dev \
>>>>       -v /tmp/ceph_data/$RANDOM:/var/lib/ceph \
>>>>       --cap-add=3DSYS_ADMIN --privileged \
>>>>       --device /dev/fuse
>>>>       ivotron/cephdev
>>>>     ```
>>>
>>> $PWD is ceph built from sources ? Could you share the dockerfile yo=
u used to create ivotron/cephdev ?
>>
>>
>> Yes, the idea is to wrap your ceph folder in a container so that it
>> becomes a target for teuthology. The link to the dockerfile:
>>
>> https://github.com/ivotron/docker-cephdev
>
> You may want to use install-deps.sh instead of apt-get build-dep to g=
et the packages from sources instead of a presumably older from the sou=
rce repositories.
>>
>>>
>>>>
>>>> Caveats:
>>>>
>>>>   * only a single job can be executed and has to be manually
>>>>     assembled. I plan to work on supporting suites, which, in shor=
t,
>>>>     implies stripping out the `install` task from existing suites =
and
>>>>     leaving only the `install.ship_utilities` subtask instead (the
>>>>     container image has all the dependencies in it already).
>>>
>>> Maybe there could be a script to transform config files such as htt=
p://qa-proxy.ceph.com/teuthology/loic-2015-09-02_15:41:18-rbd-master---=
basic-multi/1042448/config.yaml into a config file suitable for this us=
e case ?
>>
>>
>> that's what I have in mind but haven't looked into it yet. I was
>> thinking about extending teuthology-suite so that you pass a
>> --filter-tasks flag so that we can remove the unwanted tasks, in the
>> similar way that --filter leaves some suites out.
>>
>>>
>>> Together with git clone -b $sha1 + make in the container, it would =
be a nice way to replay / debug a failed job using a single vm and with=
out going through packages.
>>
>>
>> that'd be relatively straight-forward to accomplish, at least the
>> docker-side of things (a dockerfile that is given the $SHA1). Prior =
to
>> that, we'd need to have a script that extracts the failed job from
>> paddles (does this exist already?), creates a new sha1-predicated
>
> What do you mean by "extract the failed job" ? Do you expect paddles =
to have more information than the config.yaml file ( loic-2015-09-02_15=
:41:18-rbd-master---basic-multi/1042448/config.yaml for instance) ?
>
>> container and passes the yaml file of the failed job to teuthology
>> (which would be invoked with the hypothetical --filter-tasks flag
>> mentioned above).
>
> It's probably more than just filtering out tasks. What about a script=
 that would
>
>    dockerize-config < config.yaml > docker-config.yaml
>
> and be smart enough to do whatever is necessary to transform an exist=
ing config.yaml so that it is suitable to run on docker targets. And fa=
il loudly if it can't ;-)
>
>>
>>>
>>>>   * I have only tried the above with the `radosbench` and `ceph-fu=
se`
>>>>     tasks. Using `--cap-add=3DALL` and `-v /lib/modules:/lib/modul=
es`
>>>>     flags allows a container to load kernel modules so, in princip=
le,
>>>>     it should work for `rbd` and  `kclient` tasks but I haven't tr=
ied
>>>>     it yet.
>>>>   * For jobs specifying multiple remotes, multiple containers can =
be
>>>>     launched (one per remote). While it is possible to run these
>>>>     on the same docker host, the way ceph daemons dynamically
>>>>     bind to ports in the 6800-7300 range makes it difficult to
>>>>     determine which ports to expose from each container (exposing =
the
>>>>     same port from multiple containers in the same host is not
>>>>     allowed, for obvious reasons). So either each remote runs on a
>>>>     distinct docker host machine, or a deterministic port assignme=
nt
>>>>     is implemented such that, for example, 6800 is always assigned=
 to
>>>>     osd.0, regardless of where it runs.
>>>
>>> Would docker run --publish-all=3Dtrue help ?
>>
>>
>> That option doesn't work with --net=3Dcontainer, which is what we ar=
e
>> using in this case since we remap sshd's 22 port of the container. I=
n
>> other words, for --publish-all to work we need to use --net=3Dhost b=
ut
>> that disables the virtual network that docker provides. An alternati=
ve
>> would be to configure the base image we're using
>> (https://github.com/tutumcloud/tutum-ubuntu/) so that the port that
>> sshd uses is passed in an env var.
>
> Why not use --net=3Dhost then ?
>
>>
>>>
>>>
>>> Clever hack, congrats :-)
>>
>>
>> thanks!
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
