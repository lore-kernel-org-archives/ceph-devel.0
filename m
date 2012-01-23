From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: How to remove lost objects.
Date: Tue, 24 Jan 2012 02:48:37 +0400
Message-ID: <CAADCt4LXAeEd=-sc+J8MeMYpP++mDt_iK-DZ2kX+fmbsXSib5A@mail.gmail.com>
References: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
 <CAADCt4+BL6mdrQ5XyMwdNjOMQeBh-aUAxp_8ohR-AeZ4Xd8SOA@mail.gmail.com>
 <CAF3hT9D2yFqt5EKYFce_jmTdjFC_7V9LR-er+F_KuJJ3dyunSA@mail.gmail.com>
 <CAADCt4+X79C+VW30b8MM18FasDFLZtjQacWm=HkBAA-EXAq80g@mail.gmail.com>
 <CAF3hT9C+TxK01DbwdMBhZX7vKJr3Jaheg1t-G4hWM_gNvdb_Qg@mail.gmail.com>
 <CAADCt4+u87=Bhukqs5EX6uyzXCL+ug0=_M6DDLQ6oSh1acmTsw@mail.gmail.com>
 <CAF3hT9CuXn4p8ZE752RmM1E+ua14QNBb_WaN9OZZSU2SPtfdEw@mail.gmail.com>
 <CAADCt4KTKnFKXBC6VG9nZ_M8_265-qXeHQXVnQD2rjQNVOjZ7g@mail.gmail.com> <CAF3hT9DCs9RH-GA6Otu6CPL5tPoAD3VfwuGHWRV6VDO-Y=Sq6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40754 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab2AWWs6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2012 17:48:58 -0500
Received: by wics10 with SMTP id s10so2540777wic.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2012 14:48:57 -0800 (PST)
In-Reply-To: <CAF3hT9DCs9RH-GA6Otu6CPL5tPoAD3VfwuGHWRV6VDO-Y=Sq6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2012/1/23 Gregory Farnum <gregory.farnum@dreamhost.com>:
> On Thu, Jan 19, 2012 at 12:36 PM, Andrey Stepachev <octo47@gmail.com>=
 wrote:
>> 2012/1/19 Gregory Farnum <gregory.farnum@dreamhost.com>:
>>> On Thu, Jan 19, 2012 at 12:53 AM, Andrey Stepachev <octo47@gmail.co=
m> wrote:
>>>> 2012/1/19 Gregory Farnum <gregory.farnum@dreamhost.com>:
>>>>> On Wednesday, January 18, 2012, Andrey Stepachev <octo47@gmail.co=
m> wrote:
>>>>>> 2012/1/19 Gregory Farnum <gregory.farnum@dreamhost.com>:
>>>>>>> On Wed, Jan 18, 2012 at 12:48 PM, Andrey Stepachev <octo47@gmai=
l.com>
>>>>>>> wrote:
>>>>>>>> But still don't know what happens with ceph, so it can't
>>>>>>>> respond and hang. It is not a good behavior, because
>>>>>>>> such situation leads to unresponsible cluster in case of
>>>>>>>> temporal network failure.
>>>>>>>
>>>>>>> I'm a little concerned about this =E2=80=94=C2=A0I would expect=
 to see hangs of up
>>>>>>> to ~30 seconds (the timeout period), but for operations to then
>>>>>>> continue. Are you putting the MDS down? If so, do you have any
>>>>>>> standbys specified?
>>>>>>
>>>>>> Yes, MDS goes down (I restart it at some point, while changing s=
omething
>>>>>> in config).
>>>>>> Yes, i have 2 standbys.
>>>>>> Clients hang more then 10 minutes.
>>>>>
>>>>> Okay, so it's probably an issue with the MDS not entering recover=
y when it
>>>>> should. Are you also taking down one of the monitor nodes? There'=
s a known
>>>>> bug which can cause a standby MDS to wait up to 15 minutes if its=
 monitor
>>>>> goes down which is fixed in latest master (and maybe .40; I'd hav=
e to
>>>>> check).
>>>>
>>>> Yes. I have collocated mon mds and osd on some nodes.
>>>> And restart all daemons at once. I use 0.40. (built from my github=
 fork).
>>>
>>> Hrm. I checked and the fix is in 0.40. Can you reproduce this with
>>> client logging enabled (--debug_ms 1 --debug_client 10) and post th=
e
>>> logs somewhere for me to check out? That should be able to isolate =
the
>>> problem area at least.
>>
>> Client writes "renew caps" and nothing more.
>> I'd try to reproduce problem with more logging, but still no luck.
>> May be debug serializes race somewhere and prevents
>> this bug to occur.
>
> Any updates on this? "renew caps" being the last thing in the log
> doesn't actually mean much, unfortunately. We're going to need logs o=
f
> some description in order to give you any more help.

I've been switched to other urgent task now, so in a week or two
i'll return back to ceph and try to reproduce this hangouts to find out
what is going on.


> -Greg



--=20
Andrey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
