From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: C++ api for librados 0.25
Date: Thu, 24 Feb 2011 10:38:33 -0800
Message-ID: <4D66A5A9.4050107@dreamhost.com>
References: <AANLkTin3gXaBv1y+MPEvJVxNYVhtJdkqtzf+1vp=XApw@mail.gmail.com>	<4D669D48.6060202@dreamhost.com> <AANLkTi=RW=AWkDoZsM8TsKdZP+6AJNCfwdJ2SKtU3oVV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51140 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601Ab1BXSid (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 13:38:33 -0500
In-Reply-To: <AANLkTi=RW=AWkDoZsM8TsKdZP+6AJNCfwdJ2SKtU3oVV@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

On 02/24/2011 10:13 AM, Colin McCabe wrote:
> On Thu, Feb 24, 2011 at 10:02 AM, Josh Durgin <josh.durgin@dreamhost.com> wrote:
>> - aio_create_completion could be moved into Pool since it's only
>>  used within the context of a pool. (librbd would need this unless
>>  Pool had a get_rados method).
> 
> Hmm. I'm not seeing the pool dependency for aio_create_completion. It
> looks like this has nothing to do with any particular pool. It's just
> a callback?

My thinking was that the only reason for creating one is for doing aio, which is done on a pool.

Looking at the implementation, however, there's no dependency on the RadosClient at all.
These could just be constructors of AioCompletion (in the interface and implementation).

-Josh Durgin
