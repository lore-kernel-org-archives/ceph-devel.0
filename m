From: John Wilkins <john.wilkins@inktank.com>
Subject: Re: docs
Date: Fri, 22 Mar 2013 11:30:36 -0700
Message-ID: <CAM2gkg5Vi3wQDkBb50fGdb60MsJ_NWCuzpdhSCHpnZ4Rj3+_FA@mail.gmail.com>
References: <Pine.LNX.4.64.1303221315230.22502@Psilocybe.Update.UU.SE>
	<514CA070.2040408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:38365 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422786Ab3CVSag (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Mar 2013 14:30:36 -0400
Received: by mail-vb0-f50.google.com with SMTP id ft2so2772056vbb.9
        for <ceph-devel@vger.kernel.org>; Fri, 22 Mar 2013 11:30:36 -0700 (PDT)
In-Reply-To: <514CA070.2040408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Jerker Nyberg <jerker@update.uu.se>, ceph-devel <ceph-devel@vger.kernel.org>

My meeting got cancelled today, so I'll work with Gary to get this resolved.

On Fri, Mar 22, 2013 at 11:18 AM, Dan Mick <dan.mick@inktank.com> wrote:
>
>
> On 03/22/2013 05:37 AM, Jerker Nyberg wrote:
>>
>>
>> There seem to be a missing argument to ceph osd lost (also in help for
>> the command).
>>
>> http://ceph.com/docs/master/rados/operations/control/#osd-subsystem
>>
>
> Indeed, it seems to be missing the id.  The CLI is getting a big rework
> right now, but the docs should be corrected.  Patch or file an issue, either
> way.
>
>
>> src/tools/ceph.cc
>> src/test/cli/ceph/help.t
>> doc/rados/operations/control.rst
>>
>> The documentation for development release packages is slightly confused.
>> Should it not refer to http://ceph.com/rpm-testing for development
>> release packages? (Also, the ceph-release package in the development
>> release does not refer to itself (in /etc/yum.repos.d/ceph.repo) but to
>> (http://ceph.com/rpms) packages.)
>>
>> http://ceph.com/docs/master/install/rpm/
>>
>>
>> Do you want patches?
>>
>> --jerker
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
John Wilkins
Senior Technical Writer
Intank
john.wilkins@inktank.com
(415) 425-9599
http://inktank.com
