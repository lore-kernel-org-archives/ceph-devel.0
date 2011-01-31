From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: some thoughts about scrub
Date: Mon, 31 Jan 2011 21:58:19 +0000
Message-ID: <20110131215819.f0537c57.ctpm@ist.utl.pt>
References: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.ist.utl.pt ([193.136.128.21]:41096 "EHLO smtp1.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756573Ab1AaWH4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 31 Jan 2011 17:07:56 -0500
In-Reply-To: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>, brchrisman@gmail.com
Cc: ceph-devel@vger.kernel.org


On Mon, 31 Jan 2011 12:56:36 -0800 Colin McCabe <cmccabe@alumni.cmu.edu=
> wrote:
> Case #1:
> The hard disk where that the FileStore is reading from could be dying=
=2E
> In my experience, hard disks that are dying will tend to experience
> long delays in reading from the filesystem. Occasionally you will be
> unable to read some files, and you'll get EIO instead. When a hard
> disk is dying, all you want to do is get your data off there as soon
> as possible. You don't want to bother trying to "fix" the files on th=
e
> disk. That disk is toast.
>=20

 I'm my experience, with recent disks not every read error means that
the disk is going to die anytime soon. I manage several dozens of
Western Digital Drives (Caviar black 2TB) in linux raid6 arrays. When
running MD array background check, MD will report a read error from
time to time on some drives. It will recover the data for that block an=
d
rewrite it - but the "bad block" won't show as Reallocated or Pending
in SMART reports for that drive. Later, the same drive will do several
entire background checks just fine and will go some time before acting
up again.

 I also have seen some big Hitachi drives throwing some uncorrected
errors (but reallocating them, unlike WD drives), but otherwise work
just fine for months.

 So, granted, I may have flaky drives, but since they currently are not
causing significant hangs or timeouts on the array, why should I just
replace all of them? Even a flaky drive is a useful drive if it
contains a known good copy of your blocks for some time, just in case
your other good drive dies at the wrong time.

 So, I do agree that, as Brian Chrisman pointed out, background scrub
is always important as it helps to prevent your data redundancy going
bad without you knowing about it. I also agree with that sys. admin.
notification is important in either case.

 But I also think that Ceph should try to correct the errors it finds
through scrub, because some of today's drives may throw uncorrected
errors even if they are still useful - I'd rather have more copies of
my data, even if they're slightly unrealiable, since I should always be
able to tell the bad ones by BTRFS checksums. Besides, I think this
model of always trying to correct errors fits well with Ceph's
goal of working with unrealiable, comodity hardware, so it makes no
sense to just bail out and force the operator to swap every flaky drive=
=2E

 Best regards

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
