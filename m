From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: ceph from poc to production
Date: Thu, 17 Jan 2013 17:34:27 +0100
Message-ID: <CAOLwVUnnxT=tBXOakUHy1xChxC6FS2HvYP5GEQ=dvs-NpMG=sQ@mail.gmail.com>
References: <50F6F471.7030108@profihost.ag> <CAOLwVU=1vjeoFBa84doczbEeJ5nAasBLE2z9YAR-oUd5+wANrw@mail.gmail.com>
 <50F82705.50502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34419 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757090Ab3AQQes convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 11:34:48 -0500
Received: by mail-la0-f41.google.com with SMTP id em20so2894969lab.14
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 08:34:47 -0800 (PST)
In-Reply-To: <50F82705.50502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Cool, I look forward to reading it!
--
Regards,
S=E9bastien Han.


On Thu, Jan 17, 2013 at 5:29 PM, Mark Nelson <mark.nelson@inktank.com> =
wrote:
> On 01/17/2013 10:24 AM, S=E9bastien Han wrote:
>>
>> Hi Stephan,
>>
>>> - Increase the osdmax value
>>
>>
>> Well actually this doesn't seem to be necessary because when you iss=
ue
>> a "ceph osd create" the osdmax value is automatically incremented. I=
t
>> just that a while ago I saw on the ML or IRC that it was a good
>> practice to do this. And this documentation
>> http://ceph.com/docs/master/rados/operations/control/ says:
>>
>> "Set the max_osd parameter in the osd map. This is necessary when
>> expanding the storage cluster."
>>
>> Maybe the doc is outdated on this option, I don't know.
>>
>>> - Set =93filestore flusher=94 option to false, in your [osd] sectio=
n
>>
>>
>> During my benchmarks sessions I noticed that disabling this option
>> brought way better performance, at least for old hardware. Fo recent
>> hardware I haven't seen any difference, but I kept the habit to
>> disable it. There are some discussions about this option on the ML. =
As
>> far as I can remember, it's harmless to disable it.
>>  From the doc here
>> http://ceph.com/docs/master/rados/configuration/filestore-config-ref=
/:
>
>
> I actually have been doing parametric sweeps over the various ceph tu=
nables
> to try to see what affects performance.  I'll have an article coming =
out
> soonish documenting some of the findings.  Typically disabling the fl=
usher
> seems to be beneficial on XFS and BTRFS, but it seems to be the oppos=
ite on
> EXT4.
>
>
>>
>> "The filestore flusher forces data from large writes to be written o=
ut
>> using sync file range before the sync in order to (hopefully) reduce
>> the cost of the eventual sync. In practice, disabling =91filestore
>> flusher=92 seems to improve performance in some cases."
>>
>> Cheers,
>>
>> --
>> Regards,
>> S=E9bastien Han.
>>
>>
>> On Wed, Jan 16, 2013 at 7:41 PM, Stefan Priebe <s.priebe@profihost.a=
g>
>> wrote:
>>>
>>>
>>> Hello Sebastien,
>>>    hello list,
>>>
>>> first nice article sebastien ;-) thanks for contributing.
>>>
>>> I've two question regarding the tips:
>>>
>>> Can somebody explain me why i should do this?:
>>> - Increase the osdmax value
>>> - Set =93filestore flusher=94 option to false, in your [osd] sectio=
n
>>>
>>> Greets,
>>> Stefan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
