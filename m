From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Error while creating ceph cluster
Date: Thu, 2 Jun 2011 15:55:36 +0000
Message-ID: <1307030136.1760.9.camel@localhost>
References: <1306997996.2518.4.camel@lb> <1307027655.1760.2.camel@localhost>
	 <1307000504.13031.6.camel@lb>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:31999 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753151Ab1FBHz5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 03:55:57 -0400
In-Reply-To: <1307000504.13031.6.camel@lb>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lalit Bhasin <lkb@one.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


Hi ,

Could you create the folder 
node0: /data/osd0/osd0 /data/osd0/osd1
node1: /data/osd1/osd0 /data/osd1/osd1

or
try to modify  " osd data = /data" at your ceph.conf,
then create /data/osd0 and /data/osd1  at your node0&&node1.

I had filed the issue at :

http://tracker.newdream.net/issues/1015


but Greg Farnum added  the Comment :"

You need to create the directory yourself and this is deliberate. It
prevents administrators from not fully setting up their cluster and
accidentally having the OSD use the root partition when they meant to
use a separate drive mounted at /osd."

Jeff ,Wu





On Thu, 2011-06-02 at 15:41 +0800, Lalit Bhasin wrote:
> On Thu, 2011-06-02 at 15:14 +0000, Jeff Wu wrote:
> > Hi ,
> > try the steps:
> > 1. use root user;
> > 2. manually create /data/osd${N} folder.
> Jeff, I ensured that /data/osd0 ( on node0) and /data/osd1 ( on node1)
> existed before shooting this command on node1. Got same error using root
> user also ( ofcourse this time there was no permission denied error
> while writing to error logs). 
> mkcephfs is failing while trying to execute below command on node0:
> 
> ssh node0 /sbin/mkcephfs -d /tmp/mkcephfs.e3FNLexFkx --init-daemon osd.0
> 
> And it is reporting error as:
> 
>  ** ERROR: error creating empty object store in /data/osd1: error 2: No
> such file or directory
> 
> Which is somewhat true since /data/osd1 only exists in node1, and not
> node0. Does it means there are some error in ceph.conf. 
> 
> - Lalit
> 
> 
> 
> > 
> > Jeff ,Wu
> > 
> > On Thu, 2011-06-02 at 14:59 +0800, Lalit Bhasin wrote:
> > > Guys, I am new to ceph. Trying to create a 2 node cluster setup of ceph.
> > > Getting errors during mk file system : http://dpaste.com/hold/549518/.
> > > Any idea what's going wrong?
> > > 
> > > 
> > > - Lalit
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

