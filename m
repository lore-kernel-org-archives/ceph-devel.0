From: Milan Broz <mbroz@redhat.com>
Subject: Re: Interested in ceph OSD encryption and key management
Date: Wed, 03 Jun 2015 07:39:43 +0200
Message-ID: <556E931F.3000906@redhat.com>
References: <1432787005.11787.33.camel@catalyst.net.nz>	 <alpine.DEB.2.00.1505281257490.6462@cobra.newdream.net> <1433290379.11787.131.camel@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41325 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbbFCFjp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Jun 2015 01:39:45 -0400
In-Reply-To: <1433290379.11787.131.camel@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Bartlett <abartlet@catalyst.net.nz>, Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 06/03/2015 02:12 AM, Andrew Bartlett wrote:
> On Thu, 2015-05-28 at 13:03 -0700, Sage Weil wrote:
>>  2- make the key management pluggable, so that we can use petera, 
>> /etc/ceph/keys, the ceph mons, or something else.
> 
> Petera looks very much like what I was trying to home-grow, and I would
> prefer that over using the monitor nodes, as those are often shared with
> our storage nodes.  

Hi,

the preferred way to go now is using LUKS and Petera (https://github.com/npmccallum/petera),
I should probably edit the blueprint that is now kind of obsolete.

In general, the plain dm-crypt use is problematic because you have to handle
not only the key but also cipher metadata (cipher, key mode, etc).
Ceph currently uses cryptsetup default which can be different in future
or it can be changed per distro or during compilation time.
LUKS stores this information to the header ensuring you will be able to open it
with proper attributes everywhere.

(And LUKS header can be placed outside of disk itself, but I do not think this
should be done here.)

Milan

