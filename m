From: Samuel Just <sjust@redhat.com>
Subject: Re: unfound object problem
Date: Tue, 7 Jun 2016 17:18:52 -0700
Message-ID: <CAN=+7FUT_2w_QY0T8VZC3tdNkX6mUfmyvv6Sbo9_ZMn-Duht8A@mail.gmail.com>
References: <CAKE=UQJxaZPms82=qZeceSCW2+okmSPVGJ12ML0gd2JPW2uEEQ@mail.gmail.com>
	<CAJ4mKGZ9aWdDpoHeJ5cebxVn=j-vs9t2SnNBJHYYTHh-5b1E-g@mail.gmail.com>
	<CAN=+7FVBf+gu03XX3nNzff5LzKVmj8-3NxDRPXO_D13gS0m+LQ@mail.gmail.com>
	<CAKE=UQL=tdRv8CTjST9Ysw-K4_RXppWMWXFLFKdY=eTB_G9frw@mail.gmail.com>
	<CAN=+7FXCyBUJaQA7=xe-1Rf5LgUy-9MoRQC8hR=OVrjdEcSFqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36166 "EHLO
	mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcFHAZZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 20:25:25 -0400
Received: by mail-qt0-f176.google.com with SMTP id 37so21193241qtc.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2016 17:25:25 -0700 (PDT)
In-Reply-To: <CAN=+7FXCyBUJaQA7=xe-1Rf5LgUy-9MoRQC8hR=OVrjdEcSFqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rui Xie <jerry.xr86@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

http://tracker.ceph.com/issues/16185

So, it does seem to be a bug, and I've got a fix.  However, it's not
clear to me that it would result in an unfound object.  It seems like
it would result in a pg which should be down being allowed to peer or
an actually unfound object being erroneously considered ok.  I'm not
sure you've diagnosed the original issue correctly.  If you can
reproduce, you should enable logging (debug osd = 20, debug filestore
= 20, debug ms = 1) and go through the logs more carefully.
-Sam

On Tue, Jun 7, 2016 at 7:52 AM, Samuel Just <sjust@redhat.com> wrote:
> That does sound like a bug, I'll try to take a look today.
> -Sam
>
> On Mon, Jun 6, 2016 at 9:21 PM, Rui Xie <jerry.xr86@gmail.com> wrote:
>> Hi Sam
>>
>> we do not check pgtemp  map_epoch in preprocess_pgtemp and prepare_pgtemp.
>> old pgtemp messages with smaller map_epoch are prapared, and update
>> up_thru to smaller version.
>>
>> a lot of duplicate pgtemp messages there.
>>
>> 2016-06-07 6:07 GMT+08:00 Samuel Just <sjust@redhat.com>:
>>> I don't quite understand...  Can you explain the sequence of events in
>>> more detail?
>>> -Sam
>>>
>>> On Mon, Jun 6, 2016 at 2:14 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>>> On Sun, May 29, 2016 at 8:58 PM, Rui Xie <jerry.xr86@gmail.com> wrote:
>>>>> Hi
>>>>>
>>>>> I found an unfound object problem in my test environment (hammer).
>>>>> I suspect the reason is the wrong update of up_thru.
>>>>>
>>>>> from osdmap, the up_thru become smaller than before at an epoch.  some
>>>>> old PGTemp messages with smaller epoch are prepared and executed, and
>>>>> change the up_thru to smaller epoch.
>>>>> maybe_went_rw is wrong for that interval.
>>>>>
>>>>> I think prepare_pgtemp should not change up_thru if it is smaller than
>>>>> current, and duplicated PGTemp messages not be sent ?
>>>>>
>>>>> Is this a bug or something wrong for me?
>>>>>
>>>>> Thanks !
>>>>
>>>> I'm not sure if this came out of the same place or not, but Sam was
>>>> just talking last week about an issue with pgtemp updates that is at
>>>> least close to this bug. That one was resolved in the OSDMonitor, if
>>>> those are the up_thru locations you're talking about. :)
>>>> -Greg
