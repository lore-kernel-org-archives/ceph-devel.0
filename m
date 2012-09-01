From: Andrew Thompson <andrewkt@aktzero.com>
Subject: Re: Very unbalanced storage
Date: Sat, 01 Sep 2012 02:58:12 -0400
Message-ID: <5041B204.7000008@aktzero.com>
References: <50409BDC.5010006@gmail.com> <alpine.DEB.2.00.1208310904570.1531@cobra.newdream.net> <5041785E.3040707@gmail.com> <alpine.DEB.2.00.1208312000160.27708@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1a.cologlobal.com ([96.125.182.177]:44514 "EHLO
	mx1.cologlobal.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751350Ab2IAG7k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Sep 2012 02:59:40 -0400
Received: from mail3.hspheredns.com ([208.77.157.24])
	by mx1.cologlobal.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <andrewkt@aktzero.com>)
	id 1T7hg5-0008AL-DE
	for ceph-devel@vger.kernel.org; Sat, 01 Sep 2012 02:59:39 -0400
In-Reply-To: <alpine.DEB.2.00.1208312000160.27708@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 8/31/2012 11:05 PM, Sage Weil wrote:
> Sadly you can't yet adjust pg_num for an active pool.  You can create a
> new pool,
>
> 	ceph osd pool create <name> <pg_num>
>
> I would aim for 20 * num_osd, or thereabouts.. see
>
> 	http://ceph.com/docs/master/ops/manage/grow/placement-groups/
>
> Then you can copy the data from the old pool to the new one with
>
> 	rados cppool yunio2 yunio3
>
> This won't be particularly fast, but it will work.  You can also do
>
> 	ceph osd pool rename <oldname> <newname>
> 	ceph osd pool delete <name>
>
> I hope this solves your problem!

Looking at old archives, I found this thread which shows that to mount a 
pool as cephfs, it needs to be added to mds:

http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/5685

I started a `rados cppool data tempstore` a couple hours ago. When it 
finishes, will I need to remove the current pool from mds somehow(other 
than just deleting the pool)?

Is `ceph mds add_data_pool <poolname>` still required? (It's not listed 
in `ceph --help`.)

Thanks.

-- 
Andrew Thompson
http://aktzero.com/

