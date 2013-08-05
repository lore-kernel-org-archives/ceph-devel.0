From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] ceph: fix bugs about handling short-read for sync read
 mode.
Date: Mon, 05 Aug 2013 08:56:17 +0800
Message-ID: <51FEF831.2070208@intel.com>
References: <201308020907510158900@gmail.com>,  <alpine.DEB.2.00.1308021316010.1128@cobra.newdream.net> <201308050826095277010@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35879 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049Ab3HEA4T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 4 Aug 2013 20:56:19 -0400
In-Reply-To: <201308050826095277010@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 08/05/2013 08:26 AM, majianpeng wrote:
>> BTW, I was going to add this to the testing branch but it doesn't apply to 
>> the current tree.  Can you rebase on top of ceph-client.git #testing?
>>
> Sorry, Can you tell me the URL of ceph-client.git ?
> 

https://github.com/ceph/ceph-client

