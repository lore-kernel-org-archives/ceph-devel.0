From: Gregory Farnum <greg@inktank.com>
Subject: Re: crc32 for erasure code
Date: Mon, 23 Sep 2013 10:14:51 -0700
Message-ID: <CAPYLRzhdHbVp-ySAjShM+4PqAmRp+xBPNg=TdW3KcMMH+qEXfg@mail.gmail.com>
References: <523FFD1B.4030801@dachary.org>
	<CAPYLRzib=_3JdtZdrAr0xHbAXCcR--ZJHX1cMR1oRvADBwpCWA@mail.gmail.com>
	<52407607.7040307@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:48138 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab3IWROw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 13:14:52 -0400
Received: by mail-wg0-f45.google.com with SMTP id y10so3462309wgg.24
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 10:14:51 -0700 (PDT)
In-Reply-To: <52407607.7040307@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Sep 23, 2013 at 10:10 AM, Loic Dachary <loic@dachary.org> wrote=
:
>
>
> On 23/09/2013 18:59, Gregory Farnum wrote:
>> On Mon, Sep 23, 2013 at 1:34 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi,
>>>
>>> Unless I'm mistaken, ceph_crc32() is currently used in master via t=
he crc32c() method of bufferlist to:
>>>
>>> * encode_with_checksum/decode_with_checksum a PGLog entry
>>> * Message::decode_message/Message::encode_message a message via cal=
c_*_crc
>>> * FileJournal::do_read_entry/FileJournal::prepare_single_write a jo=
urnal entry
>>> * for information in the report monitory command ( Monitor.cc )
>>>
>>> Erasure coded chunks ( i.e. files ) will need checksums. Should thi=
s be implemented as an optional feature in ceph/src/os/FileStore.{h,cc}=
 ? If the underlying filesystem does not provide this feature, FileStor=
e would call ceph_crc32 each time the object is modified. A verificatio=
n method would be exposed and used when scrubbing erasure coded pools.
>>
>> You mean should checksums be optional in the FileStore, or should we
>> provide a plugin framework for using things other than crc32, or...?
>> :)
>
> Not really. I was under the impression that crc32 is good enough. I'm=
 not sure where ( in the code path ) it should be used for erasure code=
d pools. In the FileStore ? Or in the erasure code PG to set an attribu=
te of the object ? The FileStore seems to be more sensible but ... I'm =
not sure hence the mail ;-)

Ah, I see. We currently use the CRC in two different ways:
1) For local and network checksums, making sure that what we read is
what was written =97 this is used in writing journal entries, and in
sending a message over the network, and lets us check for bit flips,
etc.
2) For comparing two different copies of any object during scrubbing
without shipping the whole object.

The first of these uses doesn't need any changing for erasure-coded
pools, which I believe means we don't need to change any of the
functions you've mentioned. However, we will need to do something else
for the second use case. Luckily we've already started that as it's in
the scrub code and part of the functionality split that's already
under way. :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
