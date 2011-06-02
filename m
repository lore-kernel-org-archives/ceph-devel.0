From: Anders Saaby <anders@saaby.com>
Subject: Re: Error while creating ceph cluster
Date: Thu, 2 Jun 2011 10:12:18 +0200
Message-ID: <7CA2B1D9-38D9-425E-974D-5B9EB1B1F2F5@saaby.com>
References: <1306997996.2518.4.camel@lb> <1307027655.1760.2.camel@localhost> <1307000504.13031.6.camel@lb>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.saaby.com ([77.66.17.210]:33146 "EHLO mail.saaby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759560Ab1FBIUl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 04:20:41 -0400
In-Reply-To: <1307000504.13031.6.camel@lb>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lalit Bhasin <lkb@one.com>
Cc: cpwu@tnsoft.com.cn, ceph-devel <ceph-devel@vger.kernel.org>

Lalit,

I think the answer is in your ceph.conf file:

<SNIP>
[osd]
       sudo = true
       osd data = /data/osd1
[osd.0]
       host = node0
[osd.1]
       host = node1
</SNIP>

Which dictates the "/data/osd1" dir on both nodes.

You should go for something more like: "osd data = /data/osd$id" which will use osd0 on node0, osd1 on node1.


Best regards
Anders Saaby

On 02/06/2011, at 09.41, Lalit Bhasin wrote:

> On Thu, 2011-06-02 at 15:14 +0000, Jeff Wu wrote:
>> Hi ,
>> try the steps:
>> 1. use root user;
>> 2. manually create /data/osd${N} folder.
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
> ** ERROR: error creating empty object store in /data/osd1: error 2: No
> such file or directory
> 
> Which is somewhat true since /data/osd1 only exists in node1, and not
> node0. Does it means there are some error in ceph.conf. 
> 
> - Lalit
> 
> 
> 
>> 
>> Jeff ,Wu
>> 
>> On Thu, 2011-06-02 at 14:59 +0800, Lalit Bhasin wrote:
>>> Guys, I am new to ceph. Trying to create a 2 node cluster setup of ceph.
>>> Getting errors during mk file system : http://dpaste.com/hold/549518/.
>>> Any idea what's going wrong?
>>> 
>>> 
>>> - Lalit
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

