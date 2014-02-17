From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: [ceph-users] ceph hadoop using ambari
Date: Mon, 17 Feb 2014 09:39:32 -0800
Message-ID: <CA+Hcz59UhkpkD23YgVVyfQD28Vzqo4piXHj8U+R-Zc8YtRzeWA@mail.gmail.com>
References: <CF27A1B3.420B%kbroughton@21ct.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:35088 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbaBQRje convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Feb 2014 12:39:34 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so22258602qaq.15
        for <ceph-devel@vger.kernel.org>; Mon, 17 Feb 2014 09:39:33 -0800 (PST)
In-Reply-To: <CF27A1B3.420B%kbroughton@21ct.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kesten Broughton <kbroughton@21ct.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Kesten,

It's a little difficult to tell what the source of the problem is, but
looking at the gist you referenced, I don't see anything that would
indicate that Ceph is causing the issue. For instance,
hadoop-mapred-tasktracker-xxx-yyy-hdfs01.log looks like Hadoop daemons
are having problems conneting to each other. Finding out what command
in hadoop-daemon.sh is causing the permission errors might be
informative, but I don't have any experience with Ambari.

On Mon, Feb 17, 2014 at 9:23 AM, Kesten Broughton <kbroughton@21ct.com>=
 wrote:
> I posted this to ceph-devel-owner before seeing that this is the corr=
ect
> place to post.
>
> My company is trying to evaluate virtualized hdfs clusters using ceph=
 as a
> drop-in replacement for staging and development
> following http://ceph.com/docs/master/cephfs/hadoop/.  We deploy clus=
ters
> with ambari 1.3.2.
>
> I spun up a 10 node cluster with 3 datanodes, name, secondary, 3
> zookeepers, ambari master, and accumulo master.
>
> Our process is
> This was likely the cause of shutdown errors.  Should do
> 1. Run ambari install
> 2. shut down all ambari services
> 3. push modified core-site.xml to datanodes, name, secondary
> 4. restart ambari services
>
> I am getting errors
> /usr/lib/hadoop/bin/hadoop-daemon.sh: Permission denied
>
> in the ambari console error log from the command:
> su - hdfs -c  'export HADOOP_LIBEXEC_DIR=3D/usr/lib/hadoop/libexec &&
> /usr/lib/hadoop/bin/hadoop-daemon.sh --config /etc/hadoop/conf start
> datanode'
>
>
> I think this is an ambari issue, but I=B9m wondering
> 1.  Is there a detailed guide of using ambari with ceph-hadoop, or ha=
s
> anyone tried it?
> 2.  Is there a script or list of log files useful for debugging ceph
> issues in general?
>
> thanks,
>
> kesten
>
>
> ps.
> I have opened a gist via
> https://gist.github.com/darKoram/9051450
> and an issue on the horton forums at
> http://hortonworks.com/community/forums/topic/ambari-restart-services=
-give-
> bash-usrlibhadoopbinhadoop-daemon-sh-permiss/#post-48793
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
