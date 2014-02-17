From: Kesten Broughton <kbroughton@21ct.com>
Subject: ceph hadoop using ambari
Date: Mon, 17 Feb 2014 08:57:27 -0600
Message-ID: <CF277D7A.41EC%kbroughton@21ct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 21ct-exg07.21technologies.com ([173.226.154.197]:5555 "EHLO
	21ct-exg07.21technologies.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751086AbaBQPCu convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Feb 2014 10:02:50 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Brian Gosnell <bgosnell@21ct.com>

>Hi,

Sorry if this is not the correct email list.  I checked
http://ceph.com/help/  but it was blank.

My company is trying to evaluate virtualized hdfs clusters using ceph a=
s a
drop-in replacement for staging and development
following http://ceph.com/docs/master/cephfs/hadoop/.  We deploy cluste=
rs
with ambari 1.3.2.

I spun up a 10 node cluster with 3 datanodes, name, secondary, 3
zookeepers, ambari master, and accumulo master.

Our process is
This was likely the cause of shutdown errors.  Should do
1. Run ambari install
2. shut down all ambari services
3. push modified core-site.xml to datanodes, name, secondary
4. restart ambari services

I am getting errors
/usr/lib/hadoop/bin/hadoop-daemon.sh: Permission denied

in the ambari console error log from the command:
 su - hdfs -c  'export HADOOP_LIBEXEC_DIR=3D/usr/lib/hadoop/libexec &&
/usr/lib/hadoop/bin/hadoop-daemon.sh --config /etc/hadoop/conf start
datanode'


I think this is an ambari issue, but I=B9m wondering
1.  Is there a detailed guide of using ambari with ceph-hadoop, or has
anyone tried it?
2.  Is there a script or list of log files useful for debugging ceph
issues in general?

thanks,

kesten


ps.
I have opened a gist via
https://gist.github.com/darKoram/9051450
and an issue on the horton forums at
http://hortonworks.com/community/forums/topic/ambari-restart-services-g=
ive-
bash-usrlibhadoopbinhadoop-daemon-sh-permiss/#post-48793

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
