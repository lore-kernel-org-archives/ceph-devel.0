From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: ceph-mon terminated with status 28
Date: Sun, 13 Dec 2015 13:49:16 +0000
Message-ID: <DM2PR12MB0556410B658CF096B4F3326C9BEC0@DM2PR12MB0556.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0076.outbound.protection.outlook.com ([207.46.100.76]:14304
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751827AbbLMOWj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Dec 2015 09:22:39 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I am trying to understand the following failure:

A small cluster was running fine, and then was left unused for a while.
When I went to try to use it again, the mon socket wasn't there and I could see that
ceph-mon was not running.  I saw the lines below at the end of dmesg output.
When I tried to restart ceph-mon using sudo start ceph-mon id=monhost,
I got the same set of errors newly appended to dmesg output.

I don't see anything more descriptive in /var/log/ceph/ceph-mon.log, just
the recording of new mon processes starting.

In this particular small cluster, the mon process was running on the same
node with 7 osd processes.  sudo initctl list shows that the osd procs are still
up, although logging the fact that they can't communicate with the mon socket.

Is there someplace else I should look for more details as to why mon is down
and can't be restarted?

-- Tom Deneau

dmesg output:
--------------
 init: ceph-mon (ceph/monhost) main process (16538) terminated with status 28
 init: ceph-mon (ceph/monhost) main process ended, respawning
 init: ceph-create-keys main process (16227) killed by TERM signal
 init: ceph-mon (ceph/monhost) main process (16546) terminated with status 28
 init: ceph-mon (ceph/monhost) main process ended, respawning
 init: ceph-create-keys main process (16548) killed by TERM signal
 init: ceph-mon (ceph/monhost) main process (16556) terminated with status 28
 init: ceph-mon (ceph/monhost) main process ended, respawning
 init: ceph-create-keys main process (16558) killed by TERM signal
 init: ceph-mon (ceph/monhost) main process (16566) terminated with status 28
 init: ceph-mon (ceph/monhost) respawning too fast, stopped
 init: ceph-create-keys main process (16568) killed by TERM signal

