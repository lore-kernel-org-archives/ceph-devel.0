From: Alfredo Deza <adeza@redhat.com>
Subject: CentOS 6 and Ubuntu Precise binaries for Hammer 0.94.6
Date: Thu, 3 Mar 2016 14:41:16 -0500
Message-ID: <CAC-Np1xgn8TsowLqrtkRjjLYbmpmy1dk2NuG3v+uDpm4AVHJRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34320 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758117AbcCCTlS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2016 14:41:18 -0500
Received: by mail-wm0-f50.google.com with SMTP id p65so49686350wmp.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Mar 2016 11:41:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,

Some good news, we were able to go back and get CentOS 6 binaries
built for the 0.94.6 release.

They aren't published yet (they remain unsigned, queued up in our
release process).

However, we are at an impasse with the Precise build. We can't get
Precise nodes to build because the distro has a very old version of
the JVM which causes issues when connecting to Jenkins as a node.

The exact error when attempting a connection is:

     Caused by: java.lang.UnsupportedClassVersionError:
hudson/slaves/SlaveComputer$SlaveVersion: Unsupported major.minor 51.0

The way we get a new node for the build system up and running is by
making an API call to an OpenStack provider that a boot time it runs
some Ansible playbook which allows the new host to comply with our
needs to be a workable node and register itself to the Master Jenkins
server.

What does this mean? --> I can't commit to fix this and would love to
have some help from anyone in the community. I can review/merge a pull
request with a patch to the playbook we use to setup slaves so that if
a Precise machine is used it gets a newer JVM version.

The Github project for our build system is: https://github.com/ceph/ceph-build

The YAML file we use to setup new slaves is:
https://github.com/ceph/ceph-build/blob/master/ansible/slave.yml

Once a fix is in place I can go and get the process going again,
complete the signing of the binaries and get them released into the
Hammer repositories.

Thanks


Alfredo
