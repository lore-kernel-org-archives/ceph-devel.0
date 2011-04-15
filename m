From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Mounting
Date: Thu, 14 Apr 2011 17:00:27 -0700
Message-ID: <20110415000027.GG30604@dreamer>
References: <4DA786E7.9060305@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54873 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739Ab1DOAAY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 20:00:24 -0400
Content-Disposition: inline
In-Reply-To: <4DA786E7.9060305@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Fri, Apr 15, 2011 at 01:44:39AM +0200, Zenon Panoussis wrote:
> I'm facing yet another one of "those problems", more likely caused by
> lack of knowledge and/or documentation than by anything else.
> 
> # mount.ceph 192.168.178.100:6789:/ /vol
> mount error 22 = Invalid argument
> 
> # dmesg -c
> libceph: no secret set (for auth_x protocol)
> libceph: error -22 on auth protocol 2 init
> 
> It looks very much like http://marc.info/?l=ceph-devel&m=130072087704874&w=2 .
> Yes, I have enabled cephx, but I have no clue how to tell the client what key
> to use. I tried

Yup, those mean your server demands authentication but your client
didn't provide it.

> # cauthtool -l /etc/ceph/admin.keyring
> # mount.ceph 192.168.178.100:6789:/ /vol -v -o name=<auid>,secret=<key>
> 
> but all I got was
> 
> ceph: Unknown mount option name
> ceph: Unknown mount option secret
> mount error 1 = Operation not permitted

> 
> Yet, 'man mount.ceph' says
> 
> name	string, used with authx, Default: guest
> secret	string, used with authx
> 
> Commenting out "auth supported = cephx" gets rid of the problem and
> lets the store be mounted, but it's a workaround, not a solution.
> 
> Any ideas? This is ceph-0.26 with vanilla kernel 2.6.38.2.

The name and secret error messages seem to be just you running a
version of Ceph that does not include commit
9233889a7be8f672729a71e48681a1e779dabd1c; that'll be in 0.27.  Ignore
those two lines for now.

It looks like you're passing in the key the right way, but it's hard
to tell as you've obscured the actual key. The error you are seeing
is exactly what you would get if the key was invalid, or didn't have
the capabilities needed for mounting Ceph.

Perhaps you could share the ceph.conf, keyring and exact mount command
you are using, and once you get it going regenerate the keys to get
back your security.

-- 
:(){ :|:&};:
