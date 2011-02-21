From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about PG ID to OSDs
Date: Mon, 21 Feb 2011 12:30:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102211230150.30637@cobra.newdream.net>
References: <1298279135.1867.34.camel@cephhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52536 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab1BUU3Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Feb 2011 15:29:24 -0500
In-Reply-To: <1298279135.1867.34.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Wu <cpwu@tnsoft.com.cn>
Cc: ceph-devel@vger.kernel.org

On Mon, 21 Feb 2011, Jeff Wu wrote:
> I'm reading CRUSH and RADOS thesis,from these thesis , 
> i can get the algorithms:
> 
> object_id = <object_number,inode_number>;
> pg_id = (r,hash(object_id) & mask)  ;   // closely resembles consistent
> hashing
> 
> but i am wondering how to map a pg_id to OSDs by CRUSH .
> Example , 
> if pg_id = 1.12,exist osd0,osd1,osd2,osd3,
> then how to map pg_id = 1.12 to these osds ?  the algorithms ? the
> detail steps ?

The CRUSH algorithm is described in detail by

	http://ceph.newdream.net/papers/weil-crush-sc06.pdf

sage
