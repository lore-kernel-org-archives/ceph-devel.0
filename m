From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw-agent testing
Date: Thu, 22 Aug 2013 08:08:15 -0700
Message-ID: <CABBk=J_+76wWUgxHq=LEivbP7Ksp3a070DjCbcNsZXWtMScg7Q@mail.gmail.com>
References: <CAA8043hiySh18_LR_v3opM=sMiSikciLr9o3+35M9=xs29t55g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:41715 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab3HVPIP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 11:08:15 -0400
Received: by mail-vc0-f176.google.com with SMTP id ha11so1144940vcb.35
        for <ceph-devel@vger.kernel.org>; Thu, 22 Aug 2013 08:08:15 -0700 (PDT)
In-Reply-To: <CAA8043hiySh18_LR_v3opM=sMiSikciLr9o3+35M9=xs29t55g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: christophe courtaut <christophe.courtaut@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 22, 2013 at 4:38 AM, christophe courtaut
<christophe.courtaut@gmail.com> wrote:
> Hi Yehuda,
>
> I'm currently trying to test the radosgw-agent which lives in
> https://github.com/ceph/radosgw-agent
>
> I modified the vstart.sh script (you can see it here
> https://github.com/ceph/ceph/pull/522) to be able to launch multiple
> cluster with vstart.sh in different directories.
>
> I created a little script to automate the launch of two clusters and
> the setup of region and zone, so that i have a master and a slave
> cluster.
>
> With that setup, i encounter two problems:
>
> First when i try to create a bucket after setup is done using s3cmd,
> got this error
> ERROR: Access to bucket 'TEST' was denied.
> in the function open_bucket_pool_ctx, it tries to open the pool
> .rgw.buckets.index, but this pool doesn't seems to exist.
> Is this behaviour correct? Is it due to my setup? or should this pool
> be created?

This pool should have been automatically created (if didn't exist
before). Not sure why it's not happening.

>
> Second, is that i get a 403 while using the radosgw-agent on the
> previous setup, with the test.sh script.
> Am i doing something wrong here?

Did you set the 'system' flag on the appropriate users?
>
> To reproduce the first bug:
>
> - Get the vstart.sh script from https://github.com/ceph/ceph/pull/522
> - Get the script to launch cluster and the *.master *.zone files
> - Launch the script
> - Try to create a bucket with s3cmd
>
> To reproduce the second one :
>
> - Do the same setup as for the first one
> - Get the radosgw-agent repo
> - Get the test.sh script in this directory
> - Launch the test.sh script
>
> You can find below the various files i mentionned earlier
>
> the script for launching clusters
> http://pastebin.com/VSJhwRSs
>
> master.region file
> http://pastebin.com/pCrRpM3w
>
> master.zone file
> http://pastebin.com/gi1DDNvr
>
> slave.region file
> http://pastebin.com/idgMDYjj
>
> slave.zone file
> http://pastebin.com/m2KRnqdJ

On both slave and master zone you didn't set the placement pools, so
it resorts to the default. What does 'radosgw-admin zone get' show on
both?


>
> test.sh file
> http://pastebin.com/gaitrPqX

You can put most of these configurables in a yaml file and -c conf.yaml.


Yehuda
