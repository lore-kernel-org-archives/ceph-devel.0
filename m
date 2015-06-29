From: Gregory Farnum <greg@gregs42.com>
Subject: Re: What is omap
Date: Mon, 29 Jun 2015 11:44:24 +0100
Message-ID: <CAC6JEv8KDoTPPMxVHK=UZh6zMOZHBAub=rVa=JcFd5fQSMgiZw@mail.gmail.com>
References: <20150624234728.79c29b49@guren.zaitcev.lan>
	<CAJY_B6RCA+3s3r+7B=s8pYomrrnTscSsd77PSL8QsJFbeOG6jQ@mail.gmail.com>
	<20150626130222.42af4404@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:32806 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbbF2Ko1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 06:44:27 -0400
Received: by laar3 with SMTP id r3so58261178laa.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 03:44:26 -0700 (PDT)
Received: from mail-la0-f52.google.com (mail-la0-f52.google.com. [209.85.215.52])
        by mx.google.com with ESMTPSA id p9sm10636390laf.11.2015.06.29.03.44.25
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 03:44:25 -0700 (PDT)
Received: by laar3 with SMTP id r3so58260280laa.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 03:44:24 -0700 (PDT)
In-Reply-To: <20150626130222.42af4404@guren.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jun 26, 2015 at 8:02 PM, Pete Zaitcev <zaitcev@redhat.com> wrote:
> On Fri, 26 Jun 2015 14:48:15 +0100
> Gregory Farnum <greg@gregs42.com> wrote:
>
>> Each object consists of three different data storage areas, all of
>> which are 100% optional: the "bundle of bits" object data, the object
>> xattrs, and the object omap key-value store.
>
> Thanks for the explanation. This was unexpected. I thought an object had
> one K/V namespace associated with it, with xattrs and omap being two
> implementations of it, switcheable depending on OSD configuration.

Nope. Internally the xattrs are *sometimes* stored in leveldb,
but they're not in the omap namespace. Being in leveldb is one of the
things that has changed you shouldn't worry about; it was in response
to local filesystem limitations and we handle it without any
visibility on the client side (except occasional changes in access
latency).

>
>> Each OSD has its *own* local leveldb where all that data
>> goes; there's no cross-OSD LevelDB replication or communication.
>
> Okay, that makes sense.
>
> So, do I understand right that we don't have a document that
> explains the above? All I want to write is "the list of buckets
> is kept in omap of object such and such; see URL FOO for explanation
> of omap".

...I have no idea if there's a document about that. Probably not; we
don't have a ton of client developer documentation right now. :(
-Greg
