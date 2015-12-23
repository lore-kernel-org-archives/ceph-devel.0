From: Alfredo Deza <adeza@redhat.com>
Subject: New "make check" job for Ceph pull requests
Date: Wed, 23 Dec 2015 15:05:03 -0500
Message-ID: <CAC-Np1wTpq4fJBtfJow9KY5dQ2vDmd_Mi_AsLhnavkhdr21apA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34124 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933827AbbLWUFE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Dec 2015 15:05:04 -0500
Received: by mail-wm0-f41.google.com with SMTP id l126so158718663wml.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Dec 2015 12:05:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, sepia@ceph.com

Hi all,

As of yesterday (Tuesday Dec 22nd) we have the "make check" job
running within our CI infrastructure, working very similarly as the
previous check with a few differences:

* there are no longer comments added to the pull requests
* notifications of success (or failure) are done inline in the same
notification box for "This branch has no conflicts with the base
branch"
* All members of the Ceph organization can trigger a job with the
following comment:
    test this please

Changes to the job should be done following our new process: anyone can open
a pull request against the "ceph-pull-requests" job that configures/modifies
it. This process is fairly minimal:

1) *Jobs no longer require to make changes in the Jenkins UI*, they
are rather plain text YAML files that live in the ceph/ceph-build.git
repository and have a specific structure. Job changes (including
scripts) are made directly on that repository via pull requests.

2) As soon as a PR is merged the changes are automatically pushed to
Jenkins. Regardless if this is a new or old job. All one needs for a
new job to appear is a directory with a working YAML file (see links
at the end on what this means)

Below, please find a list to resources on how to make changes to a
Jenkins Job, and examples on how mostly anyone can provide changes:

* Format and configuration of YAML files are consumed by JJB (Jenkins
Job builder), full docs are here:
http://docs.openstack.org/infra/jenkins-job-builder/definition.html
* Where does the make-check configuration lives?
https://github.com/ceph/ceph-build/tree/master/ceph-pull-requests
* Full documentation on Job structure and configuration:
https://github.com/ceph/ceph-build#ceph-build
* Everyone has READ permissions on jenkins.ceph.com (you can 'login'
with your github account), current admin members (WRITE permissions)
are: ktdreyer, alfredodeza, gregmeno, dmick, zmc, andrewschoen,
ceph-jenkins, dachary, ldachary

If you have any questions, we can help and provide guidance and feedback. We
highly encourage contributors to take ownership on this new tool and make it
awesome!

Thanks,


Alfredo
