From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Repeated messages of "heartbeat_check: no heartbeat from"
Date: Thu, 23 Feb 2012 21:18:10 -0800
Message-ID: <CAF3hT9BPkWi6XXrKeyAv3pXXdPk+eRt=faQCv3ri7eDZey63qw@mail.gmail.com>
References: <1312546310.2754.41.camel@wido-laptop.pcextreme.nl>
	<1312972246.2742.7.camel@wido-desktop>
	<4F3BBD50.3030905@widodh.nl>
	<CAF3hT9DHxakM8PAAPuZBUjOHHo-0gbU3qLW0jkkGKTR79Rg5qQ@mail.gmail.com>
	<4F4618D3.4030501@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36383 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab2BXFSK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2012 00:18:10 -0500
Received: by iacb35 with SMTP id b35so2546750iac.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2012 21:18:10 -0800 (PST)
In-Reply-To: <4F4618D3.4030501@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Thu, Feb 23, 2012 at 2:45 AM, Wido den Hollander <wido@widodh.nl> wr=
ote:
> Hi,
>
>
>
> On 02/22/2012 07:08 PM, Gregory Farnum wrote:
>>
>> Wido,
>> Sorry we lost track of this last week =97 we were all distracted by =
=46AST 12!
>> :)
>>
> No problem!
>
>
>> So it looks like they're both on the same map and osd.4 is sending
>> pings to osd.19, but osd.19 is just ignoring them? Or do you really
>> have on debug_os and not debug_osd? :)
>
>
> That was a typo, I have debug_osd set to 20.
>
> I haven't rebooted the OSD's since and now osd.4 and osd.19 are not
> complaining anymore, but it's now a different set of OSD's who are sa=
ying
> the other one is down.
>
> I'm still running v0.41 btw. I'm not going to touch the cluster until=
 this
> one is tracked down, it keeps coming back.
>
> Suggestions?

Well, like Sage said long ago, this will be easiest to diagnose if
there are logs available for both OSDs that cover the entire time
after one requested heartbeats from the other.

If you do have these and can post them somewhere, I'm sure Sage or I
will find it interesting enough to look through...  ;)
If not, I'm out of ideas, although I'm not super-familiar with the
heartbeat code since Sage rewrote it so we may be able to come up with
something if we discuss it more.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
