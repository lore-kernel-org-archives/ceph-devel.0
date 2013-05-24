From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [doc] strange navigation error
Date: Fri, 24 May 2013 13:55:52 -0700
Message-ID: <519FD3D8.6040309@inktank.com>
References: <CACkq2mo6nRDYxDYEEbWJYGmVfiKcEEL8dMKrEYz_Yqx9MbVR1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62152 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787Ab3EXUz4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 May 2013 16:55:56 -0400
Received: by mail-pd0-f180.google.com with SMTP id 14so2128175pdc.25
        for <ceph-devel@vger.kernel.org>; Fri, 24 May 2013 13:55:56 -0700 (PDT)
In-Reply-To: <CACkq2mo6nRDYxDYEEbWJYGmVfiKcEEL8dMKrEYz_Yqx9MbVR1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 05/24/2013 10:05 AM, Travis Rhoden wrote:
> I stumbled across a weird TOC/navigation error in the docs.
>
> On the page: http://ceph.com/docs/master/rados/deployment/ceph-deploy-mds/,
> if you hover over "next" on the top right, it wants to go to
> mds-config-ref, even though the TOC on the left says the next entry
> should be ceph-deploy-purge.

Ah.  That's because the TOC *also* says that the next is MDS 
Configuration (under CephFS).  I guess we're sharing the Add/Remove MDS 
page at two places in the hierarchy.

-- 
Dan Mick, Filesystem Engineering
Inktank Storage, Inc.	http://inktank.com
Ceph docs: http://ceph.com/docs
