From: Alfredo Deza <adeza@redhat.com>
Subject: quick testing/development with ceph-ansible
Date: Tue, 9 May 2017 09:53:53 -0400
Message-ID: <CAC-Np1zJJF8f4nh2RMQH6m85hKfXOWbDcvzXUOyv89YEyLUiRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33754 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753798AbdEINxz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 09:53:55 -0400
Received: by mail-wr0-f171.google.com with SMTP id w50so100789wrc.0
        for <ceph-devel@vger.kernel.org>; Tue, 09 May 2017 06:53:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Andrew Schoen <aschoen@redhat.com>

Hi,

For the past few months Andrew Schoen and I have been working on
getting a testing workflow [0] for ceph-ansible that can quickly bring
up a number of machines, deploy Ceph, and verify correctness
afterwards.

Unlike other testing *frameworks*, there is no actual framework, but
just a collection of tools working together to create machines, deploy
ceph, and run tests. The process uses a few tools:

* tox [1] For creating the test matrix from variables (factors) and
defining the steps

* vagrant [2] To create the machines

* testinfra [3] For testing remote nodes

* virtualbox or libvirt: as the backend for creating machines

Our reasoning for something like this was to be able to test
thoroughly all pull requests coming into the ceph-ansible project,
with all the permutations we think are important (e.g. we have the
ability to test ansible 2.1 and 2.2, and can add 2.3 easily to the
matrix), while being able to run these locally.

Currently, we are running about 26 separate test scenarios per pull
request. These are just a few of the combinations we currently
support:

jewel-ansible2.2-xenial_cluster
jewel-ansible2.2-journal_collocation
jewel-ansible2.2-centos7_cluster
jewel-ansible2.2-dmcrypt_journal
jewel-ansible2.2-dmcrypt_journal_collocation
jewel-ansible2.2-docker_cluster
jewel-ansible2.2-purge_cluster
jewel-ansible2.2-purge_dmcrypt
jewel-ansible2.2-docker_dedicated_journal
jewel-ansible2.2-docker_dmcrypt_journal_collocation
jewel-ansible2.2-update_dmcrypt
jewel-ansible2.2-update_cluster
jewel-ansible2.2-cluster
kraken-ansible2.2-xenial_cluster
kraken-ansible2.2-journal_collocation
kraken-ansible2.2-centos7_cluster
kraken-ansible2.2-dmcrypt_journal
kraken-ansible2.2-dmcrypt_journal_collocation
kraken-ansible2.2-docker_cluster
kraken-ansible2.2-purge_cluster
kraken-ansible2.2-purge_dmcrypt
kraken-ansible2.2-docker_dedicated_journal
kraken-ansible2.2-docker_dmcrypt_journal_collocation
kraken-ansible2.2-update_dmcrypt
kraken-ansible2.2-update_cluster
kraken-ansible2.2-cluster

All of those are expanded by tox, from factors defined in the tox.ini
[4] (tox's configuration file).

This way of setting up a cluster is very liberating: machines are in
pristine condition each time, with a few variables the provisioning
can change, one can reproduce environments regardless of the testing
system (e.g. not tied to Jenkins or other CI components), and it
doesn't need actual running machines.

The objective of this is to bring up a cluster, test it, and tear it
down, but for debugging/development  it isn't hard to keep the
machines around: just remove the line in tox.ini that destroys the
machines with vagrant.

The amount of (non-functional) tests we have is not very large, but
helps make verification of deployment with ceph-ansible. For example,
there are assertions on how we generate a ceph.conf file from the
template.

We have a good amount of initial documentation for the project [0]
explaining how to set things up and add/change tests, any feedback is
welcome so we can improve those docs and make it easier to get
started.

Thanks!

[0] http://docs.ceph.com/ceph-ansible/master/testing/index.html
[1] https://tox.readthedocs.io/en/latest/
[2] https://www.vagrantup.com/
[3] https://testinfra.readthedocs.io/en/latest/
[4] https://github.com/ceph/ceph-ansible/blob/master/tox.ini
