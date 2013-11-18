From: Dmitry Borodaenko <dborodaenko@mirantis.com>
Subject: Re: HSM
Date: Mon, 18 Nov 2013 11:22:21 -0800
Message-ID: <CAM0pNLOiCVwRgWTzcXket+DJbSrDRew1wBvo0hVHO_1AvwDsGg@mail.gmail.com>
References: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
	<3472A07E6605974CBC9BC573F1BC02E4AE69DEBF@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:60823 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab3KRTWV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Nov 2013 14:22:21 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so7557576obc.34
        for <ceph-devel@vger.kernel.org>; Mon, 18 Nov 2013 11:22:21 -0800 (PST)
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE69DEBF@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Nov 12, 2013 at 1:47 AM, Andreas Joachim Peters
<Andreas.Joachim.Peters@cern.ch> wrote:
> I think you need to support the following functionality to support HSM (file not block based):
>
> 1 implement a trigger on file creation/modification/deletion
>
> 2 store the additional HSM identifier for recall as a file attribute
>
> 3 policy based purging of file related blocks (LRU cache etc.)
>
> 4 implement an optional trigger to recall a purged file and block the IO (our experience is that automatic recalls are problematic for huge installations if the aggregation window for desired recalls is short since they create inefficient and chaotic access on tapes)
>
> 5 either snapshot a file before migration, do an exclusive lock or freeze it to avoid modifications during migration (you need to have a unique enough identifier for a file, either inode/path + checksum or also inode/path + modification time works)

DMAPI seems to be the natural choice for items 1 & 4 above.

> FYI: there was a paper about migration policy scanning performance by IBM two years ago:
> http://domino.watson.ibm.com/library/CyberDig.nsf/papers/4A50C2D66A1F90F7852578E3005A2034/$File/rj10484.pdf

An important omission in that paper is the exact ILM policy that was
used to scan the file system. I strongly suspect that it was a
catch-all policy that matches every file without examining any
metadata. When you add conditions that check file metadata, scan time
would increase, probably by a few orders of magnitude.

-- 
Dmitry Borodaenko
