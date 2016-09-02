From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Python 3 plans
Date: Fri, 2 Sep 2016 11:56:46 +0200
Message-ID: <a91096da-7dd0-5347-ac11-13c75ec57c06@digiware.nl>
References: <CALe9h7fHZpXF18HoiQ4qeihrbg5C9p14m=T834T6tm+pdsquuw@mail.gmail.com>
 <2bf23853-de9e-5a98-2db1-fe17e9999548@redhat.com>
 <dbcef1f1-82a7-3d8e-ddb1-7d204b1f58cc@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:24683 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbcIBJ46 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Sep 2016 05:56:58 -0400
In-Reply-To: <dbcef1f1-82a7-3d8e-ddb1-7d204b1f58cc@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 31-8-2016 22:04, Willem Jan Withagen wrote:
> On 31-8-2016 21:01, Josh Durgin wrote:
>> On 08/31/2016 07:09 AM, John Spray wrote:
>>> Hi all,
>>>
>>> Various people have been helpfully fixing up the python modules for
>>> python 3 -- but I realised I wasn't sure what our plan really was or
>>> who was depending on this.
> 
> This is on FreeBSD.
> 
> I have not yet figured out why, but even though {python/cython}3 is not
> installed, I'm getting Cmake to report that it found cytron3.
> And then things start to fail during building.

I have submitted PR #10960 to make python3 stuff fail quietly, meaning
that if it is not available Cmake will not start moaning.
It still reports that it is using cyton3, but that seems annoying but
harmless.

Perhaps you care to merge this PR?

Thanx,
--WjW

