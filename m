From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: v9.1.0 Infernalis release candidate released
Date: Wed, 14 Oct 2015 01:32:33 +0100
Message-ID: <561DA2A1.3030901@suse.de>
References: <alpine.DEB.2.00.1510131356001.27022@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55170 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033AbbJNAcq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Oct 2015 20:32:46 -0400
In-Reply-To: <alpine.DEB.2.00.1510131356001.27022@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-announce@ceph.com, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

On 13/10/15 22:01, Sage Weil wrote:
> * *RADOS*:
>   * The RADOS cache tier can now proxy write operations to the base
>     tier, allowing writes to be handled without forcing migration of
>     an object into the cache.
>   * The SHEC erasure coding support is no longer flagged as
>     experimental. SHEC trades some additional storage space for faster
>     repair.
>   * There is now a unified queue (and thus prioritization) of client
>     IO, recovery, scrubbing, and snapshot trimming.
>   * There have been many improvements to low-level repair tooling
>     (ceph-objectstore-tool).
>   * The internal ObjectStore API has been significantly cleaned up in order
>     to faciliate new storage backends like NewStore.

It may also be worth to mention that we dropped a few options from the
monitor that people may have customized in their configurations (I guess
we forgot to add them to the PendingReleaseNotes).

These options are:

- mon_lease_renew_interval (default: 3)
- mon_lease_ack_timeout (default: 10)
- mon_accept_timeout (default: 10)

If you are using these in your configuration, please use instead

- mon_lease_renew_interval_factor (default: 0.6)
- mon_lease_ack_timeout_factor (default: 2.0)
- mon_accept_timeout_factor (default: 2.0)

These are now used as a factor of 'mon_lease'. If you also have
'mon_lease' (default: 5) adjusted and your previous options match the
new factors defaults, you have nothing else to do but to drop the old
options from your configuration file. Otherwise, please consider
adjusting the factors to match whatever is working for you.

  -Joao
