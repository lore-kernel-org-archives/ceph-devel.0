From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Assert in OSDMap::Incremental::decode with recent git
Date: Tue, 15 Nov 2011 11:44:11 -0800
Message-ID: <CAF3hT9C+K_mDmL_W3RzLhjxZHn2JsNQUzmTxsda3+pnbytFPRg@mail.gmail.com>
References: <20111115113747.GA32287@rcn.com>
	<20111115115544.GA1557@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45703 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327Ab1KOToM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2011 14:44:12 -0500
Received: by yenq3 with SMTP id q3so1020528yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Nov 2011 11:44:12 -0800 (PST)
In-Reply-To: <20111115115544.GA1557@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Pieper <jjp@pobox.com>, Christoph Hellwig <hch@infradead.org>

On Tue, Nov 15, 2011 at 3:55 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
> On Tue, Nov 15, 2011 at 06:37:47AM -0500, Josh Pieper wrote:
>> Hello,
>>
>> I was trying to test http://tracker.newdream.net/issues/1708, but in
>> the process of attempting to do so, keep getting asserts in one of m=
y
>> monitors.
>>
>> Pretty much all I have done is bring up a simple 3 node cluster, eac=
h
>> with a mon, osd, and mds. =A0All are using amd64 ubuntu 11.10, with =
git
>> 2e195500. =A0Once the cluster is up, I have a rbd load applied which=
 is
>> a single VM reading large files. =A0Three times now, I have gotten t=
he
>> same assert out of mon, inlined below.
>
> I hit the same when trying to bring up a test cluster on a single
> physical machine. =A0As soon as moved to vstart.sh I couldn't reprodu=
ce
> it anymore.

Hmm, interesting that it doesn't happen on vstart, since that's
supposed to use the new mon bootstrapping pieces as well.

Josh, can you turn up monitor debugging and send me the log/post it
somewhere? Presumably the big refactor Sage referred to broke
something here.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
