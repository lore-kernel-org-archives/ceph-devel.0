From: Dan Mick <dan.mick@inktank.com>
Subject: Re: S3 comapatible with java-rados.
Date: Mon, 20 Aug 2012 18:38:16 -0700
Message-ID: <5032E688.1080803@inktank.com>
References: <loom.20120820T091919-196@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57396 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab2HUBiT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Aug 2012 21:38:19 -0400
Received: by pbbrr13 with SMTP id rr13so7744697pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 20 Aug 2012 18:38:19 -0700 (PDT)
In-Reply-To: <loom.20120820T091919-196@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org



On 08/20/2012 12:26 AM, ramu wrote:
> Hi all,
>
>     Is there anybody wrote s3 compatible with java-rados.Please help me to
> write s3 compatible with java-rados.Means from java ,how to connecting
> to ceph and create bucket or volume.

As a first approximation, I might try Googling "S3 Java", and thus 
trying something like

http://aws.amazon.com/sdkforjava/

or

http://jets3t.s3.amazonaws.com/downloads.html

The point of the RADOS gateway is to provide the S3 HTTP/REST interface 
in a compatible way, so Java bindings to S3 should Just Work.
