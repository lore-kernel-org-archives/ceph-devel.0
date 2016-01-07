From: CSa <Christian.Salzmann@fu-berlin.de>
Subject: cephfs (hammer) flips directory access bits
Date: Thu, 07 Jan 2016 09:05 +0100
Message-ID: <n6l67c$hu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44131 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbcAGIPJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jan 2016 03:15:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1aH5iq-0001Cp-ED
	for ceph-devel@vger.kernel.org; Thu, 07 Jan 2016 09:15:04 +0100
Received: from mintzer.imp.fu-berlin.de ([160.45.113.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jan 2016 09:15:04 +0100
Received: from Christian.Salzmann by mintzer.imp.fu-berlin.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jan 2016 09:15:04 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

we are using cephfs on a ceph cluster (V0.94.5, 3x MON, 1x MDS, ~50x OSD).
Recently, we observed a spontaneous (and unwanted) change in the access 
rights of newly created directories:

$ umask
0077
$ mkdir test 
$ ls -ld test
drwx------ 1 me me 0 Jan  6 14:59 test
$ touch test/foo
$ ls -ld test
drwxrwxrwx 1 me me 0 Jan  6 14:59 test
$

I kindly would like to ask for help tracking down this issue.

ciao
Christian

