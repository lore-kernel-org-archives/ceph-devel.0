From: Andrew Thompson <andrewkt@aktzero.com>
Subject: Re: Very unbalanced storage
Date: Tue, 04 Sep 2012 12:19:07 -0400
Message-ID: <504629FB.30801@aktzero.com>
References: <50409BDC.5010006@gmail.com> <alpine.DEB.2.00.1208310904570.1531@cobra.newdream.net> <5041785E.3040707@gmail.com> <alpine.DEB.2.00.1208312000160.27708@cobra.newdream.net> <5041B204.7000008@aktzero.com> <CADvuQRGGE9hcqO+NevwTdj97hmUe2eCPCO6mBT5B-oon0zaODw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2b.cologlobal.com ([67.22.138.240]:55284 "EHLO
	mx2.cologlobal.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757135Ab2IDQhx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 12:37:53 -0400
Received: from mail3.hspheredns.com ([208.77.157.24])
	by mx2.cologlobal.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <andrewkt@aktzero.com>)
	id 1T8vqL-0007TH-Kj
	for ceph-devel@vger.kernel.org; Tue, 04 Sep 2012 12:19:28 -0400
In-Reply-To: <CADvuQRGGE9hcqO+NevwTdj97hmUe2eCPCO6mBT5B-oon0zaODw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 9/4/2012 11:59 AM, Tommi Virtanen wrote:
> On Fri, Aug 31, 2012 at 11:58 PM, Andrew Thompson <andrewkt@aktzero.com> wrote:
>> Looking at old archives, I found this thread which shows that to mount a
>> pool as cephfs, it needs to be added to mds:
>>
>> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/5685
>>
>> I started a `rados cppool data tempstore` a couple hours ago. When it
>> finishes, will I need to remove the current pool from mds somehow(other than
>> just deleting the pool)?
>>
>> Is `ceph mds add_data_pool <poolname>` still required? (It's not listed in
>> `ceph --help`.)
> If the pool you are trying to grow pg_num for really is a CephFS data
> pool, I fear a "rados cppool" is nowhere near enough to perform a
> migration. My understanding is that each of the inodes stored in
> cephfs/on ceph-mds'es knows what pool the file data resides in; you
> shoveling the objects into another pool with "rados cppool" doesn't
> change these pointers, removing the old pool will just break the
> filesystem.
>
> Before we go too far down this road: is your problem pool *really*
> being use as a cephfs data pool? Based on how it's not named "data"
> and you're just now asking about "ceph mds add_data_pool", it seems
> that's not likely..

Well, I guess it's time to wipe this cluster and start over.

Yes, it was my `data` pool I was trying to grow. After renaming and 
removing the original data pool, I can `ls` my folders/files, but not 
access them.

I attempted a tar backup beforehand, so unless it flaked out, I should 
be able to recover data.

I was concerned the small number of PGs created by default by mkcephfs 
would be an issue, so I was trying to up it a bit. I'm not going to have 
100+ OSDs or petabytes of data. I just want a relatively safe place to 
store my files that I can easily extend as needed.

So far, I'm 0 and 5... I keep blowing up the filesystem, one way or another.

-- 
Andrew Thompson
http://aktzero.com/

