From: Gregory Farnum <greg@inktank.com>
Subject: Re: Help...MDS Continuously Segfaulting
Date: Sat, 3 Nov 2012 18:45:00 +0100
Message-ID: <CAPYLRzhLuhEfV+z_KAyM2axRA+ejRURtzh7fZMf1d3sEmHvQjg@mail.gmail.com>
References: <508EE58E02000099000EDE3D@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:36713 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab2KCRpA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 13:45:00 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so3375235iag.19
        for <ceph-devel@vger.kernel.org>; Sat, 03 Nov 2012 10:45:00 -0700 (PDT)
In-Reply-To: <508EE58E02000099000EDE3D@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage merged it into master, so whatever you like. If you remove the
patch and the error happens again, your MDS will fail on replay as it
did here. If you leave it in, it has no effect other than handling
that particular bad case.
-Greg

On Tue, Oct 30, 2012 at 3:22 AM, Nick Couchman <Nick.Couchman@seakr.com> wrote:
> Okay, that patch worked and it seems to be running, again.  Should I continue to run with that patch, or go back to the original binaries?
>
>>>> Gregory Farnum  10/19/12 4:16 PM >>>
> I've written a small patch on top of v0.48.1argonaut which should
> avoid this. It's in branch 3369-mds-session-workaround and will simply
> log an error in the monitor central log instead of segfaulting. There
> should shortly be packages available at
> http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/3369-mds-session-workaround/
> (for Precise amd64; or elsewhere if you're on a different platform?).
> -Greg
>
> On Fri, Oct 19, 2012 at 1:52 PM, Nick Couchman  wrote:
>> One of the MDSs crashed over the weekend (late Friday night), but I believe that one was not active and was just in Replay mode.  Other than that, I don't know of anything that would have affected the MDSs.
>>
>> -Nick
>>
>>>>> On 2012/10/18 at 16:55, Gregory Farnum  wrote:
>>> Okay, looked at this a little bit. Can you describe what was happening
>>> before you got into this failed-replay loop? (So, why was it in replay
>>> at all?) I see that the monitor marked it as laggy for some reason;
>>> was the cluster under load; did the monitors break; something else?
>>> I can see why it's failed here and I think I can do a simple code
>>> patch to work around it, but the root cause is something that happened
>>> while the MDS was still alive.
>>>
>>> Basic technical content:
>>> The MDS journals all open client sessions. It brings them back into
>>> memory during replay, and then operates on them to do things like open
>>> new sessions or close ones that it turns out not to need. Your log
>>> contains two close events for the same client session, and it's
>>> causing a big freak out. This actually feels somewhat familiar; I'll
>>> talk about it with our team here and get back to you tomorrow
>>> sometime.
>>> -Greg
>>>
>>> On Thu, Oct 18, 2012 at 8:56 AM, Nick Couchman
>>> wrote:
>>>> Hopefully this is what you're looking for...
>>>> (gdb) bt
>>>> #0  ESession::replay (this=0x7fffcc49a7c0, mds=0x127d5f0) at
>>> mds/journal.cc:828
>>>> #1  0x00000000006a2446 in MDLog::_replay_thread (this=0x1281390) at
>>> mds/MDLog.cc:580
>>>> #2  0x00000000004cf5ed in MDLog::ReplayThread::entry (this=) at
>>> mds/MDLog.h:86
>>>> #3  0x00007ffff764df05 in start_thread () from /lib64/libpthread.so.0
>>>> #4  0x00007ffff680d10d in clone () from /lib64/libc.so.6
>>>>
>>>>>>> On 2012/10/17 at 09:53, Sam Lang  wrote:
>>>>> On 10/17/2012 09:42 AM, Nick Couchman wrote:
>>>>>> Thanks...here's the backtrace:
>>>>>> (gdb) bt
>>>>>> #0  0x00000000004dcfea in ESession::replay(MDS*) ()
>>>>>> #1  0x00000000006a2446 in MDLog::_replay_thread() ()
>>>>>> #2  0x00000000004cf5ed in MDLog::ReplayThread::entry() ()
>>>>>> #3  0x00007ffff764df05 in start_thread () from /lib64/libpthread.so.0
>>>>>> #4  0x00007ffff680d10d in clone () from /lib64/libc.so.6
>>>>>
>>>>> Hi Nick,
>>>>>
>>>>> This doesn't have the debug symbols (line numbers in the source) we were
>>>>> hoping for.  Could you install the ceph-dpg package and rerun?  You will
>>>>> probably have to first uninstall the ceph package.
>>>>>
>>>>> Thanks,
>>>>> -sam
>>>>>
>>>>>>
>>>>>>>>> On 2012/10/17 at 07:34, Sam Lang  wrote:
>>>>>>> On 10/16/2012 06:04 PM, Gregory Farnum wrote:
>>>>>>>> Okay, that's the right debugging but it wasn't quite as helpful on its
>>>>>>>> own as I expected. Can you get a core dump (you might already have
>>>>>>>> one, depending on system settings) of the crash and open it up with
>>>>>>>> gdb and get a full backtrace?
>>>>>>>
>>>>>>> You can also run the mds directly in gdb and avoid any core file ulimit
>>>>>>> settings you have set:
>>>>>>>
>>>>>>>   > gdb --args ceph-mds -n mds.b -c /etc/ceph/ceph.conf -f
>>>>>>> ...
>>>>>>> (gdb) run
>>>>>>>
>>>>>>> Once you hit the segfault you can get the backtrace with:
>>>>>>>
>>>>>>> (gdb) bt
>>>>>>>
>>>>>>> -sam
>>>>>>>
>>>>>>>
>>>>>>>> -Greg
>>>>>>>>
>>>>>>>> On Mon, Oct 15, 2012 at 10:59 AM, Nick Couchman
>>>>>>> wrote:
>>>>>>>>> Well, hopefully this is still okay...8.5MB bzip2d, 230MB unzipped.
>>>>>>>>>
>>>>>>>>> -Nick
>>>>>>>>>
>>>>>>>>>>>> On 2012/10/15 at 11:47, Gregory Farnum  wrote:
>>>>>>>>>> Yeah, zip it and post * somebody's going to have to download it and
>>>>>>>>> do
>>>>>>>>>> fun things. :)
>>>>>>>>>> -Greg
>>>>>>>>>>
>>>>>>>>>> On Mon, Oct 15, 2012 at 10:43 AM, Nick Couchman
>>>>>>>>>
>>>>>>>>>> wrote:
>>>>>>>>>>> Anywhere in particular I should make it available?  It's a little
>>>>>>>>> over a
>>>>>>>>>> million lines of debug in the file - I can put it on a pastebin, if
>>>>>>>>> that
>>>>>>>>>> works, or perhaps zip it up and throw it somewhere?
>>>>>>>>>>>
>>>>>>>>>>> -Nick
>>>>>>>>>>>
>>>>>>>>>>>>>> On 2012/10/15 at 11:26, Gregory Farnum  wrote:
>>>>>>>>>>>> Something in the MDS log is bad or is poking at a bug in the code.
>>>>>>>>> Can
>>>>>>>>>>>> you turn on MDS debugging and restart a daemon and put that log
>>>>>>>>>>>> somewhere accessible?
>>>>>>>>>>>> debug mds = 20
>>>>>>>>>>>> debug journaler = 20
>>>>>>>>>>>> debug ms = 1
>>>>>>>>>>>> -Greg
>>>>>>>>>>>>
>>>>>>>>>>>> On Mon, Oct 15, 2012 at 10:02 AM, Nick Couchman
>>>>>>>>>
>>>>>>>>>>>> wrote:
>>>>>>>>>>>>> Well, both of my MDSs seem to be down right now, and then
>>>>>>>>> continually
>>>>>>>>>>>> segfault (every time I try to start them) with the following:
>>>>>>>>>>>>>
>>>>>>>>>>>>> ceph-mdsmon-a:~ # ceph-mds -n mds.b -c /etc/ceph/ceph.conf -f
>>>>>>>>>>>>> starting mds.b at :/0
>>>>>>>>>>>>> *** Caught signal (Segmentation fault) **
>>>>>>>>>>>>>    in thread 7fbe0d61d700
>>>>>>>>>>>>>    ceph version 0.48.1argonaut
>>>>>>>>>>>> (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
>>>>>>>>>>>>>    1: ceph-mds() [0x7ef83a]
>>>>>>>>>>>>>    2: (()+0xfd00) [0x7fbe15a0cd00]
>>>>>>>>>>>>>    3: (ESession::replay(MDS*)+0x3ea) [0x4dcfea]
>>>>>>>>>>>>>    4: (MDLog::_replay_thread()+0x6b6) [0x6a2446]
>>>>>>>>>>>>>    5: (MDLog::ReplayThread::entry()+0xd) [0x4cf5ed]
>>>>>>>>>>>>>    6: (()+0x7f05) [0x7fbe15a04f05]
>>>>>>>>>>>>>    7: (clone()+0x6d) [0x7fbe14bc410d]
>>>>>>>>>>>>> 2012-10-15 10:57:35.449161 7fbe0d61d700 -1 *** Caught signal
>>>>>>>>> (Segmentation
>>>>>>>>>>>> fault) **
>>>>>>>>>>>>>    in thread 7fbe0d61d700
>>>>>>>>>>>>>
>>>>>>>>>>>>>    ceph version 0.48.1argonaut
>>>>>>>>>>>> (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
>>>>>>>>>>>>>    1: ceph-mds() [0x7ef83a]
>>>>>>>>>>>>>    2: (()+0xfd00) [0x7fbe15a0cd00]
>>>>>>>>>>>>>    3: (ESession::replay(MDS*)+0x3ea) [0x4dcfea]
>>>>>>>>>>>>>    4: (MDLog::_replay_thread()+0x6b6) [0x6a2446]
>>>>>>>>>>>>>    5: (MDLog::ReplayThread::entry()+0xd) [0x4cf5ed]
>>>>>>>>>>>>>    6: (()+0x7f05) [0x7fbe15a04f05]
>>>>>>>>>>>>>    7: (clone()+0x6d) [0x7fbe14bc410d]
>>>>>>>>>>>>>    NOTE: a copy of the executable, or `objdump -rdS ` is
>>>>>>>>> needed to
>>>>>>>>>>>> interpret this.
>>>>>>>>>>>>>
>>>>>>>>>>>>>        0> 2012-10-15 10:57:35.449161 7fbe0d61d700 -1 *** Caught
>>>>>>>>> signal
>>>>>>>>>>>> (Segmentation fault) **
>>>>>>>>>>>>>    in thread 7fbe0d61d700
>>>>>>>>>>>>>
>>>>>>>>>>>>>    ceph version 0.48.1argonaut
>>>>>>>>>>>> (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
>>>>>>>>>>>>>    1: ceph-mds() [0x7ef83a]
>>>>>>>>>>>>>    2: (()+0xfd00) [0x7fbe15a0cd00]
>>>>>>>>>>>>>    3: (ESession::replay(MDS*)+0x3ea) [0x4dcfea]
>>>>>>>>>>>>>    4: (MDLog::_replay_thread()+0x6b6) [0x6a2446]
>>>>>>>>>>>>>    5: (MDLog::ReplayThread::entry()+0xd) [0x4cf5ed]
>>>>>>>>>>>>>    6: (()+0x7f05) [0x7fbe15a04f05]
>>>>>>>>>>>>>    7: (clone()+0x6d) [0x7fbe14bc410d]
>>>>>>>>>>>>>    NOTE: a copy of the executable, or `objdump -rdS ` is
>>>>>>>>> needed to
>>>>>>>>>>>> interpret this.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Segmentation fault
>>>>>>>>>>>>>
>>>>>>>>>>>>> Anyone have any hints on recovering?  I'm running 0.48.1argonaut -
>>>>>>>>> I can
>>>>>>>>>>>> attempt to upgrade to 0.48.2 and see if that helps, but I figured
>>>>>>>>> if anyone
>>>>>>>>>>>> can offer any insight as to what to do to get the replay to run
>>>>>>>>> without
>>>>>>>>>>>> segfaulting?
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> --------
>>>>>>>>>>>>> This e-mail may contain confidential and privileged material for
>>>>>>>>> the sole use
>>>>>>>>>>>> of the intended recipient.  If this email is not intended for you,
>>>>>>>>> or you
>>>>>>>>>> are
>>>>>>>>>>>> not responsible for the delivery of this message to the intended
>>>>>>>>> recipient,
>>>>>>>>>>>> please note that this message may contain SEAKR Engineering
>>>>>>>>> (SEAKR)
>>>>>>>>>>>> Privileged/Proprietary Information.  In such a case, you are
>>>>>>>>> strictly
>>>>>>>>>>>> prohibited from downloading, photocopying, distributing or
>>>>>>>>> otherwise using
>>>>>>>>>>>> this message, its contents or attachments in any way.  If you have
>>>>>>>>> received
>>>>>>>>>>>> this message in error, please notify us immediately by replying to
>>>>>>>>> this
>>>>>>>>>> e-mail
>>>>>>>>>>>> and delete the message from your mailbox.  Information contained in
>>>>>>>>> this
>>>>>>>>>>>> message that does not relate to the business of SEAKR is neither
>>>>>>>>> endorsed by
>>>>>>>>>>>> nor attributable to SEAKR.
>>>>>>>>>>>>> --
>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>> ceph-devel" in
>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>> More majordomo info at
>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> --------
>>>>>>>>>>>
>>>>>>>>>>> This e-mail may contain confidential and privileged material for the
>>>>>>>>> sole use
>>>>>>>>>> of the intended recipient.  If this email is not intended for you, or
>>>>>>>>> you are
>>>>>>>>>> not responsible for the delivery of this message to the intended
>>>>>>>>> recipient,
>>>>>>>>>> please note that this message may contain SEAKR Engineering (SEAKR)
>>>>>>>>>> Privileged/Proprietary Information.  In such a case, you are strictly
>>>>>>>>>
>>>>>>>>>> prohibited from downloading, photocopying, distributing or otherwise
>>>>>>>>> using
>>>>>>>>>> this message, its contents or attachments in any way.  If you have
>>>>>>>>> received
>>>>>>>>>> this message in error, please notify us immediately by replying to
>>>>>>>>> this e-mail
>>>>>>>>>> and delete the message from your mailbox.  Information contained in
>>>>>>>>> this
>>>>>>>>>> message that does not relate to the business of SEAKR is neither
>>>>>>>>> endorsed by
>>>>>>>>>> nor attributable to SEAKR.
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>>>>> in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> --------
>>>>>>>>> This e-mail may contain confidential and privileged material for the sole use
>>>>>>> of the intended recipient.  If this email is not intended for you, or you
>>>>> are
>>>>>>> not responsible for the delivery of this message to the intended recipient,
>>>>>>> please note that this message may contain SEAKR Engineering (SEAKR)
>>>>>>> Privileged/Proprietary Information.  In such a case, you are strictly
>>>>>>> prohibited from downloading, photocopying, distributing or otherwise using
>>>>>>> this message, its contents or attachments in any way.  If you have received
>>>>>>> this message in error, please notify us immediately by replying to this
>>>>> e-mail
>>>>>>> and delete the message from your mailbox.  Information contained in this
>>>>>>> message that does not relate to the business of SEAKR is neither endorsed by
>>>>>>> nor attributable to SEAKR.
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> --------
>>>>>> This e-mail may contain confidential and privileged material for the sole use
>>>>> of the intended recipient.  If this email is not intended for you, or you
>>> are
>>>>> not responsible for the delivery of this message to the intended recipient,
>>>>> please note that this message may contain SEAKR Engineering (SEAKR)
>>>>> Privileged/Proprietary Information.  In such a case, you are strictly
>>>>> prohibited from downloading, photocopying, distributing or otherwise using
>>>>> this message, its contents or attachments in any way.  If you have received
>>>>> this message in error, please notify us immediately by replying to this
>>> e-mail
>>>>> and delete the message from your mailbox.  Information contained in this
>>>>> message that does not relate to the business of SEAKR is neither endorsed by
>>>>> nor attributable to SEAKR.
>>>>>>
>>>>
>>>>
>>>>
>>>> --------
>>>>
>>>> This e-mail may contain confidential and privileged material for the sole use
>>> of the intended recipient.  If this email is not intended for you, or you are
>>> not responsible for the delivery of this message to the intended recipient,
>>> please note that this message may contain SEAKR Engineering (SEAKR)
>>> Privileged/Proprietary Information.  In such a case, you are strictly
>>> prohibited from downloading, photocopying, distributing or otherwise using
>>> this message, its contents or attachments in any way.  If you have received
>>> this message in error, please notify us immediately by replying to this e-mail
>>> and delete the message from your mailbox.  Information contained in this
>>> message that does not relate to the business of SEAKR is neither endorsed by
>>> nor attributable to SEAKR.
>>
>>
>>
>> --------
>>
>> This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
>
>
>
> --------
>
> This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
