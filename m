From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: Filesystem size inconsistance problem
Date: Sun, 6 Jan 2013 17:06:29 +0800
Message-ID: <CAJiejCSOFZiFFryQi4KcaFi+iTuEDZ2nDdcvhwo91Zp8haQhJg@mail.gmail.com>
References: <CAJiejCTmQYy7DpY-p27oseEAbbeNiFcxonL2pZGTofnwz1D79A@mail.gmail.com>
 <alpine.DEB.2.00.1301052230260.15430@cobra.newdream.net> <CAJiejCQ60+n_EgFe9CCpe9tBtLT-Q188OFP2tc36sEoZ_hr_MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:59646 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab3AFJGu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Jan 2013 04:06:50 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so10595120qca.17
        for <ceph-devel@vger.kernel.org>; Sun, 06 Jan 2013 01:06:49 -0800 (PST)
In-Reply-To: <CAJiejCQ60+n_EgFe9CCpe9tBtLT-Q188OFP2tc36sEoZ_hr_MA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: maillist-linux <ceph-devel@vger.kernel.org>

2013/1/6 Drunkard Zhang <gongfan193@gmail.com>:
> 2013/1/6 Sage Weil <sage@inktank.com>:
>> On Sun, 6 Jan 2013, Drunkard Zhang wrote:
>>> Some times ago, I did ceph upgrade offline, then ethernet bonding
>>> while ceph online, and also I removed some OSDs, the cluster
>>> experienced big movements, after sometime it calms down finally. When
>>> I verify the consistance, I found that the filesystem size by 'ceph
>>> -s'(true size) and mounted size is different. What's the problem?
>>>
>>> It's still usable, and the used percent is right too, but the wrong
>>> size displayed looks really uncomfortable !!!
>>
>> What OS and kernel are you running?  In order to get big numbers to come
>> out of statfs, we report a huge block size, and some combinations of the
>> system utilies, glibc, or something else result in bad output.  I don't
>> think we've ever fully tracked it down... :(
>>
> All nodes are based on Gentoo, and up-to-date.
>
> # emerge --info
> Portage 2.1.11.31 (default/linux/amd64/10.0, gcc-4.6.3, glibc-2.15-r3,
> 3.7.1-gentoo x86_64)
> =================================================================
> System uname: Linux-3.7.1-gentoo-x86_64-Intel-R-_Xeon-R-_CPU_E5620_@_2.40GHz-with-gentoo-2.1

Sorry, I lost the ceph version, it's ceph-0.55.1.
