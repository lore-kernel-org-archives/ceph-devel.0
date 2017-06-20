From: Gregory Farnum <gfarnum@redhat.com>
Subject: Redmine: new RADOS project tracker
Date: Tue, 20 Jun 2017 07:28:43 -0700
Message-ID: <CAJ4mKGaUo7nDAtOF-GF02GoYV1wFDja6Hi6kSmhx_a1c+P3ZXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38478 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdFTO2p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jun 2017 10:28:45 -0400
Received: by mail-it0-f45.google.com with SMTP id b205so15169049itg.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 07:28:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

All,
I've recently been working on building up a tracker "project" for
RADOS that is separate from the global Ceph project. You can find it
at http://tracker.ceph.com/projects/rados

Q: Why do this?
A: Historically, the Ceph project has been used for both RADOS code
(roughly speaking, the stuff maintained by the "core team" standup)
and common code shared throughout the project. That wasn't done on
purpose; it was just that once upon a time there was only the Ceph
project, we gradually migrated out other stuff, and RADOS never did.
It makes things a bit messy when looking at bug lists, and actually
has the effect of hiding issues in important common code. By splitting
it up, we should hopefully be able to improve core team planning and
better track issues of concern to the whole project.
As I've gone through the issues and scrubbed them, I've also found a
bunch of lost bugs which really belonged to other areas. :( Doing this
split and cleaning up the issue categories (not completed, but I've
started doing stuff like killing the RGW category since all that stuff
should be in the RGW project!) available should make it much easier to
keep things clean and prevent dropping bugs between cracks going
forward.

Q: What's moved?
A: So far, I've just done the "bugs". I'll be working on "features"
and other kinds of issues this week. In terms of code areas, OSD and
monitor issues are going into RADOS, as is stuff around using ceph-mgr
to replace a bunch of monitor functionality. I am *not* moving issues
with messengers or other shared software components, packaging and
common build issues, or install. I also haven't moved stuff having to
do with ceph-disk and daemon setup — we may end up doing this but for
now it's mostly being worked on by different groups of people, and is
currently being revamped. (See Alfredo's emails about ceph-volume and
the discussion there.)

Q: Should you do anything different?
A: Just try and create issues around the OSDs and monitors in the
RADOS project instead of the global Ceph one. The leads have committed
to regularly doing scrubs of the common project along with their
individual team ones so stuff should get sorted out correctly, but it
helps you get faster answers and us do less bug shuffling if issues
start out in the right place. ;)

Along with this comes a whole new set of Categories and Components you
can use when tagging issues in RADOS. For most of you that's probably
pretty inside baseball, but if you are making use of them and can't
seem to find the right ones let me or another Redmine admin know — the
lists probably aren't comprehensive yet.
-Greg
