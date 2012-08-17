From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to write data to rados pool.
Date: Fri, 17 Aug 2012 14:39:50 +0200
Message-ID: <502E3B96.2060507@widodh.nl>
References: <loom.20120817T075847-947@post.gmane.org> <6F69B412D76D49808942F99B99B96ACB@inktank.com> <loom.20120817T125003-56@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:42629 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757278Ab2HQMjw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 08:39:52 -0400
In-Reply-To: <loom.20120817T125003-56@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 08/17/2012 12:51 PM, ramu wrote:
> Hi gregory,
>
>      Text file is stored on raados pool fine.Then how to insert a folder or
> directory to ceph.
>

RADOS just knows pools and objects, it doesn't know anything about 
directories or such.

java-rados is just a wrapper around librados and can only store objects 
inside pools.

You can compare this to Amazon S3.

Wido

> Thanks,
> Ramu.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

