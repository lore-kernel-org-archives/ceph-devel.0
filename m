From: Sage Weil <sage@newdream.net>
Subject: Re: How to submit PATCH to ceph ?
Date: Tue, 14 Dec 2010 21:25:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012142124300.564@cobra.newdream.net>
References: <1292382033.2484.20.camel@cephhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47039 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0LOFUT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Dec 2010 00:20:19 -0500
In-Reply-To: <1292382033.2484.20.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Wu <cpwu@tnsoft.com.cn>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Jeff,

On Wed, 15 Dec 2010, Jeff Wu wrote:
> If we fixed some bugs of ceph and ceph-client-standalone,
> How do we submit the PATCH to ceph.git and ceph-client-standalone.git ?
> Need we register a user at http://ceph.newdream.net ?
> 
> Could anybody tell me the detail steps ?

The -standalone.git is actually generated automatically based on 
ceph-client.git (which has the full kernel tree).  Sending patches based 
on that code is definitely preferred.

If you have found/fixed a bug, though, don't hesitate to send whatever you 
have!

Thanks-
sage

