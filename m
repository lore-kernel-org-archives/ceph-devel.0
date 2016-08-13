From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: SCSI inquiry interface for RBD devices
Date: Sat, 13 Aug 2016 21:14:38 +0200
Message-ID: <CAOi1vP-nuRzksfvaCZ1nj6sTmxsH=XS2PdAFj_9j94FtMcpFqw@mail.gmail.com>
References: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
 <CAOi1vP_5gtQXd95M=qspgPeRnTDvxBpC2dknARNv=HXNFKHivQ@mail.gmail.com>
 <4257DB75-0060-4867-A5D5-2AD374722452@Teradata.com> <CAOi1vP9mdNYRCD_cTa0=4tN71L1=tA24wXSr2NqhTH9BmUBAuw@mail.gmail.com>
 <82369305-99D9-464E-B14A-D2E91AC7B76F@Teradata.com> <847a97cf-04b3-9f29-2884-5c757727b3a2@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36614 "EHLO
	mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbcHNNru (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Aug 2016 09:47:50 -0400
Received: by mail-ua0-f175.google.com with SMTP id 97so42511302uav.3
        for <ceph-devel@vger.kernel.org>; Sun, 14 Aug 2016 06:47:50 -0700 (PDT)
In-Reply-To: <847a97cf-04b3-9f29-2884-5c757727b3a2@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>, Jason Dillaman <dillaman@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>

On Sat, Aug 13, 2016 at 5:18 PM, Alex Elder <elder@ieee.org> wrote:
> On 08/12/2016 01:40 PM, Kamble, Nitin A wrote:
>>> It would make this a lot easier if we started generating a unique UUID
>>> >>> for the image and each snapshot at image/snapshot creation time.  Jason?
>>> >>>
>>>>
>>>> Image UUID seems like the right direction.
>
> Yes.  It's not a snapshot you want, but the basic image, regardless
> of the state of its content.  It needs to be created at image

I'm not sure I follow.  We need to have an identifier for each mappable
entity - that's images (HEADs) and snapshots.

> creation time, and no matter how many times the image grows or
> shrinks, or how the cluster gets reorganized along the way, that
> UUID uniquely defines the image (and it ought not to be possible,
> as a rule, to *change* an image's UUID).  Coping an entire image

Why?  IMO it shouldn't be any different from a filesystem UUID - a user
should be able to create an image (snapshot) with the specified UUID,
change it at any time and maybe even clear it (allowing clear makes
older images a non-issue).  We already have an unchangeable pool-wide
ID for ourselves, this is aimed at users and they should be in full
control here.

> (or cloning) would require a new UUID (as has been said).
>
> I think the UUID should be defined independent of the cluster as
> well.  In that case, there may be a reason to think about a "move"
> operation, where it an image is transferred to a new cluster, with
> the new one retaining the original UUID and the old one going away.

By default, it would be a randomly-generated UUID.  What I had meant
when I said "we can couple it with a cluster UUID too" was that we can
export a cluster UUID along with an image UUID.

Thanks,

                Ilya
