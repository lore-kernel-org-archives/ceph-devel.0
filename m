From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Re: Ceph FS - File Locking Status
Date: Thu, 25 Apr 2013 22:01:15 -0500
Message-ID: <21225b3d6dd1317d4af5088fa17ce973@pl1.haspere.com>
References: <5fabda9d3f136b2185df714d7f560c98@pl1.haspere.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([209.177.156.123]:58339 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758208Ab3DZDBQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Apr 2013 23:01:16 -0400
In-Reply-To: <5fabda9d3f136b2185df714d7f560c98@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

Hi All (again),

I'm specific interested in POSIX advisory locks...   as referred to by 
SQLite Version 3 (http://www.sqlite.org/lockingv3.html, section 6).

I want to store a set of SQLite database files on a shared Ceph FS, in 
order to coordinate the activities of a number of nodes.  I need to make 
sure that multiple nodes won't be stepping on each other and corrupting 
these database files.


---
Thanks,
Dyweni



On 2013-04-25 20:54, Dyweni - Ceph-Devel wrote:
> Hi All,
> 
> I ran across Bug # 2825 (http://tracker.ceph.com/issues/2825)
> tonight.  Is file locking still an issue in the latest stable release
> (0.60 / 0.61) ?
> 
> 
> 
> --
> Thanks,
> Dyweni
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
