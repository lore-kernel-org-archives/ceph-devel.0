From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Repeated messages of "heartbeat_check: no heartbeat from"
Date: Tue, 28 Feb 2012 16:42:03 +0100
Message-ID: <4F4CF5CB.9060006@widodh.nl>
References: <1312546310.2754.41.camel@wido-laptop.pcextreme.nl> <1312972246.2742.7.camel@wido-desktop> <4F3BBD50.3030905@widodh.nl> <CAF3hT9DHxakM8PAAPuZBUjOHHo-0gbU3qLW0jkkGKTR79Rg5qQ@mail.gmail.com> <4F4618D3.4030501@widodh.nl> <CAF3hT9BPkWi6XXrKeyAv3pXXdPk+eRt=faQCv3ri7eDZey63qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:42146 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965548Ab2B1PmG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 10:42:06 -0500
In-Reply-To: <CAF3hT9BPkWi6XXrKeyAv3pXXdPk+eRt=faQCv3ri7eDZey63qw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

Hi,

On 02/24/2012 06:18 AM, Gregory Farnum wrote:
> On Thu, Feb 23, 2012 at 2:45 AM, Wido den Hollander<wido@widodh.nl>  =
wrote:
>> Hi,
>>
>>
>>
>> On 02/22/2012 07:08 PM, Gregory Farnum wrote:
>>>
>>> Wido,
>>> Sorry we lost track of this last week =97 we were all distracted by=
 FAST 12!
>>> :)
>>>
>> No problem!
>>
>>
>>> So it looks like they're both on the same map and osd.4 is sending
>>> pings to osd.19, but osd.19 is just ignoring them? Or do you really
>>> have on debug_os and not debug_osd? :)
>>
>>
>> That was a typo, I have debug_osd set to 20.
>>
>> I haven't rebooted the OSD's since and now osd.4 and osd.19 are not
>> complaining anymore, but it's now a different set of OSD's who are s=
aying
>> the other one is down.
>>
>> I'm still running v0.41 btw. I'm not going to touch the cluster unti=
l this
>> one is tracked down, it keeps coming back.
>>
>> Suggestions?
>
> Well, like Sage said long ago, this will be easiest to diagnose if
> there are logs available for both OSDs that cover the entire time
> after one requested heartbeats from the other.
>
> If you do have these and can post them somewhere, I'm sure Sage or I
> will find it interesting enough to look through...  ;)
> If not, I'm out of ideas, although I'm not super-familiar with the
> heartbeat code since Sage rewrote it so we may be able to come up wit=
h
> something if we discuss it more.
> -Greg

I created an issue for this with logs attached:=20
http://tracker.newdream.net/issues/2116

Thanks,

Wido

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
