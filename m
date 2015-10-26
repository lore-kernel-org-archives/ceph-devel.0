From: Kjetil Babington <babingto@gmail.com>
Subject: Re: Ceph erasure coding
Date: Mon, 26 Oct 2015 19:34:05 +0100
Message-ID: <CA+nGFBo2=i_ez_KkLchGQPeShuOevy0A20eu0=+HxjMeoce1xw@mail.gmail.com>
References: <CA+nGFBodcEq0vOvuFP1Od0zVCyk_9PufsRSYBJYi1W4p_vh+7g@mail.gmail.com>
	<562915FC.9090401@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37945 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbbJZSeH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Oct 2015 14:34:07 -0400
Received: by wicll6 with SMTP id ll6so127844801wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2015 11:34:05 -0700 (PDT)
In-Reply-To: <562915FC.9090401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

I see, thank you for your replies. I will try to implement a
CRUSH-map, which distributes the chunks in such a way.  Do you think
there will be any performance issues with such a map, placing multiple
smaller chunks on each osd instead of one large on each?

The reason we would like to do this, is that we have developed some
new erasure codes, which we would like to test on a large-scale
storage system like Ceph. These erasure codes rely on
sub-packetization to reduce the amount of data read from each disk
when reconstructing an erasure. Since CEPH does not seem to have an
ability to read part of a chunk, we thought we could sort of bypass
this by making each chunk contain one sub-packet, and place a set of
these chunks (sub-packets) on each osd.

2015-10-22 18:59 GMT+02:00 Loic Dachary <loic@dachary.org>:
> Hi,
>
> On 22/10/2015 18:44, Kjetil Babington wrote:
>> Hi,
>>
>> I have a question about the capabilities of the erasure coding API i=
n
>> Ceph. Let's say that I have 10 data disks and 4 parity disks, is it
>> possible to create an erasure coding plugin which creates 20 data
>> chunks and 8 parity chunks, and then places two chunks on each osd?
>>
>> Or said maybe a bit simpler is it possible for two or more chunks fr=
om
>> the same encode operation to be placed on the same osd?
>
> This is more a question of creating a crush ruleset that does it. The=
 erasure code plugin encodes chunks but the crush ruleset decides where=
 they are placed.
>
> Cheers
>
>>
>> - Kjetil Babington
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
