From: Gregory Farnum <greg@gregs42.com>
Subject: Re: /usr/bin/cephfs tool
Date: Fri, 9 Jan 2015 10:11:59 -0800
Message-ID: <CAC6JEv-0GBkqMSLEnkUYUzuViWV+Esq-GkT7qcSgNM6vNDyGvg@mail.gmail.com>
References: <alpine.DEB.2.00.1501090719200.10528@cobra.newdream.net>
	<CAC6JEv9XuGSLOnzo_m1GVOYd46XyLUKysjnrJpu9623TZaxO2A@mail.gmail.com>
	<alpine.DEB.2.00.1501090959190.5967@cobra.newdream.net>
	<CAC6JEv_itSycn_SCaFUQNJ_qBDH2HNqkWtUB5HwBYezpqBx_nA@mail.gmail.com>
	<alpine.DEB.2.00.1501091006460.5967@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:65136 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbbAISMA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 13:12:00 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so16317799iec.10
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jan 2015 10:12:00 -0800 (PST)
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com. [209.85.223.170])
        by mx.google.com with ESMTPSA id a14sm4727524igm.12.2015.01.09.10.11.59
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Jan 2015 10:11:59 -0800 (PST)
Received: by mail-ie0-f170.google.com with SMTP id rd18so16373974iec.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jan 2015 10:11:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501091006460.5967@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: gfarnum@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 9, 2015 at 10:08 AM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 9 Jan 2015, Gregory Farnum wrote:
>> On Fri, Jan 9, 2015 at 10:00 AM, Sage Weil <sweil@redhat.com> wrote:
>> > On Fri, 9 Jan 2015, Gregory Farnum wrote:
>> >> On Fri, Jan 9, 2015 at 7:20 AM, Sage Weil <sweil@redhat.com> wrote:
>> >> > Should we drop this entirely in hammer?
>> >>
>> >> Yes!
>> >>
>> >> >  If I remember correctly all of
>> >> > the layout stuff is fully supported using virtual xattrs and standard
>> >> > tools.  The only thing left is the tool that shows you how file blocks map
>> >> > to objects map to OSDs (or something like that), which I've never used and
>> >> > have never seen anyone use...
>> >>
>> >> ...oh, hmmm. Actually there have been people using that tool
>> >> occasionally over the years, and I don't think we provide any other
>> >> way to learn that information (besides calculating it yourself,
>> >> obviously).
>> >> Perhaps we could extend the vxattr interface to include that
>> >> information as well?
>> >
>> > Actually, I think Andreas's librados stuff he's working on may be the
>> > right path... it'll expose general information about object -> pg ->
>> > osd mappings.  Then a simple script could take the ino + file size, turn
>> > it into object names, and use that.
>> >
>> > In any case, I don't mind nuking this and waiting for a complaint before
>> > investing in replacing that bit of functionality since it's such a small
>> > thing...
>>
>> Yeah, that's fine with me, but I'd like some idea of how we'd suggest
>> any users who complain do the implementation so we can point them at a
>> ticket if they do complain. ;)
>
> Email thread subject:
>
> RFC: new rados whereis command
>
> Earlier pull requests:
>
> https://github.com/ceph/ceph/pull/2729
> https://github.com/ceph/ceph/pull/2730
>
> There isn't a redmine ticket since it originated as a PR.

Sorry, I meant the actual FS location bit, which isn't part of that
PR. ;) The "fancy" bit is integrating transparently with the FS
striping strategy, which is a little finicky to get right in a script
right now (though possible) but could definitely change in the future.

Anyway, I'm on board with ripping the cephfs tool out of the system.
