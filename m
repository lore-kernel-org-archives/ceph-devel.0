From: Gregory Farnum <greg@inktank.com>
Subject: Re: Crash and strange things on MDS
Date: Wed, 13 Feb 2013 10:19:36 -0800
Message-ID: <CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
References: <20130204180154.GO3286@kdecherf.com>
	<20130211130518.GN6997@kdecherf.com>
	<CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
	<20130211185424.GA27669@kdecherf.com>
	<CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
	<20130213114750.GC7399@kdecherf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:63863 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934440Ab3BMSTi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 13:19:38 -0500
Received: by mail-qe0-f46.google.com with SMTP id 1so677959qec.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 10:19:36 -0800 (PST)
In-Reply-To: <20130213114750.GC7399@kdecherf.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Decherf <kevin@kdecherf.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Wed, Feb 13, 2013 at 3:47 AM, Kevin Decherf <kevin@kdecherf.com> wro=
te:
> On Mon, Feb 11, 2013 at 12:25:59PM -0800, Gregory Farnum wrote:
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
> I set mds cache size to 400000 but now I observe ~900Mbps peaks from
> osd.14 to the active mds, osd.18 and osd.2.
>
> osd.14 shares some pg with osd.18 and osd.2:
> http://pastebin.com/raw.php?i=3DuBAcTcu4

The high bandwidth from OSD to MDS really isn't a concern =97 that's th=
e
MDS asking for data and getting it back quickly! We're concerned about
client responsiveness; has that gotten better?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
