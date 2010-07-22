From: Hugo Slabbert <hugo.slabbert@slabnet.com>
Subject: ceph, shadow_copy, cifs, and "Previous Versions"
Date: Wed, 21 Jul 2010 23:19:33 -0700
Message-ID: <AANLkTilFlPF4vBYErEWtFaoR7IfXOh6ts6bY-VKvZmRD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50671 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711Ab0GVGTt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jul 2010 02:19:49 -0400
Received: by yxg6 with SMTP id 6so346861yxg.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jul 2010 23:19:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

Might it be possible to expose snapshots from a ceph data store to the
Previous Versions client on Windows machines using the shadow_copy or
shadow_copy2 vfs modules in a Samba setup? Some people appear to be
running something like that on (Open)Solaris/BSD & ZFS or Linux & LVM.
I've been playing with ceph on a 3-box Debian setup in a lab
environment using those examples as a reference point, but I've not
had any luck so far.

I saw a brief note on this at
http://marc.info/?l=ceph-devel&m=127710582006588&w=2, but nothing much
to speak of. My thoughts were that a ceph system has the potential to
make for a very robust backend to a NAS setup.

Has anyone gone down that road before or have any ideas to investigate on this?

Hugo Slabbert

email: hugo.slabbert@slabnet.com
