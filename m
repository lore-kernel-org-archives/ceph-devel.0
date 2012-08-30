From: Mike Ryan <mike.ryan@inktank.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Thu, 30 Aug 2012 07:53:37 -0700
Message-ID: <20120830145337.GF19573@splice>
References: <loom.20120827T091156-421@post.gmane.org>
 <loom.20120828T122919-139@post.gmane.org>
 <20120828160607.GC19573@splice>
 <loom.20120829T083049-345@post.gmane.org>
 <loom.20120829T133922-563@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60796 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab2H3Oxo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 10:53:44 -0400
Received: by pbbrr13 with SMTP id rr13so3260786pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 07:53:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20120829T133922-563@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 29, 2012 at 11:41:47AM +0000, ramu eppa wrote:
>    After starting apache2 ,The s3 -u list command working properly,but s3 -u 
> create mytest was not working it is showing error is,
> ERROR:XMLParseFailure
> And error.log is,

How about access.log? Is the script exiting with 200 or something else?
