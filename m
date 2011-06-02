From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Error while creating ceph cluster
Date: Thu, 2 Jun 2011 15:14:15 +0000
Message-ID: <1307027655.1760.2.camel@localhost>
References: <1306997996.2518.4.camel@lb>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:12127 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753519Ab1FBHOg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 03:14:36 -0400
In-Reply-To: <1306997996.2518.4.camel@lb>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lalit Bhasin <lkb@one.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi ,
try the steps:
1. use root user;
2. manually create /data/osd${N} folder.

Jeff ,Wu

On Thu, 2011-06-02 at 14:59 +0800, Lalit Bhasin wrote:
> Guys, I am new to ceph. Trying to create a 2 node cluster setup of ceph.
> Getting errors during mk file system : http://dpaste.com/hold/549518/.
> Any idea what's going wrong?
> 
> 
> - Lalit
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

