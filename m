From: Lalit Bhasin <lkb@one.com>
Subject: Re: Error while creating ceph cluster
Date: Thu, 02 Jun 2011 17:33:32 +0530
Message-ID: <1307016212.13031.15.camel@lb>
References: <1306997996.2518.4.camel@lb> <1307027655.1760.2.camel@localhost>
	 <1307000504.13031.6.camel@lb>  <1307030136.1760.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from kontorsmtp2.one.com ([195.47.247.17]:55462 "EHLO
	kontorsmtp2.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259Ab1FBMDk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 08:03:40 -0400
In-Reply-To: <1307030136.1760.9.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 2011-06-02 at 15:55 +0000, Jeff Wu wrote:
> Hi ,
> 
> Could you create the folder 
> node0: /data/osd0/osd0 /data/osd0/osd1
> node1: /data/osd1/osd0 /data/osd1/osd1
> 
> or
> try to modify  " osd data = /data" at your ceph.conf,
> then create /data/osd0 and /data/osd1  at your node0&&node1.
> 
> I had filed the issue at :
> 
> http://tracker.newdream.net/issues/1015
> 
> 
> but Greg Farnum added  the Comment :"
> 
> You need to create the directory yourself and this is deliberate. It
> prevents administrators from not fully setting up their cluster and
> accidentally having the OSD use the root partition when they meant to
> use a separate drive mounted at /osd."
> 
> Jeff ,Wu
> 
Thanks Jeff. This helped. I now used single ceph.conf file on both the
nodes, and used $i substitution for osd and mon, and it worked ( so
kept /data/osd1 and /data/osd0 in node1 and node0 respectively).


Subsequently file system creation worked fine, and all ceph daemons
started fine. But mount gives error as below:
--
lalitb@node0:/data/osd0$ sudo mount -t ceph 192.168.230.12:/ /ceph
[sudo] password for lalitb: 
mount error 5 = Input/output error
lalitb@node0:/data/osd0$ 
---

Where 192.168.230.12 is IP address of node0. Cannot see any error in
syslog.

- Lalit

> 
> 
> 
> 
> On Thu, 2011-06-02 at 15:41 +0800, Lalit Bhasin wrote:
> > On Thu, 2011-06-02 at 15:14 +0000, Jeff Wu wrote:
> > > Hi ,
> > > try the steps:
> > > 1. use root user;
> > > 2. manually create /data/osd${N} folder.
> > Jeff, I ensured that /data/osd0 ( on node0) and /data/osd1 ( on node1)
> > existed before shooting this command on node1. Got same error using root
> > user also ( ofcourse this time there was no permission denied error
> > while writing to error logs). 
> > mkcephfs is failing while trying to execute below command on node0:
> > 
> > ssh node0 /sbin/mkcephfs -d /tmp/mkcephfs.e3FNLexFkx --init-daemon osd.0
> > 
> > And it is reporting error as:
> > 
> >  ** ERROR: error creating empty object store in /data/osd1: error 2: No
> > such file or directory
> > 
> > Which is somewhat true since /data/osd1 only exists in node1, and not
> > node0. Does it means there are some error in ceph.conf. 
> > 
> > - Lalit
> > 
> > 
> > 
> > > 
> > > Jeff ,Wu
> > > 
> > > On Thu, 2011-06-02 at 14:59 +0800, Lalit Bhasin wrote:
> > > > Guys, I am new to ceph. Trying to create a 2 node cluster setup of ceph.
> > > > Getting errors during mk file system : http://dpaste.com/hold/549518/.
> > > > Any idea what's going wrong?
> > > > 
> > > > 
> > > > - Lalit
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


