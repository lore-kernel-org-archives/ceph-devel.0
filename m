From: Andrey Korolyov <andrey@xdel.ru>
Subject: Setting iotune limits on rbd
Date: Tue, 3 Apr 2012 12:02:45 +0400
Message-ID: <CABYiri81Jku1F7DjHYT80FPAq_swMfPkYGSnUpEaNsxs0BG6=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64912 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab2DCIDJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Apr 2012 04:03:09 -0400
Received: by wejx9 with SMTP id x9so2188363wej.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Apr 2012 01:03:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

# virsh blkdeviotune Test vdb --write_iops_sec 50 //file block device

# virsh blkdeviotune Test vda --write_iops_sec 50 //rbd block device
error: Unable to change block I/O throttle
error: invalid argument: No device found for specified path

2012-04-03 07:38:49.170+0000: 30171: debug :
virDomainSetBlockIoTune:18317 : dom=0x1114590, (VM: name=Test,
uuid=8c27bf32-82dc-315a-d0ba-4653b1b3d595), disk=vda,
params=0x1114600, nparams=1, flags=0
2012-04-03 07:38:49.170+0000: 30169: debug :
virEventPollMakePollFDs:383 : Prepare n=8 w=11, f=16 e=1 d=0
2012-04-03 07:38:49.170+0000: 30169: debug :
virEventPollCalculateTimeout:325 : Calculate expiry of 4 timers
2012-04-03 07:38:49.170+0000: 30169: debug :
virEventPollCalculateTimeout:331 : Got a timeout scheduled for
1333438734170
2012-04-03 07:38:49.170+0000: 30171: error : qemuDiskPathToAlias:11338
: invalid argument: No device found for specified path
2012-04-03 07:38:49.170+0000: 30171: debug : virDomainFree:2313 :
dom=0x1114590, (VM: name=Test,
uuid=8c27bf32-82dc-315a-d0ba-4653b1b3d595)
2012-04-03 07:38:49.170+0000: 30171: debug : virUnrefDomain:276 :
unref domain 0x1114590 Test 1
2012-04-03 07:38:49.170+0000: 30171: debug : virReleaseDomain:238 :
release domain 0x1114590 Test 8c27bf32-82dc-315a-d0ba-4653b1b3d595
2012-04-03 07:38:49.170+0000: 30169: debug :
virEventPollCalculateTimeout:351 : Timeout at 1333438734170 due in
5000 ms
2012-04-03 07:38:49.170+0000: 30169: debug : virEventPollRunOnce:619 :
EVENT_POLL_RUN: nhandles=9 imeout=5000
2012-04-03 07:38:49.170+0000: 30171: debug : virReleaseDomain:246 :
unref connection 0x1177b10 2

libvir 0.9.10, json-escape patch applied, but seems that this problem
related to another incorrect path handle.

I`m in doubt if it belongs to libvirt ml or here.
