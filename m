From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: crash on umount
Date: Fri, 03 Jun 2011 19:13:11 +0300
Message-ID: <4DE90817.7090506@ufm.su>
References: <4DE8BA2C.6030309@ufm.su> <20110603153905.GA22186@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:42110 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862Ab1FCQNP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 Jun 2011 12:13:15 -0400
In-Reply-To: <20110603153905.GA22186@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 06/03/2011 06:39 PM, Tommi Virtanen wrote:
> On Fri, Jun 03, 2011 at 01:40:44PM +0300, Fyodor Ustinov wrote:
>> Hi!
>>
>> kernel 2.6.39
>> ceph - 0.28.2
>>
>> In sysctl.conf set
>> vm.min_free_kbytes=262144
>>
>> Jun  2 03:08:17 amanda kernel: [35398.757055] libceph: msg_new can't
>> allocate 4096 bytes
> ... so first you run out of memory ...
I do not understand one thing: why on server with 2G of RAM  and 250M of 
vm.min_free_kbytes ceph (and _only_ ceph) can not allocate memory?

WBR,
     Fyodor.

