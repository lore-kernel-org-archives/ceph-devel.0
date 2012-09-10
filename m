From: Andrew Thompson <andrewkt@aktzero.com>
Subject: mds'es stuck in resolve(and one duplicated?)
Date: Mon, 10 Sep 2012 17:36:00 -0400
Message-ID: <504E5D40.10006@aktzero.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000909050907020700030703"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.cologlobal.com ([96.125.182.176]:54883 "EHLO
	mx1.cologlobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab2IJVgR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 17:36:17 -0400
Received: from mail3.hspheredns.com ([208.77.157.24])
	by mx1.cologlobal.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <andrewkt@aktzero.com>)
	id 1TBBeK-0005Jn-QF
	for ceph-devel@vger.kernel.org; Mon, 10 Sep 2012 17:36:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000909050907020700030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,

Has anyone seen this or got ideas on how to fix it?

mdsmap e18399: 3/3/3 up {0=b=up:resolve,1=a=up:resolve(laggy or 
crashed),2=a=up:resolve(laggy or crashed)}

Notice that the 2nd and 3rd mds are the same letter("a"). I'm not sure 
how that happened, I'm guessing a typo in my ceph.conf.

Taking mds.a down doesn't help, b just stays in resolve.

mds.a is only running on a single instance, even though it shows as up 
twice.

When I take a mds down, and start it back up, it goes through a couple 
of states and then sticks at resolve.

I've tried the method listed here, but can't see any change: 
http://www.sebastien-han.fr/blog/2012/07/04/remove-a-mds-server-from-a-ceph-cluster/

I tried "ceph mds stop X" as mentioned here 
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/2585 , but 
see the results below:

athompson@ceph01:~$ sudo ceph mds stop 0
mds.0 not active (up:resolve)
athompson@ceph01:~$ sudo ceph mds stop 1
mds.1 not active (up:resolve)
athompson@ceph01:~$ sudo ceph mds stop 2
mds.2 not active (up:resolve)

I've attached the results of `ceph mds dump -o -`

Currently, mds.b.log is full of these reset/connect's and then where I 
issued a `service ceph stop mds` a few minutes ago(see attached).

Thanks,
Andrew.

-- 
Andrew Thompson
http://aktzero.com/


--------------000909050907020700030703
Content-Type: text/plain; charset=windows-1252;
 name="mds-dump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mds-dump.txt"

athompson@ceph01:~$ sudo ceph mds dump -o -
dumped mdsmap epoch 18493
epoch   18493
flags   0
created 2012-08-10 16:25:06.747103
modified        2012-09-10 17:29:20.826226
tableserver     0
root    0
session_timeout 60
session_autoclose       300
last_failure    3430
last_failure_osd_epoch  426
compat  compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object}
max_mds 3
in      0,1,2
up      {0=5401,1=5524,2=5506}
failed
stopped
data_pools      [0,0]
metadata_pool   1
5401:   172.19.7.54:6800/13793 'b' mds.0.9 up:resolve seq 149 laggy since 2012-09-10 17:21:05.270280
5524:   172.19.7.39:6800/8536 'a' mds.1.11 up:resolve seq 4 laggy since 2012-09-08 02:52:20.668649
5506:   172.19.7.39:6800/7930 'a' mds.2.3 up:resolve seq 5 laggy since 2012-09-08 02:48:05.433724


--------------000909050907020700030703
Content-Type: text/plain; charset=windows-1252;
 name="ceph-mds.b.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ceph-mds.b.log"

2012-09-10 16:54:23.595995 7f843c55b700  0 mds.0.9 ms_handle_reset on 172.19.7.56:6800/8509
2012-09-10 16:54:23.598638 7f843c55b700  0 mds.0.9 ms_handle_connect on 172.19.7.56:6800/8509
2012-09-10 17:09:09.367041 7f843c55b700  0 mds.0.9 ms_handle_reset on 172.19.7.39:6804/6522
2012-09-10 17:09:09.370663 7f843c55b700  0 mds.0.9 ms_handle_connect on 172.19.7.39:6804/6522
2012-09-10 17:09:22.891795 7f843c55b700  0 mds.0.9 ms_handle_reset on 172.19.7.39:6801/6430
2012-09-10 17:09:22.894177 7f843c55b700  0 mds.0.9 ms_handle_connect on 172.19.7.39:6801/6430
2012-09-10 17:09:23.210881 7f843c55b700  0 mds.0.9 ms_handle_reset on 172.19.7.54:6801/14003
2012-09-10 17:09:23.214310 7f843c55b700  0 mds.0.9 ms_handle_connect on 172.19.7.54:6801/14003
2012-09-10 17:09:23.699220 7f843c55b700  0 mds.0.9 ms_handle_reset on 172.19.7.56:6800/8509
2012-09-10 17:09:23.701789 7f843c55b700  0 mds.0.9 ms_handle_connect on 172.19.7.56:6800/8509
2012-09-10 17:21:28.125699 7f843cd5c700 -1 mds.0.9 *** got signal Terminated ***
2012-09-10 17:21:28.125755 7f843cd5c700  1 mds.0.9 suicide.  wanted down:dne, now up:resolve
2012-09-10 17:21:28.386805 7f84422a6780  0 stopped.

--------------000909050907020700030703--
