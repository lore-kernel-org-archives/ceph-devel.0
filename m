From: John Spray <jspray@redhat.com>
Subject: dashboard in mimic
Date: Wed, 20 Dec 2017 10:55:42 +0000
Message-ID: <CALe9h7eOv-P35oJT5L2T+CmOe=VTw6V3yBHB0LUK_-ojyeKKCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:39581 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754681AbdLTK4E (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Dec 2017 05:56:04 -0500
Received: by mail-wr0-f169.google.com with SMTP id a41so21875293wra.6
        for <ceph-devel@vger.kernel.org>; Wed, 20 Dec 2017 02:56:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

There have been some discussions about making big additions to the
dashboard module (the web gui that runs in ceph-mgr), so as a couple
of people have suggested, let's have a mailing list thread about it!

This is a bit wordy so I've written it more like a document than an
email, see below.  It's a very broad topic, so what I've written here
is far from complete.  We're still at the point of discussion, there's
no UI code being written so far for any of the stuff that I mention
below.

Cheers,
John



What?
=====

Extend the dashboard module to provide management of the cluster, in
addition to monitoring.  This would potentially include anything you
can currently do with the Ceph CLI, plus additional functionality like
calling out to a container framework to spawn additional daemons.

The idea is to wrap things up into friendlier higher-level operations,
rather than just having buttons for the existing CLI operations.
Example workflows of interest:
 - a CephFS page where you can click "New Filesystem", and the pools
and MDS daemons will all be created for you.
 - similarly for RGW: ability to enable RGW and control the number of
gateway daemons
 - driving OSD additional/retirement, and also format conversions
(e.g. filestore->bluestore)

Some of the functionality would depend on how Ceph is being run:
especially, anything that detects devices and starts/stops physical
services would depend on an environment that provides that (such as
Kubenetes).

Why build it in?
============

Historically, Ceph management UIs were usually doing lots of non-Ceph
work too, configuring the underlying OS and hardware as well as the
Ceph cluster itself.  Consequently, it often made sense build the user
interface into an external tool/framework that already knew how to do
all that labour-intensive infrastructure stuff, rather than trying to
reinvent it for a Ceph-specific management tool.

As some of us are moving towards running Ceph in container
environments like Kubernetes, the hardware/OS piece is increasingly
taken care of for us.  The container platform provides a simpler way
to discover and use hosts and block devices, which we can use directly
from Ceph (or from the ceph dashboard).

What about external UIs?
====================

Building more UI functionality into Ceph should not get in the way of
integrating with any external tools/projects.  It should actually
benefit those projects: as we connect up functionality into the
dashboard module, those same ceph-mgr/python code paths can easily be
connected to REST endpoints in the restful module.

The work to actually expose the REST bits will probably still fall on
the people who really want/need that functionality, but it should be a
very lightweight task for things where the functionality already
exists in the dashboard.

Currently modules are somewhat isolated from one another, but I've
recently added an inter-module RPC interface so that we can have
better sharing of state -- the idea is to have some common things like
a table of long-running-jobs that would be shared between the
dashboard and restful modules.

Security
======

The dashboard is currently completely read-only: that's convenient
because it makes it less scary to run it over unencrypted http and/or
without login (or in practice, leaving https/login as an exercise to
the sysadmin).  When administrative functionality is added, we'll need
some sort of login, and https too.

The https part can probably be done in the same way as the restful
module: require a user-generated certificate (i.e. for their proper
domain) by default, but also provide a helper for the adventurous user
to run with a self-signed cert if they want to.

The login part could be as simple as creating users/passwords using a
CLI and just prompting for them in the GUI, or we could also have some
GUI functionality for managing users.  I wouldn't want to go too far
with the latter: if someone has complex requirements then it's
generally better to be plugging into some external user database.

It would still be very nice to retain the read only mode as an option of course.
