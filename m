From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: How to remove lost objects.
Date: Mon, 23 Jan 2012 10:47:52 -0800
Message-ID: <CAF3hT9DCs9RH-GA6Otu6CPL5tPoAD3VfwuGHWRV6VDO-Y=Sq6Q@mail.gmail.com>
References: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
	<CAADCt4+BL6mdrQ5XyMwdNjOMQeBh-aUAxp_8ohR-AeZ4Xd8SOA@mail.gmail.com>
	<CAF3hT9D2yFqt5EKYFce_jmTdjFC_7V9LR-er+F_KuJJ3dyunSA@mail.gmail.com>
	<CAADCt4+X79C+VW30b8MM18FasDFLZtjQacWm=HkBAA-EXAq80g@mail.gmail.com>
	<CAF3hT9C+TxK01DbwdMBhZX7vKJr3Jaheg1t-G4hWM_gNvdb_Qg@mail.gmail.com>
	<CAADCt4+u87=Bhukqs5EX6uyzXCL+ug0=_M6DDLQ6oSh1acmTsw@mail.gmail.com>
	<CAF3hT9CuXn4p8ZE752RmM1E+ua14QNBb_WaN9OZZSU2SPtfdEw@mail.gmail.com>
	<CAADCt4KTKnFKXBC6VG9nZ_M8_265-qXeHQXVnQD2rjQNVOjZ7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64384 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab2AWSrx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2012 13:47:53 -0500
Received: by ggnb1 with SMTP id b1so1512528ggn.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2012 10:47:52 -0800 (PST)
In-Reply-To: <CAADCt4KTKnFKXBC6VG9nZ_M8_265-qXeHQXVnQD2rjQNVOjZ7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 19, 2012 at 12:36 PM, Andrey Stepachev <octo47@gmail.com> w=
rote:
> 2012/1/19 Gregory Farnum <gregory.farnum@dreamhost.com>:
>> On Thu, Jan 19, 2012 at 12:53 AM, Andrey Stepachev <octo47@gmail.com=
> wrote:
>>> 2012/1/19 Gregory Farnum <gregory.farnum@dreamhost.com>:
>>>> On Wednesday, January 18, 2012, Andrey Stepachev <octo47@gmail.com=
> wrote:
>>>>> 2012/1/19 Gregory Farnum <gregory.farnum@dreamhost.com>:
>>>>>> On Wed, Jan 18, 2012 at 12:48 PM, Andrey Stepachev <octo47@gmail=
=2Ecom>
>>>>>> wrote:
>>>>>>> But still don't know what happens with ceph, so it can't
>>>>>>> respond and hang. It is not a good behavior, because
>>>>>>> such situation leads to unresponsible cluster in case of
>>>>>>> temporal network failure.
>>>>>>
>>>>>> I'm a little concerned about this =97=A0I would expect to see ha=
ngs of up
>>>>>> to ~30 seconds (the timeout period), but for operations to then
>>>>>> continue. Are you putting the MDS down? If so, do you have any
>>>>>> standbys specified?
>>>>>
>>>>> Yes, MDS goes down (I restart it at some point, while changing so=
mething
>>>>> in config).
>>>>> Yes, i have 2 standbys.
>>>>> Clients hang more then 10 minutes.
>>>>
>>>> Okay, so it's probably an issue with the MDS not entering recovery=
 when it
>>>> should. Are you also taking down one of the monitor nodes? There's=
 a known
>>>> bug which can cause a standby MDS to wait up to 15 minutes if its =
monitor
>>>> goes down which is fixed in latest master (and maybe .40; I'd have=
 to
>>>> check).
>>>
>>> Yes. I have collocated mon mds and osd on some nodes.
>>> And restart all daemons at once. I use 0.40. (built from my github =
fork).
>>
>> Hrm. I checked and the fix is in 0.40. Can you reproduce this with
>> client logging enabled (--debug_ms 1 --debug_client 10) and post the
>> logs somewhere for me to check out? That should be able to isolate t=
he
>> problem area at least.
>
> Client writes "renew caps" and nothing more.
> I'd try to reproduce problem with more logging, but still no luck.
> May be debug serializes race somewhere and prevents
> this bug to occur.

Any updates on this? "renew caps" being the last thing in the log
doesn't actually mean much, unfortunately. We're going to need logs of
some description in order to give you any more help.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
