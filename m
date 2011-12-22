From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH 0/3] ceph: fix a few problems in ceph_dir_*_complete()
Date: Thu, 22 Dec 2011 12:19:45 -0800
Message-ID: <CAF3hT9DeSS5e5Eezb9jKOQoO8SuCaq_OjmZUwugWL55HtT73ig@mail.gmail.com>
References: <1324576249.3957.105.camel@doink>
	<Pine.LNX.4.64.1112221203440.3284@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57183 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab1LVUTr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 15:19:47 -0500
Received: by ggdk6 with SMTP id k6so6498593ggd.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 12:19:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1112221203440.3284@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alex Elder <elder@dreamhost.com>, josh.durgin@dreamhost.com, ceph-devel@vger.kernel.org

On Thu, Dec 22, 2011 at 12:12 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 22 Dec 2011, Alex Elder wrote:
>> This series fixes a possible null pointer dereference in
>> ceph_dir_set_complete().
>>
>> It also fixes the ceph-private implementation of
>> __d_find_any_alias() so it takes a reference to the
>> returned dentry. =A0In addition, getting that reference
>> to the dentry requires the Linux inode lock, so ensure
>> that is taken by (duplicating and) using the locking
>> form of that function, d_find_any_alias().
>
> I pushed the first two to for-linus, and squashed the third into the =
patch
> it fixed. =A0Posting the series here. =A0Josh, can you schedule a reg=
ression
> suite run on that branch?
He's out of town until the middle of next week; don't count on him
getting testing done before the next release!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
