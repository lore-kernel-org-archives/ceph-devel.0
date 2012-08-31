From: Andrew Thompson <andrewkt@aktzero.com>
Subject: Re: Very unbalanced storage
Date: Fri, 31 Aug 2012 11:00:09 -0400
Message-ID: <5040D179.5000008@aktzero.com>
References: <50409BDC.5010006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1a.cologlobal.com ([96.125.182.177]:55642 "EHLO
	mx1.cologlobal.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754125Ab2HaPno (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 11:43:44 -0400
Received: from mail3.hspheredns.com ([208.77.157.24])
	by mx1.cologlobal.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <andrewkt@aktzero.com>)
	id 1T7Siz-0002ns-Qs
	for ceph-devel@vger.kernel.org; Fri, 31 Aug 2012 11:01:41 -0400
In-Reply-To: <50409BDC.5010006@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 8/31/2012 7:11 AM, Xiaopong Tran wrote:
> Hi,
>
> Ceph storage on each disk in the cluster is very unbalanced. On each
> node, the data seems to go to one or two disks, while other disks
> are almost empty.
>
> I can't find anything wrong from the crush map, it's just the
> default for now. Attached is the crush map.

Have you been reweight-ing osds? I went round and round with my cluster 
a few days ago reloading different crush maps only to find that it 
re-injecting a crush map didn't seem to overwrite reweights.

Take a look at `ceph osd tree` to see if the reweight column matches the 
weight column.

Note: I'm new at this. This is my experience only, with 0.48.1, and may 
not be entirely correct.

-- 
Andrew Thompson
http://aktzero.com/

