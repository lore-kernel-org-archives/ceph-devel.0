From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 15:48:37 -0500
Message-ID: <4FBBFBA5.9090604@inktank.com>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40003 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932632Ab2EVUso (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 16:48:44 -0400
Received: by obbtb18 with SMTP id tb18so10074488obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 13:48:43 -0700 (PDT)
In-Reply-To: <4FBBF74C.9020608@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On 05/22/2012 03:30 PM, Stefan Priebe wrote:
> Am 22.05.2012 21:52, schrieb Greg Farnum:
>> On Tuesday, May 22, 2012 at 12:40 PM, Stefan Priebe wrote:
>> Huh. That's less than I would expect. Especially since it ought to be 
>> going through the page cache.
>> What version of RBD is KVM using here?
> v0.47.1
>
>> Can you (from the KVM host) run
>> "rados -p data bench seq 60 -t 1"
>> "rados -p data bench seq 60 -t 16"
>> and paste the final output from both?
> OK here it is first with write then with seq read.
>
> # rados -p data bench 60 write -t 1
> # rados -p data bench 60 write -t 16
> # rados -p data bench 60 seq -t 1
> # rados -p data bench 60 seq -t 16
>
> Output is here:
> http://pastebin.com/iFy8GS7i
>
> Thanks!
>
> Stefan
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi Stefan,

Can you use something like iostat or collectl to check and see if the 
write throughput to each SSD is roughly equal during your tests?  Also, 
what FS are you using and how did you format/mount it?  I've been doing 
some tests internally using 2 nodes with 5 OSDs each backed by SSDs for 
both data and journal and am seeing about 600MB/s from the client (over 
10GE) on a fresh ceph fs.

Mark


