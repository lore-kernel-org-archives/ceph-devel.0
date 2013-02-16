From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Crash and strange things on MDS
Date: Sat, 16 Feb 2013 11:36:09 -0600
Message-ID: <CAKMAVE8wv0gx6RYkFxVd3NCSiYDrOc0L42VeL4uq6z3fZMk52A@mail.gmail.com>
References: <20130204180154.GO3286@kdecherf.com>
	<20130211130518.GN6997@kdecherf.com>
	<CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
	<20130211185424.GA27669@kdecherf.com>
	<CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
	<20130213114750.GC7399@kdecherf.com>
	<CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
	<20130216010217.GA26823@kdecherf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:59426 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab3BPRgM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 12:36:12 -0500
Received: by mail-oa0-f44.google.com with SMTP id h1so4783309oag.3
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 09:36:10 -0800 (PST)
In-Reply-To: <20130216010217.GA26823@kdecherf.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Decherf <kevin@kdecherf.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Fri, Feb 15, 2013 at 7:02 PM, Kevin Decherf <kevin@kdecherf.com> wro=
te:
> On Wed, Feb 13, 2013 at 10:19:36AM -0800, Gregory Farnum wrote:
>> On Wed, Feb 13, 2013 at 3:47 AM, Kevin Decherf <kevin@kdecherf.com> =
wrote:
>> > On Mon, Feb 11, 2013 at 12:25:59PM -0800, Gregory Farnum wrote:
>> >> On Mon, Feb 11, 2013 at 10:54 AM, Kevin Decherf <kevin@kdecherf.c=
om> wrote:
>> >> > Furthermore, I observe another strange thing more or less relat=
ed to the
>> >> > storms.
>> >> >
>> >> > During a rsync command to write ~20G of data on Ceph and during=
 (and
>> >> > after) the storm, one OSD sends a lot of data to the active MDS
>> >> > (400Mbps peak each 6 seconds). After a quick check, I found tha=
t when I
>> >> > stop osd.23, osd.14 stops its peaks.
>> >>
>> >> This is consistent with Sam's suggestion that MDS is thrashing it=
s
>> >> cache, and is grabbing a directory object off of the OSDs. How la=
rge
>> >> are the directories you're using? If they're a significant fracti=
on of
>> >> your cache size, it might be worth enabling the (sadly less stabl=
e)
>> >> directory fragmentation options, which will split them up into sm=
aller
>> >> fragments that can be independently read and written to disk.
>> >
>> > I set mds cache size to 400000 but now I observe ~900Mbps peaks fr=
om
>> > osd.14 to the active mds, osd.18 and osd.2.
>> >
>> > osd.14 shares some pg with osd.18 and osd.2:
>> > http://pastebin.com/raw.php?i=3DuBAcTcu4
>>
>> The high bandwidth from OSD to MDS really isn't a concern =97 that's=
 the
>> MDS asking for data and getting it back quickly! We're concerned abo=
ut
>> client responsiveness; has that gotten better?
>
> It seems better now, I didn't see any storm so far.
>
> But we observe high latency on some of our clients (with no load). Do=
es
> it exist any documentation on how to read the perfcounters_dump outpu=
t?
> I would like to know if the MDS still has any problem with its cache =
or
> if the latency comes from elsewhere.

You can use perfcounters_schema to get the output format in json,
using something like json_pp to make it somewhat readable for a human.
 You can post the dump output as well and we can try to help you
parse/understand what its telling you.
-sam

>
> --
> Kevin Decherf - @Kdecherf
> GPG C610 FE73 E706 F968 612B E4B2 108A BD75 A81E 6E2F
> http://kdecherf.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
