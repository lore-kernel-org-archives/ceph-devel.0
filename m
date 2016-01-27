From: Sage Weil <sweil@redhat.com>
Subject: Re: osd dm-crypt key management, part... deux?
Date: Wed, 27 Jan 2016 10:23:45 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601271021510.6524@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1601262106390.6524@cpach.fuggernut.com> <CA+H5UW3vtjzvYZxd=0LZ8xYCCon7CGJg_GwjvFaBtXTepFdXZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50480 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932740AbcA0PXd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Jan 2016 10:23:33 -0500
In-Reply-To: <CA+H5UW3vtjzvYZxd=0LZ8xYCCon7CGJg_GwjvFaBtXTepFdXZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 27 Jan 2016, Radoslaw Zarzynski wrote:
> On Wed, Jan 27, 2016 at 3:26 PM, Sage Weil <sweil@redhat.com> wrote:
> 
> > 2- Implement a simple mon-based strategy upstream.  We've discussed this a
> > fair bit in the past, and were getting stuck on the problem of where to
> > store the key-fetching-key.  I.e., we want a key on the disk that you use
> > to ask the monitor for the LUKS key, which you then provide to LUKS to
> > unlock the actual encryption key.  This means that we need a unencrypted
> > spot on the device to store it in.  Milan has indicated that putting it in
> > a LUKS key slot would be a bad idea and difficult to maintain.  Instead, I
> > propose we create a new GPT partition type called OSD_LOCKBOX (or
> > similar), with a tiny filesystem and a few files indicating what to do.
> > This will make it easy to store the info we need for the mon scheme, and
> > to support new key management approaches later (we can put whatever we
> > want there as long as it's not too big).
> >
> > I put some notes here:
> >
> >         http://pad.ceph.com/p/osd-key-management
> >
> > Thoughts?
> > sage
> 
> Hello Sage,
> 
> why we cannot simply fetch the LUKS key from a monitor during
> the mount phase? LUKS key wouldn't be stored in any file. Instead,
> it would be fetched to memory (RAM) and present there only for
> time necessary to initialize dm-crypt.

Right, that's basically what I'm suggesting, except with the additional 
requirement that you need the lockbox ceph auth key in order to fetch the 
LUKS key (so that this host can only fetch keys to decrypt its own disks).

> Of course, code responsible for the setup must have an access to
> the OSD's keyring. It may be put into lockbox.

The OSD's key would be in the osd_data, encrypted.  So,

 lockbox key lets us fetch luks key
 luks key lets us set up dmcrypt (by unlocking the real encryption key)
 osd key lets the osd start up and join the cluster.

sage
