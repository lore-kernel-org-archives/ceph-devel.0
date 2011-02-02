From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: rbd layering
Date: Tue, 1 Feb 2011 23:24:51 -0800
Message-ID: <AANLkTimeL7W-1uz3m2HOJn-b-kGkLDBnOFYdhx56uFM3@mail.gmail.com>
References: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
	<AANLkTikk_pm2JHQy5+sqSPK_vi-NYaxhUSr=YNYsUSw=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54556 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab1BBHYx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Feb 2011 02:24:53 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3A676C067
	for <ceph-devel@vger.kernel.org>; Tue,  1 Feb 2011 23:24:53 -0800 (PST)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id DAD98C064
	for <ceph-devel@vger.kernel.org>; Tue,  1 Feb 2011 23:24:52 -0800 (PST)
Received: by ewy5 with SMTP id 5so3600243ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 23:24:51 -0800 (PST)
In-Reply-To: <AANLkTikk_pm2JHQy5+sqSPK_vi-NYaxhUSr=YNYsUSw=@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Feb 1, 2011 at 11:13 PM, Colin McCabe <cmccabe@alumni.cmu.edu> =
wrote:
> On Mon, Jan 31, 2011 at 10:08 PM, Sage Weil <sage@newdream.net> wrote=
:
>> One idea we've talked a fair bit about is layering RBD images. =A0Th=
e idea
>> would be to create a new image in O(1) time that mirrors on old imag=
e and
>> get copy-on-write type semantics, like a writeable snapshot.
>>
>> We've come up with a few different approaches for doing this, each w=
ith
>> somewhat different performance characteristics. =A0The main consider=
ation is
>> that RBD images do not (currently) have an "allocation table." =A0Im=
age data
>> is simply striped over objects (that may or may not exist). =A0You r=
ead the
>> object for a given block to see if it exists; if it doesn't (a "hole=
"),
>> the content is defined to be zero-filled.
>
> Have we thought about the hash table based approach yet? Where every
> block gets hashed and we only store one copy for each? I guess this i=
s
> basically how git works, except instead of fixed-size blocks, it
> tracks variable-sized blobs. This is also how ZFS dedupe works.
>
> The nice thing about the hash table based approach is that you don't
> have to track parent-child relationships explicitly. If two users
> happen to both install Centos 5.5 with the same settings on the same
> sized-image, they'll both be deduped automatically.
How would you place the blocks in a CAS-based block device like this?
An allocation table might feel ugly, but when you're doing
cluster-wide block sharing you're going to need the extra metadata
somewhere. Better to store an allocation table than try and maintain
the coherency required for dynamic de-dup like that.

I guess I should say that de-dup would be a nice feature to support,
but I don't think it's appropriate to implement as part of RBD.
Anything that powerful needs to be a core RADOS feature.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
