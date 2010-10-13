From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: Ceph 0.23-rc make, slow write and client on kernel 2.6.35.7
Date: Thu, 14 Oct 2010 11:45:53 +1300
Message-ID: <AANLkTimPvmg+WV7afDbp25gmRYZ_TBSgp=3Ki--c7fi1@mail.gmail.com>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
	<Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
	<AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
	<AANLkTimrKDCCDHqYEb9CBhUoYO+OpKJe2Ohdyt65MxU=@mail.gmail.com>
	<AANLkTinieBbzew5rkmu0640XZbJ+x-wFe-+2H8otnDT3@mail.gmail.com>
	<AANLkTi=h6pb_mwYWw1EcK=GJGS0DWd-pz2k0UeU-wFN7@mail.gmail.com>
	<Pine.LNX.4.64.1010130745080.7988@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:18602 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab0JMWqA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Oct 2010 18:46:00 -0400
Received: by qyk2 with SMTP id 2so1413758qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Oct 2010 15:45:53 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010130745080.7988@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

Hi.

> Can you cat the /sys/kernel/debug/ceph/*/mdsc and osdc files?

Ok, I've re-ran again, the freeze reproduced! updated here
http://tracker.newdream.net/issues/479

> The cosd --mkfs step will clear out old data.

mkcephfs wouldn't get the --mkfs, I see now. ;)

> The 'btrfs path' is the mount point, which defaults to the same as 'o=
sd
> data'. =A0It doesn't affect anythign in your case, though. =A0The rea=
l
> question is where the EOPNOTSUPP is coming from. =A0Is /data/osd0 a b=
trfs or
> ext3/4 file system at this point?

I made sure to mount dir empty, get the disk all empty, and mount with
user_xattr,
so I no longer gets the above error, thanks.
my plan is to first get the ceph working in a good performance order
before moving to btrfs

Thanks a lot.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
