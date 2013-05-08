From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Debian package dependencies across version
Date: Wed, 8 May 2013 08:51:13 -0700
Message-ID: <75293AA6-E3AA-482D-8185-5622A29AFC05@inktank.com>
References: <CAF6-1L7-VwTQMrB5Mqd4d+fBeiA17UwKFwRkbWeK4K4JR-hZRA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51258 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835Ab3EHPvS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 11:51:18 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq12so1420530pab.12
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 08:51:17 -0700 (PDT)
In-Reply-To: <CAF6-1L7-VwTQMrB5Mqd4d+fBeiA17UwKFwRkbWeK4K4JR-hZRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org


The version requirements were relaxed a couple releases ago to allow the installation of newer libraries.   Occasionally folks want to run a newer library to pick up a specific fix before upgrading all of ceph.

We definitely want installation and upgrade to be surprise free.  Maybe it is reasonable to require all the packages to be the same or greater version than the ceph package ?

Thanks,
Gary


On May 8, 2013, at 1:21 AM, Sylvain Munaut wrote:

> Hi,
> 
> 
> In the debian/control file, the dependency from one ceph package to
> the other doesn't always specify that version should match.
> For example the 'ceph' package depends on 'ceph-common' but not on
> 'ceph-common (= ${binary:Version})'.
> 
> The result is that when I did a "apt-get install ceph" to upgrade it (
> apt-get upgrade wouldn't have updated it automatically because it had
> new dependencies ), it only updated the 'ceph' package and not
> librados/ceph-common/...  and I had to make another "apt-get upgrade"
> to finish the upgrade.
> 
> And if you don't pay attention you could end up with mixed version installed.
> 
> Is there a reason not to force all version of installed ceph package to match ?
> 
> 
> Cheers,
> 
>   Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

