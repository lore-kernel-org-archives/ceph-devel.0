From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Re: Unable to mount cephfs - can't read superblock
Date: Sun, 10 Feb 2013 08:13:29 +1000
Message-ID: <kf6hm7$l0m$1@ger.gmane.org>
References: <kf5920$1de$1@ger.gmane.org> <51162831.1070506@42on.com> <kf5ajp$c1o$1@ger.gmane.org> <51162E6F.5010405@42on.com> <0B1D23900A8348E28C15A00BCA12877D@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46838 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760833Ab3BIWNq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 9 Feb 2013 17:13:46 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1U4IgM-0002kv-1c
	for ceph-devel@vger.kernel.org; Sat, 09 Feb 2013 23:14:02 +0100
Received: from 124-170-93-254.dyn.iinet.net.au ([124.170.93.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 23:14:02 +0100
Received: from a.nielsen by 124-170-93-254.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 09 Feb 2013 23:14:02 +0100
In-Reply-To: <0B1D23900A8348E28C15A00BCA12877D@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

>>> $ ceph -s
>>> health HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean
>>> monmap e1: 1 mons at {0=192.168.0.6:6789/0}, election epoch 0,
>>> quorum 0 0
>>> osdmap e3: 1 osds: 1 up, 1 in
>>> pgmap v119: 192 pgs: 192 active+degraded; 0 bytes data, 10204 MB
>>> used, 2740 GB / 2750 GB avail
>>> mdsmap e1: 0/0/1 up
>>
> In any case, this output indicates that your MDS isn't actually running, Adam, or at least isn't connected. Check and see if the process is still going?
> You should also have minimal logging by default in /var/lib/ceph/mds*; you might find some output there that could be useful.

The MDS appears to be running:

$ ps -A | grep ceph
12903 ?        00:00:17 ceph-mon
12966 ?        00:00:10 ceph-mds
13047 ?        00:00:31 ceph-osd

And I found some logs in /var/log/ceph:

$ cat /var/log/ceph/ceph-mds.0.log 
2013-02-10 07:57:16.505842 b4aa3b70  0 mds.-1.0 ms_handle_connect on 192.168.0.6:6789/0

So it appears the mds is running.  Wireshark shows some traffic going between hosts when the mount request comes through, but then the responses stop and the client eventually gives up and the mount fails.

>> You better add a second OSD or just do a mkcephfs again with a second
>> OSD in the configuration.

I just tried this and it fixed the unclean pgs issue, but I still can't mount a cephfs filesystem:

$ ceph -s
   health HEALTH_OK
   monmap e1: 1 mons at {0=192.168.0.6:6789/0}, election epoch 0, quorum 0 0
   osdmap e5: 2 osds: 2 up, 2 in
    pgmap v107: 384 pgs: 384 active+clean; 0 bytes data, 40423 MB used, 5461 GB / 5501 GB avail
   mdsmap e1: 0/0/1 up

remote$ mount -t ceph 192.168.0.6:6789:/ /mnt/ceph/
mount: 192.168.0.6:6789:/: can't read superblock

Running the mds daemon in debug mode says this:

...
2013-02-10 08:07:03.550977 b2a83b70 10 mds.-1.0 MDS::ms_get_authorizer type=mon
2013-02-10 08:07:03.551840 b4a87b70  0 mds.-1.0 ms_handle_connect on 192.168.0.6:6789/0
2013-02-10 08:07:03.555307 b738c710 10 mds.-1.0 beacon_send up:boot seq 1 (currently up:boot)
2013-02-10 08:07:03.555629 b738c710 10 mds.-1.0 create_logger
2013-02-10 08:07:03.564138 b4a87b70  5 mds.-1.0 handle_mds_map epoch 1 from mon.0
2013-02-10 08:07:03.564348 b4a87b70 10 mds.-1.0      my compat compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object}
2013-02-10 08:07:03.564454 b4a87b70 10 mds.-1.0  mdsmap compat compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object}
2013-02-10 08:07:03.564547 b4a87b70 10 mds.-1.-1 map says i am 192.168.0.6:6800/16077 mds.-1.-1 state down:dne
2013-02-10 08:07:03.564654 b4a87b70 10 mds.-1.-1 not in map yet
2013-02-10 08:07:07.555567 b2881b70 10 mds.-1.-1 beacon_send up:boot seq 2 (currently down:dne)
2013-02-10 08:07:11.555858 b2881b70 10 mds.-1.-1 beacon_send up:boot seq 3 (currently down:dne)
2013-02-10 08:07:15.556123 b2881b70 10 mds.-1.-1 beacon_send up:boot seq 4 (currently down:dne)
2013-02-10 08:07:19.556411 b2881b70 10 mds.-1.-1 beacon_send up:boot seq 5 (currently down:dne)
2013-02-10 08:07:23.556654 b2881b70 10 mds.-1.-1 beacon_send up:boot seq 6 (currently down:dne)
2013-02-10 08:07:27.556931 b2881b70 10 mds.-1.-1 beacon_send up:boot seq 7 (currently down:dne)
2013-02-10 08:07:31.557189 b2881b70 10 mds.-1.-1 beacon_send up:boot seq 8 (currently down:dne)
...

I'm guessing there's something going wrong but I'm not sure what to do next!

Many thanks,
Adam.


