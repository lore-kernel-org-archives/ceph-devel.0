From: Andrew Bartlett <abartlet@catalyst.net.nz>
Subject: Re: Interested in ceph OSD encryption and key management
Date: Wed, 03 Jun 2015 12:07:21 +1200
Message-ID: <1433290041.11787.127.camel@catalyst.net.nz>
References: <1432787005.11787.33.camel@catalyst.net.nz>
	 <alpine.DEB.2.00.1505281257490.6462@cobra.newdream.net>
	 <CAGbvivJ=wEw1gQDx_Kfsa+E9yu4dC2GR79iFApF=An2DrRfqHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:33327 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbFCAHZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jun 2015 20:07:25 -0400
In-Reply-To: <CAGbvivJ=wEw1gQDx_Kfsa+E9yu4dC2GR79iFApF=An2DrRfqHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Sage Weil <sage@newdream.net>, mbroz@redhat.com, ceph-devel@vger.kernel.org

On Sun, 2015-05-31 at 10:01 -0400, Wyllys Ingersoll wrote:
> Also consider key management services like Barbican or using an external
> Key Mgmt server for managing the master keys (wrapping keys,
> key-encrypting-keys, etc etc).
> 
> One can store the wrapping key externally, and fetch it via KMIP or other
> standard/secure protocol when the disks come online.  The keys in
> /etc/ceph/keys can be wrapped on disk and then unwrapped with the external
> key to a ram disk when the disks come online. That way the raw dm-crypt
> keys don't persist on the disk and are only available as long as the drive
> is active and the system is up.
> 
> Just one possibility.  Switching to LUKS or something more robust is
> probably better long term solution.

Indeed, and that is why we have done that :-)

The proposal as written is confusing, because what it calls a 'wrapper
key' is really a key access key, it doesn't even encrypt it. 

Andrew Bartlett

-- 
Andrew Bartlett
http://samba.org/~abartlet/
Authentication Developer, Samba Team  http://samba.org
Samba Developer, Catalyst IT          http://catalyst.net.nz/services/samba




