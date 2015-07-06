From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: systemd support
Date: Mon, 6 Jul 2015 13:03:59 -0600
Message-ID: <559AD11F.4050100@redhat.com>
References: <55970AFF.3020603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36741 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbbGFTED (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 Jul 2015 15:04:03 -0400
In-Reply-To: <55970AFF.3020603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/03/2015 04:21 PM, Loic Dachary wrote:
> [cc'ing ceph-devel in case someone else has the answer]
> 
> Hi Ken,
> 
> I know very little about systemd and I'd like to learn more. My understanding
> is that we have some support in the current master branch, but it is
> incomplete. Are there differences with what I would find in the Red Hat
> Storage 1.3 packages ? If I'm not mistaken RHEL7 uses systemd, therefore I
> guess there may be a better support there. Unless it's using the legacy
> sysvinit files ?

Hi Loic,

The RHCS product is using the legacy sysvinit scripts that are upstream.
I doubt we'll use systemd unit files to manage the services in RHCS
until those land upstream and get a lot of testing there.

There is a ticket to track the incorporation of systemd unit files for
the services, here: http://tracker.ceph.com/issues/11344 . That ticket
has some more details regarding the current situation upstream.

From what I recall, both SUSE and Ubuntu have implemented systemd unit
files downstream for the Ceph MON/OSD/MDS services.

- Ken
