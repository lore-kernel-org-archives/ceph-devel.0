From: Milan Broz <gmazyland@gmail.com>
Subject: Re: osd dm-crypt key management, part... deux?
Date: Wed, 10 Feb 2016 11:17:04 +0100
Message-ID: <56BB0E20.9000800@gmail.com>
References: <alpine.DEB.2.11.1601262106390.6524@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35503 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757412AbcBJKRH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 05:17:07 -0500
Received: by mail-wm0-f50.google.com with SMTP id c200so21035644wme.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 02:17:06 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601262106390.6524@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Hi,

just few notes, I know that too late, but anyway...

(Partially based on meeting with Deo author yesterday...)

On 01/27/2016 03:26 PM, Sage Weil wrote:
> We've had several partial starts to address this problem but haven't 
> gotten anything over the line.  A quick summary:
> 
> 1- Currently we store dm-crypt keys in /etc/ceph/dmcrypt-keys/$osd_uuid, 
> on the boot disk.  This lets you throw away OSD disk but not boot disks 
> and doesn't help you if someone walks away with a whole server.
> 
> 2- SUSE had a pull request that made ceph-disk push/pull keys over (s)ftp.  
> I can't find it now.. did it get closed?
> 
> 3- We built a generic "config-key" storage service into the monitor that 
> lets you restrict access to certain key/value pairs based on your 
> (cephx) authentication key, intending that the osd dm-crypt keys be stored 
> there.

My (upstream cryptsetup) plan is to have LUKS2 configurable keyslot and these
should allow plugins that can directly fetch the key for example.

In fact proof-of-concept code was inspired by Ceph OSD use case and
allows fetching key from remote server through libssh (it expects
ssh keys configured such way, that you can run ssh to some server
with public key auth without password - but that's just example).

In LUKS2 header then we store just ssh server/user/dir
https://gitlab.com/cryptsetup/cryptsetup/blob/wip-luks2/misc/luks2_keyslot_example/keyslot_test.c
(please note it is just wip example of standalone binary, interface will change,
and currently it uses real volume key, not unlocking passphrase)

I can imagine that in long-term there can be simple keyslot using
cephx auth as well or whatever Ceph will need.

Integration then would be just to properly format
that keyslot, all luks commands will then work as today automagically.

(There are priority for keyslot, so we can have fallback to other
kesylot type like password-based if network is down.)

The real problem is that LUKS2 can be stable in next months, not earlier.

I have some notes in Devconf presentation but that's relay just overview
of current experiment with LUKS2 (it can still be completely abandoned :)
https://mbroz.fedorapeople.org/talks/DevConf2016/devconf2016-luks2.pdf

> 
> 4- Red Hat had a DEO project that addressed network-bound encryption in 
> the works but that project has been shelved in favor of something 
> newer/shinier/better.

Yes, Deo (formerly Petera) is dead, replaced with Clevis/Tang project.

For more info see Devconf presentation
http://slides.com/npmccallum/devconf16#/ (there is also youtube recording)

This approach is usable for you as well but it requires another
configuration and dependencies. It will probably use on-disk LUKS2 data
in long-term, just with intermediate implementation using LUKS1 and something
for metadata store (IIRC they mentioned file on boot disk).

The major risk is that the new cryptographic protocol is not yet properly
reviewed and if broken, half of it need to be redesigned.
(Also it is not in any distro yet.)

> 5- Lars observes that any solution is incomplete if we don't *also* 
> encrypt the swap devices.  (I think we don't need to worry about the boot 
> disks, though, unless we're paranoid about /var/log/ceph?)

It depends on your threat model...

But you can easily create encrypted swap using key from /dev/urandom
(iow regenerated every boot).

This is common solution if you do not store hibernation data in swap.
(Just one line in crypttab/fstab.)

> 6- Radoslaw and Adam observe that anything using dm-crypt may have higher 
> overhead than something implemented in RADOS itself.  But this is vastly 
> more complicated and, if we move in this direction, a long way off.

Gluster implemented encryption this way (no idea if it is used in reality),
it is months of development. It can provide almost native performance but
risk of doing something wrong and later redesign is quite high.

Also you can be hit by FIPS (and similar) certification requirements later...
(for government users)

But yes, there will be always overhead for dmcrypt, but because OSDs usually
run on quite powerful hw (with AESNI etc) device-mapper team can help to
solve performance issues.

> 7- In the meantime, we have nothing better than /etc/ceph/dmcrypt-keys 
> upstream...
> 
> 
> I suggest we do something simple:
> 
> 1- Update SUSE's ceph-disk changes to make it easy to plug in 
> different key management strategies.
> 
> 2- Implement a simple mon-based strategy upstream.  We've discussed this a 
> fair bit in the past, and were getting stuck on the problem of where to 
> store the key-fetching-key.  I.e., we want a key on the disk that you use 
> to ask the monitor for the LUKS key, which you then provide to LUKS to 
> unlock the actual encryption key.  This means that we need a unencrypted 
> spot on the device to store it in.  Milan has indicated that putting it in 
> a LUKS key slot would be a bad idea and difficult to maintain.  Instead, I 
> propose we create a new GPT partition type called OSD_LOCKBOX (or 
> similar), with a tiny filesystem and a few files indicating what to do.  
> This will make it easy to store the info we need for the mon scheme, and 
> to support new key management approaches later (we can put whatever we 
> want there as long as it's not too big).

I would like to have LUKS1 to be stable format, so hacking with
keyslots would be fragile solution... (Despite it is possible.)

As I mentioned, LUKS2 should solve this but it is probably not usable
in this timeframe you need.

I just want to mention LUKS2 just idea but it can simplify the whole configuration
in future for you.

Milan

