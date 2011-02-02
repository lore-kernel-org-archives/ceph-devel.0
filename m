From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: rbd layering
Date: Tue, 1 Feb 2011 23:51:51 -0800
Message-ID: <AANLkTi=sAOdCZ7KeS2RJ89a4Fzjoy+NPvGrWEfG6b+y0@mail.gmail.com>
References: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
	<AANLkTikk_pm2JHQy5+sqSPK_vi-NYaxhUSr=YNYsUSw=@mail.gmail.com>
	<AANLkTimeL7W-1uz3m2HOJn-b-kGkLDBnOFYdhx56uFM3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61096 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab1BBHvx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Feb 2011 02:51:53 -0500
Received: by fxm20 with SMTP id 20so7720612fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 23:51:52 -0800 (PST)
In-Reply-To: <AANLkTimeL7W-1uz3m2HOJn-b-kGkLDBnOFYdhx56uFM3@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Feb 1, 2011 at 11:24 PM, Gregory Farnum <gregf@hq.newdream.net>=
 wrote:
> On Tue, Feb 1, 2011 at 11:13 PM, Colin McCabe <cmccabe@alumni.cmu.edu=
> wrote:
>> On Mon, Jan 31, 2011 at 10:08 PM, Sage Weil <sage@newdream.net> wrot=
e:
>>> One idea we've talked a fair bit about is layering RBD images. =A0T=
he idea
>>> would be to create a new image in O(1) time that mirrors on old ima=
ge and
>>> get copy-on-write type semantics, like a writeable snapshot.
>>>
>>> We've come up with a few different approaches for doing this, each =
with
>>> somewhat different performance characteristics. =A0The main conside=
ration is
>>> that RBD images do not (currently) have an "allocation table." =A0I=
mage data
>>> is simply striped over objects (that may or may not exist). =A0You =
read the
>>> object for a given block to see if it exists; if it doesn't (a "hol=
e"),
>>> the content is defined to be zero-filled.
>>
>> Have we thought about the hash table based approach yet? Where every
>> block gets hashed and we only store one copy for each? I guess this =
is
>> basically how git works, except instead of fixed-size blocks, it
>> tracks variable-sized blobs. This is also how ZFS dedupe works.
>>
>> The nice thing about the hash table based approach is that you don't
>> have to track parent-child relationships explicitly. If two users
>> happen to both install Centos 5.5 with the same settings on the same
>> sized-image, they'll both be deduped automatically.
> How would you place the blocks in a CAS-based block device like this?
> An allocation table might feel ugly, but when you're doing
> cluster-wide block sharing you're going to need the extra metadata
> somewhere. Better to store an allocation table than try and maintain
> the coherency required for dynamic de-dup like that.

You could chunk the hash table over several OSDs. Then you only need
to worry about doing atomic operations on a given hash table entry,
which will of course be protected by a single PG lock.

Yehuda is probably right though... it's not 100% clear that the
benefits outweigh the disadvantages, given that it would need an extra
lookup for every operation. In the end it's something that probably
will take some experimentation to get right.

Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
