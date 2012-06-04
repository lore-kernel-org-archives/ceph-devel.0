From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 07:59:58 -0500
Message-ID: <4FCCB14E.6030109@inktank.com>
References: <70f814ae-c265-4778-bd6c-7dbbe6f9952f@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54588 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab2FDNAB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 09:00:01 -0400
Received: by yenm10 with SMTP id m10so2949371yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 06:00:01 -0700 (PDT)
In-Reply-To: <70f814ae-c265-4778-bd6c-7dbbe6f9952f@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Amon Ott <a.ott@m-privacy.de>, ceph-devel@vger.kernel.org, Yann Dupont <Yann.Dupont@univ-nantes.fr>

On 6/4/12 6:40 AM, Alexandre DERUMIER wrote:
> Hi,
>
> I'm currently doing some tests with xfs, debian wheezy with standard libc6 (2.11.3-3) and 3.2 kernel.
>
> I'm doing some iostats(3 nodes with 5 osd), and I see constant writes to disks.(as the datas are flushed each second from journal to disk).
>
> Journal is big enough (20GB tmpfs) to handle 30s of write.
>
> Do you think it's related to the missing syncfs() support ?
>
> -Alexandre

Hi Alexandre,

I've included some seekwatcher results for rados bench tests using 16 
concurrent 4MB writes on XFS OSD.  One shows ubuntu oneiric and the 
other precise (ie no syncfs support vs syncfs support in libc). 
Unfortunately the original test was on 0.46 and the second test was on 
0.47.2, so multiple things changed between the tests.  Both were tested 
with kernel 3.4.  Interestingly the seeks/second don't seem to drop much 
but the overall performance has about doubled.  This was using a single 
7200rpm disk for the OSD data disk and a seperate 7200rpm disk for the 
journal in both cases.  I'd definitely try 0.47.2 with a new libc though 
and see how that works for you.

ceph 0.46/oneiric:
http://nhm.ceph.com/movies/mailinglist-tests/xfs-osd0-oneiric-3.4.mpg

ceph 0.47.2/precise:
http://nhm.ceph.com/movies/mailinglist-tests/xfs-osd0-precise-3.4.mpg

Mark
