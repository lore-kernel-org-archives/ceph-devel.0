From: Lalit Bhasin <lkb@one.com>
Subject: Re: Error while creating ceph cluster
Date: Thu, 02 Jun 2011 13:11:44 +0530
Message-ID: <1307000504.13031.6.camel@lb>
References: <1306997996.2518.4.camel@lb> <1307027655.1760.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from kontorsmtp1.one.com ([195.47.247.16]:31162 "EHLO
	kontorsmtp1.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758889Ab1FBHlv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 03:41:51 -0400
In-Reply-To: <1307027655.1760.2.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 2011-06-02 at 15:14 +0000, Jeff Wu wrote:
> Hi ,
> try the steps:
> 1. use root user;
> 2. manually create /data/osd${N} folder.
Jeff, I ensured that /data/osd0 ( on node0) and /data/osd1 ( on node1)
existed before shooting this command on node1. Got same error using root
user also ( ofcourse this time there was no permission denied error
while writing to error logs). 
mkcephfs is failing while trying to execute below command on node0:

ssh node0 /sbin/mkcephfs -d /tmp/mkcephfs.e3FNLexFkx --init-daemon osd.0

And it is reporting error as:

 ** ERROR: error creating empty object store in /data/osd1: error 2: No
such file or directory

Which is somewhat true since /data/osd1 only exists in node1, and not
node0. Does it means there are some error in ceph.conf. 

- Lalit



> 
> Jeff ,Wu
> 
> On Thu, 2011-06-02 at 14:59 +0800, Lalit Bhasin wrote:
> > Guys, I am new to ceph. Trying to create a 2 node cluster setup of ceph.
> > Getting errors during mk file system : http://dpaste.com/hold/549518/.
> > Any idea what's going wrong?
> > 
> > 
> > - Lalit
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


