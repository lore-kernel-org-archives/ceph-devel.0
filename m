From: =?ISO-8859-9?Q?Metin_Akyal=FD?= <metin.akyali@gmail.com>
Subject: how to install a cloud storage network :which is best smart automatic
	file replication solution for cloud storage based systems.
Date: Thu, 27 May 2010 20:36:31 +0300
Message-ID: <AANLkTilC2wJJvaZlJgLvCRm3cOenq4Pt2S0d_y49L-N7@mail.gmail.com>
References: <ddb7e63e-da19-4189-b876-572c34033645@f14g2000vbn.googlegroups.com>
	<AANLkTikruTeNC9CsBYX0xrGVsqRphR9OnfXckb2cXYQ_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36931 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611Ab0E0RmD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 May 2010 13:42:03 -0400
Received: by wwb34 with SMTP id 34so187170wwb.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 May 2010 10:42:02 -0700 (PDT)
In-Reply-To: <AANLkTikruTeNC9CsBYX0xrGVsqRphR9OnfXckb2cXYQ_@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I am looking for a solution for a project i am working on.

We are developing a website where people can upload their files and
where they can share those files and other people can download them.
(similar to rapidshare . com model)

Problem is, some files can be demanded much more than other files. And
we cant replicate every file on other nodes, the cost would increase
exponentialy. The scenerio is like: Simon has uploaded his birthday
video and shared it with all of his friends, He has uploaded it to
project . com and it was stored in one of the server in the cluster
which has 100mbit connection.

Problem is, once all of Smion's friends want to download the file,
they cant download it since the bottleneck here is 100mbit which is
12.5MB per second, but he got 1000 friends trying to download the
video file and they can only download 12.5KB per second which is very
very bad. I am not taking into account that the overhead in the hdd.

Thus, i need to find a way to replicate only demanded files to scale
the network and serve the files without problem. (at least 200KB/sec)

My network infrastrucre is as follows: I will have client and storage
nodes. For client nodes i will use 1GBIT bandwidth with enough amount
of ram and cpu, and that server will be the client. And they would be
connected to 4 Nodes of storage servers that each of has 100mbit
connection. 1gbit server can handle the 1000 users traffic if one of
storage node can stream more than 15MB per second to my 1gbit (client)
server and visitor will stream directly from client server instead of
storage nodes. I can do it by replicating the file into 2 nodes . But
i dont want to replicate all files uploadded to my network to my nodes
since it is costing much more. I think =A0and i am sure that somebody
has same error in past and they have developed a solution to this
problem.

So i need a cloud based system, which will push the files into
replicated nodes automatically when demanded to those files are high,
and when the demand is low, they will delete from other nodes and it
will stay in only 1 node.

I have looked to glusterfs and asked in their irc channel that
problem, and got an answer from the guys that gluster cant do such a
thing. It is only able to replicate all the files or none of the
files. (i have to define which files to be replicated) But i need it
the cluster software to do it automatically.

I would use 1gbit client servers and 100mbit storage servers. All the
servers will be in same DC. I will rent the servers and i dont own my
own DC house. Reason i am choosing 1gbit server as the client is i
wont have too much 1gbit server, but i will have many stogage nodes,
and 1gbit server is very expensive but 100mbit is not so.

I am sure afer some time, i will have some trouble using =A0client
server which i have to loadbalance them later, but that is the next
step which i dont mind right now.

I would be happy to use open source solutions like (which i searched)
glusterfs, gfs, google file system, rdbd, parascale, cloudstore,but i
really couldnt find which is the best way for me.

I thought it is best way to listen other people's experiences'. If you
might help i will be happy. (instead of recommending me using amazon
s3 :) )

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
