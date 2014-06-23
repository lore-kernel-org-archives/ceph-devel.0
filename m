From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: CDS G/H - bucket index sharding
Date: Mon, 23 Jun 2014 07:44:10 -0700
Message-ID: <CABBk=J-N7W8wzwj=qFxXy5i2vyJBd8HyhE1deRegntxK05-fdg@mail.gmail.com>
References: <etPan.53a78626.6f6dd9ac.11c48@scuttleair.local>
	<BLU436-SMTP6695E9BCA624ADB74EE177DF1F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:42340 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbaFWOoL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jun 2014 10:44:11 -0400
Received: by mail-vc0-f180.google.com with SMTP id im17so6007650vcb.39
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jun 2014 07:44:10 -0700 (PDT)
In-Reply-To: <BLU436-SMTP6695E9BCA624ADB74EE177DF1F0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@outlook.com>, Josh Durgin <josh.durgin@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 23, 2014 at 4:11 AM, Guang Yang <yguang11@outlook.com> wrote:
> Hello Yehuda,
> I drafted a brief summary for the status of the bucket index sharding blueprint and put it here - http://pad.ceph.com/p/GH-bucket-index-scalability, it would be nice you can take a look to see if there is anything I missed, I also posted the pull request here - https://github.com/ceph/ceph/pull/2013.

Just one note regarding the blueprint, other BI log operations will
need to use the new schema too (e.g., log trim operations).

I was thinking a bit about how to do resizing and dynamic sharding
later on. My thought was that we'd have two bucket prefixes: one for
read and delete operations, and one for read, write and delete
operations. Normally both will point at the same prefix and we'll just
access a single one. But when we're resizing we'll need to use both.
If we're listing objects we'll access both sets of shards and merge
everything). If we're creating object we'll just create it in the
second one. Removing object, we'll remove it from both.
The above description is a bit vague, and shouldn't really change what
we do now. Just that the implementation needs to maybe abstract that
bucket access decision nicely so that in the future we could implement
this easily.

Sadly I'll be off for this CDS, but I'm sure Josh, Greg, Sage, and
others will be able to help there.

Thanks,
Yehuda
