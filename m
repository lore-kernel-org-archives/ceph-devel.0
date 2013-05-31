From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Speed up 'rbd rm'
Date: Fri, 31 May 2013 16:53:45 -0700
Message-ID: <51A93809.6090802@inktank.com>
References: <20130529055942.GA3977@onthe.net.au> <51A65523.10107@inktank.com> <20130530022307.GA27809@onthe.net.au> <51A7BB86.3020106@inktank.com> <20130531014049.GA424@onthe.net.au> <51A845F2.8050001@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44007 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab3EaXxw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 19:53:52 -0400
Received: by mail-pd0-f182.google.com with SMTP id g10so2971208pdj.13
        for <ceph-devel@vger.kernel.org>; Fri, 31 May 2013 16:53:52 -0700 (PDT)
In-Reply-To: <51A845F2.8050001@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Chris Dunlop <chris@onthe.net.au>, ceph-devel@vger.kernel.org

On 05/30/2013 11:40 PM, Stefan Priebe - Profihost AG wrote:
> Am 31.05.2013 03:40, schrieb Chris Dunlop:
>> On Thu, May 30, 2013 at 01:50:14PM -0700, Josh Durgin wrote:
>>> On 05/29/2013 07:23 PM, Chris Dunlop wrote:
>>>> On Wed, May 29, 2013 at 12:21:07PM -0700, Josh Durgin wrote:
>>>>> On 05/28/2013 10:59 PM, Chris Dunlop wrote:
>>>>>> I see there's a new commit to speed up an 'rbd rm':
>>>>>>
>>>>>> http://tracker.ceph.com/projects/ceph/repository/revisions/40956410169709c32a282d9b872cb5f618a48926
>>>>>>
>>>>>> Is it safe to cherry-pick this commit on top of 0.56.6 (or, if not, v0.61.2) to speed up the remove?
>>>>>
>>>>> You'll need 537386d906b8c0e395433461dcb03a82eb33f34f as well. It should
>>>>> apply cleanly to 0.61.2, and probably 0.56.6 too.
>
> I cherry picked both on top of cuttlefish it works but not very good.
> rbd command finishes but rbd image is still in rbd ls and just gets
> deleted later. I also saw a variant, where rbd rm outputs errors even
> though the image was there but it still got deleted...

I forgot that there was a bug in the original version. You'll need
395a775a8c87b0ee1ce314257e25240214f4081c too.
