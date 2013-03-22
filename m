From: Dan Mick <dan.mick@inktank.com>
Subject: Re: docs
Date: Fri, 22 Mar 2013 11:18:24 -0700
Message-ID: <514CA070.2040408@inktank.com>
References: <Pine.LNX.4.64.1303221315230.22502@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:45419 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422796Ab3CVSS2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Mar 2013 14:18:28 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so2383053daj.22
        for <ceph-devel@vger.kernel.org>; Fri, 22 Mar 2013 11:18:27 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1303221315230.22502@Psilocybe.Update.UU.SE>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jerker Nyberg <jerker@Update.UU.SE>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 03/22/2013 05:37 AM, Jerker Nyberg wrote:
>
> There seem to be a missing argument to ceph osd lost (also in help for
> the command).
>
> http://ceph.com/docs/master/rados/operations/control/#osd-subsystem
>

Indeed, it seems to be missing the id.  The CLI is getting a big rework 
right now, but the docs should be corrected.  Patch or file an issue, 
either way.

> src/tools/ceph.cc
> src/test/cli/ceph/help.t
> doc/rados/operations/control.rst
>
> The documentation for development release packages is slightly confused.
> Should it not refer to http://ceph.com/rpm-testing for development
> release packages? (Also, the ceph-release package in the development
> release does not refer to itself (in /etc/yum.repos.d/ceph.repo) but to
> (http://ceph.com/rpms) packages.)
>
> http://ceph.com/docs/master/install/rpm/
>
>
> Do you want patches?
>
> --jerker
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
