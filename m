From: Yuri Weinstein <yweinste@redhat.com>
Subject: hammer v0.94.6 QE Validation status
Date: Wed, 10 Feb 2016 10:56:11 -0800
Message-ID: <CAMMFjmHcBKZubn7e_ebmNMcE-7MbzPYXD0fAPFzA_ME2oEBkPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38329 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbcBJS4M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 13:56:12 -0500
Received: by mail-ig0-f170.google.com with SMTP id mw1so20683249igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 10:56:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>, "Weil, Sage" <sage@redhat.com>, Nathan Cutler <ncutler@suse.cz>

Hello

Detailed summary of the QE Validation can be found here
http://tracker.ceph.com/issues/13356#note-61

The following suites were in scope of this point release testing:

rados (subset 1/7)
rbd
rgw
fs
krbd
kcephfs
hadoop
samba
rest
ceph-deploy
upgrade/client-upgrade
upgrade/dumpling-firefly-x (hammer)
upgrade/firefly-x (hammer)
upgrade/hammer
upgrade/hammer-x (infernalis)
powercycle

Outstanding issues (approval requested):

fs:
http://tracker.ceph.com/issues/14716 - Greg, do you want those to be
fixed for this release or approve release as is with a known issue?

samba:
http://tracker.ceph.com/issues/14714 - Greg, do you want those to be
fixed for this release or approve release as is with a known issue?

krbd:
http://tracker.ceph.com/issues/14715
http://tracker.ceph.com/issues/14717
- Josh, do you want those to be fixed for this release or approve
release as is with known issues?

ceph-deploy:
http://tracker.ceph.com/issues/14223
- Sage, Alfredo, do you want those to be fixed for this release or
approve release  as is with a known issue?

Note - ovh environment is not performing reliably for some suites (rgw
-  http://tracker.ceph.com/issues/14712, knfs -
http://tracker.ceph.com/issues/13980)

Thx
YuriW
