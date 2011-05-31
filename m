From: Fyodor Ustinov <ufm@ufm.su>
Subject: cfuse and ceph.conf
Date: Wed, 01 Jun 2011 00:44:30 +0300
Message-ID: <4DE5613E.4010602@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:58153 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932601Ab1EaVod (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2011 17:44:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id F347660048A
	for <ceph-devel@vger.kernel.org>; Wed,  1 Jun 2011 00:44:31 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8-J98o3iQ9J6 for <ceph-devel@vger.kernel.org>;
	Wed,  1 Jun 2011 00:44:31 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 6A31D600484
	for <ceph-devel@vger.kernel.org>; Wed,  1 Jun 2011 00:44:31 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

As I understand with -m key cfuse should not require ceph.conf.

But:

root@st8:~# cfuse -m 10.5.51.230:6789 /stor01
common_init: unable to open config file.
root@st8:~#

Workaround:

root@st8:~# cfuse -c /dev/null -m 10.5.51.230:6789 /stor01
failed to open log file '/var/log/ceph/client.admin.log': error 2: No 
such file or directory
  ** WARNING: Ceph is still under development.  Any feedback can be 
directed  **
  **          at ceph-devel@vger.kernel.org or 
http://ceph.newdream.net/.     **
cfuse[2944]: starting ceph client
cfuse[2944]: starting fuse
root@st8:~# ls -al /stor01/
total 1
drwxr-xr-x 1 root root 0 2011-06-01 00:22 .
drwxr-xr-x 1 root root 0 2011-05-31 01:27 bbb
root@st8:~#

WBR,
     Fyodor.

P.S. BTW, where ".." directory?
P.P.S. I'm starting to feel myself like QA.
