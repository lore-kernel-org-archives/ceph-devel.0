From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: deb/rpm package purge
Date: Tue, 19 Mar 2013 18:01:08 -0500
Message-ID: <5148EE34.9070401@inktank.com>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net>  <5148C4EE.5090205@inktank.com> <5148CEC2.2050405@inktank.com>  <alpine.DEB.2.00.1303191349360.4850@cobra.newdream.net>  <1363732049.12547.22.camel@julia>  <alpine.DEB.2.00.1303191528510.4850@cobra.newdream.net> <1363733473.12547.33.camel@julia>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:59353 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933312Ab3CSXBM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 19:01:12 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so1160927iee.39
        for <ceph-devel@vger.kernel.org>; Tue, 19 Mar 2013 16:01:11 -0700 (PDT)
In-Reply-To: <1363733473.12547.33.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: Sage Weil <sage@inktank.com>, Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org, james.page@ubuntu.com

On 03/19/2013 05:51 PM, Laszlo Boszormenyi (GCS) wrote:
> On Tue, 2013-03-19 at 15:29 -0700, Sage Weil wrote:
>> On Tue, 19 Mar 2013, Laszlo Boszormenyi (GCS) wrote:
>>>   In short, if user asks to purge the package, then the keys have to be
>>> removed as well. If someone thinks about a reinstallation, s/he should
>>> use remove instead.
>> The keys aren't a problem; they are still in the mon database
>> (/var/lib/ceph/mon/...).
>>
>> The real question is whether purge should remove /var/lib/ceph and
>> /var/log/ceph...
>   Sorry if I was not clear and/or generic enough. Use of 'dpkg --remove'
> is to remove binaries of the package, but leave other things, runtime
> data (configuration, logs, database settings/users and so on) to be left
> untouched.
> On the other hand, 'dpkg --purge' is to remove everything the package
> has installed and/or generated. This includes debconf answers as well.
> With other words, purge is used to make the system totally clean of the
> package. As such, if the sysadmin install the package again, all debconf
> questions will be asked again and all generated files will be generated
> again from scratch.
>

Hi Lazlo,

Thanks for the answers!  The question is whether or not the data in 
/var/lib/ceph should be removed when that data was not generated as part 
of the package installation process, but rather as part of the cluster 
configuration after the package was installed.  IE the package creates 
the directory, but the user creates the data that resides in it.  What 
should purge do with the directory now that the user has placed 
(critical) data in it that was not generated as part of the package 
installation process?

> Laszlo/GCS
>

