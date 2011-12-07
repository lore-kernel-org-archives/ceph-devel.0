From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Client stuck 'waiting on max_size'
Date: Tue, 06 Dec 2011 21:13:58 -0800
Message-ID: <4EDEF616.2080208@cs.ucsc.edu>
References: <1340951383.133589.1323230543007.JavaMail.root@mail-01.cse.ucsc.edu> <Pine.LNX.4.64.1112062055490.13291@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:35677 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab1LGFNg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 00:13:36 -0500
In-Reply-To: <Pine.LNX.4.64.1112062055490.13291@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/6/11 8:56 PM, Sage Weil wrote:
> On Tue, 6 Dec 2011, Noah Watkins wrote:
>> I have a simple libcephfs client (code attached) that:
>>
>> 1) mounts ceph
>> 2) opens/create a file
>
> Does the file already exist when you run this?  Is the result different if
> the file is (not) already present?

- If the file already exists then it is truncated.
- If the file doesn't exist the file is created, but it remains zero length.
- In both cases the client still hangs.

-Noah
