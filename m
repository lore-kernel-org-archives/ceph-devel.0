From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Suggestions on tracker 13578
Date: Wed, 2 Dec 2015 10:23:36 -0800
Message-ID: <CAJ4mKGbg159aO7S1soYnR+uhR9uV=t3EjYW2Q=2fbh+PPeEAeQ@mail.gmail.com>
References: <565D9F61.6070108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33502 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbbLBSXi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Dec 2015 13:23:38 -0500
Received: by wmec201 with SMTP id c201so266633479wme.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Dec 2015 10:23:37 -0800 (PST)
In-Reply-To: <565D9F61.6070108@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vimal <vikumar@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 1, 2015 at 5:23 AM, Vimal <vikumar@redhat.com> wrote:
> Hello,
>
> This mail is to discuss the feature request at
> http://tracker.ceph.com/issues/13578.
>
> If done, such a tool should help point out several mis-configurations that
> may cause problems in a cluster later.
>
> Some of the suggestions are:
>
> a) A check to understand if the MONs and OSD nodes are on the same machines.
>
> b) If /var is a separate partition or not, to prevent the root filesystem
> from being filled up.
>
> c) If monitors are deployed in different failure domains or not.
>
> d) If the OSDs are deployed in different failure domains.
>
> e) If a journal disk is used for more than six OSDs. Right now, the
> documentation suggests upto 6 OSD journals to exist on a single journal
> disk.
>
> f) Failure domains depending on the power source.
>
> There can be several more checks, and it can be a useful tool to test the
> problems an existing cluster or a new installation.
>
> But I'd like to know how the engineering community sees this, if its seems
> to be worth pursuing, and what suggestions do you have for improving/adding
> to this.

This is a user experience and support tool; I don't think the
engineering community can really judge its value. ;)

So sure, sounds good to me. It'll need to get into the hands of users
before we find out if it's a good plan or not. I was at the SDI Summit
yesterday and was hearing about how some of our choices (like
HEALTH_WARN on pg counts) are *really* scary for users who think
they're in danger of losing data. I suspect the difficulty of a tool
like this will be more in the communication of issues and severity,
more than in what exactly we choose to check.
-Greg
