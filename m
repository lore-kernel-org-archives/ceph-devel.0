From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: timed out in osd1 error in dmes
Date: Tue, 13 Mar 2012 13:23:52 -0700
Message-ID: <4F5FACD8.8090902@dreamhost.com>
References: <loom.20120313T083325-276@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41618 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab2CMUX6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Mar 2012 16:23:58 -0400
In-Reply-To: <loom.20120313T083325-276@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 03/13/2012 12:35 AM, madhusudhana wrote:
> Hi all,
> The server in which i have mounted file system using mount -t ceph
> is showing below errors in dmesg.
>
>
> libceph:  tid 79987 timed out on osd2, will reset osd
> libceph:  tid 81516 timed out on osd0, will reset osd
> libceph:  tid 81133 timed out on osd1, will reset osd
> libceph: skipping osd1 10.25.12.127:6800 seq 1 expected 2
> libceph:  tid 80108 timed out on osd2, will reset osd
> libceph:  tid 81134 timed out on osd1, will reset osd
> libceph:  tid 81641 timed out on osd1, will reset osd
>
>
> Is is because of this, write/copy operation in my cluster
> is slow ? is this a error which needs attention or can be
> safely ignored ?

These are usually harmless, and could just mean the osds can't keep up 
with the requests you're giving them. Given your other issues, it might 
be a symptom of a problem with your osds.

What filesystem are the osds using? Are there any warnings from these 
filesystems in dmesg?

>
> Thanks
> Madhusudhan

