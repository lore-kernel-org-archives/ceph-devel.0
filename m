From: Ivo Jimenez <ivo@cs.ucsc.edu>
Subject: Fwd: Running a single teuthology job locally using containers
Date: Thu, 3 Sep 2015 14:45:37 -0700
Message-ID: <CAJw4g7XUek_0BaBFqJnJOaLSK7NVgWmbrJuKpfa5NOzTcPqy-Q@mail.gmail.com>
References: <1559779519.12046158.1441271711230.JavaMail.zimbra@redhat.com>
 <55E81C46.6060805@dachary.org> <CAJw4g7W9g6Hkk3w5c=psM5xRviF+AYqxu4hcHLTNzhJC_n8DYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34511 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbbICVp7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Sep 2015 17:45:59 -0400
Received: by iofb144 with SMTP id b144so3495180iof.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Sep 2015 14:45:59 -0700 (PDT)
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com. [209.85.223.182])
        by smtp.gmail.com with ESMTPSA id 93sm168308iog.4.2015.09.03.14.45.57
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2015 14:45:57 -0700 (PDT)
Received: by iofb144 with SMTP id b144so3494482iof.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Sep 2015 14:45:57 -0700 (PDT)
In-Reply-To: <CAJw4g7W9g6Hkk3w5c=psM5xRviF+AYqxu4hcHLTNzhJC_n8DYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

On Thu, Sep 3, 2015 at 3:09 AM Loic Dachary <loic@dachary.org> wrote:
>
> >  2. Initialize a `cephdev` container (the following assumes `$PWD` is
> >     the folder containing the ceph code in your machine):
> >
> >     ```bash
> >     docker run \
> >       --name remote0
> >       -p 2222:22
> >       -d -e AUTHORIZED_KEYS="`cat ~/.ssh/id_rsa.pub`" \
> >       -v `pwd`:/ceph \
> >       -v /dev:/dev \
> >       -v /tmp/ceph_data/$RANDOM:/var/lib/ceph \
> >       --cap-add=SYS_ADMIN --privileged \
> >       --device /dev/fuse
> >       ivotron/cephdev
> >     ```
>
> $PWD is ceph built from sources ? Could you share the dockerfile you used to create ivotron/cephdev ?


Yes, the idea is to wrap your ceph folder in a container so that it
becomes a target for teuthology. The link to the dockerfile:

https://github.com/ivotron/docker-cephdev

>
> >
> > Caveats:
> >
> >   * only a single job can be executed and has to be manually
> >     assembled. I plan to work on supporting suites, which, in short,
> >     implies stripping out the `install` task from existing suites and
> >     leaving only the `install.ship_utilities` subtask instead (the
> >     container image has all the dependencies in it already).
>
> Maybe there could be a script to transform config files such as http://qa-proxy.ceph.com/teuthology/loic-2015-09-02_15:41:18-rbd-master---basic-multi/1042448/config.yaml into a config file suitable for this use case ?


that's what I have in mind but haven't looked into it yet. I was
thinking about extending teuthology-suite so that you pass a
--filter-tasks flag so that we can remove the unwanted tasks, in the
similar way that --filter leaves some suites out.

>
> Together with git clone -b $sha1 + make in the container, it would be a nice way to replay / debug a failed job using a single vm and without going through packages.


that'd be relatively straight-forward to accomplish, at least the
docker-side of things (a dockerfile that is given the $SHA1). Prior to
that, we'd need to have a script that extracts the failed job from
paddles (does this exist already?), creates a new sha1-predicated
container and passes the yaml file of the failed job to teuthology
(which would be invoked with the hypothetical --filter-tasks flag
mentioned above).

>
> >   * I have only tried the above with the `radosbench` and `ceph-fuse`
> >     tasks. Using `--cap-add=ALL` and `-v /lib/modules:/lib/modules`
> >     flags allows a container to load kernel modules so, in principle,
> >     it should work for `rbd` and  `kclient` tasks but I haven't tried
> >     it yet.
> >   * For jobs specifying multiple remotes, multiple containers can be
> >     launched (one per remote). While it is possible to run these
> >     on the same docker host, the way ceph daemons dynamically
> >     bind to ports in the 6800-7300 range makes it difficult to
> >     determine which ports to expose from each container (exposing the
> >     same port from multiple containers in the same host is not
> >     allowed, for obvious reasons). So either each remote runs on a
> >     distinct docker host machine, or a deterministic port assignment
> >     is implemented such that, for example, 6800 is always assigned to
> >     osd.0, regardless of where it runs.
>
> Would docker run --publish-all=true help ?


That option doesn't work with --net=container, which is what we are
using in this case since we remap sshd's 22 port of the container. In
other words, for --publish-all to work we need to use --net=host but
that disables the virtual network that docker provides. An alternative
would be to configure the base image we're using
(https://github.com/tutumcloud/tutum-ubuntu/) so that the port that
sshd uses is passed in an env var.

>
>
> Clever hack, congrats :-)


thanks!
