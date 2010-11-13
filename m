From: Tatsuya Kawano <tatsuya6502@gmail.com>
Subject: Re: How can I change max_mds on v0.23?
Date: Sun, 14 Nov 2010 02:01:42 +0900
Message-ID: <0F155601-FF76-4378-B8C8-B1BC01460DD7@gmail.com>
References: <7F0CB039-816F-4252-9961-EF638EC40286@gmail.com> <AANLkTi=ayd25yVpvFqBYsdAOj2vCHqAo_Ambm50srvve@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33532 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756790Ab0KMRBs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Nov 2010 12:01:48 -0500
Received: by pwi9 with SMTP id 9so536978pwi.19
        for <ceph-devel@vger.kernel.org>; Sat, 13 Nov 2010 09:01:48 -0800 (PST)
In-Reply-To: <AANLkTi=ayd25yVpvFqBYsdAOj2vCHqAo_Ambm50srvve@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org


Hi Greg, 

set_max_mds worked. Now I've got both of them active. 

ceph@cepha1:~$ ceph mds stat
2010-11-14 01:59:16.044315 mon <- [mds,stat]
2010-11-14 01:59:16.045399 mon1 -> 'e162: 2/2/2 up {0=up:active,1=up:active}' (0)

Thanks a lot!
Tatsuya

--
Tatsuya Kawano (Mr.)
Tokyo, Japan

http://twitter.com/tatsuya6502


On 11/14/2010, at 1:46 AM, Gregory Farnum wrote:

> On Sat, Nov 13, 2010 at 7:57 AM, Tatsuya Kawano <tatsuya6502@gmail.com> wrote:
>> 
>> Hi,
>> 
>> I want to try out clustered MDS on v0.23. I followed the Wiki at <http://ceph.newdream.net/wiki/MDS_cluster_expansion>
>> and tried to set max_mds to 2, but Ceph doesn't recognize the command.
>> 
>> ceph@cepha3:~$ ceph mds set max_mds 2
>> 2010-11-14 00:44:03.008148 mon <- [mds,set,max_mds,2]
>> 2010-11-14 00:44:03.009006 mon0 -> 'unrecognized command' (-22)
> "ceph mds set_max_mds 2"
> Note the underscore, so that "set_max_mds" is a single word for the
> parser. I've fixed it in the wiki. :)
> -Greg




