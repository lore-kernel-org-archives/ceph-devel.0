From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: Simple test system not working
Date: Tue, 01 Feb 2011 15:01:23 -0800
Message-ID: <4D4890C3.3060408@hq.newdream.net>
References: <loom.20110201T072445-567@post.gmane.org>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48379 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab1BAXCq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 18:02:46 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DB64CC062
	for <ceph-devel@vger.kernel.org>; Tue,  1 Feb 2011 15:02:45 -0800 (PST)
Received: from [10.0.1.162] (ip-66-33-206-8.dreamhost.com [66.33.206.8])
	by mail.hq.newdream.net (Postfix) with ESMTP id D597527DE8
	for <ceph-devel@vger.kernel.org>; Tue,  1 Feb 2011 15:02:45 -0800 (PST)
In-Reply-To: <loom.20110201T072445-567@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

  From the logs, it looks like the osd and mds are failing to bind to
an address.  Perhaps b3 is not a valid host name?

-Sam

On 01/31/2011 10:48 PM, Chris Dunlop wrote:
> G'day,
>
> I'm just starting with ceph and am having trouble getting a test ceph
> installation going on debian lenny with a self-compiled 2.6.37. Ceph
> itself is latest unstable (73e76723) compiled using dpkg-buildpackage.
> The mon, mds and osd are all on the same machine. The ceph base /data
> directory is ext2 mounted with user_xattr.  The ceph filesystem is
> created using the attached ceph.conf and:
>
>    /sbin/mkcephfs -v -c /etc/ceph/ceph.conf --allhosts --mkbtrfs -k
> /etc/ceph/keyring.bin
>
> Once ceph has been started, trying a mount on a (separate) client
> machine (2.6.37 kernel) hangs before eventually giving an error:
>
>    # mount -t ceph b3:/ /mnt
>    mount error 5 = Input/output error
>
> On the server side, it seems that the cmon isn't accepting connections
> from the mds or osd. E.g. repeated instances of this in the osd log,
> and similar "mark_down"s in the mds log:
>
>    2011-02-01 17:18:47.463897 4a254950 -- 0.0.0.0:6801/7854 mark_down
> 10.200.63.129:6789/0 -- 0xca8a00
>    2011-02-01 17:18:47.463924 4a254950 -- 0.0.0.0:6801/7854 -->  mon0
> 10.200.63.129:6789/0 -- auth(proto 0 26 bytes) v1 -- ?+0 0xcd9800
>
> The mon log (amongst a whole bunch of other stuff) repeats:
>
>    2011-02-01 17:18:51.445785 42c73950 mon.0@0(leader).mds e1 e1: 0/0/1 up
>    2011-02-01 17:18:51.445790 42c73950 mon.0@0(leader).osd e1 e1: 0 osds: 0 up, 0 in
>
> The attached logs.zip has the full logs from one attempted start.
>
> Is there something obvious I'm doing wrong?
>
> Thanks for any assistance!
>
> Chris
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

