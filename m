From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Problems when I tried to let Hadoop use Ceph
Date: Thu, 8 Mar 2012 08:37:16 -0800
Message-ID: <A11F0BCE-C30D-49D1-8CA1-17D5F99C3A19@cs.ucsc.edu>
References: <f123f2.24b.135f2026959.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:54701 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab2CHQhR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 11:37:17 -0500
In-Reply-To: <f123f2.24b.135f2026959.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lixiaobing10@otcaix.iscas.ac.cn
Cc: ceph-devel@vger.kernel.org


On Mar 8, 2012, at 3:12 AM, lixiaobing10@otcaix.iscas.ac.cn wrote:

> Hi ceph-devel,
> I came up with the following problems when I tried to let Hadoop use =
Ceph. Could you give any advice? Thanks firstly!
> I installed ceph-0.20.2 and hadoop.0.20.205.0 with the hadoop.0.20.20=
5.0-cephfs1.patch successfully. Both ceph and hadoop(using HDFS) can wo=
rk well separately. Besides, I could run command like 'hadoop fs -ls /'=
, 'hadoop fs -put /localfilepath /cephfilepath' correctly. But when I r=
un a mapreduce demo: wordcount with a small file containing about two t=
housand words, reduce task crashed reporting information like:=20
> A fatal error has been detected by the Java Runtime Environment:...Pr=
oblematic frame:C  [libceph.so.1.0.0+0x898e7]=85

Hi Xiaobing,

It's a good sign that you are able to use 'hadoop fs -put' to load data=
 into Ceph. There are some edge cases with library loading that aren't =
quite robust enough yet. It would be great if you could provide some mo=
re information:

1. What distribution are you using?
2. When the crash occurs there should be a large block of text along si=
de the "Problematic frame=85" message that the JVM dumps out. Could you=
 post that here?
3. The JVM should be producing a file that looks like "hs_err_pid1201.l=
og". Attaching that is also helpful.

You are definitely correct that having version mis-matches can cause pr=
oblems, so making sure to have a clean installation is important when y=
ou are switching versions of Ceph and Hadoop. On the wiki http://ceph.n=
ewdream.net/wiki/Hadoop_FileSystem there are specific Git SHA1 versions=
 that are known to work on Ubuntu 11.10.

Thanks,
Noah--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
