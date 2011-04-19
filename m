From: Sage Weil <sage@newdream.net>
Subject: Re: Logging
Date: Mon, 18 Apr 2011 22:02:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104182154160.13931@cobra.newdream.net>
References: <4DAB77FD.4010804@provocation.net> <BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>
 <4DAC0EE7.4080001@provocation.net> <BANLkTikCO-pgBfNtvpMVn5HEG2ujhsSgxQ@mail.gmail.com>
 <4DAC8021.6000701@provocation.net> <BANLkTimPP2epqVTPwiXMubB_q_Rf+3Ro4w@mail.gmail.com>
 <4DACA57E.2040609@provocation.net> <BANLkTi=MsnZnmZuace=bzRhGo8sP2QjKLw@mail.gmail.com>
 <4DACD304.4010000@provocation.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40340 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab1DSE6o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2011 00:58:44 -0400
In-Reply-To: <4DACD304.4010000@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Tue, 19 Apr 2011, Zenon Panoussis wrote:
> The relation between OSD partitions (/dev/mapper/sda6 in the example above)
> is another interesting factor. As long as the load is under 100%, the
> partitions on both nodes grow in almost perfect sync. When the load exceeds
> 100%, one node starts lagging behind the other. If that continues long enough,
> the lagging node falls out completely while the other node keeps growing.
> I've seen differences of almost 300% (11 GB on node02 and 4 GB on node01)
> which won't go away until a full ceph restart followed by a few hours of
> replaying patience.

This is really interesting.  This is on the partitions that have _just_ 
the OSD data?  Do you see any OSD flapping (down/up cycles) during this 
period?

It's possible that the MDS is getting ahead of the OSDs, as there isn't 
currently any throttling of metadata request processing when the 
journaling is slow.  (We should fix this.)  I don't see how that would 
explain the variance in disk usage, though, unless you are also seeing the 
difference in disk usage reflected in the cosd memory usage on the 
less-disk-used node?

> Interestingly, the node with the monitor that actually receives the data
> (node01) is the one unable to write them to its own disk, while the other
> node (node02) grows way ahead. I'm not sure yet, but the likely cause of
> this is that the network speed of node01 and the disk speed of node02 both
> exceed the disk speed of node01. In any case, a load above 100% is not a
> reason for concern all and by itself, but the node storages growing out of
> sync is. If that goes far enough, the nodes are unable to synchronise again
> without an unmount and full restart of ceph and in the worst case scenario
> the data is corrupted.

I don't think it is the monitors, although you could verify that with a du 
on the mon data directory on the two nodes. 

In any case, none of these things should be corrupting data... :/

> Now, having run rsync for a while, I kill it and start it again. This will
> cause it to compare all files that are already on the target, skip those
> that have identical size and near-identical mtime, and only copy files that
> are either missing or different. Assuming for example that I successfully
> copied 200.000 files in the first run, the second run will compare 200.000
> files and start copying again from the 200.001:st file on.
> 
> This is where I could really see the difference between atime and noatime on
> the OSD underlying partition. bwlimit is meaningless on size and mtime reads,
> so the client would read file attributes at full blast. With atime on the
> underlying partition this caused the nodes to jump to loads of 5 or more. With
> noatime, they displayed a load of 0.1 or so and the whole compare opration
> completed in a small fraction of the time previously required.

This is good to keep in mind.  If the 'btrfs devs' option is defined and 
the init script mounts the data volume for you, the default 'btrfs opts' 
mount options include noatime.  Anyone overriding that or mounting the osd 
data themselves would be wise to keep noatime in the option set.

sage
