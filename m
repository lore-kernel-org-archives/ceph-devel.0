From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: Interested in ceph OSD encryption and key management
Date: Sun, 31 May 2015 10:01:19 -0400
Message-ID: <CAGbvivJ=wEw1gQDx_Kfsa+E9yu4dC2GR79iFApF=An2DrRfqHg@mail.gmail.com>
References: <1432787005.11787.33.camel@catalyst.net.nz>
	<alpine.DEB.2.00.1505281257490.6462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37412 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbbEaOBT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 May 2015 10:01:19 -0400
Received: by igbsb11 with SMTP id sb11so44650883igb.0
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2015 07:01:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505281257490.6462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Andrew Bartlett <abartlet@catalyst.net.nz>, mbroz@redhat.com, ceph-devel@vger.kernel.org

Also consider key management services like Barbican or using an external
Key Mgmt server for managing the master keys (wrapping keys,
key-encrypting-keys, etc etc).

One can store the wrapping key externally, and fetch it via KMIP or other
standard/secure protocol when the disks come online.  The keys in
/etc/ceph/keys can be wrapped on disk and then unwrapped with the external
key to a ram disk when the disks come online. That way the raw dm-crypt
keys don't persist on the disk and are only available as long as the drive
is active and the system is up.

Just one possibility.  Switching to LUKS or something more robust is
probably better long term solution.


Orthogonal to FDE, but possibly nice to have would be the ability to
encrypt individual pools using different keys (or none at all), but thats
probably a different conversation...

On Thu, May 28, 2015 at 4:03 PM, Sage Weil <sage@newdream.net> wrote:
> Hi Andrew,
>
> I'm copying Milan Broz, who has looked at this ome. There was some
> subsequent off-list discussion in Red Hat about using Petera[1] for the
> key management, but this'll require a bit more effort than what was
> described in that blueprint.
>
> On Thu, 28 May 2015, Andrew Bartlett wrote:
>> David Disseldorp was good enough to point me at this proposal for ceph
>> OSD key management:
>> https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%3A_simple_ceph-mon_dm-crypt_key_management
>>
>> I'm really interested in improving ceph on-disk encryption, and am
>> really glad folks are taking this beyond the local key storage we have
>> managed so far.
>>
>> So I can be part of the discussion, how do I get a login to the wiki?  I
>> would like to indicate my interest there.
>
> The wiki logins are broken, but ignore that.. we're moving to
> tracker.ceph.com's wiki shortly anyway.  Email is best in the meantime!
>
>> Regarding the proposal:
>>
>> In the default mode suggested in the wiki, my primary concern is that
>> I'm told, in a number of deployments, the monitor node is the same
>> server that also holds the OSDs, so we don't gain anything for those
>> cases over the /etc storage.
>>
>> In those cases, the hooks suggested in the wiki will be key, as will be
>> having those configurable in ceph.conf, so ceph-deploy can just pass it
>> down to all the nodes as they are built, just as the other dmcrypt
>> options are.
>>
>> I would like to see three things hookable:
>>  - the command to obtain the key (on stdout)
>
> - a command to publish/store a new key (from ceph-disk create)
>
>>  - to encrypt the key (so we can additionally pass it
>> via gpg, a HSM or remote encrypt/decrypt service)
>>  - to decrypt the key
>
> Not quite sure what you have in mind here?
>
> I think the key things I'd like to see in any effort here is
>
>  1- keep the actual decryption key in LUKS and store the LUKS key in the
> key escrow location.  The original dm-crypt stuff kept the actual key
> in /etc/ceph/keys, but that makes it hard to track key provenance, and
> also fixes the encryption algorithm... LUKS is more robust.
>
>  2- make the key management pluggable, so that we can use petera,
> /etc/ceph/keys, the ceph mons, or something else.
>
> Thanks!
> sage
>
>
> [1] https://github.com/npmccallum/petera
>
>>
>>
>> Thanks,
>>
>> Andrew Bartlett
>>
>>
>> --
>> Andrew Bartlett
>> http://samba.org/~abartlet/
>> Authentication Developer, Samba Team  http://samba.org
>> Samba Developer, Catalyst IT          http://catalyst.net.nz/services/samba
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
