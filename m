From: kefu chai <tchaikov@gmail.com>
Subject: Re: debian packaging for wip-10587-split-servers
Date: Fri, 10 Jul 2015 22:21:16 +0800
Message-ID: <CAJE9aOO5Wfxgtgvuj=Mx20C_ToVpY4VU37tS+7uGRbEjKZYEww@mail.gmail.com>
References: <559E99D8.9060208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33707 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211AbbGJOVR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jul 2015 10:21:17 -0400
Received: by qkhu186 with SMTP id u186so207775842qkh.0
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2015 07:21:16 -0700 (PDT)
In-Reply-To: <559E99D8.9060208@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-maintainers@ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jul 9, 2015 at 11:57 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> I need some Debian packaging help :)
>
> For http://tracker.ceph.com/issues/10587 I'm working to split out the
> "ceph-mon" and "ceph-osd" servers from the main "ceph" package. The goal
> is to allow someone to "apt-get install" only a monitor or an OSD
> without having to install the binaries for both. (ceph-mds is already
> split out in this fashion.)
>
> Here's what I'd like the process to look like for users:
>
> 1) User installs a Hammer MON/OSD with "apt-get install ceph".
> 2) User adjusts the sources.list to point to a newer Ceph version with
>    the server split.
> 3) User runs "apt-get update"
> 4) Apt installs all three packages onto the user's system: "ceph",
>    "ceph-mon", and "ceph-osd".
> 5) User then has the freedom to uninstall "ceph-mon" or "ceph-osd" as
>    appropriate.
>
> I've gotten about 90% of the way there with the Debian changes, but I
> can't make "apt-get upgrade" do what I want in step 4. The only way I
> can make Apt pull in all three (ceph/ceph-mon/ceph-osd) during an
> "upgrade" operation is to make the "ceph" package depend on the -mon and
> -osd sub-packages. That option means that step 5 above doesn't work.

can we
- have another package named "ceph-base" which packages whatever ceph
currently has now.
- make the "ceph" a meta package which only offers the dependencies to
ceph-mon, ceph-osd, ceph-mds? and let ceph-{mon,osd,mds} Depends on
"ceph-base" instead?

>
> I must be missing something in ./debian/control to make this work.
>
> For the RPMs, I was able to make this work by introducing a
> "ceph-compat" metapackage that used RPM's "Obsoletes" to replace the old
> "ceph" and require "ceph-mon" and "ceph-osd" (which in turn required the
> new "ceph"). But I'm not sure how to do that with Debian.
>
> Should I use a ceph-compat package? Something else?

Ken, i commented on your commit of https://github.com/ceph/ceph/commit/25766b

HTH.

>
> My WIP branch in GitHub is
> https://github.com/ceph/ceph/tree/wip-10587-split-servers . Any tips
> appreciated!
>
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
