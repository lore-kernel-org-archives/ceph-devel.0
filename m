From: Tommi Virtanen <tv@inktank.com>
Subject: Updated guide for chef installs, from where the docs stop onward
Date: Wed, 20 Jun 2012 13:57:28 -0700
Message-ID: <CADvuQRH=pfvhWWTzuXt_LqiyAwc3bxoRAM_sK4vUX3RWnqw2CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39806 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab2FTU5t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 16:57:49 -0400
Received: by pbbrp8 with SMTP id rp8so1110782pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 13:57:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, John Wilkins <john.wilkins@inktank.com>
Cc: Juan Jose Galvez <juanjose.galvez@inktank.com>, Tamil Muthamizhan <tamil.muthamizhan@inktank.com>, Ken Franklin <ken.franklin@inktank.com>

So, the docs for Chef install got some doc lovin' lately. It's all at

http://ceph.com/docs/master/install/chef/
http://ceph.com/docs/master/config-cluster/chef/

but the docs still stop short from having an actual running Ceph
cluster. Also, while the writing was in progress, I managed to lift
the "single-mon" restriction, and now you can setup multi-monitor
clusters with the cookbook. This email tries to list out the
modernized version of what's missing, based on the earlier email I
sent with the subject "OSD hotplugging & Chef cookbook ("chef-1")".

I didn't test these exact commands, but I am writing this email based
on a bunch of notes from how I tested it earlier.


http://ceph.com/docs/master/config-cluster/chef/ ends with

"""
Then execute:

knife create role {rolename}
The vim editor opens with a JSON object, and you may edit the settings
and save the JSON file.

Finally configure the nodes.

knife node edit {nodename}
"""

Instead, you want to create an *environment* not a role; the roles
were created with the earlier "knife role from file" command, and
don't need to be edited.

To set up the environment, we need to get/create some bits of information:

- monitor-secret: this is the "mon." key; to create one run
  ceph-authtool /dev/stdout --name=mon. --gen-key
  and take the value to the right of "key =", looks like
"AQBAMuJPINJgFhAAziXIrLvTvAz4PRo5IK/Log=="
- fsid: run "uuidgen -r" (from package uuid-runtime)
- initial: list of chef node names (short hostnames), the majority of
which are required to be in the first mon quorum;
  avoids split brain syndrome. Can be just one host, if you don't need
HA at cluster creation time.
  Not used after first startup. For example: mymon01 mymon02 mymon03


Using the {foo} convention from the docs for things you should edit:

knife environment create {envname}

edit the json you are presented and add

  "default_attributes": {
   # remove this line if you want to run release deb, or change to run
any branch you want
    "ceph_branch": "master"
    "ceph": {
      "monitor-secret": "{monitor-secret}",
      "config": {
        "fsid": "{fsid}",
        "mon_initial_members": "{initial}",
      }
    }
  },

Then for each node, do

knife node edit {nodename}

and edit to look like this:

  "chef_environment": "{envname}",
  "run_list": [
    "recipe[ceph::apt]",
    "role[ceph-mon]",
    "role[ceph-osd]"
  ]

leave out one of the ceph-mon and ceph-osd if you want that node to do
just one thing.

Now you can run chef-client on all the nodes. You may need a few
rounds for things to come up (first to get mon going, then to get the
osd bootstrap files in place).

The above does not bring up any osds; we never told it what disks to
use. In connection with my work on the deployment of Ceph, I switched
osds to use "hotplugging"; they detect suitably flagged GPT partitions
and start up automatically. All we need to do to start up some osds is
to make a some disks have suitable contents. Here's how (WARNING: this
will wipe out all of /dev/sdb! Adjust to fit!) (replace {fsid} just
like above):

sudo apt-get install gdisk
sudo sgdisk /dev/sdb --zap-all --clear --mbrtogpt --largest-new=1
--change-name=1:'ceph data' --typecode=1:{fsid}
# mkfs and allocate disk to cluster; any filesystem is ok, adjust for
xfs/btrfs etc
sudo mkfs -t ext4 /dev/sdb1
sudo mount -o user_xattr /dev/sdb1 /mnt
sudo ceph-disk-prepare --cluster-uuid={fsid} /mnt
sudo umount /mnt
# simulate hotplug event
sudo udevadm trigger --subsystem-match=block --action=add

The above will get simplified into a single command soon,
http://tracker.newdream.net/issues/2546 and
http://tracker.newdream.net/issues/2547 are the tickets for that work.

Now you should have an osd started for that disk, too. See it with

sudo initctl list | grep ceph

(If not, you probably didn't run chef-client enough to finish the
bootstrap key handshake.)
