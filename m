From: Malcolm Haak <malcolm@sgi.com>
Subject: Re: HSM
Date: Wed, 20 Nov 2013 22:09:03 +1000
Message-ID: <528CA65F.7030709@sgi.com>
References: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>	<3472A07E6605974CBC9BC573F1BC02E4AE69DEBF@PLOXCHG03.cern.ch> <CAM0pNLOiCVwRgWTzcXket+DJbSrDRew1wBvo0hVHO_1AvwDsGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3.sgi.com ([192.48.152.1]:32985 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753088Ab3KTMJJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Nov 2013 07:09:09 -0500
In-Reply-To: <CAM0pNLOiCVwRgWTzcXket+DJbSrDRew1wBvo0hVHO_1AvwDsGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dmitry Borodaenko <dborodaenko@mirantis.com>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It is, except it might not be.

Dmapi only works if you are the one in charge of the HSM and the filesystem.

So for example in a DMF solution the filesystem mounted with DMAPI 
options is on your NFS head node. Your HSM solution is also installed 
there.

Things get a bit more odd when you look at DMAPI + Clustered systems. 
You would need HSM agents on every client node If we are talking CephFS 
that is.

This is also true with the Lustre solution. The Lustre clients have no 
idea this stuff is happening. This is how it should work. It means the 
current requirement for installed software on the bulk of your clients 
is a working kernel or fuse module.

On 19/11/13 05:22, Dmitry Borodaenko wrote:
> On Tue, Nov 12, 2013 at 1:47 AM, Andreas Joachim Peters
> <Andreas.Joachim.Peters@cern.ch> wrote:
>> I think you need to support the following functionality to support HSM (file not block based):
>>
>> 1 implement a trigger on file creation/modification/deletion
>>
>> 2 store the additional HSM identifier for recall as a file attribute
>>
>> 3 policy based purging of file related blocks (LRU cache etc.)
>>
>> 4 implement an optional trigger to recall a purged file and block the IO (our experience is that automatic recalls are problematic for huge installations if the aggregation window for desired recalls is short since they create inefficient and chaotic access on tapes)
>>
>> 5 either snapshot a file before migration, do an exclusive lock or freeze it to avoid modifications during migration (you need to have a unique enough identifier for a file, either inode/path + checksum or also inode/path + modification time works)
>
> DMAPI seems to be the natural choice for items 1 & 4 above.
>
>> FYI: there was a paper about migration policy scanning performance by IBM two years ago:
>> http://domino.watson.ibm.com/library/CyberDig.nsf/papers/4A50C2D66A1F90F7852578E3005A2034/$File/rj10484.pdf
>
> An important omission in that paper is the exact ILM policy that was
> used to scan the file system. I strongly suspect that it was a
> catch-all policy that matches every file without examining any
> metadata. When you add conditions that check file metadata, scan time
> would increase, probably by a few orders of magnitude.
>
