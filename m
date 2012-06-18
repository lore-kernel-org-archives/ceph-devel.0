From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal,
 normal behaviour ?
Date: Mon, 18 Jun 2012 08:29:58 -0500
Message-ID: <4FDF2D56.7010108@inktank.com>
References: <de0635df-9b2a-4848-89ed-8eda179147db@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34751 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab2FRNaB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 09:30:01 -0400
Received: by yhmm54 with SMTP id m54so3769891yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 06:30:00 -0700 (PDT)
In-Reply-To: <de0635df-9b2a-4848-89ed-8eda179147db@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On 6/18/12 7:34 AM, Alexandre DERUMIER wrote:
> Hi,
>
> I'm doing test with rados bench, and I see constant writes to osd disks.
> Is it the normal behaviour ? with write-ahead should write occur each 20-30 seconde ?
>
>
> Cluster is
> 3 nodes (ubuntu precise - glibc 2.14 - ceph 0.47.2) with each node 1 journal on tmpfs 8GB - 1 osd (xfs) on sas disk  - 1 gigabit link
>
>
> 8GB journal can handle easily 20s of write (1 gigabit link)
>
> [osd]
>          osd data = /srv/osd.$id
>          osd journal = /tmpfs/osd.$id.journal
>          osd journal size = 8000
>          journal dio = false
>          filestore journal parallel = false
>          filestore journal writeahead = true
>          filestore fiemap = false
>
>
>
>
> I have done tests with differents kernel (3.0,3.2,3.4) , differents filesystem (xfs,btrfs,ext4), forced journal mode to writeahead.
> Bench were done write rados bench and fio.
>
> I always have constant write since the first second of bench start.
>
> Any idea ?

Hi Alex,

Sorry I got behind at looking at your output last week.  I've created a 
seekwatcher movie of your blktrace results here:

http://nhm.ceph.com/movies/mailinglist-tests/alex-test-3.4.mpg

The results match up well with your iostat output.  Peaks and valleys in 
the writes every couple of seconds.  Low numbers of seeks, so probably 
not limited by the filestore (a quick "osd tell X bench" might confirm 
that).

I'm wondering if you increase "filestore max sync interval" to something 
bigger (default is 5s) if you'd see somewhat different behavior.  Maybe 
try something like 30s and see what happens?

Mark

