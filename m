From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: ragweed: rgw multi-stage test suite
Date: Fri, 13 Jan 2017 13:51:00 -0800
Message-ID: <CADRKj5QUubBWtZw=NvwHBwMiqpWqtcgMY2p4Z5CnOpv+rjUMBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33989 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750701AbdAMVvB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2017 16:51:01 -0500
Received: by mail-vk0-f48.google.com with SMTP id r136so42019299vke.1
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2017 13:51:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I've been working on a new testing framework for rgw. Currently we
have a few different tests that we use to test rgw:
 - functional (s3-tests, swift)
 - multi-site (v1 via teuthology, v2 currently via test_multi)
 - unitests (a few small tests for isolated structures)
 - misc (admin, quota, etc. via teuthology)

However, I was frustrated with the lack of ability to do tests that
both verify functionality, and the way it is represented in rados. The
way to do it up until now was through the teuthology task itself
(e.g., the quota tests), but it's too cumbersome and cannot be
executed outside of teuthology. Moreover, a different type of tests
that verify upgrades, and the effect on existing data was impossible.
So, with this in mind I created ragweed, that can be found here:

https://github.com/yehudasa/ragweed

This is a framework and set of tests (currently just a few) for rgw.
It allows running the tests in two phases, so that data can be
prepared in the first phase (possibly when running against the old
version), and then tested in the second phase (after upgrade). It
keeps a state on the backing cluster (on rgw itself), and can be
executed separately for each of the phases.

The tests themselves are written explicitly to run in those two
phases. In the first phase, the stage() method in each test class will
be called, and on the second phase the check() method will be called.
The RAGWEED_RUN environment variable determines which stage will be
run (either stage, check, or both). For example, when testing an
upgrade, we'll execute ragweed with RAGWEED_RUN=stage on the old
version, then upgrade the system, then run RAGWEED_RUN=check on the
upgraded system. Another option is to set RAGWEED_RUN=stage,check
which will just run everything in one go.

Since the process can be invoked twice we store certain member
variables for each test object that are assigned at stage(), so that
they can be used in check(). This applies to all members that are
prefixes with 'r_'. The one requirement is that these members can be
serialized. It is also possible to access all buckets created in
stage() through the create_bucket() call.

The run environment includes two different boto connections to rgw,
one through a regular user, and another through the admin user.
Through the rgw admin api we can get the current zone config (e.g.,
what are the rados pools that it spans over), and can also get the
internal bucket_info structure that represents the specific bucket
instance. We can get the objects layout: manifest, and a list of all
the rados oids that make up the objects. (NOTE: these require a few
minor additions to rgw that will be merged upstream eventually.)
The run environment also includes the ability to access rados directly
through the rados python bindings.
The few tests that are currently available use all of that to validate
that the objects that were created are both located at the correct
rados pool, and that the rados objects are there and have the correct
size. There are a few multipart tests that check that a multipart
object created is valid, and the object creation is tested in a
upgrade few scenarios, e.g., create object completely before upgrade,
or upload it before upgrade and complete after upgrade, and so forth.

I want to be able to move some of the tests that are in the teuthology
task to this new framework. For example, the quota test should be
doable. What's missing is probably the ability to easily create new
users (can be done via the admin api), modify user's settings, etc.,
which should be relatively straight forward. Another missing piece is
the ability to deal with rgw config itself (e.g., change garbage
collector thread frequency, wait time, etc.). This is a bit trickier,
and might need to be resolved on a per-need basis, possibly by adding
new management apis. The tests as they are now don't try to configure
rgw, but use the current configuration as their basis. A test that
require different config for example is one that copies data between
buckets that were created in different placement targets. As was
mentioned before, we have a test suite that deals with multi site, and
that handles cluster(s) configuration. It has also gone through a work
to integrate it with teuthology. I think that we can look at
integrating both suites, so that we can have the cluster config
capabilities (and possibly teuthology integration).

Please let me know if you have any questions or comments. The
framework and tests are in their infancy, but can already be useful.
Also, if anyone wants to dive in and create new tests or expand the
framework it'd be greatly appreciated.


Yehuda
