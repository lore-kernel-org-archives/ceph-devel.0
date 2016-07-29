From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: [Feature request] config diff on a single option with the admin
 socket
Date: Fri, 29 Jul 2016 11:32:29 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1607291125130.28641@ancalagon.suse.com>
References: <CA+HUO7+qxtsS03yKp2ETUhKy6WTX1ESd0Xridw13viWwa0Cj3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55901 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbcG2Sce (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Jul 2016 14:32:34 -0400
In-Reply-To: <CA+HUO7+qxtsS03yKp2ETUhKy6WTX1ESd0Xridw13viWwa0Cj3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <shan@redhat.com>
Cc: Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, 29 Jul 2016, Sebastien Han wrote:

Hi Sebastien,

> I'd like to have the same but for a specific option only.
>
> So something like:
>
> ceph daemon mon.ceph-mon-01 config diff get <field>
>
> Which will return the diff between the actual config value and the
> original config value.

I might be able to help with this, if there's no support that anyone 
already knows of, or clear takers. I'm working on a small config-related 
librados feature right now and am somewhat familiar with the relevant 
moving parts on that end, so I might be in a good position to work on it.

WRT the admin socket, I'm less clear, but can be pointed in the right 
direction. :-)

-Jesse
