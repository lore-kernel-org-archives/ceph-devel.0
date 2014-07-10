From: Owen Synge <osynge@suse.com>
Subject: with "ceph-deploy osd create" logic check (before I write a patch)
Date: Thu, 10 Jul 2014 12:19:28 +0200
Message-ID: <53BE68B0.5090907@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:36075 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbaGJKTz (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 10 Jul 2014 06:19:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear All,

This email is about

    $ ceph-deploy osd create ceph-node4:vdb

and it not behaving identically too:

    $ ceph-deploy osd prepare ceph-node2:vdb
    $ ceph-deploy osd activate ceph-node2:vdb1

It is my understanding that the following sequence should deploy ceph
correctly and activate an OSD.

(on ceph setup server)

    $ ceph-deploy install ceph-node4
    $ ceph-deploy new ceph-node2
    $ ceph-deploy mon create-initial ceph-node2

(On actual node)

    # /etc/init.d/ceph start

(on ceph setup server)

    $ ceph-deploy osd prepare ceph-node2:vdb
    $ ceph-deploy osd activate ceph-node2:vdb1

and that the last two commands above can be replaced with:

(on ceph setup server)

    $ ceph-deploy osd create ceph-node4:vdb

and behind the scenes udev does the second process of activation rather
than use the command:

(On actual node)

    # ceph-disk-activate --mark-init ${distro_init} --mount ${disk}

it executes:

(On actual node)

    # udevadm trigger --subsystem-match=block --action=add

Is their a logic for the reason why

    $ ceph-deploy osd create ceph-node4:vdb

Is described as both "prepare" and "activate" but in fact a different
command? Would you like a patch to make the code really do the same
thing, or am I missing some important deployment logic?

Best regards

Owen

PS:

Goes off to look at why the udev rules are failing and caused me to
notice this discrepancy.
