From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: higher level library for storing large(r) RADOS objects
Date: Wed, 2 May 2012 23:21:39 -0700
Message-ID: <CAC-hyiHftFs7CPnTkFpfR--W+TEAS2GHZss5T2u9CKvy2wPdmg@mail.gmail.com>
References: <4FA2208E.5010208@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48022 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2ECGVk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 May 2012 02:21:40 -0400
Received: by bkcji2 with SMTP id ji2so1044815bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 May 2012 23:21:39 -0700 (PDT)
In-Reply-To: <4FA2208E.5010208@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, May 2, 2012 at 11:07 PM, Wido den Hollander <wido@widodh.nl> wrote:
> Hi,
>
> I've been talking to Josh today and we've been talking a bit about storing
> large objects in RADOS.
>
> One of the problem I currently see with using RADOS is storing really large
> objects.
>
> RADOS objects are stored on the OSD as a whole file, so potentially a single
> RADOS object could press an OSD over the full_ratio and stalling the whole
> cluster.
>
> This also shows another problem. It this object is heavily used a couple of
> OSDs will be very busy with the I/O's for this object.
>
> So I was thinking about an library on top of RADOS which is kind of similar
> to RBD, but it's only focused on storing objects.
>
> The first object in a pool could have a couple of xattrs:
>
> object1
> - stripe_size: 4096
> - size: 40960
>
> Based on the xattr operation we know where to read or write when asked for a
> specific offset and length.
>
> object1, object1_1, object1_2, until object1_9
>
> Potentially this could also be used for the RADOS Gateway? Since that will
> suffer from the same problem when you want to scale out.
>
> With the RAODS Gateway you can't control a user storing a 200G tar file with
> his backups in it, you never know.
>
> It's just a thought but I just wanted to get it out there and check out the
> opinions.
>
> Comments? Suggestions?
>

Actually, nowadays RGW keeps a map ("manifest") in each object which
points to where all the parts of that object actually reside. For
multipart uploads we don't merge the parts, but rather create a
manifest that points at them. For regular uploads (up to 5GB) we keep
the first 512K on the head object (where the map resides), and the
rest is in another rados object. In theory objects can be striped
using this or similar infrastructure. We don't impose a constant
stripe size, but the manifest can be extended to handle such cases.
What I'd really like to see is a rgw library that provides an object
access api and will access the backend directly. This will be used for
rgw itself, help clean up its internal structure, and will be useful
for other applications that don't need to go through the gateway
itself (but do need the same object access semantics).

Yehuda
