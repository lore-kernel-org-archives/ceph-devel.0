From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Ceph + RBD + Xen: Complete collapse -> Network issue in domU / Bad
 data for OSD / OOM Kill
Date: Thu, 30 Aug 2012 16:06:02 +0200
Message-ID: <CAF6-1L5t9CGk_kB08UPKdrOhQeZZXdbr5n+we1Oae+STpodxtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64804 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab2H3OGD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 10:06:03 -0400
Received: by vbbff1 with SMTP id ff1so1891086vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 07:06:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xen-users@lists.xen.org, ceph-devel@vger.kernel.org

Hi,


A bit of explanation of what I'm trying to achieve :
We have a bunch of homogeneous nodes that have CPU + RAM + Storage and
we want to use that as some generic cluster. The idea is to have Xen
on all of these and run Ceph OSD in a domU on each to "export" the
local storage space to the entire cluster. And then use RBD to store /
access VM images from any of the machines.

We did setup a working ceph cluster and RBD works well as long as we
don't access it from a dom0 that run a VM hosting a OSD.

When attaching a RBD image to a Dom0 that runs a VM hosting an OSD,
things get interesting. It seems works fine when accessed from the
Dom0 itself. But if we try to use that RBD image to boot another domU,
then things go _very_ wrong.


On the Dom0, I see a lot of message in dmesg:

    "osd1 192.168.3.70:6802 socket closed"  and I mean a _lot_ like
dozens per seconds.


On the DomU running the OSD, I see in the dmesg a bunch of:

     "net eth0: rx->offset: 0, size: 4294967295"


And in the OSD log itself I see a lot of :

2012-08-30 13:26:48.683948 7f3be9bea700  1
CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-08-30 13:26:48.684124 7f3be9bea700  0 bad crc in data 1035043868
!= exp 606937680
2012-08-30 13:26:48.684771 7f3be9bea700  0 -- 192.168.3.70:6803/1032
>> 192.168.3.30:0/4221752725 pipe(0x5ba5c00 sd=40 pgs=0 cs=0
l=0).accept peer addr is really 192.168.3.30:0/4221752725 (socket is
192.168.3.30:40477/0)
2012-08-30 13:26:48.686520 7f3be9bea700  1
CephxAuthorizeHandler::verify_authorizer isvalid=1
2012-08-30 13:26:48.686723 7f3be9bea700  0 bad crc in data 1385604259
!= exp 606937680
2012-08-30 13:26:48.687306 7f3be9bea700  0 -- 192.168.3.70:6803/1032
>> 192.168.3.30:0/4221752725 pipe(0x5ba5200 sd=40 pgs=0 cs=0
l=0).accept peer addr is really 192.168.3.30:0/4221752725 (socket is
192.168.3.30:40478/0)

The memory of the OSD keeps very quickly and ends up being killed by
the OOM Killer.

I tried turning off all the offloading options on the virtual network
interfaces like suggested in some old 2010 post from the Xen list, but
without any effect.


So something is going _very_ wrong here .... any suggestions from anyone ?

Note that when using the exact same setup on a dom0 that doesn't run
any OSD in a domU, it works fine. Also, only the OSD running under
that dom0 is affected, the rest of the cluster is working nicely.


Cheers,

    Sylvain
