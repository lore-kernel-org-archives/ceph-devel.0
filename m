From: Phil Carns <carns@mcs.anl.gov>
Subject: Re: minor file journal size bug
Date: Tue, 15 Jun 2010 14:29:38 -0400
Message-ID: <4C17C692.8040705@mcs.anl.gov>
References: <4C163A7E.6060701@mcs.anl.gov> <AANLkTimuybE0Lw-2RC2VOAUKh5OWopXcp4f3fdfYs2xv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailhost.anl.gov ([130.202.113.50]:49395 "EHLO mailhost.anl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758066Ab0FOS3l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Jun 2010 14:29:41 -0400
In-Reply-To: <AANLkTimuybE0Lw-2RC2VOAUKh5OWopXcp4f3fdfYs2xv@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 06/14/2010 01:37 PM, Yehuda Sadeh Weinraub wrote:
> On Mon, Jun 14, 2010 at 7:19 AM, Phil Carns<carns@mcs.anl.gov>  wrote:
>    
>> Hi,
>>
>> I ran into a minor problem when configuring the ObjectStore to use a file
>> journal that was 10 gigabytes in size (osd_journal_size = 10240).  The
>> osd_journal_size configuration parameter is an integer.  This would normally
>> be fine since the units are in megabytes, but it can overflow when bit
>> shifted in FileJournal.cc.  This causes the journal to fall back to trying
>> to detect a raw block device journal.
>>
>> I've attached a small patch that fixes the problem for me, but there is
>> probably a cleaner way to do it.
>>
>>      
> Thanks!
>
> Just defining osd_journal_size as a long long would do the trick (as
> follows), although I'm not sure whether we need to be able to define
> journals that are bigger than 2^32 MB. So I guess that in this case we
> should probably go with your solution, and also go over the code and
> check to see whether we have some other places where we do the same.
> We should really be using some macro that does this conversion with a
> correct cast.
>
> Yehuda
>    

Thanks Yehuda.  I don't know what the right long term answer is, but 
either way works fine for my test case (I just tried your patch to confirm).

-Phil
