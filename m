From: Tommi Virtanen <tv@inktank.com>
Subject: Braindump/announce: ceph-deploy
Date: Thu, 18 Oct 2012 14:03:19 -0700
Message-ID: <CADvuQRFDtotDE8wdf2iz0stArv_murGc-XwoLqE-L_XpzV3HgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:61067 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab2JRVDk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Oct 2012 17:03:40 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so1636222qaa.19
        for <ceph-devel@vger.kernel.org>; Thu, 18 Oct 2012 14:03:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Wilkins <john.wilkins@inktank.com>

Hi. We've been working on the Chef cookbook and Crowbar barclamp for
Ceph for a while now. At the same time, Clint Byrum and James Page
have been working on the Juju Charm, and I've seen at least two
separate efforts for Puppet scripts.

All this time, I've repeatedly gotten one item of feedback, in a
couple of different variations: "But we don't use <thing>." "Can I
just use shell scripts?" etc.

So, I want to announce a tool just for that: deploying Ceph without a
framework. It's called "ceph-deploy":

  https://github.com/ceph/ceph-deploy

ceph-deploy is a way to deploy Ceph relying on just SSH access to the
servers, sudo, and some Python. It runs fully on your workstation,
requiring no servers, databases, or anything like that. It is not a
generic deployment system, it is only for Ceph.

If you never wanted to install and learn Chef, Puppet or Juju, this is for you.

If you set up and tear down Ceph clusters a lot, and want minimal
extra bureaucracy, this is for you.

It's still early days for ceph-deploy, so you might be able to break
it, confuse it, or be confused by the quick README I put together.
We'll work on integrating usage of ceph-deploy better into
http://ceph.com/docs/ , and I expect the README will get shorter as
things move out from it, but the core usage is there.

Teaser: deploying the current development release of Ceph on three
virtual machines named myhost{1,2,3}, with four data disks each, is
this easy:

ceph-deploy new myhost{1,2,3}
# edit ceph.conf if you want
ceph-deploy install --dev=v0.52 myhost{1,2,3}
# the above is expanded by your shell to be ... myhost1 myhost2 myhost3
ceph-deploy mon
ceph-deploy osd myhost{1,2,3}:sd{b,c,d,e}

You can keep track of ceph-deploy development by watching the above
git repository on Github and looking at tickets prefixed
"ceph-deploy:" on
http://tracker.newdream.net/rb/master_backlogs/devops .



Until http://tracker.newdream.net/issues/3347 is solved, you may need
to adjust ~/.ssh/config to get SSH to use the right username when
connecting to your servers, and even after that you need to have SSH
working for the short hostnames and anything in ceph.conf variable
mon_host (especially if you put IP addresses there). For example, on
my Ubuntu Cloud Image vms, I do:

Host myhost1
     Hostname myhost1.and.stuff.example.com
     User ubuntu

etc.
