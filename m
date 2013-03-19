From: Dan Mick <dan.mick@inktank.com>
Subject: Re: deb/rpm package purge
Date: Tue, 19 Mar 2013 13:46:58 -0700
Message-ID: <5148CEC2.2050405@inktank.com>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net> <5148C4EE.5090205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:47264 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933741Ab3CSUrD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 16:47:03 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so529430dae.9
        for <ceph-devel@vger.kernel.org>; Tue, 19 Mar 2013 13:47:02 -0700 (PDT)
In-Reply-To: <5148C4EE.5090205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, james.page@ubuntu.com, gcs@debian.hu

Is there a way out if you remove the keyrings?

On 03/19/2013 01:05 PM, Mark Nelson wrote:
>
>
> On 03/19/2013 02:48 PM, Sage Weil wrote:
>> Should the package purge remove /var/lib/ceph/* (potential mon data, osd
>> data) and/or /var/log/ceph/* (logs)?  Right now it does, but mysql, for
>> example, leaves /var/lib/mysql where it is (not sure about logs).
>
> I'm definitely for leaving mon/osd data in place.  Those files are
> created at cluster creation time, not when the packages are installed.
> They may have been created by a totally different installation of Ceph
> than the packaged version.
>
> What's worse is that you can't get the files back simply by reinstalling
> the package.  With the way things currently are, a package purge will
> effectively permanently destroy your cluster.  Purge should get rid of
> configuration files, but I don't think it should destroy user data which
> is what it effectively is doing now.
