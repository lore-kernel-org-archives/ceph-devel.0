From: Gregory Farnum <greg@inktank.com>
Subject: Re: Disabling CRUSH for erasure code and doing custom placement
Date: Wed, 23 Jul 2014 15:57:51 -0700
Message-ID: <CAPYLRzi9BWMeK51d=P3P1-Mv7FN6jE3OLNqYQsoX5C0JK=Ueug@mail.gmail.com>
References: <CALUBZ__98nzUjucW9NmFKEHzPFvu0yY0X5yHEtFH7g9QkhqSAQ@mail.gmail.com>
	<CAPYLRzgeb2DB_tJfRFvK1gk5XEYYd7mgHH5E5URqYsn_2bH4mQ@mail.gmail.com>
	<CALUBZ_-gBR2KHMQcGe65+GDHE3xC+Fq9_J+DZLDqf+7LQHrq6g@mail.gmail.com>
	<CAPYLRzhoiP7t81VG5FEgo53xP9GVMOu6e8zQdwU+HxF2gB7HRQ@mail.gmail.com>
	<CALUBZ_-HxjMrni0Gtv_gs=nT1RGxTEYhZGmw1s=z5hkPT4kV3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:52674 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758447AbaGWW5w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jul 2014 18:57:52 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so1910500wes.39
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jul 2014 15:57:51 -0700 (PDT)
In-Reply-To: <CALUBZ_-HxjMrni0Gtv_gs=nT1RGxTEYhZGmw1s=z5hkPT4kV3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shayan Saeed <shayansaeed93@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 22, 2014 at 2:48 PM, Shayan Saeed <shayansaeed93@gmail.com> wrote:
> Another question along the same lines. For erasure code, same as
> replicated files, the request goes through the primary member. Isn't
> it possible to send the request to any of the members and get the
> file. While this might have kept things neater on the development side
> and might have made some sense for replicated system, it makes the
> availability and load balancing worse for erasure coded files. I see a
> lot of requests coming in for a specific object which makes the
> primary osd hosting it go down sometimes and then all the requests
> have to wait another osd comes up and repair is done.  For load
> balancing purposes, is there a way to make the requests go to someone
> else without hinderance and get the object without waiting for repair.

Not really. This would have all the same consistency issues of having
replicated objects read from multiple replicas, plus the problem of
needing to get a consistent view across multiple machines instead of a
single machine. If an OSD is getting overloaded by clients, that's the
bug and it should be addressed as one.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
