From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] mds: handle setxattr ceph.parent
Date: Tue, 7 Jan 2014 08:39:12 -0800
Message-ID: <CAPYLRzjYmuNLwgCvZDWLqtm-L7KseuA_ukBMSrMW=rr_oDf-ag@mail.gmail.com>
References: <oriounafd8.fsf@livre.home>
	<CAAM7YAnb494gQAqa=by3vTc0Oe2Oxr15QAckiHsopMjVDpvMfg@mail.gmail.com>
	<or38lq86ig.fsf@livre.home>
	<alpine.DEB.2.00.1312180908270.27634@cobra.newdream.net>
	<CAPYLRzgf=H1dMc+AdsJYJpkbjaU6bEJ1VYVAcXgB6PZX70yxVg@mail.gmail.com>
	<or4n656zij.fsf@livre.home>
	<52B2F44A.1050109@intel.com>
	<orbo0c5h4p.fsf@livre.home>
	<52B3F9DE.60301@intel.com>
	<ord2kr3vez.fsf@livre.home>
	<or8uvf3u3r.fsf@livre.home>
	<CAPYLRzgG0VTh+7cDg58-pknn7Kv_-CDDLqoGxd=UhX4vAiCkJA@mail.gmail.com>
	<orha9gzatp.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:59712 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaAGQjO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jan 2014 11:39:14 -0500
Received: by mail-qa0-f41.google.com with SMTP id w5so766664qac.14
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jan 2014 08:39:13 -0800 (PST)
In-Reply-To: <orha9gzatp.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, Sage Weil <sage@inktank.com>, "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jan 6, 2014 at 8:15 PM, Alexandre Oliva <oliva@gnu.org> wrote:
> On Jan  6, 2014, Gregory Farnum <greg@inktank.com> wrote:
>
>> On Fri, Dec 20, 2013 at 4:50 PM, Alexandre Oliva <oliva@gnu.org> wro=
te:
>>> On Dec 20, 2013, Alexandre Oliva <oliva@gnu.org> wrote:
>>>
>>>> back many of the osds to recent snapshots thereof, from which I'd
>>>> cleaned all traces of the user.ceph._parent.  I intended to roll b=
ack
>>>
>>> Err, I meant user.ceph._path, of course ;-)
>>>
>>>> So I think by now I'm happy to announce that it was an IO error (w=
here
>>>> IO stands for Incompetence of the Operator ;-)
>>>
>>>> Sorry about this disturbance, and thanks for asking me to investig=
ate it
>>>> further and find a probable cause that involves no fault of Ceph's=
=2E
>>>
>>> I guess after the successful --reset-journal, I get to clean up on =
my
>>> own the journal files that are no longer used but that apparently w=
on't
>>> get cleaned up by the mds any more.  Right?
>
>> If they're in the "future" of the mds journal they'll get cleared ou=
t
>> automatically as the MDS gets up to them (this is the pre-zeroing
>> thing). If they're in the "past", yeah, you'll need to clear them up=
=2E
>
> After an ceph-mds --reset-journal, I don't see how they could be in t=
he
> "future", but what do I know?

I wasn't entirely clear on the ordering of things =97 if for instance
you rolled back OSDs such that the journal head pointed to an offset,
and there was a hole following that offset, but you didn't roll back
every OSD so there were still some log segments which didn't get
deleted in your rollback or the reset-journal operation (because it
stopped once it found a hole).
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
