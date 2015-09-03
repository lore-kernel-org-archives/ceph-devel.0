From: Ivo Jimenez <ivo@redhat.com>
Subject: Running a single teuthology job locally using containers
Date: Thu, 3 Sep 2015 05:15:11 -0400 (EDT)
Message-ID: <1559779519.12046158.1441271711230.JavaMail.zimbra@redhat.com>
References: <823799711.11457395.1441183192847.JavaMail.zimbra@redhat.com>
Reply-To: Ivo Jimenez <ivo@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:58410 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbbICJPM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Sep 2015 05:15:12 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t839FBPY030783
	for <ceph-devel@vger.kernel.org>; Thu, 3 Sep 2015 05:15:11 -0400
In-Reply-To: <823799711.11457395.1441183192847.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This describes how to run teuthology jobs using docker in three
"easy" steps, with the goal of shortening the develop/build/test
cycle for integration-tested code.

 1. Write a file containing an entire teuthology job (tasks, targets
    and roles in a YAML file):

    ```yaml
    sshkeys: ignore
    roles:
    - [mon.0, osd.0, osd.1, osd.2, client.0]
    tasks:
    - install.ship_utilities:
    - ceph:
        conf:
          mon:
            debug mon: 20
            debug ms: 1
            debug paxos: 20
          osd:
            debug filestore: 20
            debug journal: 20
            debug ms: 1
            debug osd: 20
    - radosbench:
        clients: [client.0]
    targets:
      'root@localhost:2222': ssh-dss ignored
    ```

    The `sshkeys` option is required and the `install.ship_utilities`
    should be the first task to execute. Also, `~/.teuthology.yaml`
    should look like this:

    ```yaml
    lab_domain: ''
    lock_server: ''
    ```

 2. Initialize a `cephdev` container (the following assumes `$PWD` is 
    the folder containing the ceph code in your machine):

    ```bash
    docker run \
      --name remote0
      -p 2222:22
      -d -e AUTHORIZED_KEYS="`cat ~/.ssh/id_rsa.pub`" \
      -v `pwd`:/ceph \
      -v /dev:/dev \
      -v /tmp/ceph_data/$RANDOM:/var/lib/ceph \
      --cap-add=SYS_ADMIN --privileged \
      --device /dev/fuse
      ivotron/cephdev
    ```

 3. Execute teuthology using the `wip-11892-docker` branch:

    ```bash
    teuthology \
      -a ~/archive/`date +%s` \
      --suite-path /path/to/ceph-qa-suite/ \
      ~/test.yml
    ```

Caveats:

  * only a single job can be executed and has to be manually 
    assembled. I plan to work on supporting suites, which, in short, 
    implies stripping out the `install` task from existing suites and 
    leaving only the `install.ship_utilities` subtask instead (the 
    container image has all the dependencies in it already).
  * I have only tried the above with the `radosbench` and `ceph-fuse` 
    tasks. Using `--cap-add=ALL` and `-v /lib/modules:/lib/modules` 
    flags allows a container to load kernel modules so, in principle,
    it should work for `rbd` and  `kclient` tasks but I haven't tried
    it yet.
  * For jobs specifying multiple remotes, multiple containers can be 
    launched (one per remote). While it is possible to run these 
    on the same docker host, the way ceph daemons dynamically
    bind to ports in the 6800-7300 range makes it difficult to
    determine which ports to expose from each container (exposing the
    same port from multiple containers in the same host is not
    allowed, for obvious reasons). So either each remote runs on a
    distinct docker host machine, or a deterministic port assignment
    is implemented such that, for example, 6800 is always assigned to
    osd.0, regardless of where it runs.

Cheers,
ivo
