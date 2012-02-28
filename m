From: Wido den Hollander <wido@widodh.nl>
Subject: Re: ceph v0.42 sync
Date: Tue, 28 Feb 2012 12:45:21 +0100
Message-ID: <4F4CBE51.2000006@widodh.nl>
References: <1330250058.3834.46.camel@julia.gcs.org.hu>  <Pine.LNX.4.64.1202262122370.23717@cobra.newdream.net> <1330322472.3834.56.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:47200 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab2B1LpW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 06:45:22 -0500
In-Reply-To: <1330322472.3834.56.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

Hi,

On 02/27/2012 07:01 AM, Laszlo Boszormenyi wrote:
> On Sun, 2012-02-26 at 21:23 -0800, Sage Weil wrote:
>> v0.42.2 for now.. v0.43 should be out either Friday or the following
>> Monday.
>   OK, will get v0.42.2 from git, as the homepage has only v0.42 for
> download.
>

I've just submitted a patch to the ml with a fix for the auto_start setting.

My previous patch (my bad..) broke starting any daemon with the "auto 
start" set to false, no, disabled.

I don't know if 0.42.2 would be going into Ubuntu 12.04, but it might be 
useful to include this (small patch?)

Wido

> On Sun, 2012-02-26 at 21:29 -0800, Sage Weil wrote:
>> Hmm, actually it looks like /run isn't present on many of my machines
>> (squeeze, oneiric).  I'm inclined to stick with the /var/run symlink until
>> the change is more pervasive.
>   Yes, this change is for the new Debian and Ubuntu releases in
> development. The others have /var/run only.
>
>> Is this important enough to add an autoconf option to use the new path
>> instead of the old?
>   Not at all. Even now /run is the real directory, /var/run is now a
> symlink to it. Everyone can still use /var/run for a while.
>
> Laszlo/GCS
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

