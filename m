From: Sage Weil <sage@newdream.net>
Subject: Re: pg scrub check problem
Date: Wed, 28 Oct 2015 17:13:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510281712280.1004@cobra.newdream.net>
References: <000001d11164$7fa470a0$7eed51e0$@com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44488 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbbJ2ANS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 20:13:18 -0400
In-Reply-To: <000001d11164$7fa470a0$7eed51e0$@com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: changtao381 <changtao381@163.com>
Cc: 'ceph-devel' <ceph-devel@vger.kernel.org>

On Wed, 28 Oct 2015, changtao381 wrote:
> Hi,
> 
> I?m testing the deep-scrub function of ceph.  And the test steps are below :
> 
> 1)  I put an object on ceph using command :
>  rados put test.txt test.txt ?p testpool
> 
> The size of testpool is 3, so there three replicates on three osds:
> 
> osd.0:   /data1/ceph_data/osd.0/current/1.0_head/test.txt__head_8B0B6108__1
> osd.1:   /data2/ceph_data/osd.1/current/1.0_head/test.txt__head_8B0B6108__1
> osd.2    /data3/ceph_data/osd.2/current/1.0_head/test.txt__head_8B0B6108__1
> 
> 2) I modified the content of one replica on osd.0 using vim editor directly on disk
> 
> 3) I run the command 
> ?ceph pg deep-scrub 1.0
> 
> and expect it can check the inconsistent error out, but it fails. It doesn?t find the error
> why? 

Becuse you *just* wrote the object, and the FileStore caches open file 
handles.  Vim renames a new inode over the old one so the open inode is 
untouched.

If you restart the osd and then scrub you'll see the error.

sage

