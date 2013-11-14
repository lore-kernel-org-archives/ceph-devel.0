From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: CDS blueprint: strong auth for cephfs
Date: Thu, 14 Nov 2013 12:09:41 -0800
Message-ID: <l63als$lk4$1@ger.gmane.org>
References: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com> <CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com> <CABZ+qq=SQman+HPvKany0HigYrtMn766itdU_7ZsYm6SOaQzcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39797 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756061Ab3KNUJz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Nov 2013 15:09:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Vh3Ef-0001fl-OV
	for ceph-devel@vger.kernel.org; Thu, 14 Nov 2013 21:09:53 +0100
Received: from c-24-17-202-252.hsd1.wa.comcast.net ([24.17.202.252])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 14 Nov 2013 21:09:53 +0100
Received: from eternaleye by c-24-17-202-252.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 14 Nov 2013 21:09:53 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dan van der Ster wrote:

> Hi Greg,
<snip>
> AFAICT, this would allow single users to mount a subtree on CephFS and
> prevent them from writing where they are not permitted. But our
> use-case is different: we want to mount /cephfs/ from shared
> workstations and batch nodes to store personal home directories,
> shared group areas, and read-only software areas. Managing per-user
> keyrings and per-user mountpoints would become quickly unmanageable.
<snip>

Actually, there are a number of ways this could be managed pretty reasonably 
- eCryptfs, in particular, may be worth examining. It ships with a 
pam_ecryptfs module that (on login) uses the login password to produce the 
decryption key, and load it into the user's session keyring (which is then 
associated with every process in that session, although I don't think 
eCryptfs uses that). It then mounts the eCryptfs filesystem, and the kernel 
uses the loaded key for decryption.

If the credentials are only used on mount, something similar to pam_ecryptfs 
could work, or a minimal module that _only_ loads the key followed by 
pam_mount.

If the credentials are handled on FS operations, then you'd be able to have 
a single top-level mount with minimal privileges and then use the kernel 
keyring on access.

That also opens up using 'keyctl' to manually load the key into the user or 
session keyring, or using trusted/encrypted keys to allow secure automated 
mounts.

In fact, trusted or encrypted keys could be very useful if someone wanted to 
securely use Ceph as a rootfs - they'd make it possible to authenticate 
mounts based on the hardware, not just the configuration.

