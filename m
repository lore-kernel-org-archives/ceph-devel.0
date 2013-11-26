From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: Re: os recommendations
Date: Tue, 26 Nov 2013 22:27:51 +0100
Message-ID: <CAMNMNTx5rq8qv-MNsRK7oqvBqe8JjB0QOsf9+K=_NvGqs4b61w@mail.gmail.com>
References: <CAMNMNTz+whZWk55qCxx_8JCRWAruoHYz+stHYS93gBiU3qz3SQ@mail.gmail.com>
	<20131126142243.GA7360@infradead.org>
	<alpine.DEB.2.00.1311260647310.24677@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:47601 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab3KZV1w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Nov 2013 16:27:52 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so6693831oag.18
        for <ceph-devel@vger.kernel.org>; Tue, 26 Nov 2013 13:27:52 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311260647310.24677@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Thanks.

--
Regards
Dominik

2013/11/26 Sage Weil <sage@inktank.com>:
> On Tue, 26 Nov 2013, Christoph Hellwig wrote:
>> On Tue, Nov 26, 2013 at 11:43:07AM +0100, Dominik Mostowiec wrote:
>> > Hi,
>> > I found in doc: http://ceph.com/docs/master/start/os-recommendations/
>> > "Putting multiple ceph-osd daemons using XFS or ext4 on the same host
>> > will not perform as well as they could."
>> >
>> > For now recommended filesystem is XFS.
>> > This means that for the best performance setup should be 1 OSD per host?
>>
>> Btw, could anyone clarify where that stance comes from, that is numbers
>> to back it up.
>
> If syncfs(2) is not present, we have to use sync(2).  That means you have
> N daemons calling sync(2) to force a commit on a single fs, but all other
> mounted fs's are also synced... which means N times the sync(2) calls.
>
> Fortunately syncfs(2) has been around for a while now, so this only
> affects really old distros.  And even when glibc does not have a syscall
> wrapper for it, we try to call the syscall directly.
>
> sage



-- 
Pozdrawiam
Dominik
