From: Dan Mick <dan.mick@inktank.com>
Subject: Re: a few deb updates
Date: Tue, 01 Apr 2014 18:45:26 -0700
Message-ID: <533B6BB6.10608@inktank.com>
References: <alpine.DEB.2.00.1404011443380.22715@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34576 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbaDBBp3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Apr 2014 21:45:29 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so10283529pdj.6
        for <ceph-devel@vger.kernel.org>; Tue, 01 Apr 2014 18:45:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1404011443380.22715@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-maintainers@ceph.com
Cc: ceph-devel@vger.kernel.org

One comment; otherwise looks rational to me

On 04/01/2014 02:44 PM, Sage Weil wrote:
> Can someone please review
> 
> 	https://github.com/ceph/ceph/pull/1581
> 
> There are a couple of minor packages changes here that could use a second 
> look.  Mostly just shifting things into ceph-common from ceph (since they 
> can be used by clients too).
> 
> Thanks!
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
