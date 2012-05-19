From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: session lost, hunting for new mon
Date: Sat, 19 May 2012 10:13:30 +0200
Message-ID: <4FB7562A.5080103@profihost.ag>
References: <4FB72E28.2040709@profihost.ag> <4FB738F3.1060602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60938 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab2ESINa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 May 2012 04:13:30 -0400
In-Reply-To: <4FB738F3.1060602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 19.05.2012 08:08, schrieb Josh Durgin:
> On 05/18/2012 10:22 PM, Stefan Priebe wrote:
>> Hi,
>>
>> while doing my first tests with ceph i'm always struggling about these
>> kernel messages:
>>
>> [ 273.332472] libceph: client0 fsid d3aa8d88-3aa8-4f74-bb87-aa8de4975a84
>> [ 273.351025] libceph: mon1 10.0.255.101:6789 session established
>> [ 459.830296] libceph: mon1 10.0.255.101:6789 socket closed
>> [ 459.847044] libceph: mon1 10.0.255.101:6789 session lost, hunting for
>> new mon
>> [ 472.226073] libceph: mon0 10.0.255.100:6789 session established
>>
>> Always while stress testing the session to the mon's got lost. Any ideas?
>
> These aren't a problem - it's just the connection to a monitor being
> lost, and the client connecting to another one.
But what is causing this? I'm also seeing:
[  623.554698] ceph: mds0 caps stale
[  650.190504] ceph: mds0 caps renewed

My biggest problem is that random reads and writes are awfully slow.

Stefan
