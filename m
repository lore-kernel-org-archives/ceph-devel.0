From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [ceph-commit] ceph.git branch master updated. v0.27.1-331-gd9ea95f
Date: Mon, 9 May 2011 16:29:30 -0700
Message-ID: <BANLkTikz-ZWCrAVu7E1c-3udHVdCb=fasA@mail.gmail.com>
References: <20110509222127.2B4DA485C521@ceph-tracker.dreamhostps.com>
	<BANLkTikviXrv_LHTnJ0QmsB0DtqKYoaoaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43244 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab1EIX3c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2011 19:29:32 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id CDC40C066
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 16:29:32 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 7D5BAC064
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 16:29:32 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1684918eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 May 2011 16:29:30 -0700 (PDT)
In-Reply-To: <BANLkTikviXrv_LHTnJ0QmsB0DtqKYoaoaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@ceph-tracker.dreamhostps.com>
Cc: ceph-devel@vger.kernel.org

On Mon, May 9, 2011 at 4:24 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> Ermm, doesn't rados sync do a whole tree sync or something? I think we
> want to maintain a simple get/set object capability and the rados tool
> is a pretty logical place for that.
> -Greg
Sorry, Gmail got confused so I resent! :(


On Mon, May 9, 2011 at 4:25 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 9 May 2011, Gregory Farnum wrote:
>> Ermm, doesn't rados sync do a whole tree sync or something? I think we
>> want to maintain a simple get/set object capability and the rados tool
>> is a pretty logical place for that.
>
> The main difference with sync is that it does incremental updates (skips
> dup items).
>
> As an aside I we should move that into the rados tool, though ('rados
> sync' instead of 'rados_sync')...
If it's that simple a syntax change, I agree. I thought rados_sync
would require an empty directory if you just want to pull an object
out, which was my main concern.
-Greg
