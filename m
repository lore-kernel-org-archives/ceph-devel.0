From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: ceph and network
Date: Wed, 25 May 2011 16:12:11 +0300
Message-ID: <4DDD002B.7060902@ufm.su>
References: <4DDB82FF.4070100@ufm.su> <BANLkTimTdB9zMKuLSz_BiSrCbyvBB42Q6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:33939 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757134Ab1EYNMM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 May 2011 09:12:12 -0400
In-Reply-To: <BANLkTimTdB9zMKuLSz_BiSrCbyvBB42Q6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 05/24/2011 05:55 PM, Brian Chrisman wrote:
> On Tue, May 24, 2011 at 3:05 AM, Fyodor Ustinov<ufm@ufm.su>  wrote:
>> Hi!
>>
>> I need to implement this scheme of servers connections:
>>
>> All servers of ceph cluster have 2 network addresses in different nets.
>> One net - for ceph interconnect. I.e. for traffic between ceph servers
>> (Suppose called "internal").
>> One - for traffic between clients and cluster ("external").
>>
>> As I understand it - the client receives the address of the ceph servers
>> frommon. And mon server needs to know about that it is necessary give out
>> "external" address, not "internal".
>>
>> How can I do?
> There's a 'cluster addr' option which is intended to split the traffic
> between multiple networks afaik.
As Iunderstandmdsandmonserversshould livein the"public"network?

WBR,
     Fyodor.
