From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: Read speed. again.
Date: Sat, 02 Jul 2011 23:49:45 +0300
Message-ID: <4E0F8469.5090407@ufm.su>
References: <4E0F5D8F.6050000@ufm.su> <Pine.LNX.4.64.1107021345060.15043@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:57741 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217Ab1GBUtr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 2 Jul 2011 16:49:47 -0400
In-Reply-To: <Pine.LNX.4.64.1107021345060.15043@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 07/02/2011 11:45 PM, Sage Weil wrote:
> On Sat, 2 Jul 2011, Fyodor Ustinov wrote:
>> Hi!
>>
>> ceph 0.30
>>
>> the rate of re-reading the file 10G. 13 OSD servers (ie the file is already in
>> the cache in OSD servers).
>>
>> cfuse: 118 MB/s
>>
>> kenel (3.0.0-rc3): 84.0 MB/s
>>
>> :(
> Yeah, this is still on the list.  We can include it in the next sprint
> (starting next week).
>
> sage
>
Not only that. Linus has promised that the implementation in kernel must 
be faster. FUSE only for toys. :)

WBR,
     Fyodor.
