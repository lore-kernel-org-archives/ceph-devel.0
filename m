From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: Filesystems for ceph
Date: Thu, 28 Jul 2011 07:23:10 +0300
Message-ID: <4E30E42E.30101@ufm.su>
References: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>	<loom.20110728T001529-856@post.gmane.org> <Pine.LNX.4.64.1107271633110.29985@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:36103 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab1G1EXM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Jul 2011 00:23:12 -0400
In-Reply-To: <Pine.LNX.4.64.1107271633110.29985@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 07/28/2011 02:33 AM, Sage Weil wrote:
> On Wed, 27 Jul 2011, Fyodor Ustinov wrote:
>> Christian Brunner<chb<at>  muc.de>  writes:
>>
>>>  From what I read in Fyodors emails ext4 in 2.6.39 isn't much better.
>>>
>>> So, what filesystem would you recommend?
>>>
>> Christian, IMHO ext3/ext4/btrfs unusable for ceph. I tested some time xfs, and
>> think to use it again. But I think that the ceph developers do not like xfs:)
> What problems have you seen with ext4?
Look to my message to Greg. In a nutshell - I again have broken ext4 fs 
on OSD servers with 2.6.39 kernel.

WBR,
     Fyodor.

