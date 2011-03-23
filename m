From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Object storage service beta
Date: Wed, 23 Mar 2011 16:08:31 -0700
Message-ID: <5BDDDCED47BE441BBAE8289CAA058E49@gmail.com>
References: <AANLkTi=_bK36h8oJg1phBfcjsQ6oOC9e5SzcOSEgy6Be@mail.gmail.com>
 <AANLkTikWDONK-YTKx+7Uxmp40QE=FvgjMj_2=XigoMf-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35624 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933037Ab1CWXIg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2011 19:08:36 -0400
Received: by iwn34 with SMTP id 34so9058682iwn.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 16:08:36 -0700 (PDT)
In-Reply-To: <AANLkTikWDONK-YTKx+7Uxmp40QE=FvgjMj_2=XigoMf-@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Wilfrid,
If you used a promo code you should be able to create a Ceph Object Storage user. This will give you access to the playground via our S3 lookalike service, which you can set up to serve images the same way you set up Amazon S3 to do so.

You can also create users to use the Ceph filesystem via rsync, sftp, scp and play around with snapshots and things a bit.

This has been running for a while though and I'm not sure how much longer it's going to remain available as we've made a lot of progress since opening the cluster up. :)
-Greg
On Wednesday, March 23, 2011 at 2:59 PM, Wilfrid Allembrand wrote: 
> Hi all,
> 
> I downloaded the ODP file "Ceph: a scalable distributed storage system
> for Linux (January 20, 2010)" and read on the last slide that it was
> possible to test a storage service/free test cluster on dreamhost.com
> I used the promo code from the slide and I setup a test website +
> installed Gallery in order to manipulate binary files like images.
> 
> I'd like to know how I could use a free test cluster as an image
> repository ? With that test cluster, I'd like to test scalability
> (add, remove capacity) & failure scenarios.
> 
> Is it possible ? Can I find somewhere some documentation/how to on
> that free test cluster ?
> 
> Best regards,
> Wilfrid
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

