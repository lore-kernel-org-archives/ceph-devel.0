From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Wed, 3 Oct 2012 12:34:09 -0700
Message-ID: <CAPrxi59Per-OMrc83pVLAkUs3rU=+RF9bN_X5bb+K1zC+STUng@mail.gmail.com>
References: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com>
	<alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net>
	<CAPrxi5-_AYV0UUuABCM+LkSpRVOM63R5XPDmjz9HE3UxFBe7AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51500 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab2JCTeK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 15:34:10 -0400
Received: by iagy32 with SMTP id y32so1218692iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 12:34:09 -0700 (PDT)
In-Reply-To: <CAPrxi5-_AYV0UUuABCM+LkSpRVOM63R5XPDmjz9HE3UxFBe7AA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Joe Buck <buck@soe.ucsc.edu>, gcs@debian.hu, ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

I wanted to touch base on this Java bindings patch series to make sure
this can become a solid foundation for the Hadoop shim clean-up. Were
there any specific issues with this, other than not yet having a major
consumer?

-Noah

On Thu, Sep 6, 2012 at 11:02 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> On Thu, Sep 6, 2012 at 8:42 AM, Sage Weil <sage@inktank.com> wrote:
>>
>> Also, I noticed the automake patch removes CephException.java, added in
>> the previous patch... probably an accident?
>
> I left CephException out intentionally because it could be replaced by
> generic exceptions in Java like IOException or FileNotFoundException.
> My belief is that CephException (and specializations of this) will
> need to be re-introduced as more error cases are covered. For example,
> I think we'll want a CephBadFileDescriptor, but currently libcephfs
> doesn't appear to return -EBADF (the client is crashing do to fd_map
> assert). So, the Java wrappers should be as stable as the C API, but
> both seem to need some loose ends tied up.
>
>> Can't wait to pull this in!  BTW, Noah, do you know if this is still an
>> issue?
>>
>>         http://tracker.newdream.net/issues/2778
>
> It does appear that -ENOENT is now returned. I added a unit test that
> expects FileNotFoundException and that works out nicely.
>
> - Noah
