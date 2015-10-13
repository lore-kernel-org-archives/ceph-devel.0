From: Jeremy Hanmer <jeremy.hanmer@dreamhost.com>
Subject: pre-Infernalis ceph-disk bug
Date: Tue, 13 Oct 2015 15:02:01 -0700
Message-ID: <CAKRUTFCOucYJL-fqNoSA69V6ACjNNEr4hTskmcv=H1v+XSsoFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33762 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbbJMWCC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 18:02:02 -0400
Received: by qgeb31 with SMTP id b31so27656126qge.0
        for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2015 15:02:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I think I've found a bug in ceph-disk when running on Ubuntu 14.04
(and I believe 12.04 as well, but haven't confirmed) and using
--dmcrypt.

The problem is that when update_partition() is called, partprobe is
used to re-read the partition table (as opposed to partx on all other
distros) and it appears that it isn't smart/thorough enough to update
all of the device's metadata. Specifically, ID_PART_ENTRY_TYPE isn't
updated:

root@ceph-osd03:~# udevadm info --query=env --name=/dev/vdd1 | grep
ID_PART_ENTRY_TYPE
ID_PART_ENTRY_TYPE=89c57f98-2fe5-4dc0-89c1-5ec00ceff2be

running `partx -u` rather than `partprobe` does the appropriate thing:

root@ceph-osd03:~# partx -u /dev/vdd1
root@ceph-osd03:~# udevadm info --query=env --name=/dev/vdd1 | grep
ID_PART_ENTRY_TYPE
ID_PART_ENTRY_TYPE=4fbd7e29-9d25-41b8-afd0-5ec00ceff05d


I have an experimental patch here that Works For Me, but Sage wanted
me to ping the list for input:

https://github.com/fzylogic/ceph/commit/8c83f75392d68fbec7def8aa61f20b2c9c237571


I also want to test the new Infernalis code for this same bug (after a
cursory check, I strongly suspect it's there as well), but it'll take
a little bit to get another test cluster up to confirm.
