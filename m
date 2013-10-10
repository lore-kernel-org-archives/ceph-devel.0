From: Wido den Hollander <wido@42on.com>
Subject: Re: Blocking rados_* calls
Date: Thu, 10 Oct 2013 22:47:34 +0200
Message-ID: <52571266.4060303@42on.com>
References: <52569498.2090109@42on.com> <alpine.DEB.2.00.1310100644130.18301@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:40149 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755542Ab3JJUri (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Oct 2013 16:47:38 -0400
In-Reply-To: <alpine.DEB.2.00.1310100644130.18301@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 10/10/2013 03:45 PM, Sage Weil wrote:
> On Thu, 10 Oct 2013, Wido den Hollander wrote:
>> Hi,
>>
>> Currently librados blocks all calls when something is not working inside the
>> Ceph cluster.
>>
>> This is common practice for fopen(), fread() and fwrite(), but I'm running
>> into a use-case where I think the rados_connect() should not block
>> indefinitely.
>>
>> The use-case here is the RBD storage pool in libvirt. When for whatever reason
>> libvirt is not able to connect to the Ceph cluster libvirt will simply block
>> and wait on rados_connect() to complete.
>>
>> This causes libvirt not being able to report new statistics about the RBD
>> storage pool, which causes issues again for the applications using it.
>>
>> Would it be an idea that you can configure librados not to block indefinitely
>> and return for example ETIMEDOUT?
>>
>> By default librados could stay blocking like it's now so nothing changes for
>> existing users.
>
> Yeah I think this is definitely doable.  The simplest would be to have a
> configurable (or configurables) that are set via rados_conf_set() (or put
> in the config).  There are several timeouts there already, but I think
> they don't capture the entire connect sequence.
>
> Want to open a feature ticket?

Done!

http://tracker.ceph.com/issues/6507

Wido

>
> sage
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
