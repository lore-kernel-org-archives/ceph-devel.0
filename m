From: Samuel Just <sam.just@inktank.com>
Subject: Fwd: app design recommendations
Date: Wed, 21 Aug 2013 08:25:19 -0700
Message-ID: <CA+4uBUaBU1jBfCKrm9gDCs51VpkWUbDmmchFBs7OVULxBxhtLg@mail.gmail.com>
References: <CAHO6xe-FSmZdFTqDq56U9_QQ_hoPMnPqbFLjT1CLGETz-hCs7A@mail.gmail.com>
	<CA+4uBUa9c=n632p7XdTV_XM=3AVF6WCNoX_XCzpJOVT4YpURjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:59699 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab3HUPZU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 11:25:20 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz10so472880veb.31
        for <ceph-devel@vger.kernel.org>; Wed, 21 Aug 2013 08:25:19 -0700 (PDT)
In-Reply-To: <CA+4uBUa9c=n632p7XdTV_XM=3AVF6WCNoX_XCzpJOVT4YpURjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Looks interesting.

On Tue, Aug 20, 2013 at 1:06 PM, Nulik Nol <nuliknol@gmail.com> wrote:
> Hi,
> I am creating an email system which will handle whole company's email,
> mostly internal mail. There will be thousands of companies and
> hundreds of users per company. So I am planning to use one pool per
> company to store email messages. Can Ceph manage thousands or maybe
> hundred thousands of pools ? Could there be any slowdown at production
> with such design after some growth?

You can't have thousands of pools.  Each pool shows up in the OSDMap,
and each pool must have at least 1 pg.  However, we now have rados
level namespaces which subdivide a pool.  You can have as many
namespaces as objects if you want.  The main caveat is that you can't
efficiently list the contents of a namespace.  We do support user
capabilities on namespaces.

>
> Every email will be stored as an individual ceph object (emails will
> average 512 bytes and rarely have attachments) , is it ok to store
> them as a ceph objects or will it be less efficient than storing
> multiple emails in a ceph object,? What is the optimal ceph object
> size to store individually, so it would be preferable to do this
> instead of writing through omap with leveldb? (kind of "ceph object vs
> omap" benchmark question)

I am unsure.  Each rados object will end up as a file on the backing
filesystem, so there is some overhead there.  My first instinct for
objects of 512 bytes might be to hash the key and use part of the
hash to determine the object name and the rest to determine the omap
key.  It might be fine to do 1 email per object though.

>
> Also I will be putting mini-chat sessions between users in a ceph
> object, each time a user sends a message to another user, I will
> append the text to the ceph object, so my question is, will Ceph
> rewrite the whole object into a new physical location on disk when I
> do an append? Or will it just rewrite the block that was modified?

Appends are performed using filesystem writes, so it won't overwrite
the entire object.  Rados support partial overwrites just fine.

>
> And last questions: Which is faster, storing small key/value pairs in
> omap or in xattrs ? Will storing key/value pairs in xattrs result in
> space waste by allocating a block for zero-sized object on the OSD? (I
> won't write any data to the object, just use xattrs)

Depending on the backing filesystem, xattrs are either stored as xattrs
on the backing filesystem or as keys in leveldb (just like omap).  I
suggest you reserve xattrs for small pieces of metadata and omap for
large sets of keys.  zero sized objects are fine.

-Sam

>
> Will appreciate very much your comments.
>
> Best Regards
> Nulik
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
