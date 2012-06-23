From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Unable to restart Mon after reboot
Date: Fri, 22 Jun 2012 22:48:59 -0700
Message-ID: <4FE558CB.4010509@inktank.com>
References: <BDAE812E-2659-4025-9B30-2DEC6675B59A@100percentit.com> <4FE55567.6080201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36194 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab2FWFtD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jun 2012 01:49:03 -0400
Received: by dady13 with SMTP id y13so3184783dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 22:49:02 -0700 (PDT)
In-Reply-To: <4FE55567.6080201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Blundell <David.Blundell@100percentit.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sorry: that file would actually be /data/mon0/osdmap/latest

On 06/22/2012 10:34 PM, Dan Mick wrote:
> Hi David:
>
> The code there is trying to read some stuff off the monitor's storage to
> initialize, and apparently failing in an odd way. It's trying to read
> the file 'latest' from the monitor directory (/data/mon0); the file can
> be opened, and stat says it's 4289 bytes long, but apparently the read
> is succeeding without error, but only getting back 0 bytes (i.e., not an
> error, but apparently end of file).
>
> See if there's a file /data/mon0/latest of length 4289, and see if
> something is odd about its permissions (like maybe the read bits are
> turned off, or maybe the filesystem it's on has errors).
>
>
> On 06/22/2012 05:31 PM, David Blundell wrote:
>> Hi all,
>>
>> I am testing Ceph 0.47.2 on btrfs with three servers running Fedora
>> 17. Following a reboot of the servers, one of the mon daemons crashes
>> on startup with "FAILED assert(r>0)"
>>
>> MDS and the OSD start and run fine as do the mon daemons on the other
>> two servers.
>>
>> The debug log is at http://pastebin.com/tXwvd44Z
>>
>> I would really appreciate any comments - especially if I am missing
>> something obvious.
>>
>> David--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
