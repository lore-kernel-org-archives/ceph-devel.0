From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: How to create new empty journal?
Date: Thu, 9 Jun 2011 10:13:11 -0700
Message-ID: <BANLkTime2c04mvMy0uB7EV3=bFwGLJ=3hA@mail.gmail.com>
References: <4DEFF804.9010606@ufm.su>
	<1307614145.2906.2.camel@wido-desktop>
	<4DF09E18.5090006@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34683 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab1FIRNO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2011 13:13:14 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 40EB3C31E
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jun 2011 10:13:13 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id E4C88C22C
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jun 2011 10:13:12 -0700 (PDT)
Received: by ewy4 with SMTP id 4so617913ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jun 2011 10:13:11 -0700 (PDT)
In-Reply-To: <4DF09E18.5090006@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

=46or all of these use cases you're going to want to flush the journal
to permanent store to make sure you don't lose any data.
1) Shut down the cosd.
2) Start it up again with the --flush-journal argument.
It will run in the foreground and flush out any data in the journal.
You're all set and can do whatever you want!
-Greg

On Thu, Jun 9, 2011 at 3:19 AM, Fyodor Ustinov <ufm@ufm.su> wrote:
> On 06/09/2011 01:09 PM, Wido den Hollander wrote:
>>
>> Hi,
>>
>> On Thu, 2011-06-09 at 01:30 +0300, Fyodor Ustinov wrote:
>>>
>>> Hi!
>>>
>>> I need to create new fresh journal for OSD server without removing =
data.
>>> How?
>>
>> This can be done with:
>>
>> $ cosd -i<osdnum> =A0-c /etc/ceph/ceph.conf --mkjournal
>
> Thanx!
>
>> This will reset your journal.
>>
>> Why do you want to do this?
>>
>
> Many cases:
>
> 1. I have journal on tempfs and want to stop ceph cluster and restart
> servers. After that I lose journal.
>
> 2. I want to increase journal size.
>
> 3. I want to decrease journal size.
>
> 4. I want replace journal device.
>
> And so on.
>
> WBR,
> =A0 =A0Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
