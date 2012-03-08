From: lixiaobing10@otcaix.iscas.ac.cn
Subject: Problems when I tried to let Hadoop use Ceph
Date: Thu, 8 Mar 2012 19:12:18 +0800 (CST)
Message-ID: <f123f2.24b.135f2026959.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [124.16.137.195] ([124.16.137.195]:60266 "EHLO
	otcaix.iscas.ac.cn" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab2CHLTF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 06:19:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi ceph-devel,
I came up with the following problems when I tried to let Hadoop use Ce=
ph. Could you give any advice? Thanks firstly!
I installed ceph-0.20.2 and hadoop.0.20.205.0 with the hadoop.0.20.205.=
0-cephfs1.patch successfully. Both ceph and hadoop(using HDFS) can work=
 well separately. Besides, I could run command like 'hadoop fs -ls /', =
'hadoop fs -put /localfilepath /cephfilepath' correctly. But when I run=
 a mapreduce demo: wordcount with a small file containing about two tho=
usand words, reduce task crashed reporting information like:=C2=A0
A fatal error has been detected by the Java Runtime Environment:...Prob=
lematic frame:C =C2=A0[libceph.so.1.0.0+0x898e7]...
I thought it was because ceph version is a little older compared with h=
adoop version. So I tried ceph-0.41.0 and ceph-0.30.0.=C2=A0
However, when I run command 'hadoop fs -ls /' with ceph-0.41.0, a FATAL=
 error occurred:
=46ATAL ceph.CephFileSystem: initialize:Ceph initialization failed!
After tracing the source code, I found the failure was due to client fa=
iling to authenticate and establish communication with ceph. I was not =
quite sure about the reason leading to this failure.=C2=A0=C2=A0And whe=
n I tried ceph-0.30.0, I got the following when I run 'hadoop fs -ls /'=
, a little like the first one:
A fatal error has been detected by the Java Runtime Environment:...Prob=
lematic frame:C =C2=A0[libceph.so.1.0.0+0x929fe]...
I found that ceph-0.41.0 can make libcephfs.so directly, which hadoop l=
ooking for. =C2=A0While ceph-0.20.2 and ceph-0.30.0 just make libceph.s=
o out. So I used 'ln -s libceph.so libcephfs.so' to bypass this problem=
=2E
The above is what I got when I tried to let Hadoop use Ceph. And ceph-0=
=2E20.2 led me to the best point among the three versions. I did this a=
ccording to the paper 'Ceph as a scalable alternative to the Hadoop Dis=
tributed File System' and the webpage 'http://ceph.newdream.net/wiki/Ha=
doop_FileSystem'. The webpage did not point out the version of Ceph, wh=
ich I think is important to my trial.=C2=A0
Now, I really need your suggestion. And thanks for your attention. Hopi=
ng to get your reply soon!
Best,Xiaobing


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
