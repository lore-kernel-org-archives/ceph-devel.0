From: Alfredo Deza <adeza@redhat.com>
Subject: Questions about embedding Lua in the Ceph source tree
Date: Fri, 5 Aug 2016 14:00:23 -0400
Message-ID: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38084 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932800AbcHESA0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2016 14:00:26 -0400
Received: by mail-wm0-f49.google.com with SMTP id o80so47441368wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 05 Aug 2016 11:00:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

At the last Ceph Developer Monthly (CDM) meeting, there was some discussion
about "Mantle" [0], a "a programmable metadata balancer built into the
MDS" which
would use Lua for controlling the load balancing policies.

I wanted to raise a few questions that are important from the
testing/release/maintenance point of view in hopes that we can clarify what the
best path is moving forward and how we can have a robust support for this
feature.

Using Python to create a good portion of the tooling for Ceph, we have
found there is a constant struggle
for testing:

* virtualenvs can (and do) break
* Python packaging can be cumbersome to work with and the Ceph source
has a good amount of workarounds
  to provide an easier path for development)
* Python tools in the Ceph tree are not real Python packages which
forces the whole tooling to workaround this as well
* Dependencies are difficult to deal with (ceph-disk has only one: argparse)

There is a tendency to embed dependencies in the Ceph project which is a big
problem for maintainers (there are many reasons for this, including security
patches, and keeping up to date with forks). For Mantle, this is the case
again: it depends on a Pull Request [1] that embeds a *forked* version of the
official Lua repository that includes custom changes.

Here are a few concerns I have:

* The fork is already modified and has diverged from the upstream Lua [2], who
  is going to keep up with upstream changes? (pulling/rebasing etc...)
* Who (or whom) is going to be responsible for keeping track of CVE's and their
  corresponding patches?
* Embedding Lua in this form makes it *impossible* for distro maintainers to
  package Ceph: they would most likely rip out and figure out how to try and
  make it work with the distro-provided version. *This is very frowned upon and
  creates a gigantic amount of work for package maintainers*.
* Modifying the make files to accommodate for this is fine, but that is a tiny
  corner of the impact this would have on everything else that deals with Ceph.
  These would certainly need attention (and there are lots more):
  - Continuous Integration scripts (make check)
  - Release scripts and process/workflow
  - Testing (both functional and unit tests)
  - Packaging rules

Even if the Lua interpreter was out-of-tree, my concern is how to provide these
patches (e.g. the cmsgpack module) so that it works in the expected manner?

Is it not possible to make this a completely separate component of Ceph that
doesn't require the project to embed the modified forked or depend in any way
with the modifications done to the Lua interpreter?



[0] Mantle BluePrint
https://github.com/michaelsevilla/mantle-popper/wiki/Blueprint
[1] Lua object class support Pull Request https://github.com/ceph/ceph/pull/7338
[2] https://github.com/ceph/lua/commits/lua-5.3-ceph
