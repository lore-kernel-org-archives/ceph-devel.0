From: Sage Weil <sage@inktank.com>
Subject: LSB Requires-Start: ... $network ... vs network.service
Date: Tue, 2 Jul 2013 20:06:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307022001130.31293@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57808 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab3GCDG3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jul 2013 23:06:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: systemd-devel@lists.freedesktop.org
Cc: ceph-devel@vger.kernel.org

Hi everyone,

I have a sysvinit script on fedora 18 (systemd 195) with

 ### BEGIN INIT INFO
 # Provides:          ceph
 # Default-Start:     2 3 4 5
 # Default-Stop:      0 1 6
 # Required-Start:    $remote_fs $named $network $time
 # Required-Stop:     $remote_fs $named $network $time
 # Short-Description: Start Ceph distributed file system daemons at boot  time
 # Description:       Enable Ceph distributed file system services.
 ### END INIT INFO

and my daemon keeps failing on startup to bind to it's ip:port.  I 
modified the script to dump systemctl -a output and I see

 network.service           loaded inactive   dead            LSB: Bring up/down networking
 NetworkM...online.service loaded inactive   dead            Network Manager Wait Online
 NetworkManager.service    loaded active     running         Network Manager

I know next to nothing about systemd (or Fedora, for that matter), but I 
would expect the $network bit in Required-Start to make the job wait for 
network.service.  FWIW, this is what 'chkconfig --add ceph' during package 
installation seems to have done:

 $ find /etc/rc.d | grep ceph
 /etc/rc.d/rc0.d/K80ceph
 /etc/rc.d/rc3.d/S60ceph
 /etc/rc.d/rc4.d/S60ceph
 /etc/rc.d/init.d/ceph
 /etc/rc.d/rc6.d/K80ceph
 /etc/rc.d/rc1.d/K80ceph
 /etc/rc.d/rc5.d/S60ceph
 /etc/rc.d/rc2.d/S60ceph

Hopefully there is somewhere obvious where we've gone astray?

Thanks!
sage
