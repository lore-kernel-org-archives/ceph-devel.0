From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: How to create new empty journal?
Date: Thu, 09 Jun 2011 13:19:04 +0300
Message-ID: <4DF09E18.5090006@ufm.su>
References: <4DEFF804.9010606@ufm.su> <1307614145.2906.2.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:40897 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827Ab1FIKTH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Jun 2011 06:19:07 -0400
In-Reply-To: <1307614145.2906.2.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On 06/09/2011 01:09 PM, Wido den Hollander wrote:
> Hi,
>
> On Thu, 2011-06-09 at 01:30 +0300, Fyodor Ustinov wrote:
>> Hi!
>>
>> I need to create new fresh journal for OSD server without removing data.
>> How?
> This can be done with:
>
> $ cosd -i<osdnum>  -c /etc/ceph/ceph.conf --mkjournal
Thanx!

> This will reset your journal.
>
> Why do you want to do this?
>

Many cases:

1. I have journal on tempfs and want to stop ceph cluster and restart 
servers. After that I lose journal.

2. I want to increase journal size.

3. I want to decrease journal size.

4. I want replace journal device.

And so on.

WBR,
     Fyodor.
