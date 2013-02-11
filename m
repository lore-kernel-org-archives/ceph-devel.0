From: Gregory Farnum <greg@inktank.com>
Subject: Re: Crash and strange things on MDS
Date: Mon, 11 Feb 2013 14:47:13 -0800
Message-ID: <CAPYLRzjYwD5nHdcE-p_jjzQWuPLXVfxOzW9O1d6mHKw3ig-jzw@mail.gmail.com>
References: <20130204180154.GO3286@kdecherf.com>
	<20130211130518.GN6997@kdecherf.com>
	<CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
	<20130211185424.GA27669@kdecherf.com>
	<CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
	<20130211222449.GA553@kdecherf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:63279 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817Ab3BKWrP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 17:47:15 -0500
Received: by mail-qa0-f43.google.com with SMTP id dx4so1400441qab.9
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 14:47:14 -0800 (PST)
In-Reply-To: <20130211222449.GA553@kdecherf.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Decherf <kevin@kdecherf.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Mon, Feb 11, 2013 at 2:24 PM, Kevin Decherf <kevin@kdecherf.com> wro=
te:
> On Mon, Feb 11, 2013 at 12:25:59PM -0800, Gregory Farnum wrote:
>> On Mon, Feb 4, 2013 at 10:01 AM, Kevin Decherf <kevin@kdecherf.com> =
wrote:
>> > References:
>> > [1] http://www.spinics.net/lists/ceph-devel/msg04903.html
>> > [2] ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
>> >     1: /usr/bin/ceph-mds() [0x817e82]
>> >     2: (()+0xf140) [0x7f9091d30140]
>> >     3: (MDCache::request_drop_foreign_locks(MDRequest*)+0x21) [0x5=
b9dc1]
>> >     4: (MDCache::request_drop_locks(MDRequest*)+0x19) [0x5baae9]
>> >     5: (MDCache::request_cleanup(MDRequest*)+0x60) [0x5bab70]
>> >     6: (MDCache::request_kill(MDRequest*)+0x80) [0x5bae90]
>> >     7: (Server::journal_close_session(Session*, int)+0x372) [0x549=
aa2]
>> >     8: (Server::kill_session(Session*)+0x137) [0x549c67]
>> >     9: (Server::find_idle_sessions()+0x12a6) [0x54b0d6]
>> >     10: (MDS::tick()+0x338) [0x4da928]
>> >     11: (SafeTimer::timer_thread()+0x1af) [0x78151f]
>> >     12: (SafeTimerThread::entry()+0xd) [0x782bad]
>> >     13: (()+0x7ddf) [0x7f9091d28ddf]
>> >     14: (clone()+0x6d) [0x7f90909cc24d]
>>
>> This in particular is quite odd. Do you have any logging from when
>> that happened? (Oftentimes the log can have a bunch of debugging
>> information from shortly before the crash.)
>
> Yes, there is a dump of 100,000 events for this backtrace in the link=
ed
> archive (I need 7 hours to upload it).

Can you just pastebin the last couple hundred lines? I'm mostly
interested if there's anything from the function which actually caused
the assert/segfault. Also, the log should compress well and get much
smaller!

>> On Mon, Feb 11, 2013 at 10:54 AM, Kevin Decherf <kevin@kdecherf.com>=
 wrote:
>> > Furthermore, I observe another strange thing more or less related =
to the
>> > storms.
>> >
>> > During a rsync command to write ~20G of data on Ceph and during (a=
nd
>> > after) the storm, one OSD sends a lot of data to the active MDS
>> > (400Mbps peak each 6 seconds). After a quick check, I found that w=
hen I
>> > stop osd.23, osd.14 stops its peaks.
>>
>> This is consistent with Sam's suggestion that MDS is thrashing its
>> cache, and is grabbing a directory object off of the OSDs. How large
>> are the directories you're using? If they're a significant fraction =
of
>> your cache size, it might be worth enabling the (sadly less stable)
>> directory fragmentation options, which will split them up into small=
er
>> fragments that can be independently read and written to disk.
>
> The distribution is heterogeneous: we have a folder of ~17G for 300k
> objects, another of ~2G for 150k objects and a lof of smaller directo=
ries.

Sorry, you mean 300,000 files in the single folder?
If so, that's definitely why it's behaving so badly =97 your folder is
larger than your maximum cache size settings, and so if you run an
"ls" or anything the MDS will read the whole thing off disk, then
instantly drop most of the folder from its cache. Then re-read again
for the next request to list contents, etc etc.

> Are you talking about the mds bal frag and mds bal split * settings?
> Do you have any advice about the value to use?
If you set "mds bal frag =3D true" in your config, it will split up
those very large directories into smaller fragments and behave a lot
better. This isn't quite as stable (thus the default to "off"), so if
you have the memory to just really up your cache size I'd start with
that and see if it makes your problems better. But if it doesn't,
directory fragmentation does work reasonably well and it's something
we'd be interested in bug reports for. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
