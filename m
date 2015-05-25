From: Sage Weil <sweil@redhat.com>
Subject: Re: Cache pool on top of ec base pool teuthology test
Date: Mon, 25 May 2015 08:04:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505250801290.6462@cobra.newdream.net>
References: <06E7D85B3BA36C4DB207FEDE871C53489E8DE1@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50621 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbbEYPET (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 May 2015 11:04:19 -0400
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C53489E8DE1@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 25 May 2015, Wang, Zhiqiang wrote:
> We have a bunch of teuthology tests which build cache pool on top of an 
> ec base pool, and do partial object write. This is ok with the current 
> cache tiering implementation. But with proxy write, this won't work. In 
> my testing, the error message is something like below:
> 
> 2015-05-20 05:51:42.896828 7f682eed4700 10 osd.5 pg_epoch: 183 pg[2.1( v 183'7978 (179'7799,183'7978] local-les=172 n=1258 ec=8 les/c 172/172 170/171/171) [5,0] r=0 lpr=171 luod=183'7975 crt=183'7974 lcod 183'7974 mlcod 183'7974 active+clean] do_proxy_write Start proxy write for osd_op(client.4130.0:32967 plana4222147-6594 [write 733117~408660] 2.3ed99ff9 ack+ondisk+write+known_if_redirected e183) v5
> 2015-05-20 05:51:42.899958 7f682c6cf700  1 -- 10.214.132.32:6808/20666 --> 10.214.132.32:0/20666 -- osd_op_reply(17556 plana4222147-6594 [write 733117~408660] v0'0 uv0 ondisk = -95 ((95) Operation not supported)) v6 -- ?+0 0xa2e23c0 con 0x9355760
> 
> What should we do with these tests?

I think the test is fine.. but the OSD should refuse to proxy the write if 
the base tier won't support the write operation in question.  I believe we 
recently renamed one of the helpers supports_omap()... we probably need a 
similar set of helpers for object overwrites?

Or, we can make a method like "should_proxy_to_ec()" that scans through 
the op vector and makes a conservative judgement of whether it is safe 
to proxy...

sage
