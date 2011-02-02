From: Kiran Patil <kirantpatil@gmail.com>
Subject: Re: rbd layering
Date: Wed, 2 Feb 2011 13:11:43 +0530
Message-ID: <AANLkTimPMJu7ukWqs2=TgV0RzvTsc1q1pH2uZx4WhZtu@mail.gmail.com>
References: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
	<AANLkTikk_pm2JHQy5+sqSPK_vi-NYaxhUSr=YNYsUSw=@mail.gmail.com>
	<AANLkTimeL7W-1uz3m2HOJn-b-kGkLDBnOFYdhx56uFM3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64330 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab1BBHlp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Feb 2011 02:41:45 -0500
Received: by wyb28 with SMTP id 28so7573023wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 23:41:44 -0800 (PST)
In-Reply-To: <AANLkTimeL7W-1uz3m2HOJn-b-kGkLDBnOFYdhx56uFM3@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello,

Josef has added Offline Deduplication for Btrfs.

http://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg07777.html

On Wed, Feb 2, 2011 at 12:54 PM, Gregory Farnum <gregf@hq.newdream.net>=
 wrote:
>
> On Tue, Feb 1, 2011 at 11:13 PM, Colin McCabe <cmccabe@alumni.cmu.edu=
> wrote:
> > On Mon, Jan 31, 2011 at 10:08 PM, Sage Weil <sage@newdream.net> wro=
te:
> >> One idea we've talked a fair bit about is layering RBD images. =A0=
The idea
> >> would be to create a new image in O(1) time that mirrors on old im=
age and
> >> get copy-on-write type semantics, like a writeable snapshot.
> >>
> >> We've come up with a few different approaches for doing this, each=
 with
> >> somewhat different performance characteristics. =A0The main consid=
eration is
> >> that RBD images do not (currently) have an "allocation table." =A0=
Image data
> >> is simply striped over objects (that may or may not exist). =A0You=
 read the
> >> object for a given block to see if it exists; if it doesn't (a "ho=
le"),
> >> the content is defined to be zero-filled.
> >
> > Have we thought about the hash table based approach yet? Where ever=
y
> > block gets hashed and we only store one copy for each? I guess this=
 is
> > basically how git works, except instead of fixed-size blocks, it
> > tracks variable-sized blobs. This is also how ZFS dedupe works.
> >
> > The nice thing about the hash table based approach is that you don'=
t
> > have to track parent-child relationships explicitly. If two users
> > happen to both install Centos 5.5 with the same settings on the sam=
e
> > sized-image, they'll both be deduped automatically.
> How would you place the blocks in a CAS-based block device like this?
> An allocation table might feel ugly, but when you're doing
> cluster-wide block sharing you're going to need the extra metadata
> somewhere. Better to store an allocation table than try and maintain
> the coherency required for dynamic de-dup like that.
>
> I guess I should say that de-dup would be a nice feature to support,
> but I don't think it's appropriate to implement as part of RBD.
> Anything that powerful needs to be a core RADOS feature.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html


--
Kind Regards,
---------------------

Kiran T Patil
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
